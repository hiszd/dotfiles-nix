nix-shell -p git --run "
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' &&
git clone --bare https://github.com/hiszd/.dot-files $HOME/.cfg &&
config checkout &&
config config --local status.showUntrackedFiles no"
