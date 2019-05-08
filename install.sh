mkdir install
echo "Installing fatty"
cp fatty/src/fatty.exe install
echo "Installing wslbridge frontend"
cp wslbridge/out/wslbridge.exe install
echo "Installing wslbridge backend"
cp wslbridge/out/wslbridge-backend install
echo "Updating dependencies of fatty"
rm install/*.dll
DEP=`ldd fatty.exe | grep usr | awk '{print $3}'`
cp $DEP install -v
echo "Installing launch scripts"
cp makelink.vbs startfatty.bat install -v