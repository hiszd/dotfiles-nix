{
  description = "Example kickstart Nix development setup.";

  inputs = {
    # Use this repo as the `nixpkgs` URL
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    # wezterm.url = "github:wez/wezterm";
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
