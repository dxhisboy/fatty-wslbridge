alias GIT="wsl.exe -e proxychains git"
#set -x
function update_source(){
    #export GIT=wsl.exe -e proxychains git
    if [ -d $1/.git ]; then
	echo "Updating source of $1"
	cd $1
	GIT pull < /dev/null
	cd ..
    else
	if [ -d $1 ]; then
	    rm $1 -rf
	fi
	echo "Cloning source of $1"
	GIT clone $2 < /dev/null
    fi
}
function build_wslbridge2(){
    echo "Building WSLbridge2"
    make -C wslbridge2/
    wsl.exe -e make -C wslbridge2/ < /dev/null
}
function build_fatty(){
    echo "Building fatty"
    make -C fatty
}

function build_unquote(){
    echo "Building unquote"
    gcc unquote.c -o unquote.exe
}
function install_bin() {
    if [ ! -d install/usr/bin ]; then
	echo "Creating install directory"
	mkdir -p install/usr/bin
    fi
    echo "Installing wslbridge2"
    cp -v wslbridge2/bin/hvpty.exe \
       wslbridge2/bin/rawpty.exe \
       wslbridge2/bin/wslbridge2.exe \
       wslbridge2/bin/hvpty-backend \
       wslbridge2/bin/wslbridge2-backend \
       install/usr/bin
    echo "Installing fatty"
    cp -v fatty/src/fatty.exe install/usr/bin
    echo "Installing fatty dependencies"
    rm install/usr/bin/*.dll
    DEP=`ldd install/usr/bin/*.exe | grep usr | awk '{print $3}' | sort | uniq`
    cp -v $DEP install/usr/bin
    cp -v /bin/cygwin-console-helper.exe install/usr/bin
    echo "Installing init scripts"
    cp -v init.vbs deinit.vbs install
}
function install_assets() {
    echo "Installing fatty assets"
    if [ ! -d install/.config ]; then
	mkdir -p install/.config
    fi
    cp -r fatty/themes install/.config
    cp -r fatty/sounds install/.config
    cp -r fatty/lang install/.config
}
update_source wslbridge2 https://github.com/dxhisboy/wslbridge2.git
update_source fatty https://github.com/juho-p/fatty.git
build_wslbridge2
build_fatty
install_bin
#install_assets
