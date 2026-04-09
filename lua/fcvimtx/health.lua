local M = {}

function M.check()
  local health = vim.health

  health.start('Requirements')

  if vim.fn.executable('fcitx5-remote') == 1 then
    health.ok('fcitx5-remote found')
  elseif vim.fn.executable('fcitx-remote') == 1 then
    health.ok('fcitx-remote found')
  else
    health.error('Neither fcitx5-remote nor fcitx-remote is found!')
  end
end

return M
