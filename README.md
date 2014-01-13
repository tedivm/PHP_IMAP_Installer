# PHP_IMAP_Installer_OSX

Installs the PHP IMAP Extension on OSX, as well as the dependancies needed to make it run-

 * PCRE
 * IMAP C Client Libraries
 * PHP IMAP Extension

## Setup

This script needs the XCode Command Line Tools and autoconf to run. 

First, to install the command line tools-

```
xcode-select --install
```

Then install autoconf using brew-
```
brew install automake
```

## Run 

Running this application is pretty straight forward.

```
./php_imap.sh
```

## Cleanup

To finish simply add this line to your php.ini file-

```
extension=/usr/lib/php/extensions/no-debug-non-zts-20090626/imap.so
```

Then clean up the build directory.
```
rm -rf /tmp/phpimapmountainlion/
```

## Attribution

The original script was written by Ivan Vucica and was hosted on [his blog](http://blog.vucica.net/2012/10/installing-imap-extension-for-php-on-mountain-lion.html).

It has since been updated by Robert Hafner.
