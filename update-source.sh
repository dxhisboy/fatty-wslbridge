GIT=git
GITOS=wsl

CUROS=wsl
echo $GIT
if [ -e /bin/cygwin1.dll ]; then
	CUROS=cygwin
fi
if [ x$GITOS != x$CUROS ]; then
	exit
fi
if [ -d wslbridge ]; then
    echo "Updating source of wslbridge"
    cd wslbridge
    $GIT pull
    cd ..
else
    echo "Cloning source of wslbridge"
    $GIT clone https://github.com/rprichard/wslbridge.git
fi
if [ -d fatty ]; then
    echo "Updating source of fatty"
    cd fatty
    $GIT pull
    cd ..
else
    echo "Cloning source of fatty"
    $GIT clone https://github.com/juho-p/fatty.git
fi
