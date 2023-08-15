nix-shell -p git --run "
git clone --bare https://github.com/hiszd/.dot-files $HOME/.cfg &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout &&
git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no"
