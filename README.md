The command-line program `sx1k` sends files using the xmodem 1K protocol.

Here is the output of `sx1k --help`:

    This program sends xmodem 1k packets using stdin/stdout.
    
        Usage: sx1k <file_to_send>
          or   sx1k --help
          or   sx1k --version

    where <file_to_send> is the name of the file to be sent via xmodem.

Source code and additional information about `sx1k` may be found at
[https://github.com/DaleFarnsworth/sx1k](
https://github.com/DaleFarnsworth/sx1k).

A Linux/amd64 executable may be downloaded from
[https://www.farnsworth.org/dale/sx1k/downloads/linux/amd64](
https://www.farnsworth.org/dale/sx1k/downloads/linux/amd64).

Executables for other Linux (and MacOS) variants can be found starting at 
[https://www.farnsworth.org/dale/sx1k/downloads](
https://www.farnsworth.org/dale/sx1k/downloads).

I'll entertain requests to make executables for other OS/Architecture
combinations available.  Unfortunately, the serial library I'm using
has no windows support, so it's very unlikely that I'll produce a
windows version.

Dale Farnsworth dale@farnsworth.org
