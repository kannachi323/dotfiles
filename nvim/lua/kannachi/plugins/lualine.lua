return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "gruvbox",
            -- Keep a bar per window (set true for one bar across the whole bottom).
            globalstatus = false,
            -- Blank out the bars under the no-neck-pain side padding.
            disabled_filetypes = {
                statusline = { "no-neck-pain" },
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", path = 1 } }, -- path relative to cwd
            lualine_x = { "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    },
    config = function(_, opts)
        -- lualine shows the mode, so drop the duplicate "-- INSERT --" in the cmdline.
        vim.opt.showmode = false
        require("lualine").setup(opts)
    end,
}
