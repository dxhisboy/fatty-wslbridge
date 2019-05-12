mkdir -p install/bin
echo "Installing fatty"
cp fatty/src/fatty.exe install/bin
echo "Installing wslbridge frontend"
cp wslbridge/out/wslbridge.exe install/bin
echo "Installing wslbridge backend"
cp wslbridge/out/wslbridge-backend install/bin
echo "Updating dependencies of fatty"
rm install/bin/*.dll
DEP=`ldd install/bin/fatty.exe | grep usr | awk '{print $3}'`
cp $DEP install/bin -v
cp /bin/cygwin-console-helper.exe install/bin -v
echo "Installing launch scripts"
cp *.vbs startfatty.bat install -v