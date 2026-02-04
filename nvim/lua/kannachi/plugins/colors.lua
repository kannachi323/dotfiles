return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,    -- Load immediately on startup
    priority = 1000, -- Load before all other plugins
    config = function()
      -- 1. Setup Gruvbox options
      require("gruvbox").setup({
        transparent_mode = true,
        integrations = {
          telescope = true,
          harpoon = true,
        },
      })

      -- 2. Define our "Fix" function
      local function apply_custom_highlights()
        local colors = require("gruvbox").palette
        
        local hl_groups = {
          -- Telescope: Orange Search Bar
          TelescopePromptBorder  = { fg = colors.bright_orange, bg = "none" },
          TelescopePromptTitle   = { fg = colors.bright_orange, bg = "none", bold = true },
          TelescopePromptPrefix  = { fg = colors.bright_red,    bg = "none" },
          
          -- Telescope: Aqua/Blue Results
          TelescopeResultsBorder = { fg = colors.bright_aqua,   bg = "none" },
          TelescopeResultsTitle  = { fg = colors.bright_aqua,   bg = "none", bold = true },
          
          -- Telescope: Green Preview
          TelescopePreviewBorder = { fg = colors.bright_green,  bg = "none" },
          TelescopePreviewTitle  = { fg = colors.bright_green,  bg = "none", bold = true },

          
          HarpoonBorder = { fg = colors.bright_yellow, bg = "none" },

          -- This ensures the inside of the window is also transparent
          HarpoonWindow = { bg = "none" },

          -- This is the highlight for the file you are currently in (if it's in the list)
          HarpoonCurrentFile = { fg = colors.bright_orange, bold = true }, 

          -- Global Transparency Fixes
          Normal       = { bg = "none" },
          NormalFloat  = { bg = "none" },
          NormalNC     = { bg = "none" },
          SignColumn   = { bg = "none" },
        }

        for group, opts in pairs(hl_groups) do
          vim.api.nvim_set_hl(0, group, opts)
        end
      end

      -- 3. Create an Autocommand to re-apply colors whenever the theme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          apply_custom_highlights()
        end,
      })

      -- 4. Finally, set the colorscheme
      vim.cmd("colorscheme gruvbox")
    end,
  },
}
