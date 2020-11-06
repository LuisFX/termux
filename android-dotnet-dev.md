# Instructions to setup a perfect linux dotnet development environment within Android device

Install [Termux](https://play.google.com/store/apps/details?id=com.termux&hl=en&gl=US) app on your android device.

### Install proot

```shell
pkg install proot
pkg install proot-distro
proot-distro install ubuntu
```

### Update Termux itself

Quit all instances of Termux. After that, long-press the app button and launch the app in "failsafe" mode.

```shell
apt update && apt upgrade -y
#apt install neofetch
#neofetch
exit
```

Now you can launch Termux normally.

## Distro Login
After the distro is installed, you must "login". Every step below MUST be run within the distro.

```shell
proot-distro login ubuntu
```

## Update the ubuntu distro

```shell
apt update && apt upgrade -y
#apt install neofetch
#neofetch
```

### Add a user with sudo privileges, and switch to that user

```shell
apt install nano sudo
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

### Install dependencies
sudo apt install wget curl libicu-dev git gpg

### Install dotnet 3.1

```shell
wget https://download.visualstudio.microsoft.com/download/pr/7a027d45-b442-4cc5-91e5-e5ea210ffc75/68c891aaae18468a25803ff7c105cf18/dotnet-sdk-3.1.403-linux-arm64.tar.gz

mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-3.1.403-linux-arm64.tar.gz -C $HOME/dotnet
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
```

### Edit .bashrc

```shell
sudo nano ~/.bashrc
```

Add the following entries to the bottom of the file.

```shell
export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
```

### Install code-server (allows a Visual Code Editor to be user remotely)

```shell
wget https://github.com/cdr/code-server/releases/download/2.1698/code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
tar -xvf ./code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
rm ./code-server2.1698-vsc1.41.1-linux-arm64.tar.gz
cp ./code-server2.1698-vsc1.41.1-linux-arm64/code-server /bin
```

## Add Desktop Environment

#### XFCE

```shell
wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/APT/XFCE4/xfce19.sh -O /root/xfce19.sh
bash ~/xfce19.sh

#wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/DesktopEnvironment/Apt/Xfce4/de-apt-xfce4.sh && sudo bash #de-apt-xfce4.sh
```

#### Install VS code
```shell
. <( wget -O - https://code.headmelted.com/installers/apt.sh )
```


#### Install NVM
```shell
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
```

Edit your bashrc file to "unset PREFIX"
```shell
sudo nano ~/.bashrc
```
Right before "

Logout/reboot device then install node/npm using NVM

#### Install Azure Functions Locally
```shell
npm i -g azure-functions-core-tools@3 --unsafe-perm true
```


```shell
nvm install node
```

#### Install yarn

```shell
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install --no-install-recommends yarn
#esudo apt update && sudo apt install yarn
```