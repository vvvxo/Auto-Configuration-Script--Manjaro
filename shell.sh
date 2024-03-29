#!/bin/bash

echo "============================="
echo "更新源相关操作"
sudo pacman-mirrors -i -c China -m rank

sudo pacman-optimize && sync

sudo echo -e "\n[archlinuxcn]\nSigLevel = Optional TrustedOnly\nServer = https://mirrors.cloud.tencent.com/archlinuxcn/$arch" >> /etc/pacman.conf

sudo pacman -Syyu && sudo pacman -S --noconfirm archlinuxcn-keyring

echo "============================="
echo "解决时间同步问题"

sudo timedatectl set-ntp true

echo "============================="
echo "安装yay"
sudo pacman -S --noconfirm yay

echo "============================="
echo "安装常用软件"
sudo pacman -S --noconfirm shadowsocks-qt5 fcitx-im fcitx-configtool fcitx-sogoupinyin visual-studio-code-bin ttf-dejavu-sans-mono-powerline python-powerline powerline powerline-common
#设置代理
echo -e "set http_proxy=socks5://127.0.0.1:1080\nset https_proxy=socks5://127.0.0.1:1080\n" >> ~/.zshrc
git config --global http.proxy socks5://127.0.0.1:1080
git config --global https.proxy socks5://127.0.0.1:1080

echo "============================="
echo "配置输入法"

sudo echo -e "export GTK_IM_MODULE=fcitx\nexport QT_IM_MODULE=fcitx\nexport XMODIFIERS=@im=fcitx" >> ~/.xprofile

echo "以下操作请设置好代理后再运行"
res = N
until [$res == y] 
do
	echo "代理是否已设置好[y/n]"
	read res
done 

echo "============================="
echo "安装zsh"
sudo pacman -S --noconfirm zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
echo "安装zsh插件"
sudo pacman -S --noconfirm autojump
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

echo "修改agnoster主题"
wget https://raw.githubusercontent.com/vvvxo/Auto-Configuration-Script--Manjaro/master/agnoster.zsh-theme -O  ~/.oh-my-zsh/themes/agnoster.zsh-theme
echo "复制zsh配置"
wget https://raw.githubusercontent.com/vvvxo/Auto-Configuration-Script--Manjaro/master/.zshrc -O ~/.zshrc



echo "============================"
echo "安装spacevim"
curl -sLf https://spacevim.org/cn/install.sh | bash

echo "============================"
echo "安装jetbrains-toolbox和JBR运行环境"
yay -S --noconfirm jetbrains-toolbox jetbrains-jre 

echo "============================"
echo "安装字体"
yay -S --noconfirm ttf-sarasa-gothic powerline-fonts

echo "============================"
echo "安装snap"
yay -S --noconfirm snap

sudo snap install mathpix-snipping-tool


echo "============================"
echo "安装wine及依赖"
yay -S --noconfirm wine winetricks wine-gecko wine-mono
sudo winetricks --self-update

winetricks corefonts colorprofile
winetricks fontfix fontsmooth-gray fontsmooth-rgb fontsmooth-bgr
winetricks gdiplus
winetricks d3dx9
winetricks riched20 riched30
winetricks mfc40 mfc42
winetricks vcrun6 vb6run vcrun2003 vcrun2005 vcrun2008
winetricks msxml3 msxml4 msxml6
winetricks wsh57





# ....
echo "============================="
echo "Reboot now? Y/N"
 
read res
 
if [[ $res = "Y"||$res = "y" ]]
then
        reboot
elif [[ $res = "N"||$res = "n" ]]
then
        echo "============================="
        echo -e "OK!\nBut if you need,you can edit the program."

fi
