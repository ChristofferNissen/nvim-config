# nvim-config

My Neovim configuration is built with the [lazy.nvim](https://lazy.folke.io/)
plugin manager, and [mason.nvim](https://github.com/mason-org/mason.nvim)
package manager.

I try to keep this configuration portable, however some dependencies are
defined in my [NixOS flake](https://github.com/ChristofferNissen/nixos-config/blob/main/home-manager/configs/neovim.nix).

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
