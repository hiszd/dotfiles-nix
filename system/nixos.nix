{ inputs }:

system:

let
  hardware-configuration = import ./hardware-configuration.nix;
  configuration = import ../module/configuration.nix;
  home-manager = import ../module/home-manager.nix;
in
inputs.nixpkgs.lib.nixosSystem {
  system = system;
  specialArgs = { inherit inputs; };
  # modules: allows for reusable code
  modules = [
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      security.sudo.enable = true;
      security.sudo.wheelNeedsPassword = false;
      services.openssh.enable = true;
      networking.hostName = "noizos"; 
      networking.networkmanager.enable = true;
      users.mutableUsers = false;
      users.users.zion = {
        extraGroups = [ "wheel" "networkmanager" "pipewire" "audio" ];
        description = "Zion Koyl";
        isNormalUser = true;
        passwordFile = "/home/zion/.nix-creds";
      };
      system.stateVersion = "23.05";
    }
    hardware-configuration
    configuration
    home-manager
    # add more nix modules here
  ];
}
