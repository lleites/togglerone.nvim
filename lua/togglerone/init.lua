local M = {}
M.toggles = {}

local function call_cmd(cmd)
  if type(cmd) == 'function' then
    cmd()
  else
    vim.api.nvim_command(cmd)
  end
end

M.toggle_map = function(open, close)
  local toogle_name = #M.toggles + 1
  return function()
    if M.toggles[toogle_name] then
      call_cmd(close)
      M.toggles[toogle_name] = false
    else
      call_cmd(open)
      M.toggles[toogle_name] = true
    end
  end
end

return M
