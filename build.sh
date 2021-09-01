sudo pacman -Syu

cd $HOME
mkdir -p $HOME/development/resources/dotfiles
mkdir -p $HOME/development/resources/scripts
mkdir -p $HOME/development/algorithms

sudo pacman -S tmux yarn nvm neovim clang xclip xsel ccls ruby github-cli solaar net-tools

gh auth login

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

export DOTFILES="$HOME/development/resources/dotfiles"
alias config="/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME"


config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs dirname | sort | uniq | xargs -I{} mkdir -p .config-backup/{}

config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
echo "$DOTFILES" >> .gitignore
git clone --bare git@github.com:dgcnz/dotfiles.git $DOTFILES
gh repo clone dgcnz/dotfiles $HOME/development/resources/dotfiles -- --bare
config config --local status.showUntrackedFiles no

gh repo clone dgcnz/competitive-programming $HOME/development/algorithms/competitive-programming
gh repo clone dgcnz/cp-library $HOME/development/algorithms/cp-library
gh repo clone atcoder/ac-library $HOME/development/algorithms/ac-library

pamac build google-chrome dbg-macro discord
sudo pacman -Rcn lightdm
