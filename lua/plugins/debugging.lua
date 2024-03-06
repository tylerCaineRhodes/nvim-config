return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "suketa/nvim-dap-ruby",
  },

  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- ruby dap config

    require("dap-ruby").setup()

    dap.adapters.ruby = function(callback, config)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "bundle",
          args = {
            "exec",
            "rdbg",
            "-n",
            "--open",
            "--port",
            "${port}",
            "-c",
            "--",
            "bundle",
            "exec",
            config.command,
            config.script,
          },
        },
      })
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "debug current file",
        request = "attach",
        localfs = true,
        command = "ruby",
        script = "${file}",
      },
      {
        type = "ruby",
        name = "run current spec file",
        request = "attach",
        localfs = true,
        command = "rspec",
        script = "${file}",
      },
    }

    -- keymappings
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", dap.continue, {})
  end,
}
