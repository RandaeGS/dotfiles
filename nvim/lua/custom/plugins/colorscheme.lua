return {

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000,
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
    },

    -- Set colorscheme in this function
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme onedark]]
        end,
    },
}
