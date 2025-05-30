local M = {}

M.extract_models = function()
  local models = vim.fn.systemlist('llm models')
  local only_models = {}
  for _, line in ipairs(models) do
    local model = line:match('^.-:%s*([^(%s]+)')
    if model then table.insert(only_models, model) end
  end
  return only_models
end

M.llm_cmd = function(user_input, continue, show_usage, model, ctx_files)
  local cmd = 'llm'
  if continue then cmd = cmd .. ' -c' end
  if show_usage then cmd = cmd .. ' -u' end
  cmd = cmd .. ' -m ' .. vim.fn.shellescape(model)

  if ctx_files then
    for _, filename in ipairs(ctx_files) do
      cmd = cmd .. ' -f ' .. vim.fn.shellescape(filename) .. ' '
    end
  end

  cmd = cmd .. ' ' .. vim.fn.shellescape(user_input)
  return cmd
end

return M
