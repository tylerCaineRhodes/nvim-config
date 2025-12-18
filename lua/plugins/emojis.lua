return {
  "allaman/emoji.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
  },
  opts = {},
  config = function(_, opts)
    local emoji = require("emoji")
    emoji.setup(opts)

    local ok, telescope = pcall(require, 'telescope')
    if ok then
      telescope.load_extension('emoji')

      vim.keymap.set('n', '<leader>se', function()
        require('telescope').extensions.emoji.emoji()
      end, { desc = '[S]earch [E]moji' })

      vim.keymap.set('n', '<leader>ss', function()
        emoji.insert_kaomoji()
      end, { desc = 'search kaomoji' })

      vim.keymap.set('n', '<leader>sg', function()
        emoji.insert_kaomoji_by_group()
      end, { desc = 'search kaomoji by group' })
    end
  end,
}
