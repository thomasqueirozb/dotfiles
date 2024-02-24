Colorschemes = { Gruvbox = "gruvbox", TokioNight = "tokionight" }
local colorscheme = Colorschemes.Gruvbox;


if colorscheme == Colorschemes.Gruvbox then
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
    })

    vim.o.background = "dark" -- or "light" for light mode
elseif colorscheme == Colorschemes.TokioNight then
    require("tokyonight").setup({
        style = "storm",
        terminal_colors = true,
        transparent = true,
        styles = {
            sidebars = "dark",
        },
        on_highlights = function(colors)
            colors.LineNr = colors.orange
            colors.DiagnosticWarn = colors.red
        end,

        on_colors = function(colors)
            colors.Comment = {
                fg = colors.white,
                style = colors.italic,
            }
        end
    })
end

vim.cmd("colorscheme " .. colorscheme)
