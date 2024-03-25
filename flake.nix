{
  description = "Example kickstart Nix development setup.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    # wezterm.url = "github:wez/wezterm";
    ocaml-overlay = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
