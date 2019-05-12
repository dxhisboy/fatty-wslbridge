# fatty-wslbridge
Combine juho-p/fatty and  rprichard/wslbridge to provide a tty for WSL.

## Build

### Install cygwin:
Install make and gcc-g++ from cygwin repo.

### Install WSL:
Install Ubuntu and its build-essentials. Or your favorite WSL distro.

### Install GIT:
GIT may be installed in either cygwin or WSL.

### Configuration:

#### GIT:
In update-source.sh, git may be configured in cygwin or WSL. Also, GIT is configured as a variable to support proxies like proxychains or tsocks

#### cygwin and WSL:
In build.bat, you can configure the path of cygwin and WSL distro.

### Build fatty-wslbridge:
Execute build.bat in the root directory.

## Use:

1. Use startfatty.bat to launch fatty-wslbridge directly.
2. Use create_shortcut.vbs to create a shortcut that contains essential arguments.
3. Use create_contextmenu.vbs/remove_contextmenu.vbs to create/remove a right click menu entry.