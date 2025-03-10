#printf "Enable vim copilot? [y/N] ";
#read answ;
#COPILOT=0;
#if echo "$answ" | grep -q '[yY]'; then
#  echo "Install copilot";
#  COPILOT=1;
#fi

### Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -- --unattended
sed -i 's/robbyrussell/x-lpha3ch0/g' ~/.zshrc
sudo apt update && sudo apt install -y fzf atool vifm rlwrap httrack
sed -i 's/(git)/(git fzf nmap)/g' ~/.zshrc
#sudo chsh $(whoami) -s $(which zsh)
echo 'export TERM=xterm-256color' >> ~/.zshrc
curl 'https://raw.githubusercontent.com/la1n23/la1n-tools/refs/heads/master/x-lpha3ch0.zsh-theme' > ~/.oh-my-zsh/themes/x-lpha3ch0.zsh-theme
echo "export PATH=/home/$(whoami)/la1n-tools:$PATH" >> ~/.zshrc

# gdb enhancer
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# keep bash settings
cat << DESU >> ~/.bashrc

zsh -i
DESU

### Keybinds (need to fix on ParrotOS)
/usr/bin/setxkbmap -option "ctrl:nocaps"
/usr/bin/setxkbmap -option "caps:ctrl_modifier"

cat << DESU >> ~/.zshrc
/usr/bin/setxkbmap -option "ctrl:nocaps"
/usr/bin/setxkbmap -option "caps:ctrl_modifier"
DESU

### VIM
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8

# TODO: testd and fix autocompletion
#Plug 'ncm2/ncm2'
#Plug 'ncm2/ncm2-bufword'
#Plug 'ncm2/ncm2-path'
#autocmd BufEnter * call ncm2#enable_for_buffer()
#set completeopt=noinsert,menuone,noselect

# TODO: comment/uncomment line/region hotkeys
# TODO: autoformat file/region hotkeys
# TODO: doesnt work on parrotos
#Plug 'scrooloose/nerdcommenter'
cat << DESU > ~/.vimrc
call plug#begin('~/.vim/plugged')"
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }"
Plug 'itchyny/lightline.vim'
Plug 'StanAngeloff/php.vim'
Plug 'roxma/nvim-yarp'
call plug#end()

set autoindent expandtab tabstop=2 shiftwidth=2
set autoindent
set number
set background=dark
colorscheme solarized8

set laststatus=2

let mapleader = ","
imap jj <esc>

nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l

filetype plugin on
DESU

vim -c PlugInstall +qa

### dont work :(
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
xset -dpms

### variables for vpn
cat << DESU >> ~/.zshrc
VPN_USER=
VPN_CERT_HASH=
VPN_DOMAIN=
VPN_PORT=
DESU

# TODO: migrate to nvim
#echo 'export VISUAL=nvim' >> .zshrc
#echo 'export EDITOR="$VISUAL"' >> .zshrc
#bash -c "$(curl -fsSL https://raw.githubusercontent.com/jdhao/nvim-config/refs/heads/main/docs/nvim_setup_linux.sh)"

# Copilot for vim
# install nodejs
# sudo apt install -y node
#git clone --depth=1 https://github.com/github/copilot.vim.git ~/.vim/pack/github/start/copilot.vim
#vim -c 'Copilot setup'

echo "Done, start downloading seclists... ctrl+C to skip"
sudo apt install seclists

zsh -i
