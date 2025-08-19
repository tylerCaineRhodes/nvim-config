function ChangeTestStrategy(strategy)
  vim.g["test#strategy"] = strategy
  print("Test strategy changed to: " .. strategy)
end

vim.api.nvim_create_user_command("TestStrategy", function(inner_options)
  -- vim.g["test#strategy"] = inner_options.args
  -- print("Test strategy changed to: " .. inner_options.args)
  ChangeTestStrategy(inner_options.args)
end, { nargs = 1 })


vim.api.nvim_create_user_command('Google', function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ('https://www.google.com/search?q=%s'):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = 'just google it' })

vim.api.nvim_create_user_command('DuckDuckGo', function(o)
  local escaped = vim.uri_encode(o.args)
  local url = ('https://duckduckgo.com/?q=%s'):format(escaped)
  vim.ui.open(url)
end, { nargs = 1, desc = 'just google i mean duckduckgo it' })

vim.api.nvim_create_user_command(
  'Bufo',
  '%bd|e#|bd#',
  {}
)

-- close every buffer
vim.api.nvim_create_user_command(
  'Bufc',
  '%bd',
  {}
)

vim.api.nvim_create_user_command(
  'Delmark',
  'delmark A-Za-z',
  {}
)

vim.api.nvim_create_user_command(
  'FormatJson',
  '%!jq .',
  {}
)
