-- cycle through capital marks across buffers
local function collect_capital_marks()
  local marks = vim.fn.getmarklist()
  local capitals = {}

  for _, mark in ipairs(marks) do
    local m = mark.mark
    local pos = mark.pos or {}

    if m and m:match("^'[A-Z]$") and #pos >= 3 then
      local file = mark.file
      local bufnr = file and vim.fn.bufnr(file) or -1

      if bufnr == -1 and file then
        vim.cmd("edit " .. vim.fn.fnameescape(file))
        bufnr = vim.fn.bufnr(file)
      end

      if bufnr ~= -1 then
        table.insert(capitals, { mark = m, bufnr = bufnr, line = pos[2], col = pos[3] })
      end
    end
  end

  table.sort(capitals, function(a, b)
    return a.bufnr == b.bufnr and a.line < b.line or a.bufnr < b.bufnr
  end)

  return capitals
end

local function jump_to_capital(offset)
  local capitals = collect_capital_marks()
  if #capitals == 0 then
    print("No capital marks found")
    return
  end

  vim.g._capital_mark_index = (vim.g._capital_mark_index or 0) + offset

  -- wrap around
  if vim.g._capital_mark_index > #capitals then
    vim.g._capital_mark_index = 1
  elseif vim.g._capital_mark_index < 1 then
    vim.g._capital_mark_index = #capitals
  end

  local mark = capitals[vim.g._capital_mark_index]
  vim.api.nvim_set_current_buf(mark.bufnr)
  vim.api.nvim_win_set_cursor(0, { mark.line, mark.col })
  vim.cmd("normal! zz")
  -- vim.cmd("normal! zt")
end

-- Forward
vim.keymap.set("n", "<leader>mm", function()
  jump_to_capital(1)
end, { desc = "Cycle to next capital mark" })

-- Reverse
vim.keymap.set("n", "<leader>nn", function()
  jump_to_capital(-1)
end, { desc = "Cycle to previous capital mark" })

local function get_next_capital_mark()
  local marks = vim.fn.getmarklist()
  local used_marks = {}

  -- Collect all used capital marks
  for _, mark in ipairs(marks) do
    local m = mark.mark
    if m and m:match("^'[A-Z]$") then
      used_marks[m:sub(2, 2)] = true
    end
  end

  -- Find the next available capital mark
  for i = 65, 90 do -- ASCII values for A-Z
    local mark = string.char(i)
    if not used_marks[mark] then
      return mark
    end
  end

  -- If all marks are used, start over from A
  return "A"
end

local function set_next_capital_mark()
  local next_mark = get_next_capital_mark()
  vim.cmd("mark " .. next_mark)
  print("Set mark " .. next_mark .. " at current position")
end

vim.keymap.set("n", "<leader>sm", set_next_capital_mark, { desc = "Set next capital mark" })
