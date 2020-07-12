#include "helper.hpp"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <iterator>
#include <streambuf>
#include <vector>

std::vector<std::string> parse_ignore(std::string ignore_path) {
    if (std::ifstream infile{ignore_path}) {
        std::vector<std::string> ignore; // Return vector
        std::string line;
        while (std::getline(infile, line)) { // Parse file line by line
            ltrim(line);                     // Remove whitespace from start
            if (line[0] == '#') continue;    // Go to next line if commented
            // rtrim(line);                  // Remove whitespace from end
            trim_dir(line); // Remove whitespace or '/' from end

            // Probably emplace_back would not work here because line is reused
            ignore.push_back(line);
        }
        return ignore;
    } else {
        std::cerr << ".ignore file not found in " << ignore_path << '\n';
        std::exit(2);
    }
}

const std::filesystem::path git_root() {
    std::filesystem::path cur_path = std::filesystem::current_path();
    const std::filesystem::path fs_root = cur_path.root_directory(); // Could use "/";

    while (1) {
        // std::cout << "Folder: " << cur_path << '\n';

        if (cur_path == fs_root) {
            err("Could not find .git/ folder and got to root directory. \nAre "
                "you sure you are running this inside the repository folder?");
            std::exit(2);
        }

        for (const std::filesystem::directory_entry &entry :
             std::filesystem::directory_iterator(cur_path)) {
            const std::filesystem::path path = entry.path();
            if (path.filename() == ".git" && std::filesystem::is_directory(path)) {
                return cur_path;
            }
        }

        std::filesystem::current_path((cur_path = cur_path.parent_path())); // This can fail

        // #include <unistd.h>
        // if (chdir("..") != 0) {
        //     err("Failed to go to directory above");
        //     std::exit(1);
        // }
    }
}

[[nodiscard]] bool equal_files(const std::string &a, const std::string &b) {
    std::ifstream stream_a{a};
    std::string file1{std::istreambuf_iterator<char>(stream_a), std::istreambuf_iterator<char>()};

    std::ifstream stream_b{b};
    std::string file2{std::istreambuf_iterator<char>(stream_b), std::istreambuf_iterator<char>()};

    return file1 == file2;
}

[[nodiscard]] bool get_user_input(const std::string prompt, const bool default_option) {
    if (default_option)
        std::cout << prompt << " [Y/n] " << std::flush;
    else
        std::cout << prompt << " [y/N] " << std::flush;

    std::string user_input;
    std::getline(std::cin, user_input);
    std::transform(user_input.begin(), user_input.end(), user_input.begin(),
                   [](unsigned char c) { return std::tolower(c); });

    // std::cout << "user_input: " << user_input << '\n';
    // for (auto c : user_input) {
    //     std::cout << "C: " << static_cast<unsigned int>(c) << "\n";
    // }
    if (std::cin.eof()) {
        std::putchar('\n');
        std::exit(1);
    }

    if (!user_input.compare("y") || !user_input.compare("yes")) return true;
    if (!user_input.compare("n") || !user_input.compare("no")) return false;
    if (!user_input.compare("")) return default_option;

    std::exit(1);
}
