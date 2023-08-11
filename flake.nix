{
  description = "Example kickstart Nix development setup.";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
    let
      nixos-system = import ./system/nixos.nix { inherit inputs; };
    in
    {
      nixosConfigurations = {
        noizos = nixos-system "x86_64-linux";
      };
    };
}
