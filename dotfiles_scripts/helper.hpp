#pragma once
// Credit to jotik and Evan Teran over at StackOverflow
// https://stackoverflow.com/questions/216823/whats-the-best-way-to-trim-stdstring#217605

#include <algorithm>
#include <filesystem>
#include <iostream>
#include <vector>

const std::filesystem::path git_root();

std::vector<std::string> parse_ignore(const std::string ignore_path);

[[nodiscard]] bool equal_files(const std::string &a, const std::string &b);

[[nodiscard]] bool get_user_input(const std::string prompt, const bool default_option = true);

static inline void red_error() { std::fputs("\x1B[1m\x1B[31m[ERROR]\x1B[37m ", stderr); }

static inline void reset_colors() { std::fputs("\x1B[0m", stderr); }

static inline void err(const char *s) {
    red_error();
    std::fputs(s, stderr);
    std::putc('\n', stderr);
    reset_colors();
}

// trim from start (in place)
static inline void ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](int ch) { return !std::isspace(ch); }));
}

// trim from end (in place)
static inline void rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](int ch) { return !std::isspace(ch); }).base(),
            s.end());
}

// trim from both ends (in place)
static inline void trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

static inline void trim_dir(std::string &s) {
    s.erase(
        std::find_if(s.rbegin(), s.rend(), [](int ch) { return !(std::isspace(ch) || ch == '/'); })
            .base(),
        s.end());
}
