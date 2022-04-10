#!/bin/bash
HOME="/home/container"
HOMEA="$HOME/linux/.apt"
STAR1="$HOMEA/lib:$HOMEA/usr/lib:$HOMEA/var/lib:$HOMEA/usr/lib/x86_64-linux-gnu:$HOMEA/lib/x86_64-linux-gnu:$HOMEA/lib:$HOMEA/usr/lib/sudo"
STAR2="$HOMEA/usr/include/x86_64-linux-gnu:$HOMEA/usr/include/x86_64-linux-gnu/bits:$HOMEA/usr/include/x86_64-linux-gnu/gnu"
STAR3="$HOMEA/usr/share/lintian/overrides/:$HOMEA/usr/src/glibc/debian/:$HOMEA/usr/src/glibc/debian/debhelper.in:$HOMEA/usr/lib/mono"
STAR4="$HOMEA/usr/src/glibc/debian/control.in:$HOMEA/usr/lib/x86_64-linux-gnu/libcanberra-0.30:$HOMEA/usr/lib/x86_64-linux-gnu/libgtk2.0-0"
STAR5="$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/printbackends"
STAR6="$HOMEA/usr/lib/x86_64-linux-gnu/samba/:$HOMEA/usr/lib/x86_64-linux-gnu/pulseaudio:$HOMEA/usr/lib/x86_64-linux-gnu/blas:$HOMEA/usr/lib/x86_64-linux-gnu/blis-serial"
STAR7="$HOMEA/usr/lib/x86_64-linux-gnu/blis-openmp:$HOMEA/usr/lib/x86_64-linux-gnu/atlas:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-miners-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/lapack:$HOMEA/usr/lib/x86_64-linux-gnu/gedit"
STARALL="$STAR1:$STAR2:$STAR3:$STAR4:$STAR5:$STAR6:$STAR7"
export LD_LIBRARY_PATH=$STARALL
export PATH="$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA

bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")
RED='\033[0;31m'
NC='\033[0m'
clear

if [[ -f "./installed" ]]; then
    echo "
████████╗██████╗  ██████╗ ███████╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗████████╗
╚══██╔══╝██╔══██╗██╔═══██╗██╔════╝██║  ██║██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
   ██║   ██████╔╝██║   ██║███████╗███████║███████║██║   ██║███████╗   ██║   
   ██║   ██╔══██╗██║   ██║╚════██║██╔══██║██╔══██║██║   ██║╚════██║   ██║   
   ██║   ██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╔╝███████║   ██║   
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
    "
    echo "──────────────────────────────────────────────────────────────────────"
    echo "Votre LVPS a été démarré !"
    echo "──────────────────────────────────────────────────────────────────────"
    echo "INFORMATIONS SSH :"
    echo "Hostname : game.troshhost.ml"
    echo "Port : "$1""
    echo "Password : trosh"$1""
    echo "──────────────────────────────────────────────────────────────────────"
    ./dist/proot -S . /bin/bash --login
else
    echo "Telechargement en cours..."
    curl -sSLo ptero-vm.zip https://cdn2.mythicalkitten.com/pterodactylmarket/ptero-vm/ptero-vm.zip
    curl -sSLo apth https://cdn2.mythicalkitten.com/pterodactylmarket/ptero-vm/apth
    curl -sSLo unzip https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/unzip
    chmod +x apth
    echo "Installations en cours (0%)"
    ./apth unzip >/dev/null 
    linux/usr/bin/unzip ptero-vm.zip
    linux/usr/bin/unzip root.zip
    tar -xf root.tar.gz 
    chmod +x ./dist/proot
    rm -rf ptero-vm.zip
    rm -rf root.zip
    rm -rf root.tar.gz
    touch installed
    ./dist/proot -S . /bin/bash -c "mv apth /usr/bin/"
    ./dist/proot -S . /bin/bash -c "mv unzip /usr/bin/"
    ./dist/proot -S . /bin/bash -c "apt-get update"
    ./dist/proot -S . /bin/bash -c "apt-get -y upgrade"
    ./dist/proot -S . /bin/bash -c "apt-get -y install curl"
    ./dist/proot -S . /bin/bash -c "apt-get -y install wget"
    ./dist/proot -S . /bin/bash -c "apt-get -y install neofetch"
    echo "Installations en cours (80%)"
    ./dist/proot -S . /bin/bash -c "curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py"
    ./dist/proot -S . /bin/bash -c "chmod +x /bin/systemctl"
    echo "Installations des services ssh..."
    ./dist/proot -S . /bin/bash -c "apt-get -y install sudo"
./dist/proot -S . /bin/bash -c "sudo chmod -R 777 /etc/default"
./dist/proot -S . /bin/bash -c "cat <<EOT >> /etc/default/dropbear
NO_START=0

DROPBEAR_PORT=$1

DROPBEAR_EXTRA_ARGS=

DROPBEAR_BANNER=""

DROPBEAR_RECEIVE_WINDOW=65536
EOT"

cd
    ./dist/proot -S . /bin/bash -c "apt-get -y install dropbear"
    ./dist/proot -S . /bin/bash -c "echo -e "trosh$1\ntrosh$1" | passwd"
     echo "
████████╗██████╗  ██████╗ ███████╗██╗  ██╗██╗  ██╗ ██████╗ ███████╗████████╗
╚══██╔══╝██╔══██╗██╔═══██╗██╔════╝██║  ██║██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
   ██║   ██████╔╝██║   ██║███████╗███████║███████║██║   ██║███████╗   ██║   
   ██║   ██╔══██╗██║   ██║╚════██║██╔══██║██╔══██║██║   ██║╚════██║   ██║   
   ██║   ██║  ██║╚██████╔╝███████║██║  ██║██║  ██║╚██████╔╝███████║   ██║   
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
    "
    echo "──────────────────────────────────────────────────────────────────────"
    echo "Votre LVPS a été démarré !"
    echo "──────────────────────────────────────────────────────────────────────"
    echo "INFORMATIONS SSH :"
    echo "Hostname : game.troshhost.ml"
    echo "Port : "$1""
    echo "Password : trosh"$1""
    echo "──────────────────────────────────────────────────────────────────────"
    ./dist/proot -S . /bin/bash --login
fi
