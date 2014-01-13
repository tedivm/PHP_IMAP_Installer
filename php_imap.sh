#!/bin/bash

# Original Script found at:
# http://blog.vucica.net/2012/10/installing-imap-extension-for-php-on-mountain-lion.html
# Updated by Robert Hafner 2014

BUILDDIR=/tmp/phpimapmountainlion
PHPVER=$(php -r 'echo phpversion();')
PCREVER='8.33'
IMAPVER='2007f'
 
mkdir "$BUILDDIR"

echo " "
echo "= FETCHING AND INSTALLING IMAP $IMAPVER C LIBRARIES"
echo " "

cd "$BUILDDIR"
wget -c ftp://ftp.cac.washington.edu/imap/imap-$IMAPVER.tar.gz
rm -rf imap-$IMAPVER
tar xvvfz imap-$IMAPVER.tar.gz
cd imap-$IMAPVER
make osx EXTRACFLAGS="-arch i386 -arch x86_64 -g -Os -pipe -no-cpp-precomp"
sudo mkdir -p /usr/local/imap-$IMAPVER/include
sudo cp c-client/*.h /usr/local/imap-$IMAPVER/include
sudo mkdir -p /usr/local/imap-$IMAPVER/lib
sudo cp c-client/c-client.a /usr/local/imap-$IMAPVER/lib/libc-client.a



 
echo " "
echo "= FETCHING AND INSTALLING PCRE $PCREVER"
echo " "

cd "$BUILDDIR"
wget "http://sourceforge.net/projects/pcre/files/pcre/$PCREVER/pcre-$PCREVER.tar.gz"
rm -rf pcre-$PCREVER
tar xvvfz pcre-$PCREVER.tar.gz
cd pcre-$PCREVER
./configure --prefix=/usr/local
make
sudo make install


 
echo " "
echo "= FETCHING AND INSTALLING PHP-IMAP FOR PHP $PHPVER"
echo " "

cd "$BUILDDIR"
wget --no-check-certificate -c https://github.com/php/php-src/tarball/PHP-$PHPVER -O PHP-$PHPVER.tar.gz
tar xvvfz PHP-$PHPVER.tar.gz
cd `ls |grep php-php-src-|head -n1`
cd ext/imap
phpize
./configure --with-imap=/usr/local/imap-2007f --with-kerberos --with-imap-ssl
make
sudo mkdir -p /usr/lib/php/extensions/no-debug-non-zts-20090626/
sudo cp modules/imap.so /usr/lib/php/extensions/no-debug-non-zts-20090626/



echo " "
echo "= INSTALLATION COMPLETE"
echo " "
echo "= PLEASE UPDATE YOUR PHP.INI FILE BY ADDING THIS LINE:"
echo "extension=/usr/lib/php/extensions/no-debug-non-zts-20090626/imap.so"
echo " "
echo "= PLEASE CLEAN UP BUILD DIRECTORY WHEN FINISHED:"
echo "$BUILDDIR"
echo " "