return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        -- Toggle the tree
        { "<leader>pe", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
        -- Focus the tree
        { "<leader>pf", "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" },
        -- Find current file in tree
        { "<leader>pff", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Tree" },
    },    
    config = function()
        require("nvim-tree").setup {
            
        }
    end,
}
