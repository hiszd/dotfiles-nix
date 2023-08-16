{ pkgs, inputs, ... }:

{
  imports = [ <home-manager/nixos> ];

  # add home-manager user settings here
  home-manager.users.zion = {
    home.stateVersion = "23.11";
    home.packages = with pkgs; [ 
    git
    neovim
    wget
    rustup
    hyprland
    ];

    programs.neovim = {
      extraConfig = pkgs.lib.fileContents /home/zion/.config/nvim/init.lua;
    };
  };
}
