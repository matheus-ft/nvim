# Nvim

Structure:

  - `after` is a folder that neovim "knows" it exists and all its files are automatically sourced right before the
    editor is opened

    - `ftplugin` contains all the filetype specific configurations (only sourced when needed)

    - `plugin` contains all the plugins configurations (names are usually pretty self explanatory)

  - `lua/matheus` basically contains utilities files, which are not automatically sourced, thus they need to be imported
    with
      ```lua
      require('matheus.<file>')
      ```

  - `init.lua` calls packer to be setup and also handles plugin-agnostic settings

  - `plugin` contains only the `packer_compiled.lua` file, which is automatically generated after a new `:PackerCompile`

