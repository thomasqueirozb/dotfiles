-- Boilerplate from nvim-lspconfig
-- Global mappings.
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', 'g[', function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set('n', 'g]', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- set up lsp_lines
        require("lsp_lines").setup()
        -- remove default lsp diagnostic lines
        vim.diagnostic.config({
            virtual_text = false,
        })
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>F', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
--capabilities
local capabilities_with_completion = require('cmp_nvim_lsp').default_capabilities()
capabilities_with_completion.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('rust_analyzer', {
    cmd = { "rust-analyzer" },
    capabilities = capabilities_with_completion,
    settings = {
        ["rust-analyzer"] = {
            check = { command = "check" },
            cargo = { allFeatures = false },
            diagnostics = {
                enable = true,
                -- enableExperimental = true,
            },
        },
    },
})

vim.lsp.enable('rust_analyzer')


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
vim.lsp.config('lua_ls', {
    capabilities = capabilities_with_completion,

    settings = {
        Lua = {
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            telemetry = {
                enable = false,
            },
        }
    }
})

-- local util = require('lspconfig.util')
vim.filetype.add({
    pattern = {
        ['.*/%.github[%w/]+workflows[%w/]+.*%.ya?ml'] = 'yaml.github',
    },
})

vim.lsp.config('gh_actions_ls', {
    -- capabilities = capabilities_with_completion,

    filetypes = { 'yaml.github' },

    -- root_dir = util.root_pattern('.github'),
    single_file_support = true,
    capabilities = {
        workspace = {
            didChangeWorkspaceFolders = {
                dynamicRegistration = true,
            },
        },
    },
})

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_enable = {
        exclude = { "rust_analyzer" } -- Managed by rustup
    }
})

--require("mason-lspconfig").setup_handlers {
--    -- default setup for unconfigured servers
--    function(server_name)
--        require("lspconfig")[server_name].setup {}
--    end,
--    ["yamlls"] = function()
--        require('lspconfig')['yamlls'].setup {
--            capabilities = capabilities_with_completion,
--            settings = {
--                yaml = {
--                    schemas = {
--                        ["http://json.schemastore.org/github-action"] = ".github/workflows/*",
--                    }
--                }
--            }
--        }
--    end,
--    -- Go configuration
--    ["gopls"] = function()
--        require('lspconfig')['gopls'].setup {
--            cmd = { 'gopls' },
--            capabilities = capabilities_with_completion,
--            settings = {
--                gopls = {
--                    experimentalPostfixCompletions = true,
--                    analyses = {
--                        unusedparams = true,
--                        shadow = true,
--                        fieldalignment = true,
--                        nilness = true,
--                        unusedwrite = true,
--                    },
--                    staticcheck = true,
--                    codelenses = {
--                        tidy = true
--                    },
--                },
--            },
--            init_options = {
--                usePlaceholders = true,
--            }
--        }
--    end,
--    -- typescript config
--    ["tsserver"] = function()
--        require 'lspconfig'.tsserver.setup {
--            settings = { documentFormatting = true }
--        }
--    end,
--}

require("conform").setup({
    format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})
