{
    config,
    pkgs,
    ...
}: 
let my-rules = pkgs.writeTextFile {
  name = "50-hiszd-keeb-rules.rules";
  text = ''
    SUBSYSTEMS=="usb", ATTRS{manufacturer}=="HisZd", GROUP="users", TAG+="uaccess"
    '';
  destination = "/etc/udev/rules.d/50-hiszd-keeb-rules.rules";
};
in
{

  boot.loader.systemd-boot.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    XDG_DATA_HOME = "$HOME/.local/share";
  };

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
    wantedBy = [ "default.target" ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.extraConfig = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  services.flatpak.enable = true;

  services.displayManager = {
    enable = true;
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
  services.xserver = {
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

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
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

}
