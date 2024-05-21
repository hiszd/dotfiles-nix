# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # neovim-nightly = inputs.neovim-nightly-overlay.overlay;
  neovim-nightly = (import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
  }));

  ocaml-packages = final: _prev: {
    ocaml-packages = import inputs.nixpkgs-ocaml {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
