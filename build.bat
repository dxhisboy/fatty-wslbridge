set CYGDIR=c:\cygwin64
%CYGDIR%\bin\bash.exe --login -c 'cd "%CD%"; bash ./update-source.sh'
echo "Building wslbridge backend"
ubuntu.exe run "make -C wslbridge/backend"
copy wslbridge\out\wslbridge-backend .
