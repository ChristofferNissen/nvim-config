# nvim-config

My Neovim configuration is built with the [lazy.nvim](https://lazy.folke.io/) package manager.

## Adding a plugin

Plugins are normally defined in `lua/plugins.lua`. In order to make the config
more maintainable, I've added a `lua/plugins/*.lua` file for each plugin.

Any lua file in `lua/plugins/*.lua` will be automatically merged in the main
plugin spec.

## Testing

You can test config changes by running `task test` which will setup a test config folder under `~/.config`.

You can check the health in the new config with:

```vim
:checkhealth lazy
```

