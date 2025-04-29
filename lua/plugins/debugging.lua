return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "suketa/nvim-dap-ruby",
    "nvim-neotest/nvim-nio",
  },
  lazy = true,
  keys = {
    { "<leader>dt", desc = "Toggle breakpoint" },
    { "<leader>dc", desc = "Continue" },
    { "<leader>ds", desc = "Step over" },
    { "<leader>di", desc = "Step into" },
    { "<leader>do", desc = "Step out" },
  },
  init = function()
    local function load_dap_and_call(fn_name)
      return function()
        require("lazy").load({ plugins = { "nvim-dap" } })
        vim.schedule(function()
          require("dap")[fn_name]()
        end)
      end
    end

    vim.keymap.set("n", "<leader>dt", load_dap_and_call("toggle_breakpoint"))
    vim.keymap.set("n", "<leader>dc", load_dap_and_call("continue"))
    vim.keymap.set("n", "<leader>ds", load_dap_and_call("step_over"))
    vim.keymap.set("n", "<leader>di", load_dap_and_call("step_into"))
    vim.keymap.set("n", "<leader>do", load_dap_and_call("step_out"))
  end,
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
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

    dap.adapters.ruby = function(callback, _config)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = 12345
      })
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "Debug bin/dev",
        request = "attach",
        localfs = true,
        command = "bin/dev",
        args = {},
        port = 12345,
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

    vim.g["test#custom_strategies"] = {
      dap = function(cmd)
        local file, line = cmd:match("^%.(/bin/rspec) (.-):?(%d*)$")
        if not file then error("Invalid test command for nvim-dap") end

        local dap_config = {
          type = "ruby",
          request = "attach",
          name = "Debug RSpec",
          localfs = true,
          command = "bundle",
          args = { "exec", "rspec", file .. (line ~= "" and (":" .. line) or "") },
          port = 12345,
        }
        require("dap").run(dap_config)
      end,
    }
  end,
}
