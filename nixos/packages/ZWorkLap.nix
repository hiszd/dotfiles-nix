
{
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
      inter
  ];

  nixpkgs.config.vivaldi = {
    proprietaryCodecs = true;
    enableWideVine = true;
  };

programs.git.enable = true;
  programs.fish.enable = true;
    programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
    };
  };

  users.defaultUserShell = pkgs.fish;

}
