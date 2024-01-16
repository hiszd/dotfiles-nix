sudo rm -r ~/.config/hypr
sudo rm -r ~/.config/fish

alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

nix-shell -p git --run "
git config --global credential.helper store &&
git config --global user.email 'hiszd1@gmail.com' &&
git config --global user.name 'Zion Koyl' &&
git clone --bare https://github.com/hiszd/.dot-files $HOME/.cfg &&
config checkout nix &&
config config --local status.showUntrackedFiles no &&
config submodule init &&
config submodule update"
