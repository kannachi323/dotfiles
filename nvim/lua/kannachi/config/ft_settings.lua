local ft_settings = {
    java = { tabstop = 2, shiftwidth = 2 },
    lua = { tabstop = 2, shiftwidth = 2 },
    python = { tabstop = 4, shiftwidth = 4},
    c = { tabstop = 4, shiftwidth = 4 },
}

for ft, opts in pairs(ft_settings) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = function()
            for k, v in pairs(opts) do
                vim.opt_local[k] = v
            end
        end,
    })
end

