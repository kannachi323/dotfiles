vim.g.mapleader = " "

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Disable the arrow keys entirely
local keys = { '<Up>', '<Down>', '<Left>', '<Right>' }
for _, key in ipairs(keys) do
    vim.keymap.set({'n', 'i', 'v'}, key, '<Nop>')
end

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pe", vim.cmd.Lexplore)
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
