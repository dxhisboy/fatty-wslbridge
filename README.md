# fatty-wslbridge

Combine fatty and wslbridge2 to provide a tty for WSL.

## Build

### Install cygwin:

Install make and gcc-g++ from cygwin repo.

### Install WSL:

Install Ubuntu and its build-essentials. Or your favorite WSL distro and equivlent packages.

### Install GIT:

GIT may be installed in either cygwin or WSL, and you can specify which git to use in build.sh.

### Configuration:

### Build fatty-wslbridge:

Execute build.sh in CYGWIN.

## Use:

1. Use init.vbs to create context menus and shortcuts for launching fatty-wslbridge.
2. Use deinit.vbs to clean context menus.

## Known Issues:

1. Sometimes WSL2 loses its drvfs, and this will make the hvpty backend cannot start, in such cases just terminate WSL2 in CMD window using `wsl -t <distro>`.
2. Some proxy or VPN softwares may break the winsock, espescially `SangFor` (what a shame) ones, open an **administrative** CMD window and use `netsh winsock reset` in this case.
3. If you reconfigured the version of your WSL, or installed a new distro, you need to run init.vbs again to update context menu and shortcut info.