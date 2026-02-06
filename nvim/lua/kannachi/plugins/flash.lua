return {
    "folke/flash.nvim",
    keys = {
        { "s", mode = { "n", "x", "o" }, false }, -- Disable default 'or flash
      { "F", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
}
