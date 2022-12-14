# Neovim

Structure:

- `init.lua` calls packer to be setup and also handles plugin-agnostic settings

- `after` is a folder that neovim "knows" it exists and its files are automatically sourced right before the
  editor is opened

  - `ftplugin` contains all the filetype specific configurations (only sourced when needed)

  - `plugin` contains all the plugins configurations (names are usually pretty self explanatory)

- `lua/matheus` basically contains utilities files, which are not automatically sourced, thus they need to be imported
  with
  ```lua
  require('matheus.<file>')
  ```

For other system config files and installation info, check out my [dots](https://github.com/matheus-ft/.dotfiles).
