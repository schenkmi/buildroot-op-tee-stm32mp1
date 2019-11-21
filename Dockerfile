FROM ubuntu:18.04

ENV GIT_NAME John Example
ENV GIT_EMAIL john@example.org

WORKDIR /build

RUN \
	dpkg --add-architecture i386 && apt-get update && apt-get -y install \
	android-tools-adb android-tools-fastboot autoconf automake \
	bc bison build-essential cscope curl device-tree-compiler flex \
	ftp-upload gdisk iasl libattr1-dev libc6:i386 libcap-dev libfdt-dev \
	libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
	libpixman-1-dev libssl-dev libstdc++6:i386 libtool libz1:i386 make \
	mtools netcat python-crypto python-serial python-wand unzip uuid-dev \
	xdg-utils xterm xz-utils zlib1g-dev git nano wget cpio rsync

RUN \
	git config --global user.name $GIT_NAME && \
	git config --global user.email $GIT_EMAIL
