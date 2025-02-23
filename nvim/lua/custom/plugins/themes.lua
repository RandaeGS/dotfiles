return {
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      {
        '<leader>oc',
        function()
          local config_path = vim.fn.stdpath 'config'
          local builtin = require 'telescope.builtin'

          builtin.colorscheme {
            enable_preview = true,
            attach_mappings = function(_, map)
              map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)

                -- Aplica el colorscheme inmediatamente
                vim.cmd.colorscheme(selection.value)

                -- Lee el contenido actual de init.lua
                local init_content = table.concat(vim.fn.readfile(config_path .. '/init.lua'), '\n')
                local colorscheme_line = string.format("vim.cmd.colorscheme('%s')", selection.value)

                -- Busca cualquier línea que establezca el colorscheme
                local new_content
                if init_content:match 'vim.cmd.colorscheme%b()' then
                  -- Si existe, reemplázala
                  new_content = init_content:gsub('vim.cmd.colorscheme%b()', colorscheme_line)
                elseif init_content:match "vim.cmd%('colorscheme%s+[^')]+%)" then
                  -- Busca formato alternativo: vim.cmd('colorscheme nombre')
                  new_content = init_content:gsub("vim.cmd%('colorscheme%s+[^')]+%)", colorscheme_line)
                else
                  -- Si no existe, agrégala al final
                  new_content = init_content .. '\n\n-- Colorscheme configuration\n' .. colorscheme_line
                end

                -- Guarda los cambios
                local file = io.open(config_path .. '/init.lua', 'w')
                if file then
                  file:write(new_content)
                  file:close()
                  print('Colorscheme ' .. selection.value .. ' saved to init.lua')
                else
                  print 'Error: Could not save colorscheme to init.lua'
                end
              end)
              return true
            end,
          }
        end,
        desc = 'Select and Save Colorscheme',
      },
    },
  },

  { 'rose-pine/neovim', name = 'rose-pine' },

  {
    'scottmckendry/cyberdream.nvim',
  },

  { 'catppuccin/nvim', name = 'catppuccin' },

  {
    'folke/tokyonight.nvim',
    opts = {},
  },
}
