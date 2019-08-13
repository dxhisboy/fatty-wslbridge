alias GIT="wsl.exe -e proxychains git"

function update_source(){
    #export GIT=wsl.exe -e proxychains git
    if [ -d $1 ]; then
	echo "Updating source of $1"
	cd $1
	GIT pull
	cd ..
    else
	echo "Cloning source of $1"
	GIT clone $2
    fi
}
function build_wslbridge2(){
    make -C wslbridge2/
    wsl.exe -e make -C wslbridge2/
}
function build_fatty(){
    make -C fatty
}
function install_bin(){
    if [ ! -d install/bin ]; then
	echo "Creating install directory"
	mkdir -p install/bin
    fi
    echo "Installing wslbridge2"
    cp -v wslbridge2/bin/hvpty.exe \
       wslbridge2/bin/rawpty.exe \
       wslbridge2/bin/wslbridge2.exe \
       wslbridge2/bin/hvpty-backend \
       wslbridge2/bin/wslbridge2-backend \
       install/bin
    echo "Installing fatty"
    cp -v fatty/src/fatty.exe install/bin
    echo "Installing fatty dependencies"
    rm install/bin/*.dll
    DEP=`ldd install/bin/fatty.exe | grep usr | awk '{print $3}'`
    cp -v $DEP install/bin
    cp -v /bin/cygwin-console-helper.exe install/bin
    echo "Installing launch scripts"
    cp -v create_contextmenu.vbs \
       create_shortcut.vbs \
       remove_contextmenu.vbs \
       startfatty.bat \
       startfattyat.bat \
       install
}
update_source wslbridge2 https://github.com/Biswa96/wslbridge2.git
update_source fatty https://github.com/juho-p/fatty.git
build_wslbridge2
install_bin
