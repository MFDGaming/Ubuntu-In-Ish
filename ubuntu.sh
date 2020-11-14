#!/usr/bin/env sh

clear
printf "This Project is distributed under the Lisence GPLv3 by MFDGaming\n"

UBUNTU_VERSION=18.04.5
DIR=ubuntu-fs
ARCHITECTURE=i386

INSTP1 () {

if [ -d "$DIR" ];then
FIRST=1
printf "Do you want to reinstall ubuntu-in-ish? [Y/n] "
read CMDR
if [ "$CMDR" = "y" ];then
INSTP2
elif [ "$CMDR" = "Y" ];then
INSTP2
else
printf "Reinstallation aborted.\n"
exit
fi
elif [ -z "$(command -v wget)" ];then
printf "Please install wget.\n"
exit
fi
if [ "$FIRST" != 1 ];then
INSTP2
fi
}
INSTP2 () {
if [ -f "ubuntu.tar.gz" ];then
rm -rf ubuntu.tar.gz
fi
if [ ! -f "ubuntu.tar.gz" ];then
printf "Downloading the ubuntu rootfs, please wait...\n"
wget http://cdimage.ubuntu.com/ubuntu-base/releases/${UBUNTU_VERSION}/release/ubuntu-base-${UBUNTU_VERSION}-base-${ARCHITECTURE}.tar.gz -q -O ubuntu.tar.gz
printf "Download complete!\n"
fi
cur=`pwd`
mkdir -p $DIR
cd $DIR
mkdir dev
printf "Decompressing the ubuntu rootfs, please wait...\n"
tar -zxf $cur/ubuntu.tar.gz --exclude='dev'||:
printf "The ubuntu rootfs have been successfully decompressed!\n"
printf "Fixed the resolv.conf, so that you have access to the internet\n"
printf "nameserver 8.8.8.8\nnameserver 8.8.4.4\n" > etc/resolv.conf
cd $cur

mkdir -p ubuntu-binds
bin=startubuntu.sh
printf "Creating the start script, please wait...\n"
cat > $bin <<- EOM
#!/usr/bin/env sh
cd \$(dirname \$0)
rm -rf ubuntu-fs/sys
rm -rf ubuntu-fs/dev
mount -t proc none ubuntu-fs/proc
ln -s /sys ubuntu-fs/sys
ln -s /dev ubuntu-fs/dev
chroot ubuntu-fs/ /bin/bash
EOM
printf "The start script has been successfully created!\n"
printf "Making startubuntu.sh executable, please wait...\n"
chmod +x $bin
printf "Successfully made startubuntu.sh executable\n"
printf "Cleaning up, please wait...\n"
rm ubuntu.tar.gz -rf
printf "Successfully cleaned up!\n"
printf "The installation has been completed! You can now launch Ubuntu with ./startubuntu.sh\n"
printf "\e[0m"
}
if [ "$1" = "-y" ];then
INSTP1
elif [ "$1" = "-Y" ];then
INSTP1
elif [ "$1" = "" ];then
printf "Do you want to install ubuntu-in-termux? [Y/n] "

read CMDI
if [ "$CMDI" = "y" ];then
INSTP1
elif [ "$CMDI" = "Y" ];then 
INSTP1 
else 
printf "Installation aborted.\n" 
exit 
fi 
else 
printf "Installation aborted.\n" 
fi
