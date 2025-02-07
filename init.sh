sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/funky/g' ~/.zshrc
sudo apt update && sudo apt install -y fzf atool
sed -i 's/(git)/(git fzf nmap)/g' ~/.zshrc
/usr/bin/setxkbmap -option "ctrl:nocaps"
/usr/bin/setxkbmap -option "caps:ctrl_modifier"
sudo chsh $(whoami) -s $(which zsh)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat << DESU >> ~/.vimrc
call plug#begin('~/.vim/plugged')"
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }"
call plug#end()
set autoindent expandtab tabstop=2 shiftwidth=2
set autoindent
set number
DESU

vim -c PlugInstall +qa

/bin/zsh -i

# TODO: find or create nice nvim config
#echo 'export VISUAL=nvim' >> .zshrc
#echo 'export EDITOR="$VISUAL"' >> .zshrc
#bash -c "$(curl -fsSL https://raw.githubusercontent.com/jdhao/nvim-config/refs/heads/main/docs/nvim_setup_linux.sh)"

