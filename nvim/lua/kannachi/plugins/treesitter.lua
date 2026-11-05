return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ':TSUpdate',
    config = function()
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
