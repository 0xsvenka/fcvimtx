local M = {}

vim.b.was_fcitx_on = false

local fcitx_cmd = ''
if vim.fn.executable('fcitx5-remote') == 1 then
  fcitx_cmd = 'fcitx5-remote'
elseif vim.fn.executable('fcitx-remote') == 1 then
  fcitx_cmd = 'fcitx-remote'
else
  vim.notify('fcitx5-remote or fcitx-remote executable not found',
      vim.log.levels.ERROR)
  return M
end

function M.turn_on()
  vim.fn.jobstart({ fcitx_cmd, '-o' }, { detach = true })
end

function M.turn_off()
  vim.fn.jobstart({ fcitx_cmd, '-c' }, { detach = true })
end

function M.save()
  local fcitx_state = tonumber(vim.fn.system(fcitx_cmd))
  if fcitx_state == 2 then
    vim.b.was_fcitx_on = true
  else
    vim.b.was_fcitx_on = false
  end
end

function M.restore()
  if vim.b.was_fcitx_on then
    fcitx.turn_on()
  else
    fcitx.turn_off()
  end
end

function M.setup(_)
  vim.api.nvim_create_autocmd('InsertEnter', {
    callback = M.restore,
  })
  vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
      M.save()
      M.turn_off()
    end,
  })
end

return M
