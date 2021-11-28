# Instructions to setup a perfect linux dotnet development environment within Android device

Install [Termux](https://play.google.com/store/apps/details?id=com.termux&hl=en&gl=US) app on your android device.

### Update Termux itself

Quit all instances of Termux. After that, long-press the app button and launch the app in "failsafe" mode.

```shell
pkg update -y
#pkg install neofetch
#neofetch
exit
```

Now you can launch Termux normally.

### Enable device storage access
```shell
termux-setup-storage
```

### Install proot

```shell
# pkg install proot
pkg install -y proot-distro
proot-distro install debian-buster
```


## Distro Login
After the distro is installed, you must "login". Every step below MUST be run within the distro.

```shell
proot-distro login debian-buster
```

## Update distro

```shell
apt update && apt upgrade -y
```

## Install dependencies

```shell
apt install -y firefox-esr nano sudo neofetch wget curl libicu-dev git gpg
```

### Install Chrome and modify desktop link
```
apt install chromium -y
sed -i 's/chromium %U/chromium --no-sandbox %U/g' /usr/share/applications/chromium.desktop
```

### Add a user with sudo privileges, and switch to that user

```shell
sudo useradd -m -s /bin/bash -c "<Display Name>" <username>
sudo passwd <username>
sudo usermod -aG sudo <username>
#sudo adduser <username> sudo
#chmod 0440 /etc/sudoers
```

Edit the "sudoers" list.

```shell
visudo
```

Add this line right below "root"

```shell
<username> ALL=(ALL:ALL) ALL
```

Switch to that user.

```shell
su - <username>
```

### Install dotnet 3.1 and 6.0

```shell
wget https://download.visualstudio.microsoft.com/download/pr/7a027d45-b442-4cc5-91e5-e5ea210ffc75/68c891aaae18468a25803ff7c105cf18/dotnet-sdk-3.1.403-linux-arm64.tar.gz

wget https://download.visualstudio.microsoft.com/download/pr/adcd9310-5072-4179-9b8b-16563b897995/15a7595966f488c74909e4a9273c0e24/dotnet-sdk-6.0.100-linux-arm64.tar.gz


mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-3.1.403-linux-arm64.tar.gz -C $HOME/dotnet
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-6.0.100-linux-arm64.tar.gz -C $HOME/dotnet

echo 'export DOTNET_ROOT=$HOME/dotnet' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/dotnet' >> ~/.bashrc
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

source ~/.bashrc
```

### Install useful dotnet templates

```shell
dotnet new -i SAFE.Template
dotnet new --install Microsoft.Azure.WebJobs.ProjectTemplates::3.1.1624
dotnet new --install Microsoft.Azure.WebJobs.ItemTemplates::3.1.1624
```

<!-- ### Edit .bashrc

```shell
sudo nano ~/.bashrc
```

Add the following entries to the bottom of the file.

```shell
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
``` -->

### Install code-server (allows a Visual Code Editor to be user remotely)

```shell
#latest release: https://github.com/cdr/code-server/releases

Debian based:
wget https://github.com/cdr/code-server/releases/download/v3.9.0/code-server_3.9.0_arm64.deb
dpkg -i code-server_3.9.0_arm64.deb

wget https://github.com/cdr/code-server/releases/download/v3.9.0/code-server-3.9.0-linux-arm64.tar.gz
wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
tar -xvf ./code-server-3.9.0-linux-arm64.tar.gz
rm ./code-server-3.9.0-linux-arm64.tar.gz
cp ./code-server-3.9.0-linux-arm64/code-server /bin

#run example: code-server --port 8445 --auth none --bind-addr <ip> (192.168.0.1)
```

## Add Desktop Environment

#### XFCE

```shell
mkdir code && cd code
git clone https://github.com/luisfx/termux.git && cd termux
chmod +x andronix_xfce19.sh
./andronix_xfce19.sh

# wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/APT/XFCE4/xfce19.sh -O /root/xfce19.sh
# bash ~/xfce19.sh

#wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Xfce4/de-apt-xfce4.sh && sudo bash #de-apt-xfce4.sh
```

#### Install VS code
```shell
wget -O- https://code.headmelted.com/installers/apt.sh | sudo bash
```


#### Install NVM
```shell
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | sudosudo bash
```

Edit your bashrc file to "unset PREFIX"
```shell
sudo nano ~/.bashrc
```
Right before "

Logout/reboot device then install node/npm using NVM


```shell
nvm install node
```

#### Install Azure Functions Locally
```shell
npm i -g azure-functions-core-tools@3 --unsafe-perm true
```

#### Install yarn

```shell
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install --no-install-recommends yarn
#esudo apt update && sudo apt install yarn
```
