#!/bin/bash

sudo apt-get install subversion autoconf automake python python-dev git libgtk2.0-dev
svn checkout http://distcc.googlecode.com/svn/trunk/ distcc-read-only
cd distcc-read-only
wget https://toolbox-of-eric.googlecode.com/files/libiberty.tar.gz
tar -xvf libiberty.tar.gz
cd libiberty
./configure
make
sudo make install
cd ..
./autogen.sh
./configure --with-gtk
make
sudo make install
