#!/bin/bash
perl -pi -e 's/call plug#end\\(\\)/Plug \\'vim-autoformat\\/vim-autoformat\\'\\ncall plug#end\\(\\)/g' ~/.vimrc

#sudo dnf install clang-format python3-autopep8 nodejs npm cpanminus python3-sqlparse golang
sudo apt install -y clang-format python3-autopep8 nodejs npm cpanminus python3-sqlparse golang

sudo npm install -g eslint fixjson prettier @prettier/plugin-php

echo '{ "plugins": ["@prettier/plugin-php"] }' > ~/.prettierrc

cpanm Perl::Tidy

go install mvdan.cc/sh/v3/cmd/shfmt@latest
