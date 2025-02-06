sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/robbyrussell/norm/g' ~/.zshrc
sudo apt update && sudo apt install -y fzf atool
sed -i 's/(git)/(git fzf nmap)/g' ~/.zshrc
/usr/bin/setxkbmap -option "ctrl:nocaps"
/bin/zsh
#echo 'export VISUAL=nvim' >> .zshrc
#echo 'export EDITOR="$VISUAL"' >> .zshrc
#bash -c "$(curl -fsSL https://raw.githubusercontent.com/jdhao/nvim-config/refs/heads/main/docs/nvim_setup_linux.sh)"

