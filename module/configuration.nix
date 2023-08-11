{inputs, pkgs, ...}:
{

  environment.systemPackages = with pkgs; [
    neovim
    kitty
    git
    wget
    ripgrep
    chromium
    gcc
    nodejs_20
    ocaml
    opam
    ocamlformat
    ocamlPackages.ocaml-lsp
    firefox-devedition-unwrapped
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
    lightdm
    lightdm-slick-greeter
    dunst
    wofi
    brightnessctl
    hyprpicker
    tmux
    tmuxinator
    home-manager
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  services.xserver = {
    enable = true;
    displayManager = { 
      defaultSession = "hyprland"; 
      autoLogin.enable =  false;
      lightdm = { 
        enable = true; 
        greeter = {
          enable = true;
          name = "lightdm-slick-greeter";
        };
      }; 
    };
  };

  # Set your time zone.
  time.timeZone = "America/Detroit";

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

  users.users.zion.shell = pkgs.fish;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # add more system settings here
  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
      # Enable the OpenSSH daemon.
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
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
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
