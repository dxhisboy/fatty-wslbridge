if [ -d wslbridge ]; then
    echo "Updating source of wslbridge"
    cd wslbridge
    git pull
    cd ..
else
    echo "Cloning source of wslbridge"
    git clone https://github.com/rprichard/wslbridge.git
fi
if [ -d fatty ]; then
    echo "Updating source of fatty"
    cd fatty
    git pull
    cd ..
else
    echo "Cloning source of fatty"
    git clone https://github.com/juho-p/fatty.git
fi
echo "Building fatty"
make -C fatty/src
echo "Building wslbridge frontend"
make -C wslbridge/frontend
echo "Installing fatty"
cp fatty/src/fatty.exe .
echo "Installing wslbridge backend"
cp wslbridge/out/wslbridge.exe .
echo "Updating dependencies of fatty"
rm *.dll
DEP=`ldd fatty.exe | grep usr | awk '{print $3}'`
cp $DEP . -v

