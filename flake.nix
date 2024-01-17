{
  description = "Example kickstart Nix development setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
# wezterm.url = "github:wez/wezterm";
  };

  outputs = inputs@{ self, hyprland, home-manager, nixpkgs, ... }:
    let
      nixos-system = import ./system/nixos.nix { inherit inputs; };
    in
    {
      nixosConfigurations = {
        noizos = nixos-system "x86_64-linux";
      };
    };
}
