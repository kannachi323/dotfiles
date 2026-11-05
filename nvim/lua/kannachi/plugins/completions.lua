return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Source: LSP suggestions
      "hrsh7th/cmp-buffer",       -- Source: words from current file
      "hrsh7th/cmp-path",         -- Source: file system paths
      "L3MON4D3/LuaSnip",         -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Bridge: snippets to cmp
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept suggestion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Prioritize LSP
          { name = "luasnip" },  -- Then snippets
        }, {
          { name = "buffer" },   -- Then words in file
          { name = "path" },     -- Then paths
        }),
        window = {
          completion = cmp.config.window.bordered(), -- Makes it look like our other windows!
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
