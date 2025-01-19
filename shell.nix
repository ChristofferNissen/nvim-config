{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  shellHook = ''
    mkdir -p ~/.config/local/lua/ChristofferNissen
    touch ~/.config/local/lua/ChristofferNissen/init.lua 
    ln -sf ~/configs/lazyvim-config/lua/ChristofferNissen/* ~/.config/local/lua/ChristofferNissen/
    ln -sf ~/configs/lazyvim-config/init.lua ~/.config/local/init.lua
    ln -sf ~/configs/lazyvim-config/lua/plugins/* ~/.config/local/lua/plugins/

    export NVIM_APPNAME=local
    export MYVIMRC=/home/cn/.config/local/init.lua
    export NVIM_RTP=/home/cn/.config/local
  '';
}
