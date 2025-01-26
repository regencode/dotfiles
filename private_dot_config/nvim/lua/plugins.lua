--Modules --


require("options")
require("lazy").setup({
    {
        "glepnir/zephyr-nvim",
        config = function()
            vim.cmd.colorscheme("zephyr")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "css", "hyprlang" },

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                -- List of parsers to ignore installing (or "all")
                ignore_install = {},
                highlight = {
                    enable = true,
                },


                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = init_selection, -- set to `false` to disable one of the mappings
                        node_incremental = node_incremental,
                        scope_incremental = scope_incremental,
                        node_decremental = node_decremental,
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            ["<leader>fo"] = "@function.outer",
                            ["<leader>fi"] = "@function.inner",
                            ["<leader>co"] = "@class.outer",
                            ["<leader>ci"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["<leader>ls"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = 'v', -- charwise
                            ["@function.outer"] = 'V', -- linewise
                            ["@class.outer"] = '<c-v>', -- blockwise
                            -- You can choose the select mode (default is charwise "v")
                            --
                            -- Can also be a function which gets passed a table with the keys
                            -- * query_string: eg "@function.inner"
                            -- * method: eg "v" or 'o'
                            -- and should return the mode ("v", 'V', or '<c-v>') or a table
                            -- mapping query_strings to modes. If you set this to `true` (default is `false`) then any textobject is
                            -- extended to include preceding or succeeding whitespace.
                            include_surrounding_whitespace = true,
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'none',
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        },

                    },
                },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    {
        "neovim/nvim-lspconfig",
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-treesitter/nvim-treesitter"
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end,
    },
    'nvim-tree/nvim-web-devicons',
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = "auto",
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                },
            })
        end,

    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- LuaSnip
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    {
        "hrsh7th/nvim-cmp",
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
            cmp.setup.cmdline({ "/", '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            -- Set up lspconfig.
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup_handlers({
                function (server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            })
        end
    },
})
