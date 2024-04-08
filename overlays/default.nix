# ./overlays/default.nix
{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz"))
  ];
}
