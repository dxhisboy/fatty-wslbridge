set CYGDIR=c:\cygwin64
set WSL=ubuntu.exe
%CYGDIR%\bin\bash.exe --login -c 'cd "%CD%"; bash ./update-source.sh'
%WSL% run ./update-source.sh
echo "Building wslbridge backend"
%WSL% run "make -C wslbridge/backend"
%CYGDIR%\bin\bash.exe --login -c 'cd "%CD%"; bash ./cygwin-build.sh'
%CYGDIR%\bin\bash.exe --login -c 'cd "%CD%"; bash ./install.sh'

pause