echo "Installing fatty"
cp fatty/src/fatty.exe .
echo "Installing wslbridge frontend"
cp wslbridge/out/wslbridge.exe .
echo "Installing wslbridge backend"
cp wslbridge/out/wslbridge-backend .
echo "Updating dependencies of fatty"
rm *.dll
DEP=`ldd fatty.exe | grep usr | awk '{print $3}'`
cp $DEP . -v
