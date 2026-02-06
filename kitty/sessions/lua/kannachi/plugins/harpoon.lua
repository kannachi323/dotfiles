return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>mm", function() require("harpoon.mark").add_file() end, desc = "harpoon mark file" },
        { "<leader>hf", function() require("harpoon.ui").toggle_quick_menu() end, desc = "harpoon quick menu" },
        { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "navigate to file 1" },
        { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "navigate to file 2" },
        { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "navigate to file 3" },
        { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "navigate to file 4" },
        { "<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "navigate to file 5" },
        { "<leader>hh", function() require("harpoon.ui").nav_next() end, desc = "navigate to next mark" },
        { "<leader>hl", function() require("harpoon.ui").nav_prev() end, desc = "navigate to prev mark" },
    },
}
