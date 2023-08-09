# kickstart.nix
Kickstart your Nix environment.


## Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Personalizing Your Environment](#personalizing-your-environment)


## Prerequisites

- Familiarity with terminal commands.
- An account on [GitHub](https://github.com/) for forking the repository.
- [GitHub CLI](https://github.com/cli/cli) (`gh`) installed for some commands.


## Initial Setup

Choose the appropriate setup instructions based on your operating system.

### NixOS

1. Add the following to `/etc/nixos/configuration.nix` to enable `nix-command` and `flakes` features:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

2. Update you system to reflect the changes:

```bash
nixos-rebuild switch
```

3. Fork this repository to create your own flake kickstart.

> **Note**
> This can be done in the Github UI at: https://github.com/ALT-F4-LLC/kickstart.nix

```bash
gh repo fork ALT-F4-LLC/kickstart.nix
```

4. Clone your new fork locally to customize:

> **Note**
> If the following command does not work revist steps 1 & 2.

```bash
nix run nixpkgs#git clone https://github.com/<username>/kickstart.nix
```

5. Update the following value(s) in `flake.nix` configuration:

```nix
let
    username = "<insert-username>"; # replace
in
```

6. Switch to `kickstart.nix` environment for your system with flake configuration:

```bash
nixos-rebuild switch --flake ".#nixos-aarch64" # for ARM Chipsets
nixos-rebuild switch --flake ".#nixos-x86_64" # for Intel Chipsets
```


## Personalizing Your Environment

You can further tailor your Nix environment through configurations.

### NixOS

> **Important**
> The default user password can be found and updated in `./system/nixos.nix`. 

- `nixos` system hardware options exist in `./system/nixos-hardware-configuration.nix`
- `nixos` system options exist in `./system/nixos.nix`
- `home-manager` system options exist in `./system/nixos.nix`

- `nix` system options exist in `./module/configuration.nix`
- `home-manager` user options exist in `./module/home-manager.nix`
