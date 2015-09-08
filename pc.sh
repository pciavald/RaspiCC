#!/bin/bash

#sudo iptables --list INPUT
#sudo iptables -I INPUT 7 -i eth0 -p tcp -s 192.168.1.0/24 --dport 3632 -j ACCEPT

cp service.sh /etc/init.d/RaspiCC
chmod 755 /etc/init.d/RaspiCC
cd /usr/local
sudo git clone https://github.com/raspberrypi/tools.git rpi-tools
cd rpi-tools
sudo mkdir x32bin x64bin
cd x32bin
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc gcc
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc cc
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-c++ c++
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-cpp cpp
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-g++ g++
cd ../x64bin
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc gcc
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc cc
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-c++ c++
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-cpp cpp
sudo ln -s ../arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-g++ g++
