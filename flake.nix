{
  description = "My personal flake";

  inputs = {
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, hyprland, nixpkgs, ... }:
    let
      nixos-system = import ./system/nixos.nix { inherit inputs; };
    in
    {
      nixosConfigurations = {
        noizos = nixos-system "noizos";
        ZWorkLap = nixos-system "ZWorkLap";
        ZGamePC = nixos-system "ZGamePC";
      };
    };
}
