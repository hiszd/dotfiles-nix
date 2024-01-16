{ pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  # add home-manager user settings here
  home-manager.users.zion = {
    home.stateVersion = "23.11";

    # programs.neovim = {
    #   enable = true;
    #   defaultEditor = true;
    # };

    # TODO:
    # Need to write config as plugin, or find better way to source git repo

    # programs.neovim = let nvimcfg = builtins.fetchGit {
    #   url = "https://github.com/hiszd/.dot-files-nvim";
    #   ref = "nix";
    # };
    # in {
    #   extraConfig = ":luafile ${nvimcfg.outPath}/init.lua";
    #   defaultEditor= true;
    #   enable = true;
    # };
  };
}
