-- Center the editing area so code isn't flush against the left edge of the screen.
-- Empty padding windows are added on each side; they resize with the terminal.

-- Code area width: up to 110 cols (colorcolumn 100 + line numbers + sign column),
-- shrinking on narrow terminals (laptop, split panes) so there is always some padding.
-- A fixed 110 silently did nothing below ~130 cols.
local function fit_width()
    return math.max(60, math.min(110, vim.o.columns - 16))
end

return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
    keys = {
        { "<leader>z", "<cmd>NoNeckPain<cr>", desc = "Toggle centered buffer" },
    },
    opts = function()
        return {
            width = fit_width(),
            minSideBufferWidth = 1,
            autocmds = {
                -- "safe" enables on a short timer instead of inside BufEnter. With `true`,
                -- a window closing at startup (e.g. lazy.nvim's install float) raised
                -- E242 "Can't split a window while closing another".
                enableOnVimEnter = "safe",
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
        }
    end,
    config = function(_, opts)
        require("no-neck-pain").setup(opts)
        -- Recompute the width when the terminal resizes; the plugin re-lays out right after.
        vim.api.nvim_create_autocmd("VimResized", {
            callback = function()
                if _G.NoNeckPain and _G.NoNeckPain.config then
                    _G.NoNeckPain.config.width = fit_width()
                end
            end,
        })
    end,
}
