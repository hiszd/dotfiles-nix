
{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inotify-tools
    docker
    docker-compose
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


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
      inter
  ];

  nixpkgs.config.vivaldi = {
    proprietaryCodecs = true;
    enableWideVine = true;
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
