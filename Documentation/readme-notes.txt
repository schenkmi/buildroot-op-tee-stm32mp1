2019.11.08
----------
https://github.com/STMicroelectronics/meta-st-stm32mp/tree/thud/recipes-kernel/linux/linux-stm32mp/4.19/4.19.49


 make arm-trusted-firmware
schenk@schenk-linux:/work/buildroot-op-tee-stm32mp1/buildroot$ rm -rf /work/buildroot-op-tee-stm32mp1/buildroot/output/build/optee-os-3.3.0-stm32mp-r2
schenk@schenk-linux:/work/buildroot-op-tee-stm32mp1/buildroot$ make optee-os

TODO U-BOOT Patch

From a7204e5ae1e5f87ad449c7425cf7614205e60734 Mon Sep 17 00:00:00 2001
-From: Bartosz Bilas <bartosz.bilas@hotmail.com>
-Date: Sun, 27 Oct 2019 09:01:12 +0100
-Subject: [PATCH] stm32mp1: configs: fix checking the presence of an
- environment
-
-Execute env check command within extra env settings section instead of
-bootcmd whereby we are able to mount rootfs partition from sd card properly.
-
-Signed-off-by: Bartosz Bilas <bartosz.bilas@hotmail.com>
----
- include/configs/stm32mp1.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/configs/stm32mp1.h b/include/configs/stm32mp1.h
-index 988992b336..cadc0358fd 100644
---- a/include/configs/stm32mp1.h
-+++ b/include/configs/stm32mp1.h
-@@ -115,7 +115,6 @@
- 	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
- 	"then stm32prog ${boot_device} ${boot_instance}; " \
- 	"else " \
--		"run env_check;" \
- 		"if test ${boot_device} = mmc;" \
- 		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
- 		"if test ${boot_device} = nand;" \
-@@ -160,6 +159,7 @@
- 	"initrd_high=0xffffffff\0" \
- 	"altbootcmd=run bootcmd\0" \
- 	"env_default=1\0" \
-+	"run env_check;" \
- 	"env_check=if test $env_default -eq 1;"\
- 		" then env set env_default 0;env save;fi\0" \
- 	STM32MP_BOOTCMD \
--- 
-2.23.0
-




board/stmicroelectronics/stm32mp157c-dk2/patches/uboot/0001-stm32mp1-configs-fix-checking-the-presence-of-an-env.patch

rm -rf output/build/uboot-v2018.11-stm32mp-r3.1/

make uboot-extract
cp -R output/build/uboot-v2018.11-stm32mp-r3.1 output/build/uboot-v2018.11-stm32mp-r3.1.org

Change ....

cd output/build/

diff -Naur uboot-v2018.11-stm32mp-r3.1.org uboot-v2018.11-stm32mp-r3.1
diff -Naur uboot-v2018.11-stm32mp-r3.1.org uboot-v2018.11-stm32mp-r3.1 > ../../board/stmicroelectronics/stm32mp157c-dk2/patches/uboot/0001-stm32mp1-configs-fix-checking-the-presence-of-an-env.patch

cd ../..


https://wiki.st.com/stm32mpu/wiki/STM32MP15_OP-TEE

