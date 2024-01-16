{
  description = "Example kickstart Nix development setup.";

  inputs = 
    let
    neovim-nightly-overlay =
    fetchTarball
    "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  in
    let
    overlays = [
    neovim-nightly-overlay
    ];
  in
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.overlays = overlays;
# home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
# wezterm.url = "github:wez/wezterm";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
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
