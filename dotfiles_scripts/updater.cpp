#include "updater.hpp"
#include "helper.hpp"
#include <cstring>
#include <filesystem>
#include <iostream>
#include <queue>
#include <vector>

/*
// full path
std::cout << "path  " << path << '\n';
// Without extention
std::cout << "stem  " << path.stem() << '\n';
// name without path
std::cout << "fname " << path.filename() << '\n';
*/

enum {
    LOCAL_TO_GIT,
    GIT_TO_LOCAL,
};

#define DEBUG 0
#define DEBUG_VERBOSE 0

int main(int argc, char *argv[]) {
    int action = -1;
    if (argc < 2) {
        std::cerr << "Please supply --local-to-git or --git-to-local as command line parameter\n";
        return 2;
    }

    // Argument parsing
    for (int i = 1; i < argc; i++) {
        if (std::strcmp("--local-to-git", argv[i]) == 0) {
            action = LOCAL_TO_GIT;
        } else if (std::strcmp("--git-to-local", argv[i]) == 0) {
            action = GIT_TO_LOCAL;
        }
    }

    if (action == -1) {
        std::cerr << "Please supply --local-to-git or --git-to-local as command line "
                     "parameter\n";
        return 2;
    }

    const std::filesystem::path git_path = git_root(); // This changes cwd
    const std::filesystem::path sys_path = std::getenv("HOME");

#if DEBUG
    std::clog << "git_path " << git_path << '\n';
    std::clog << "sys_path " << sys_path << '\n';

    std::clog << action << " - action \n";
    std::clog << LOCAL_TO_GIT << " - LOCAL_TO_GIT \n";
    std::clog << GIT_TO_LOCAL << " - GIT_TO_LOCAL \n";
#endif

    const auto ignore = parse_ignore(git_path / "dotfiles_scripts/.ignore");

#if DEBUG_VERBOSE
    for (auto line : ignore) // Print ignored files
        std::cout << line << '\n';
#endif

    std::vector<std::pair<const std::filesystem::path, const std::filesystem::path>> files_to_check;

    std::queue<std::filesystem::path> path_queue;
    path_queue.push(git_path);
    const auto path_len = git_path.string().size() + 1;

    // Recurse over all files in git folder
    while (!path_queue.empty()) {
        const auto cur_path = path_queue.front();
        path_queue.pop();

        for (const auto &entry : std::filesystem::directory_iterator(cur_path)) {
            const std::filesystem::path entry_path_git = entry.path();
            const auto entry_path_str = entry_path_git.string();
            const auto entry_root_name = entry_path_str.substr(path_len, entry_path_str.size());

            // Make std::filesystem::path entry_root_name_path to use on next line ???
            const std::filesystem::path entry_path_sys = sys_path / entry_root_name;

            if (std::find(ignore.begin(), ignore.end(), entry_root_name) != ignore.end())
                continue; // File found in .ignore

            // I do not check if entry is block, char, symlink...
            if (entry.is_directory())
                path_queue.push(entry_path_git); // Use emplace here? (variable is const)
            else // TODO - create threads to check files instead of pushing into vector
                files_to_check.push_back(std::make_pair(
                    entry_path_sys, entry_path_git)); // Probably can use emplace_back

            // std::cout << entry_root_name << '\n';
        }
    }

    // TODO - try to reuse files_to_check vector by shifting elements - inverse for
    // for (int i = n - 1; i <= index; i--) list[i] = list[i + 1];

    std::vector<std::pair<const std::filesystem::path, const std::filesystem::path>>
        files_to_update;

    std::vector<std::pair<const std::filesystem::path, const std::filesystem::path>>
        files_to_create;

    for (auto pair : files_to_check) {
        const std::filesystem::path file_path_sys = pair.first;
        const std::filesystem::path file_path_git = pair.second;

        // file_path_git is guaranteed to exist
        if (!std::filesystem::exists(file_path_sys))
            files_to_create.push_back(pair); // use emplace_back?
        else if ((std::filesystem::file_size(file_path_git) !=
                  std::filesystem::file_size(file_path_sys)) ||
                 (!equal_files(file_path_git, file_path_sys))) {
            // File does not exist or has different size or different content
            files_to_update.push_back(pair); // use emplace_back?
        }
    }

    if (action == LOCAL_TO_GIT) {
        if (files_to_update.empty()) {
            std::cout << "No files to update\n";
            return 0;
        }

        for (auto pair : files_to_update)
            std::cout << pair.first << "\n";

        if (!get_user_input("\nDo you wish to update all these files to git?")) return 0;

        for (auto pair : files_to_update) {
            const std::filesystem::path file_path_sys = pair.first;
            const std::filesystem::path file_path_git = pair.second;
            std::filesystem::copy_file(
                file_path_sys, file_path_git,
                std::filesystem::copy_options{std::filesystem::copy_options::overwrite_existing});
        }

    } else {
        for (auto pair : files_to_create)
            std::cout << pair.first << "\n";
        for (auto pair : files_to_update)
            std::cout << pair.first << "\n";

        if (!get_user_input("\nDo you wish to update all these files to this machine?")) return 0;

        for (auto pair : files_to_update) {
            const std::filesystem::path file_path_sys = pair.first;
            const std::filesystem::path file_path_git = pair.second;
            std::filesystem::copy_file(
                file_path_git, file_path_sys,
                std::filesystem::copy_options{std::filesystem::copy_options::overwrite_existing});
        }

        for (auto pair : files_to_create) {
            const std::filesystem::path file_path_sys = pair.first;
            const std::filesystem::path file_path_git = pair.second;
            std::filesystem::create_directories(file_path_sys.parent_path());
            std::filesystem::copy_file(file_path_git, file_path_sys);
        }
    }

    std::cout << "Done!\n";
    return 0;
}
