return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = "v0.0.29",
  opts = {
    provider = "claude",
    providers = {
      claude = {
        model = "claude-sonnet-4-5-20250929",
      },
      openai = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-5-20250929", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,                      -- timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,                 -- adjust if needed
          max_completion_tokens = 812,
          -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
        },
      },
    },
    windows = {
      position = 'right',
      width = 40,
    },
    behaviour = {
      auto_suggestions = true,
      -- auto_apply_diff_after_generation = true,
      -- enable_fastapply = true,
      auto_approve_tool_permissions = false,
      confirmation_ui_style = "popup",
    }
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  }
}
