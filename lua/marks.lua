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

local function annotate_marks()
  require("lazy").load({ plugins = { "telescope.nvim" } })
  vim.schedule(function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local raw_marks = vim.fn.getmarklist()
    local by_letter = {}
    for _, mark in ipairs(raw_marks) do
      local m = mark.mark
      local pos = mark.pos or {}
      if m and m:match("^'[A-Z]$") and #pos >= 3 then
        local letter = m:sub(2, 2)
        by_letter[letter] = { file = mark.file, lnum = pos[2], col = pos[3] }
      end
    end

    local entries = {}
    for i = 65, 90 do
      local letter = string.char(i)
      local entry = by_letter[letter]
      if entry then
        table.insert(entries, {
          letter = letter,
          filename = entry.file,
          lnum = entry.lnum,
          col = entry.col,
          display = letter .. ". " .. entry.file .. ":" .. entry.lnum,
        })
      end
    end

    if #entries == 0 then
      print("No capital marks set")
      return
    end

    pickers.new({}, {
      prompt_title = "Capital Marks",
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.display,
            ordinal = entry.display,
            filename = entry.filename,
            lnum = entry.lnum,
            col = entry.col,
          }
        end,
      }),
      previewer = conf.grep_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.cmd("normal! '" .. selection.value.letter)
            vim.cmd("normal! zz")
          end
        end)

        map({ "i", "n" }, "<C-d>", function()
          local picker = action_state.get_current_picker(prompt_bufnr)
          local multi = picker:get_multi_selection()
          local to_delete = {}
          if #multi > 0 then
            for _, sel in ipairs(multi) do
              table.insert(to_delete, sel.value.letter)
            end
          else
            local sel = action_state.get_selected_entry()
            if sel then
              table.insert(to_delete, sel.value.letter)
            end
          end
          if #to_delete > 0 then
            vim.cmd("delmarks " .. table.concat(to_delete, ""))
          end
          actions.close(prompt_bufnr)
        end)

        map({ "i", "n" }, "<C-q>", function()
          local picker = action_state.get_current_picker(prompt_bufnr)
          local multi = picker:get_multi_selection()
          local items = #multi > 0 and multi or { action_state.get_selected_entry() }
          actions.close(prompt_bufnr)
          local qf_items = {}
          for _, sel in ipairs(items) do
            table.insert(qf_items, {
              filename = sel.filename,
              lnum = sel.lnum,
              col = sel.col,
              text = sel.display,
            })
          end
          vim.fn.setqflist(qf_items, "r")
          vim.cmd("copen")
        end)

        return true
      end,
    }):find()
  end)
end

vim.api.nvim_create_user_command("AnnotateMarks", annotate_marks, {})

local function annotate_marks_slim()
  local marks = vim.fn.getmarklist()
  local by_letter = {}

  for _, mark in ipairs(marks) do
    local m = mark.mark
    local pos = mark.pos or {}
    if m and m:match("^'[A-Z]$") and #pos >= 3 then
      local letter = m:sub(2, 2)
      by_letter[letter] = { file = mark.file, line = pos[2] }
    end
  end

  local lines = {}
  for i = 65, 90 do
    local letter = string.char(i)
    local entry = by_letter[letter]
    if entry then
      table.insert(lines, letter .. ". " .. (entry.file or "?") .. ":" .. entry.line)
    end
  end

  if #lines == 0 then
    print("No capital marks set")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local width = 0
  for _, l in ipairs(lines) do
    width = math.max(width, #l)
  end
  width = math.min(width + 2, vim.o.columns - 4)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = #lines,
    row = math.floor((vim.o.lines - #lines) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " Marks ",
    title_pos = "center",
  })

  vim.wo[win].number = true

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })

  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true })

  vim.keymap.set("n", "<CR>", function()
    local cursor_line = vim.api.nvim_win_get_cursor(win)[1]
    local selected = lines[cursor_line]
    if not selected then return end
    local letter = selected:sub(1, 1)
    vim.api.nvim_win_close(win, true)
    vim.cmd("normal! '" .. letter)
    vim.cmd("normal! zz")
  end, { buffer = buf, nowait = true })
end

vim.api.nvim_create_user_command("AnnotateMarksSlim", annotate_marks_slim, {})
