# nvim-config

My Neovim configuration is built with the [lazy.nvim](https://lazy.folke.io/)
plugin manager, and [mason.nvim](https://github.com/mason-org/mason.nvim)
package manager.

I try to keep this configuration portable, however some dependencies are
defined in my [NixOS flake](https://github.com/ChristofferNissen/nixos-config/blob/main/home-manager/configs/neovim.nix).

## Minimal Configuration

For a lightweight editing experience, you can use the minimal plugin set by modifying `lua/config/lazy.lua`:

```lua
require("lazy").setup({
    spec = {
        -- Use minimal config instead of all plugins
        { import = "plugins.minimal" },
    },
    -- ... rest of config
})
```

The minimal configuration (`lua/plugins/minimal.lua`) includes only **10 essential plugins**:

| Plugin | Purpose |
|--------|---------|
| nvim-treesitter | Syntax highlighting and code understanding |
| telescope.nvim | Fuzzy finder for files, text, and more |
| tokyonight.nvim | Color scheme |
| mason.nvim | LSP/tool installer |
| blink.cmp | Auto-completion |
| gitsigns.nvim | Git integration (signs, blame, etc.) |
| Comment.nvim | Code commenting (gcc, gc in visual) |
| nvim-autopairs | Auto-close brackets and quotes |
| nvim-surround | Surround text with brackets/quotes |
| mini.icons | Icons support |

### Full vs Minimal Comparison

| Feature | Full Config | Minimal Config |
|---------|-------------|----------------|
| Plugins | 50+ | 10 |
| Startup time | Higher | Lower |
| Copilot/AI | ✓ | ✗ |
| DAP/Debugging | ✓ | ✗ |
| Test runner | ✓ | ✗ |
| File explorer | ✓ (Otree/Oil) | ✗ (use netrw) |
| Status line | ✓ (Lualine) | ✗ (built-in) |
| Diagnostics UI | ✓ (Trouble) | ✗ (built-in) |
| Language-specific | Go, C#, Java, etc. | ✗ |
| Session mgmt | ✓ (persistence.nvim) | ✗ |

### Customizing the Minimal Config

To add more plugins to your minimal setup, edit `lua/plugins/minimal.lua` or create additional plugin files that will be auto-loaded.

## Add a plugin

Plugins are defined in `lua/plugins.lua`. In order to make the config
more maintainable, I've added a `lua/plugins/*.lua` file for each plugin.

Any lua file in `lua/plugins/*.lua` will be automatically merged in the main
plugin spec by lazy.

## Add a language server with LSP

This configuration uses the nvim v0.11 native lsp integration option.

Add a lsp spec in `lsp/`:

example: gleamls.lua

```lua
---@type vim.lsp.Config
return {
    cmd = { "gleam", "lsp" },
    filetypes = { "gleam" },
    root_markers = {
        "gleam.toml",
    },
}
```

Enable the LS in `lua/ChristofferNissen/lsp.lua`

```lua
-- LSP configs in lsp/
vim.lsp.enable({
    "azure_pipelines_ls",
    "bashls",
    "cssls",
    "docker_compose_language_service",
    ...
    "gleamls" <- new lsp
    ...
})
```

The name of the file ("gleamls" in this case) must match the entry in
vim.lsp.enable.

## Add a Debug Adapter with DAP

Tbd

## Testing

You can test config changes by running `task test` which will setup a test config folder under `~/.config`.

You can check the health in the new config with:

```vim
:checkhealth lazy
```
