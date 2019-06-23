#!/bin/bash

apk add wget bash && wget http://cdimage.ubuntu.com/ubuntu-base/releases/19.04/release/ubuntu-base-19.04-base-i386.tar.gz -O rootfs.tar.gz && mkdir rootfs && tar -C rootfs/ -zxvf rootfs.tar.gz && rm rootfs.tar.gz && echo "nameserver 8.8.8.8" > rootfs/etc/resolv.conf && echo "You can start ubuntu with ./start.sh
