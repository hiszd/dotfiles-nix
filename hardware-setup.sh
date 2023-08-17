nix-shell -p git --run "
sudo git add --intent-to-add system/hardware-configuration.nix
git update-index --assume-unchanged system/hardware-configuration.nix"
