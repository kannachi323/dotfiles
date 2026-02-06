return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd" },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local servers = { "lua_ls", "ts_ls", "pyright", "clangd" }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
      vim.lsp.enable(server)
    end

    -- --- KEYMAPS (Placed outside the loop for cleanliness) ---
    
    -- LSP Brain Functions
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Variable" })

    -- Diagnostic Functions (This fixes your 'gl' issue)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show Line Error" })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Error" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Error" })
  end,
}
