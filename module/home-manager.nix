{ pkgs, inputs, ... }:

{
  imports = [ "${inputs.home-manager}/nixos" ];

  # add home-manager user settings here
  home-manager.users.zion = {
    home.stateVersion = "23.05";
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

    programs.git = {
      enable = true;
      userName  = "my_git_username";
      userEmail = "my_git_username@gmail.com";
    };

  };
}
