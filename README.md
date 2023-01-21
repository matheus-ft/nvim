# Neovim

<!--toc:start-->

- [Neovim](#neovim)
  - [`init.lua`](#initlua)
  - [`after`](#after)
    - [`after/ftplugin`](#afterftplugin)
    - [`after/plugin`](#afterplugin)
  - [`lua`](#lua) - [`lua/matheus`](#luamatheus) - [`lua/plugin`](#luaplugin)
  <!--toc:end-->

Structure:

## `init.lua`

Calls packer to be setup and also handles plugin-agnostic settings

## `after`

This is a folder that neovim "knows" it exists and its files are automatically sourced right before the
editor is opened

### `after/ftplugin`

Contains all the filetype specific configurations (only sourced when needed)

### `after/plugin`

Contains all the plugins configurations (names are usually pretty self explanatory)

## `lua`

This is a folder that lua "knows" it exists and allow sourcing them from anywhere in the directory using

```lua
require('<path>')
```

### `lua/matheus`

Contains utilities files, which are not automatically sourced, they need to be imported with

```lua
require('matheus.<script>')
```

### `lua/plugin`

Contains plugin settings that, for some reason, are supposed to be manually sourced with

```lua
require('plugin.<config>')
```

---

For other system config files and installation info, check out my [dots](https://github.com/matheus-ft/.dotfiles).
