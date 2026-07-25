-- Custom plugins replicated from zFlabmonsta/kickstart.nvim@v0.0.0.
--  The upstream file is a Lazy.nvim spec; this config uses Neovim's built-in
--  `vim.pack`, so each plugin is installed with `vim.pack.add` and configured
--  with an explicit `setup` / keymap call.
--
-- This file is loaded automatically by `custom/plugins/init.lua`.

---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

do
  -- [[ tiny-inline-diagnostic.nvim ]]
  -- Prettier inline diagnostics.
  vim.pack.add { gh 'rachartier/tiny-inline-diagnostic.nvim' }
  require('tiny-inline-diagnostic').setup {
    options = {
      multilines = {
        enabled = true,
      },
      show_source = {
        enabled = true,
      },
    },
  }

  -- [[ oil.nvim ]]
  -- Edit your filesystem like a buffer.
  --  Icons come from `mini.icons` (mocked as nvim-web-devicons in init.lua),
  --  so no extra devicons dependency is needed here.
  vim.pack.add { gh 'stevearc/oil.nvim' }
  ---@module 'oil'
  ---@type oil.SetupOpts
  require('oil').setup {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  }
  vim.keymap.set('n', '<leader>pv', '<cmd>Oil --float<CR>', { desc = 'Open Oil Floating Explorer' })

  -- [[ undotree ]]
  -- Visualize the undo history.
  vim.pack.add { gh 'mbbill/undotree' }
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undotree' })

  -- [[ vim-fugitive ]]
  -- The premier Git plugin for Vim, with vim-rhubarb for :GBrowse on GitHub.
  vim.pack.add { gh 'tpope/vim-fugitive' }
  vim.pack.add { gh 'tpope/vim-rhubarb' }
  vim.keymap.set('n', '<leader>GS', vim.cmd.Git, { desc = 'Git status' })
  vim.keymap.set('n', '<leader>GB', ':.GBrowse<CR>', { desc = 'GBrowse current line' })

  -- [[ harpoon ]]
  -- Quick file navigation. Uses the `harpoon2` branch.
  --  Depends on plenary.nvim, already installed for Telescope.
  vim.pack.add { { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' } }
  local harpoon = require 'harpoon'
  harpoon:setup {
    settings = {
      save_on_toggle = true,
    },
  }

  vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon File' })
  vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Quick Menu' })

  local keyMap = {
    [1] = 'j',
    [2] = 'k',
    [3] = 'l',
    [4] = 'h',
  }
  for i = 1, 5 do
    local key = keyMap[i] or tostring(i)
    vim.keymap.set('n', string.format('<C-%s>', key), function() harpoon:list():select(i) end, { desc = 'Harpoon to File ' .. i })
  end

  -- [[ trouble.nvim ]]
  -- A pretty diagnostics / references / quickfix list.
  vim.pack.add { gh 'folke/trouble.nvim' }
  require('trouble').setup {}
  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })

  -- [[ render-markdown.nvim ]]
  -- Improved in-buffer Markdown rendering.
  --  Deps (nvim-treesitter, mini.nvim) are already installed in init.lua.
  vim.pack.add { gh 'MeanderingProgrammer/render-markdown.nvim' }
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  require('render-markdown').setup {}
end
