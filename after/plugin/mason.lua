require('mason').setup({
  pip = {
    -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
    upgrade_pip = false,

    -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
    -- and is not recommended.
    --
    -- Example: { "--proxy", "https://proxyserver" }
    install_args = {},
  },

  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 4,

  github = {
    -- The template URL to use when downloading assets from GitHub.
    -- The placeholders are the following (in order):
    -- 1. The repository (e.g. "rust-lang/rust-analyzer")
    -- 2. The release version (e.g. "v0.3.0")
    -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
    download_url_template = 'https://github.com/%s/releases/download/%s/%s',
  },

  -- The provider implementations to use for resolving package metadata (latest version, available versions, etc.).
  -- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
  -- Builtin providers are:
  --   - mason.providers.registry-api (default) - uses the https://api.mason-registry.dev API
  --   - mason.providers.client                 - uses only client-side tooling to resolve metadata
  providers = {
    'mason.providers.registry-api',
  },

  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = 'none',

    icons = { package_pending = ' ', package_installed = ' ', package_uninstalled = ' ﮊ' },

    keymaps = {
      toggle_package_expand = '<CR>', -- expand a package
      install_package = 'i', -- install the package under the current cursor position
      update_package = 'u', -- reinstall/update the package under the current cursor position
      check_package_version = 'c', -- check for new version for the package under the current cursor position
      update_all_packages = 'U', -- update all installed packages
      check_outdated_packages = 'C', -- check which installed packages are outdated
      uninstall_package = 'X', -- uninstall a package
      cancel_installation = '<C-c>', -- cancel a package installation
      apply_language_filter = '<C-f>', -- apply language filter
    },
  },
})
