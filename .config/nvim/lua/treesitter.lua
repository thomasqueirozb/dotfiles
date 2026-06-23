-- Highlighting is built into Neovim 0.12
-- Install parsers with :TSInstall <language>
require('nvim-treesitter').setup({
    ensure_installed = { "rust", "go" },
})
