#!/bin/bash

echo "What is your compiling server's ip config ? [ip/threads - 192.168.1.158/16 192.168.1.192/8]"
read HOSTS

LIBGTK=""
OPT=""
read -p "Do you want to enable GUI ? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	LIBGTK="libgtk2.0-dev"
	OPT="--with-gtk"
fi

sudo apt-get install subversion autoconf automake python python-dev git $LIBGTK
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
./configure $OPT
make
sudo make install
sudo ln -s /usr/local/bin/distcc /usr/local/bin/gcc
sudo ln -s /usr/local/bin/distcc /usr/local/bin/cc
sudo ln -s /usr/local/bin/distcc /usr/local/bin/g++
sudo ln -s /usr/local/bin/distcc /usr/local/bin/c++
sudo ln -s /usr/local/bin/distcc /usr/local/bin/cpp

echo "
export PATH=/usr/local/bin:\$PATH

# The remote machines that will build things for you. Dont put the ip of the Pi unless
# you want the Pi to take part to the build process.
# The syntax is : \"IP_ADDRESS/NUMBER_OF_JOBS IP_ADDRESS/NUMBER_OF_JOBS\" etc...
# The documentation states that your should set the number of jobs per machine to
# its number of processors. I advise you to set it to twice as much. See why in the test paragraph.
# For example:
export DISTCC_HOSTS=\"$HOSTS\"

# When a job fails, distcc backs off the machine that failed for some time.
# We want distcc to retry immediately
export DISTCC_BACKOFF_PERIOD=0

# Time, in seconds, before distcc throws a DISTCC_IO_TIMEOUT error and tries to build the file
# locally ( default hardcoded to 300 in version prior to 3.2 )
export DISTCC_IO_TIMEOUT=3000

# Dont try to build the file locally when a remote job failed
export DISTCC_SKIP_LOCAL_RETRY=1" >> ~/.profile

echo "
export PATH=/usr/local/bin:\$PATH

# The remote machines that will build things for you. Dont put the ip of the Pi unless
# you want the Pi to take part to the build process.
# The syntax is : \"IP_ADDRESS/NUMBER_OF_JOBS IP_ADDRESS/NUMBER_OF_JOBS\" etc...
# The documentation states that your should set the number of jobs per machine to
# its number of processors. I advise you to set it to twice as much. See why in the test paragraph.
# For example:
export DISTCC_HOSTS=\"$HOSTS\"

# When a job fails, distcc backs off the machine that failed for some time.
# We want distcc to retry immediately
export DISTCC_BACKOFF_PERIOD=0

# Time, in seconds, before distcc throws a DISTCC_IO_TIMEOUT error and tries to build the file
# locally ( default hardcoded to 300 in version prior to 3.2 )
export DISTCC_IO_TIMEOUT=3000

# Dont try to build the file locally when a remote job failed
export DISTCC_SKIP_LOCAL_RETRY=1" | sudo tee --append /root/.profile
