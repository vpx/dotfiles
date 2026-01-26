return {
    -- {
    --     "stevearc/conform.nvim",
    --     -- event = 'BufWritePre', -- uncomment for format on save
    --     opts = require "configs.conform",
    -- },
    {
          "stevearc/conform.nvim",
          -- event = { "BufReadPre", "BufNewFile" },         -- load when you open/edit files
          cmd = { "ConformInfo" },                        -- also load when you run :ConformInfo
          config = function()
            require("conform").setup(require("configs.conform"))
          end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim", "lua", "vimdoc",
                "html", "css", "cpp", "c", "cmake",
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function()
            local config = require("nvchad.configs.telescope")

            config.defaults.file_ignore_patterns = {
                "node_modules",
                "build",
                ".git",
                ".vscode",
                ".cache",
                ".idea",
                "%third_party",
            }

            return config
        end,
    },
    {
        'L3MON4D3/LuaSnip',
        config = function ()
            require("configs/luasnip");
        end
    },
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },

                sources = {
                    { name = 'luasnip' },
                    -- more sources
                },
            }

            require("configs/cmp")
        end
    },
    {
        'saadparwaiz1/cmp_luasnip'
    },
    {
      "lervag/vimtex",
      ft = { "tex" },
      lazy = false,
      init = function()
        local config = require("configs/vimtex")
      end
    },
    {
        "WGUNDERWOOD/tex-fmt",
        lazy = false,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    vim.keymap.set(
                        "n",
                        "<localleader>f",
                        function()
                            if vim.bo.filetype ~= "tex" then return end
                            vim.cmd("write")
                            local filename = vim.fn.expand("%:p")
                            vim.fn.system("tex-fmt --config .tex-fmt.toml " .. filename)
                            vim.cmd("edit")
                            print("tex-fmt applied to " .. vim.fn.expand("%:t"))
                        end,
                        {
                            noremap = true,
                            silent = true,
                            desc = "Format current TeX file with tex-fmt",
                            buffer = 0,
                        }
                    )
                end
            })
        end
    },
}