PC $> ls -l /dev/disk/by-partlabel/
total 0
lrwxrwxrwx 1 root root 10 Jan 28 16:35 bootfs -> ../../sdd7        (Linux kernel boot filesystem)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 fsbl1 -> ../../sdd1         (part#1 is TF-A)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 fsbl2 -> ../../sdd2         (part#2 is TF-A backup)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 rootfs -> ../../sdd9        (Linux kernel root filesystem)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 ssbl -> ../../sdd3          (part#3# is U-Boot)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 teed -> ../../sdd5          (OP-TEE OS paged data)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 teeh -> ../../sdd4          (OP-TEE OS header image)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 teex -> ../../sdd6          (OP-TEE OS resident core)
lrwxrwxrwx 1 root root 11 Jan 28 16:35 userfs -> ../../sdd10       (Linux kernel user filesystem)
lrwxrwxrwx 1 root root 10 Jan 28 16:35 vendorfs -> ../../sdd8      (Linux kernel vendor filesystem)


PC $> dd conv=fdatasync of=/dev/sdd4 if=<optee-os>/out/core/tee-header_v2.stm32
PC $> dd conv=fdatasync of=/dev/sdd5 if=<optee-os>/out/core/tee-pageable_v2.stm32
PC $> dd conv=fdatasync of=/dev/sdd6 if=<optee-os>/out/core/tee-pager_v2.stm32 

https://wiki.st.com/stm32mpu/wiki/STM32MP15_TF-A


schenk@schenk-linux:/work/buildroot-op-tee-stm32mp1/buildroot$ find . -name *.stm32
./output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-header_v2.stm32
./output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-pager_v2.stm32
./output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-pageable_v2.stm32
./output/build/arm-trusted-firmware-v2.0-stm32mp-r2/build/stm32mp1/release/tf-a-stm32mp157c-dk2.stm32
./output/build/uboot-v2018.11-stm32mp-r3.1/u-boot.stm32





Yocto

 2005  mkdir openstlinux-4.19-thud-mp1-19-10-09 
 2006  cd openstlinux-4.19-thud-mp1-19-10-09/
 2007  repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-4.19-thud-mp1-19-10-09
 2008  repo sync
 2009  DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh
 2010  bitbake st-image-weston



schenk@schenk-linux:/media/schenk/priv/openstlinux-4.19-thud-mp1-19-10-09/build-openstlinuxweston-stm32mp1$ find . -name tee-header*
./tmp-glibc/deploy/images/stm32mp1/tee-header_v2-stm32mp157c-dk2-optee.stm32

ARM_ARCH_MAJOR=7 ARCH=aarch32 PLAT=stm32mp1 AARCH32_SP=sp_min DTB_FILE_NAME=stm32mp157c-<board>.dtb

3.5 Final image
↑

Final image is available for Flash or SD card update in the corresponding folder:

build/<target>/<debug|release>/tf-a-<target>.stm32
Ex:
build/stm32mp1/debug/tf-a-stm32mp157c-ev1.stm32

4 Distribution Package
↑

For an OpenSTLinux distribution, the TF-A image is built in release mode by default. The yocto recipe can be found in:

meta-st/meta-st-stm32mp/recipes-bsp/trusted-firmware-a/tf-a-stm32mp_<version>.bb

If you want to modify the TF-A code source, use the following steps starting from an already downloaded and built OpenSTLinux distribution.
4.1 Access sources
↑

You can use devtool to access the source.

 PC $> cd <baseline root directory>
 PC $> devtool modify tf-a-stm32mp sources/boot/tf-a

By going to the sources/boot/tf-a folder, you can manage and modify the TF-A sources. To rebuild it, go back to the build-<distribution> folder and launch the TF-A recipe:

 PC $> bitbake tf-a-stm32mp

The final image is deployed in the image default output folder.
5 Update software on board
↑
5.1 Partitioning of binaries
↑

The TF-A build provides a binary named tf-a-stm32mp157c-<board>.stm32 that MUST be copied to a dedicated partition named "fsblX" (X depends of needed backup).
Warning.png 	TF-A must be located in the first partition of your boot device.

You can just update the first partition for a simple test, but all backup partitions must contain the same image at the end.
5.2 Update via SDCARD
↑

If you use an SD card, you can simply update TF-A using the dd command on your host.
Plug your SD card into the computer and copy the binary to the dedicated partition; on an SDCard/USB disk the "fsbl1" partition is partition 1:

 - SDCARD: /dev/mmcblkXp1 (where X is the instance number)
 - SDCARD via USB reader: /dev/sdX1 (where X is the instance number)

    Linux

 PC $> dd if=<tf-a file> of=/dev/<device partition> bs=1M conv=fdatasync

Info.png 	To find the partition associated to a specific label, just plug the

SDCARD/USB disk into your PC and call the following command:

 PC $> ls -l /dev/disk/by-partlabel/
 total 0
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 bootfs -> ../../mmcblk0p4
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 fsbl1 -> ../../mmcblk0p1          ➔ FSBL1 (TF-A)
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 fsbl2 -> ../../mmcblk0p2          ➔ FSBL2 (TF-A backup – same content as FSBL)
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 rootfs -> ../../mmcblk0p5
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 ssbl -> ../../mmcblk0p3           ➔ SSBL (U-Boot)
 lrwxrwxrwx 1 root root 10 Jan 17 17:38 userfs -> ../../mmcblk0p6

    Windows

There is an existing dd for Windows that makes binary copying possible.
5.3 Update via USB mass storage on U-boot
↑

See How to use USB mass storage in U-Boot

Follow the previous section to put tf-a-<board>.stm32 onto SDCard/USB disk
5.4 Update your boot device (including SD card on the target)
↑

Refer to the STM32CubeProgrammer documentation to update your target.

 PC $> make ARM_ARCH_MAJOR=7 ARCH=aarch32 PLAT=stm32mp1 AARCH32_SP=optee DTB_FILE_NAME=stm32mp157c-dk2.dtb


stm32mp157c-dk2


schenk@schenk-linux:/work/buildroot-op-tee-stm32mp1/buildroot$ ll /work/buildroot-op-tee-stm32mp1/buildroot/output/images/
total 42424
drwxr-xr-x 2 schenk schenk      4096 Nov  7 15:45 ./
drwxrwxr-x 6 schenk schenk      4096 Nov  7 15:45 ../
-rwxr-xr-x 1 schenk schenk     62113 Nov  7 14:56 bl2.bin*
-rw-r--r-- 1 schenk schenk 125829120 Nov  7 15:45 rootfs.ext2
lrwxrwxrwx 1 schenk schenk        11 Nov  7 15:45 rootfs.ext4 -> rootfs.ext2
-rw-r--r-- 1 schenk schenk     68852 Nov  7 15:45 stm32mp157c-dk2.dtb
-rw-r--r-- 1 schenk schenk    210916 Nov  7 15:13 tee.bin
-rw-r--r-- 1 schenk schenk        44 Nov  7 15:13 tee-header_v2.bin
-rw-r--r-- 1 schenk schenk    143360 Nov  7 15:13 tee-pageable_v2.bin
-rw-r--r-- 1 schenk schenk     67528 Nov  7 15:13 tee-pager_v2.bin
-rwxr-xr-x 1 schenk schenk    187136 Nov  7 14:56 tf-a-stm32mp157c-ev1.bin*
-rw-r--r-- 1 schenk schenk    805586 Nov  7 15:35 u-boot.img
-rw-r--r-- 1 schenk schenk   6660608 Nov  7 15:45 zImage



sudo picocom -b 115200 /dev/ttyACM0




sudo dd if=output/images/sdcard.img of=/dev/sdf bs=1M conv=fdatasync status=progress



Terminal ready
NOTICE:  CPU: STM32MP157CAC Rev.B
NOTICE:  Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
NOTICE:  Board: MB1272 Var2 Rev.C-01
INFO:    Reset reason (0x15):
INFO:      Power-on Reset (rst_por)
INFO:    Using SDMMC
INFO:      Instance 1
INFO:    Boot used partition fsbl1
INFO:    Product_below_2v5=1: HSLVEN update is
INFO:      destructive, no update as VDD>2.7V
NOTICE:  BL2: v2.0(debug):
NOTICE:  BL2: Built : 13:13:37, Oct  2 2018
INFO:    BL2: Doing platform setup
INFO:    PMIC version = 0x10
INFO:    RAM: DDR3-1066/888 bin G 1x4Gb 533MHz v1.41
INFO:    Memory size = 0x20000000 (512 MB)
INFO:    BL2 runs SP_MIN setup
INFO:    BL2: Loading image id 4
INFO:    Loading image id=4 at address 0x2fff0000
INFO:    Image id=4 loaded: 0x2fff0000 - 0x30000000
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0xc0100000
INFO:    STM32 Image size : 748404
WARNING: Skip signature check (header option)
INFO:    Image id=5 loaded: 0xc0100000 - 0xc01b6b74
INFO:    read version 0 current version 0
NOTICE:  BL2: Booting BL32
INFO:    Entry point address = 0x2fff0000
INFO:    SPSR = 0x1d3
INFO:    PMIC version = 0x10
NOTICE:  SP_MIN: v2.0(debug):
NOTICE:  SP_MIN: Built : 13:13:37, Oct  2 2018
INFO:    ARM GICv2 driver initialized
INFO:    stm32mp HSI (18): Secure only
INFO:    stm32mp HSE (20): Secure only
INFO:    stm32mp PLL2 (27): Secure only
INFO:    stm32mp PLL2_R (30): Secure only
INFO:    SP_MIN: Initializing runtime services
INFO:    SP_MIN: Preparing exit to normal world


U-Boot 2018.11-stm32mp-r2 (Nov 14 2018 - 16:10:06 +0000)

CPU: STM32MP157CAC Rev.B
Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
Board: MB1272 Var2 Rev.C-01
       Watchdog enabled
DRAM:  512 MiB
Clocks:
- MPU : 650 MHz
- MCU : 208.878 MHz
- AXI : 266.500 MHz
- PER : 24 MHz
- DDR : 533 MHz




mkdir -p /work/buildroot-op-tee-stm32mp1/buildroot/output/images
cp -dpf /work/buildroot-op-tee-stm32mp1/buildroot/output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee.bin /work/buildroot-op-tee-stm32mp1/buildroot/output/images/
cp -dpf /work/buildroot-op-tee-stm32mp1/buildroot/output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-pager_v2.bin /work/buildroot-op-tee-stm32mp1/buildroot/output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-header_v2.bin /work/buildroot-op-tee-stm32mp1/buildroot/output/build/optee-os-3.3.0-stm32mp-r2/out/core/tee-pageable_v2.bin /work/buildroot-op-tee-stm32mp1/buildroot/output/images/



Scanning mmc 0:7...
Found /boot/extlinux/extlinux.conf
Retrieving file: /boot/extlinux/extlinux.conf
131 bytes read in 1 ms (127.9 KiB/s)
1:	stm32mp157c-dk2-buildroot
Retrieving file: /boot/zImage

 mmc dev 0:7

STM32MP> ext4ls 0:7 /boot


2020.07.16

For STM32 OP-TEE BR
sudo apt install -y python3-pip
pip3 install pycryptodome
pip3 install pycryptodomex
apt install python3-pyelftools

./configs/stm32mp15_trusted_defconfig

Kernel Config from Yocto Projekt

Take default config for STM32MP1 and all fragments https://github.com/STMicroelectronics/meta-st-stm32mp/tree/openstlinux-5.4-dunfell-mp1-20-06-24/recipes-kernel/linux/linux-stm32mp/5.4

Build Yocto from to get Kernel COnfig
https://github.com/STMicroelectronics/oe-manifest/tree/openstlinux-5.4-dunfell-mp1-20-06-24

From https://wiki.st.com/stm32mpu/wiki/STM32MP1_Distribution_Package#Installing_the_OpenSTLinux_distribution https://wiki.st.com/stm32mpu/wiki/STM32MP1_Distribution_Package#Installing_the_OpenSTLinux_distribution
cd /work
mkdir openstlinux-5.4-dunfell-mp1-20-06-24
cd openstlinux-5.4-dunfell-mp1-20-06-24
repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-5.4-dunfell-mp1-20-06-24
repo sync
DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh
#bitbake st-image-weston
bitbake st-image-core

As soon as we get .config we can copy it to buitroot


cp ./build-openstlinuxweston-stm32mp1/tmp-glibc/work/stm32mp1-ostl-linux-gnueabi/linux-stm32mp/5.4.31-r0/build/.config /work/buildroot-op-tee-stm32mp1/br-external/board/optee/linux-5.4.config


Removed Patch boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch from buildroot
schenk@schenk-virtual-machine:/work/buildroot-op-tee-stm32mp1/buildroot$ git status .
HEAD detached at 2020.05
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch

no changes added to commit (use "git add" and/or "git commit -a")
schenk@schenk-virtual-machine:/work/buildroot-op-tee-stm32mp1/buildroot$

  102  cd buildroot/
  103  git status .
  104  git rm boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch
  105  git status .
  106  git commit -m "update to 2020.05 and remove boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch" .


schenk@schenk-virtual-machine:/work/buildroot-op-tee-stm32mp1$ git commit -m "update to 2020.05 and remove boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch" buildroot/

For build help OP-TEE and params for stm32mp1_defconfig see
out/build/arm-trusted-firmware-v2.2-stm32mp-r1/docs/plat/stm32mp1.rst

    make CROSS_COMPILE=arm-linux-gnueabihf- PLAT=stm32mp1 ARCH=aarch32 ARM_ARCH_MAJOR=7 AARCH32_SP=optee STM32MP_SDMMC=1 STM32MP_EMMC=1 STM32MP_RAW_NAND=1 STM32MP_SPI_NAND=1 STM32MP_SPI_NOR=1 DTB_FILE_NAME=stm32mp157c-ev1.dtb
    cd <optee_directory>
    make CROSS_COMPILE=arm-linux-gnueabihf- ARCH=arm PLATFORM=stm32mp1 CFG_EMBED_DTB_SOURCE_FILE=stm32mp157c-ev1.dts
    cd <u-boot_directory>
    make stm32mp15_optee_defconfig
    make DEVICE_TREE=stm32mp157c-ev1 all



meta-st/meta-st-stm32mp/files/flashlayouts/FlashLayout_sdcard_stm32mp157c-ev1_sample.tsv
#Opt	Id	Name	Type	IP	Offset	Binary
-	0x01	fsbl1-boot	Binary	none	0x0	arm-trusted-firmware/tf-a-stm32mp157c-ev1-serialboot.stm32
-	0x03	ssbl-boot	Binary	none	0x0	bootloader/u-boot-stm32mp157c-ev1-trusted.stm32
P	0x04	fsbl1	Binary	mmc0	0x00004400	arm-trusted-firmware/tf-a-stm32mp157c-ev1-trusted.stm32
P	0x05	fsbl2	Binary	mmc0	0x00044400	arm-trusted-firmware/tf-a-stm32mp157c-ev1-trusted.stm32
PD	0x06	ssbl	Binary	mmc0	0x00084400	bootloader/u-boot-stm32mp157c-ev1-trusted.stm32
P	0x21	bootfs	System	mmc0	0x00284400	st-image-bootfs-openstlinux-weston-stm32mp1.ext4
P	0x22	vendorfs	FileSystem	mmc0	0x04284400	st-image-vendorfs-openstlinux-weston-stm32mp1.ext4
P	0x23	rootfs	FileSystem	mmc0	0x05284400	st-image-weston-openstlinux-weston-stm32mp1.ext4
P	0x24	userfs	FileSystem	mmc0	0x340F0400	st-image-userfs-openstlinux-weston-stm32mp1.ext4

Rebuild U-BOOT
make uboot-rebuild

We still need to disable the U-BOOT env otherwise the image boots only once. The U-BOOT Env corrupts

NOTICE:  Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
NOTICE:  Board: MB1272 Var2.0 Rev.C-01
INFO:    Reset reason (0x54):
INFO:      System reset generated by MPU (MPSYSRST)
INFO:    PMIC version = 0x10
INFO:    Using SDMMC
INFO:      Instance 1
INFO:    Boot used partition fsbl1
NOTICE:  BL2: v2.2-r1.0(debug):V1.0.1-3-g28b7c7c-dirty
NOTICE:  BL2: Built : 07:38:12, Jul 17 2020
INFO:    Using crypto library 'stm32_crypto_lib'
INFO:    BL2: Doing platform setup
INFO:    RAM: DDR3-DDR3L 16bits 533000Khz
INFO:    Memory size = 0x20000000 (512 MB)
INFO:    BL2 runs OP-TEE setup
INFO:    BL2: Loading image id 4
INFO:    Loading image id=4 at address 0x2ffc0000
INFO:    STM32 Image size : 512
INFO:    Image id=4 loaded: 0x2ffc0000 - 0x2ffc0200
WARNING: Skip signature check (header option)
NOTICE:  ROTPK is not deployed on platform. Skipping ROTPK verification.
INFO:    OPTEE ep=0x2ffc0000
INFO:    OPTEE header info:
INFO:          magic=0x4554504f
INFO:          version=0x2
INFO:          arch=0x0
INFO:          flags=0x0
INFO:          nb_images=0x2
INFO:    BL2: Loading image id 21
INFO:    Loading image id=21 at address 0x2ffc0000
INFO:    STM32 Image size : 97792
INFO:    Image id=21 loaded: 0x2ffc0000 - 0x2ffd7e00
WARNING: Skip signature check (header option)
NOTICE:  ROTPK is not deployed on platform. Skipping ROTPK verification.
INFO:    BL2: Loading image id 22
INFO:    Loading image id=22 at address 0xde000000
INFO:    STM32 Image size : 249856
INFO:    Image id=22 loaded: 0xde000000 - 0xde03d000
WARNING: Skip signature check (header option)
NOTICE:  ROTPK is not deployed on platform. Skipping ROTPK verification.
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0xc0100000
INFO:    STM32 Image size : 870596
INFO:    Image id=5 loaded: 0xc0100000 - 0xc01d48c4
ERROR:   Checksum: 0x4aeed3f (awaited: 0x4aabddf)
ERROR:   BL2: Failed to load image (-80)

old out/build/uboot-v2020.01-stm32mp-r1/include/configs/stm32mp1.h

#define STM32MP_BOOTCMD "bootcmd_stm32mp=" \
	"echo \"Boot over ${boot_device}${boot_instance}!\";" \
	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
	"then stm32prog ${boot_device} ${boot_instance}; " \
	"else " \
		"run env_check;" \
		"if test ${boot_device} = mmc;" \
		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
		"if test ${boot_device} = nand ||" \
		  " test ${boot_device} = spi-nand ;" \
		"then env set boot_targets ubifs0; fi;" \
		"if test ${boot_device} = nor;" \
		"then env set boot_targets mmc0; fi;" \
		"run distro_bootcmd;" \
	"fi;\0"

new out/build/uboot-v2020.01-stm32mp-r1/include/configs/stm32mp1.h

#define STM32MP_BOOTCMD "bootcmd_stm32mp=" \
	"echo \"Boot over ${boot_device}${boot_instance}!\";" \
	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
	"then stm32prog ${boot_device} ${boot_instance}; " \
	"else " \
		"if test ${boot_device} = mmc;" \
		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
		"if test ${boot_device} = nand ||" \
		  " test ${boot_device} = spi-nand ;" \
		"then env set boot_targets ubifs0; fi;" \
		"if test ${boot_device} = nor;" \
		"then env set boot_targets mmc0; fi;" \
		"run distro_bootcmd;" \
	"fi;\0"

out/build/uboot-v2020.01-stm32mp-r1/configs/stm32mp15_trusted_defconfig
CONFIG_ENV_OFFSET=0x280000
CONFIG_ENV_SECT_SIZE=0x40000
CONFIG_ENV_OFFSET_REDUND=0x2C0000

Disk /dev/sdb: 117.77 GiB, 126437294080 bytes, 246947840 sectors
Disk model: STORAGE DEVICE
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 45E5F6A7-2ADB-49D4-819F-7EB44556A2EE

Device     Start    End Sectors   Size Type
/dev/sdb1     34    473     440   220K Linux filesystem
/dev/sdb2    546    985     440   220K Linux filesystem
/dev/sdb3   1058   2758    1701 850.5K Linux filesystem
/dev/sdb4   5154   5154       1   512B Linux filesystem
/dev/sdb5   5155   5643     489 244.5K Linux filesystem
/dev/sdb6   5644   5835     192    96K Linux filesystem
/dev/sdb7   5836 530123  524288   256M Linux filesystem

Command (m for help):





We need to reserve some addition size for U-BOOT. Otherwise the env override the TEE stuff

CONFIG_ENV_OFFSET=0x280000 (2621440)
CONFIG_ENV_SECT_SIZE=0x40000 (262144)
CONFIG_ENV_OFFSET_REDUND=0x2C0000 (2883584)

0x000000 ---
U-BOOT
0x280000 ---
ENV
0x2C0000 ---
REDUND ENV
0x2FFFFF ---

=> So the size of the U-BOOT Parition must be 0x300000




image sdcard.img {
	hdimage {
		gpt = "true"
	}

	partition fsbl1 {
		image = "tf-a-stm32mp157c-dk2.stm32"
		offset = 0x00004400
	}

	partition fsbl2 {
		image = "tf-a-stm32mp157c-dk2.stm32"
		offset = 0x00044400
	}

	partition ssbl {
		image = "u-boot.stm32"
		offset = 0x00284400
		size = 100M
	}

	partition teeh {
		image = "tee-header_v2.stm32"
	}

	partition teed {
		image = "tee-pageable_v2.stm32"
	}

	partition teex {
		image = "tee-pager_v2.stm32"
	}


	partition rootfs {
		image = "rootfs.ext4"
		partition-type = 0x83
		bootable = "yes"
		size = 256M
	}
}

Git submodule

git clone git@github.com:schenkmi/buildroot-op-tee-stm32mp1.git
cd buildroot-op-tee-stm32mp1
git checkout feature/update-20200716
git submodule update --init --recursive

git clone --recursive --branch feature/update-20200716 git@github.com:schenkmi/buildroot-op-tee-stm32mp1.git

boot/optee-os/0001-scripts-pem_to_pub_c.py-sign.py-use-pycryptodomex.patch

git log --oneline

git submodule foreach git tag -l
git submodule foreach git tag -m "tagName" tagName

git tag -m "update to components form openstlinux-5.4-dunfell-mp1-20-06-24 and buildroot 2020.05" V1.1.0
git push --tags




