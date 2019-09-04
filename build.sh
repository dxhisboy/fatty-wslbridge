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
    make -C wslbridge2/
    wsl.exe -e make -C wslbridge2/ < /dev/null
}
function build_fatty(){
    make -C fatty
}
function install_bin(){
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
    cp -v fatty/bin/fatty.exe install/usr/bin
    echo "Installing fatty dependencies"
    rm install/usr/bin/*.dll
    DEP=`ldd install/usr/bin/*.exe | grep usr | awk '{print $3}' | sort | uniq`
    cp -v $DEP install/usr/bin
    cp -v /bin/cygwin-console-helper.exe install/usr/bin
    echo "Installing launch scripts"
    cp -v create_contextmenu.vbs \
       create_shortcut.vbs \
       remove_contextmenu.vbs \
       startfatty.bat \
       startfattyat.bat \
       install
}
update_source wslbridge2 https://github.com/dxhisboy/wslbridge2.git
update_source fatty https://github.com/dxhisboy/fatty.git
build_wslbridge2
build_fatty
install_bin
