# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.ocaml-packages
      outputs.overlays.neovim-nightly

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
    bluez
    pulseaudio
    yadm
    fzf
    unzip
    zip
    bc
    spotify-player
    sddm-chili-theme
    neovim-nightly
    floorp
    postgres-lsp
    kitty
    wezterm.terminfo
    grimblast
    gnumake
    git
    wget
    ripgrep
    chromium
    gcc
    nodejs_22
    nodePackages_latest.prettier
    firefox-devedition
    polkit_gnome
    ffmpeg
    viewnior
    rofi
    pamixer
    pavucontrol
    xfce.thunar
    starship
    wl-clipboard
    wf-recorder
    swaybg
    ffmpegthumbnailer
    xfce.tumbler
    playerctl
    xfce.thunar-archive-plugin
    wlogout
    gtklock
    dunst
    wofi
    brightnessctl
    hyprpicker
    tmux
    tmuxinator
    linuxKernel.packages.linux_zen.nvidia_x11
    gparted
    eww
    sway
    nerdfonts
    pipewire
    qpwgraph
    qjackctl
    mpv
    mp4v2
    openh264
    ffmpegthumbnailer
    rdesktop
    killall
    openvpn
    lua-language-server
    cifs-utils
    codeium
    nil
    gimp
    ntfs3g
    acpi
    go
    libpqxx
    postgresql
    vscode-langservers-extracted
    libva-utils
    libxkbcommon
    xorg.setxkbmap
    ] ++ ( with pkgs.ocaml-packages.ocamlPackages_latest;
      [
        dune_3
        opam
        ocaml
        ocamlformat
        core
        core_extended
        findlib
        utop
        merlin
        ocp-indent
        ocaml-lsp
      ]);


  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    (
      import ./packages/ZWorkLap.nix { inherit pkgs inputs outputs; }
    )
    (
      import ./services/ZWorkLap.nix { inherit pkgs config; }
    )

    # Import your generated (nixos-generate-config) hardware configuration
    ./ZWorkLap-hardware.nix
  ];

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

      boot.loader.efi.canTouchEfiVariables = true;
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
      networking.networkmanager.enable = true;

  networking.hostName = "ZWorkLap";

  users = {
    mutableUsers = false;
    users = {
      zion = {
        description = "Zion Koyl";
        initialPassword = "correcthorsebatterystaple";
        hashedPasswordFile = "/home/zion/.nix-creds";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
        ];
        extraGroups = [ "wheel" "networkmanager" "pipewire" "audio" "lightdm" ];
      };
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}