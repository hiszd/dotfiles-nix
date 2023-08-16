sudo rm -r ~/.config/hypr
sudo rm -r ~/.config/fish

nix-shell -p git --run "
git clone --bare https://github.com/hiszd/.dot-files $HOME/.cfg &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout nix &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config submodule init &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config submodule update"
