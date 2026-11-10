-- Center the editing area so code isn't flush against the left edge of the screen.
-- Empty padding windows are added on each side; they resize with the terminal.
return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
    keys = {
        { "<leader>z", "<cmd>NoNeckPain<cr>", desc = "Toggle centered buffer" },
    },
    opts = {
        -- Text area width: colorcolumn is 100, plus room for line numbers + sign column.
        width = 110,
        autocmds = {
            enableOnVimEnter = true,
            enableOnTabEnter = true,
            -- Don't let <C-h>/<C-l> land in the empty side padding.
            skipEnteringNoNeckPainBuffer = true,
        },
        buffers = {
            wo = {
                fillchars = "eob: ", -- hide the ~ markers in the padding
            },
        },
        integrations = {
            NvimTree = {
                position = "left",
                reopen = true,
            },
        },
    },
}
