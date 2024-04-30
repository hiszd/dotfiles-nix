{config, inputs,...}:
let pkgs = import inputs.nixpkgs {}; in
let my-rules = pkgs.writeTextFile {
  name = "50-hiszd-keeb-rules.rules";
  text = ''
    SUBSYSTEMS=="usb", ATTRS{manufacturer}=="HisZd", GROUP="users", TAG+="uaccess"
    '';
  destination = "/etc/udev/rules.d/50-hiszd-keeb-rules.rules";
};
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  environment.systemPackages = with pkgs; [
    bluez
    pulseaudio
    yadm
    fzf
    unzip
    zip
    bc
    spotify-player
    sddm-chili-theme
    neovim
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
    nodejs_21
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
    home-manager
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
    ] ++ ( with pkgs.ocamlPackages_latest;
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

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    XDG_DATA_HOME = "$HOME/.local/share";
  };

  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
  inter
  ];

  services.udev.packages = [ my-rules ];

  systemd.services.hid-io = {
    enable = true;
    description = "HID IO";
    path = with pkgs; [
      xorg.setxkbmap
    ];
    serviceConfig = {
      ExecStart = "/home/zion/.local/bin/hid-io-core";
      User = "zion";
    };
    wantedBy = [ "hid-io-ergoone.target" ];
  };

  systemd.services.hid-io-ergoone = {
    enable = true;
    description = "HID IO ErgoOne";
    path = with pkgs; [
      pamixer
    ];
    serviceConfig = {
      ExecStart = "/home/zion/.local/bin/hid-io-ergoone";
      User = "zion";
    };
    wantedBy = [ "default.target" ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  services.flatpak.enable = true;

  services.xserver = {
    enable = true;
    displayManager = { 
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        theme = "chili";
        wayland.enable = true;
        # settings = {
        #   Autologin = {
        #     Session = "hyprland";
        #     User = "zion";
        #   };
        # };
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
    extraPackages = with pkgs; [
      intel-media-driver 
      intel-vaapi-driver
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      libva
    ];
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
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
    };
  };
}
