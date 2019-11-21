

Add buildroot
-------------
git clone git://git.buildroot.net/buildroot
rm -rf buildroot/.git
git add --force --all buildroot/

git commit -m "buildroot master from 2019.11.07 10:31" buildroot
git push


Adding br-external
------------------
git add --force --all br-external/
git commit -m "external br tree for STM32MP1" br-external/
git push


Build
------
cd buildroot
make BR2_EXTERNAL=../br-external stm32mp1_defconfig
make
