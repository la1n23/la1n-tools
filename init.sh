#printf "Enable vim copilot? [y/N] ";
#read answ;
#COPILOT=0;
#if echo "$answ" | grep -q '[yY]'; then
#  echo "Install copilot";
#  COPILOT=1;
#fi

### Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/funky/g' ~/.zshrc
sudo apt update && sudo apt install -y fzf atool vifm
sed -i 's/(git)/(git fzf nmap)/g' ~/.zshrc
sudo chsh $(whoami) -s $(which zsh)
echo 'export TERM=xterm-256color' >> ~/.zshrc
# ParrotOS is shit and gay
echo "zsh -i" >> ~/.bashrc
# TODO: configure omz theme to display current IP

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

cat << DESU > ~/.vimrc
call plug#begin('~/.vim/plugged')"
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }"
Plug 'itchyny/lightline.vim'
Plug 'StanAngeloff/php.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

set autoindent expandtab tabstop=2 shiftwidth=2
set autoindent
set number
set background=dark
colorscheme solarized8

set laststatus=2
DESU

vim -c PlugInstall +qa

gsettings set org.gnome.desktop.lockdown disable-lock-screen true
xset -dpms

# TODO: migrate to nvim
#echo 'export VISUAL=nvim' >> .zshrc
#echo 'export EDITOR="$VISUAL"' >> .zshrc
#bash -c "$(curl -fsSL https://raw.githubusercontent.com/jdhao/nvim-config/refs/heads/main/docs/nvim_setup_linux.sh)"

# Copilot for vim
# install nodejs
# sudo apt install -y node
#git clone --depth=1 https://github.com/github/copilot.vim.git ~/.vim/pack/github/start/copilot.vim
#vim -c 'Copilot setup'


/bin/zsh -i
