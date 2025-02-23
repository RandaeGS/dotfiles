return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require 'dashboard'

      local logo = [[
███████╗██╗  ██╗   ██╗███████╗██╗██╗   ██╗███╗   ███╗
██╔════╝██║  ╚██╗ ██╔╝██╔════╝██║██║   ██║████╗ ████║
█████╗  ██║   ╚████╔╝ ███████╗██║██║   ██║██╔████╔██║
██╔══╝  ██║    ╚██╔╝  ╚════██║██║██║   ██║██║╚██╔╝██║
███████╗███████╗██║   ███████║██║╚██████╔╝██║ ╚═╝ ██║
╚══════╝╚══════╝╚═╝   ╚══════╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
      ]]

      logo = string.rep('\n', 8) .. logo .. '\n\n'
      local builtin = require 'telescope.builtin'

      dashboard.setup {
        theme = 'doom',
        config = {
          header = vim.split(logo, '\n'),
          center = {
            { action = builtin.find_files, desc = ' Find File', icon = ' ', key = 'f' },
            { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
            { action = 'Telescope oldfiles', desc = ' Recent Files', icon = ' ', key = 'r' },
            {
              action = function()
                require('telescope.builtin').find_files {
                  cwd = vim.fn.stdpath 'config',
                  promp_title = 'Neovim Config Files',
                  hidden = true,
                }
              end,
              desc = ' Config',
              icon = ' ',
              key = 'c',
            },
            { action = 'lua require("persistence").load()', desc = ' Restore Session', icon = ' ', key = 's' },
            { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
            { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
          },
        },
      }
    end,
  },
}
