# scratch-pad.nvim

A minimal Neovim plugin that opens a floating scratch pad popup.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "l4rma/scratch-pad.nvim",
  config = function()
    require("scratch-pad").setup()
  end,
}
```

## Usage

Run `:ScratchPad` to toggle the scratch pad popup.

By default, `<leader>sp` toggles the scratch pad. You can customize the
title and keybinding via `setup()`:

```lua
require("scratch-pad").setup({
  scratch_title = { "# Scratch pad", "---", "" },
  keymap = "<leader>sp",
})
```

## Help

See `:help scratch-pad` for full documentation.
