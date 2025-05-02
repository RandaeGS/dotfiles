return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup()

    -- Keymaps: neio = file 1-4
    vim.keymap.set('n', '<leader>an', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon file 1 (n)' })
    vim.keymap.set('n', '<leader>ae', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon file 2 (e)' })
    vim.keymap.set('n', '<leader>ai', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon file 3 (i)' })
    vim.keymap.set('n', '<leader>ao', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon file 4 (o)' })

    -- Extra: Add file and toggle menu
    vim.keymap.set('n', '<leader>aa', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add file' })
    vim.keymap.set('n', '<leader>am', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon menu' })
  end,
}
