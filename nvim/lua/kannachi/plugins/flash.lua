return {
    "folke/flash.nvim",
    keys = {
        { "s", mode = { "n", "x", "o" }, false }, -- Disable default 'or flash
      { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
}
