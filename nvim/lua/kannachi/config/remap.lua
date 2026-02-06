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

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })

vim.keymap.set('n', '<leader>sv', ':vsp<CR><C-w>l')
vim.keymap.set('n', '<leader>sh', ':sp<CR><C-w>j')
vim.keymap.set('n', '<leader>xx', ':x<CR>', { desc = 'Save and quit window' })
vim.keymap.set('n', '<C-Up>', ':resize -3<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +3<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -3<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +3<CR>')
vim.keymap.set('n', '<leader>=', '<C-w>=')

