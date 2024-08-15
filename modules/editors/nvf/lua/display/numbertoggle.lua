-- taken from https://github.com/sitiom/nvim-numbertoggle
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('NumberToggle', {}),
    callback = function()
        if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
    pattern = '*',
    group = vim.api.nvim_create_augroup('NumberToggle', {}),
    callback = function()
        if vim.o.nu then
            vim.opt.relativenumber = false
            vim.cmd('redraw')
        end
    end,
})
