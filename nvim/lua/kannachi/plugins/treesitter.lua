return {
    'nvim-treesitter/nvim-treesitter',
    -- master is the frozen branch with the `nvim-treesitter.configs` API this file uses;
    -- the repo's default branch (main) is a rewrite that would break on :Lazy update.
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ':TSUpdate',
    config = function()
        -- master passes `--no-bindings` to `tree-sitter generate`, which tree-sitter CLI 0.26
        -- removed. Parsers built from grammar (e.g. swift) failed with "unexpected argument".
        require("nvim-treesitter.install").ts_generate_args = {
            "generate", "--abi", tostring(vim.treesitter.language_version),
        }

        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "lua", "javascript", "typescript", "c", "cpp",
                "python", "go", "markdown", "markdown_inline"
            },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
        })

    end,
}
