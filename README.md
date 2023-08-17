1. Add the following to `/etc/nixos/configuration.nix` to enable `nix-command` and `flakes` features:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

2. Update you system to reflect the changes:

```bash
nixos-rebuild switch
```

3. Initialize dotfiles and git config:
```bash
./dotfiles-setup.sh
```
4. Copy hardware-configuration.nix from install wizard and setup for build:
```bash
cp /etc/nixos/hardware-configuration.nix ./system
./hardware-setup.sh
```

5. Build new system with what is in the flake:
```bash
nixos-rebuild switch --flake ".#noizos"
```
