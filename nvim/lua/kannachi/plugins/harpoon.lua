local function workspace()
    return require("kannachi.config.harpoon")
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    cmd = { "HarpoonList" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function() workspace().setup() end,
    keys = {
        { "<leader>mm", function() workspace().add() end, desc = "Harpoon mark file" },
        { "<leader>hf", function() workspace().menu() end, desc = "Harpoon active list" },
        { "<leader>hs", function() workspace().pick() end, desc = "Harpoon switch list" },
        { "<leader>hn", function() workspace().create() end, desc = "Harpoon new list" },
        { "<leader>1", function() workspace().list():select(1) end, desc = "Harpoon file 1" },
        { "<leader>2", function() workspace().list():select(2) end, desc = "Harpoon file 2" },
        { "<leader>3", function() workspace().list():select(3) end, desc = "Harpoon file 3" },
        { "<leader>4", function() workspace().list():select(4) end, desc = "Harpoon file 4" },
        { "<leader>5", function() workspace().list():select(5) end, desc = "Harpoon file 5" },
        { "<leader>hh", function() workspace().list():next({ ui_nav_wrap = true }) end, desc = "Harpoon next file" },
        { "<leader>hl", function() workspace().list():prev({ ui_nav_wrap = true }) end, desc = "Harpoon previous file" },
    },
}
