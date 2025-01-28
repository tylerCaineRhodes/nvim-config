return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "suketa/nvim-dap-ruby",
    "nvim-neotest/nvim-nio",
  },
  ft = { "ruby", "javascript", "python" },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = { "repl" },
          size = 10,
          position = "bottom",
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require("dap-ruby").setup()

    dap.adapters.ruby = function(callback, config)
      callback({
        type = "server",
        host = "127.0.0.1", -- Match the host for rdbg
        port = 12345
      })
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "Debug bin/dev",
        request = "attach",
        localfs = true, -- Maps local filesystem paths
        command = "bin/dev", -- Command to run
        args = {}, -- Additional arguments for bin/dev if needed
        port = 12345, -- Port used by rdbg in the Procfile
      },
      {
        type = "ruby",
        name = "Debug RSpec Current File",
        request = "attach",
        localfs = true,
        command = "bundle",
        args = { "exec", "rspec", "${file}" },
        port = 12345,
      },
      {
        type = "ruby",
        name = "Debug RSpec Current Line",
        request = "attach",
        localfs = true,
        command = "bundle",
        args = { "exec", "rspec", "${file}:${line}" },
        port = 12345,
      },
    }

    -- Custom vim-test strategy for nvim-dap (wip)
    vim.g["test#custom_strategies"] = {
      dap = function(cmd)
        local file, line = cmd:match("^%.(/bin/rspec) (.-):?(%d*)$")
        print('file: ', file)
        print('line: ', line)
        if not file then
          error("Invalid test command for nvim-dap")
        end

        local dap_config = {
          type = "ruby",
          request = "attach",
          name = "Debug RSpec",
          localfs = true,
          command = "bundle",
          args = { "exec", "rspec", file .. (line ~= "" and (":" .. line) or "") },
          port = 12345,
        }
        dap.run(dap_config)
      end,
    }
    -- Keybindings for dap
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", dap.continue, {})
    vim.keymap.set("n", "<leader>ds", dap.step_over, {})
    vim.keymap.set("n", "<leader>di", dap.step_into, {})
    vim.keymap.set("n", "<leader>do", dap.step_out, {})
  end,
}

