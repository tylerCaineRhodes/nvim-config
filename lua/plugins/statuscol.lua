return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  config = function()
    local builtin = require("statuscol.builtin")

    function _G.ScToggleFold(minwid, clicks, button, mods)
      vim.cmd("normal! za")
    end

    require("statuscol").setup({
      segments = {
        { text = { "%s" },                        click = "v:lua.ScSa" },
        { text = { builtin.lnumfunc },            click = "v:lua.ScLa" },
        { text = { " ", builtin.foldfunc, "  " }, click = "v:lua.ScToggleFold" },
      },
    })
  end,
}
