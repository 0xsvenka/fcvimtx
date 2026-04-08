# fcVIMtx

A Neovim plugin that saves & restores Fcitx state between modes.

## Requirements

- Neovim (obviously)
- Fcitx5 or Fcitx, with `fcitx5-remote` or `fcitx-remote` in `$PATH`

## Installation

### Using the builtin `vim.pack` (Neovim v0.12+)

```lua
vim.pack.add { 'https://github.com/0xsvenka/fcvimtx' }
require('fcvimtx').setup {}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  '0xsvenka/fcvimtx',
  config = function()
    require('fcvimtx').setup {}
  end,
}
```

Other plugin managers should follow similar patterns.

## Usage

The `setup` function, as shown above, provides the default behavior: disable the input method after saving its state when leaving insert mode, then restore that state when entering insert mode.

Alternatively, you can bypass `setup` and create your own autocmds by using the functions provided by fcVIMtx:

```lua
local fcvimtx = require('fcvimtx')
fcvimtx.turn_on()
fcvimtx.turn_off()
fcvimtx.save()
fcvimtx.restore()
```

For reference, the `setup` function creates these two autocmds:

```lua
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = fcvimtx.restore,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    fcvimtx.save()
    fcvimtx.turn_off()
  end,
})
```

## Acknowledgements

- [lilydjwg/fcitx.vim](https://github.com/lilydjwg/fcitx.vim)
- [h-hg/fcitx.nvim](https://github.com/h-hg/fcitx.nvim)
