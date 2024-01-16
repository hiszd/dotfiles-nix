{config, pkgs, ...}:
  let
  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-unstable.tar.gz";
in
{
  nixpkgs.config = {
      packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
    };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz"
    ))
  ];

  environment.systemPackages = with pkgs; [
    neovim-nightly
    floorp
    postgres-lsp
    kitty
    unstable.wezterm.terminfo
    unstable.grimblast
    gnumake
    git
    wget
    ripgrep
    chromium
    gcc
    nodejs
    ocaml
    dune_3
    opam
    ocamlformat
    firefox-devedition
    polkit_gnome
    ffmpeg
    viewnior
    rofi
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
    home-manager
    linuxKernel.packages.linux_zen.nvidia_x11
    gparted
    unstable.eww-wayland
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
    unstable.codeium
    nil
    gimp
    ntfs3g
    acpi
    go
    libpqxx
    postgresql
    ] ++ ( with ocamlPackages;
      [
        ocaml
        core
        core_extended
        findlib
        utop
        merlin
        ocp-indent
        ocaml-lsp
      ]);

  environment.sessionVariables = {
    XDG_DATA_HOME = "$HOME/.local/share";
  };

  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
  inter
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager = { 
      autoLogin = {
          enable = true;
          user = "zion";
        };
    };
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:14:0:0";
      };
  };
  programs.xwayland.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages = with pkgs; [
    #   intel-media-driver # LIBVA_DRIVER_NAME=iHD
    #   vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    #   vaapiVdpau
    #   libvdpau-va-gl
    #   libva
    # ];
  };

# Set your time zone.
  time.timeZone = "America/Detroit";
  time.hardwareClockInLocalTime = true;

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.defaultUserShell = pkgs.fish;

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.vivaldi = {
    proprietaryCodecs = true;
    enableWideVine = true;
  };



# add more system settings here
  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "@wheel" ];
      warn-dirty = false;
    };
  };
  programs.git.enable = true;
  programs.fish.enable = true;
    programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
    enableNvidiaPatches = false;
    xwayland = {
      enable = true;
    };
  };
}
