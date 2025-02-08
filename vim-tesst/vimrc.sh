### testing color scheme
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cat << DESU >> ~/.vimrc
execute pathogen#infect()
syntax on
filetype plugin indent on  
DESU

cd ~/.vim/bundle && git clone --depth=1 http://github.com/ericbn/vim-solarized.git
cat << DESU >> ~/.vimrc
syntax enable
set background=dark
colorscheme solarized
DESU
