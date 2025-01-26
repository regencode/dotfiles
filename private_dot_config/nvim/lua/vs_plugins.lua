--Modules --

require("options")
require("lazy").setup({
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
})
