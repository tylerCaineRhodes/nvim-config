
vim.g.scratchfile_path = vim.fn.getenv("SCRATCHFILE_PATH")

-- :ScratchNew {filename}
vim.api.nvim_create_user_command("ScratchNew", function(opts)
  local fname = opts.fargs[1]
  if not fname or fname == "" then
    error("ScratchNew: filename required, e.g. :ScratchNew myfile.rb")
  end

  local dir = vim.g.scratchfile_path or (vim.fn.stdpath("data") .. "/scratches")
  vim.fn.mkdir(dir, "p")

  local target = dir .. "/" .. fname
  local exists = (vim.fn.filereadable(target) == 1)

  if exists and not opts.bang then
    error("ScratchNew: file exists: " .. target .. " (use :ScratchNew! to overwrite)")
  end

  local f = assert(io.open(target, "w"))
  f:close()

  vim.cmd((opts.bang and "edit! " or "edit ") .. vim.fn.fnameescape(target))

  vim.bo.buftype = ""
  vim.bo.bufhidden = ""
  vim.bo.swapfile = true
end, { nargs = 1, bang = true, complete = "file" })


-- :ScratchSave {filename}
vim.api.nvim_create_user_command("ScratchSave", function(opts)
  local fname = opts.fargs[1]
  if not fname or fname == "" then
    error("ScratchSave: filename required, e.g. :ScratchSave myfile.rb")
  end

  local dir = vim.g.scratchfile_path or (vim.fn.stdpath("data") .. "/scratches")
  vim.fn.mkdir(dir, "p")  -- ensure the directory exists

  local target = dir .. "/" .. fname
  local exists = (vim.fn.filereadable(target) == 1)

  if exists and not opts.bang then
    error("ScratchSave: file exists: " .. target .. " (use :ScratchSave! to overwrite)")
  end

  vim.cmd((opts.bang and "saveas! " or "saveas ") .. vim.fn.fnameescape(target))

  vim.bo.buftype = ""
  vim.bo.bufhidden = ""
  vim.bo.swapfile = true
end, { nargs = 1, bang = true, complete = "file" })

vim.api.nvim_create_user_command("ScratchOpen", function()
  local dir = vim.g.scratchfile_path or (vim.fn.stdpath("data") .. "/scratches")

  vim.fn.mkdir(dir, "p")

  require("telescope.builtin").find_files({
    prompt_title = "Scratch Files",
    cwd = dir,
    hidden = true, -- show hidden files if any
  })
end, { nargs = 0 })
