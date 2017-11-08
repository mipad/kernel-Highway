#!/bin/bash
# simple bash script for executing build

# root directory of NetHunter Mipad1[mocha] git repo (default is this script's location)
RDIR=$(pwd)

[ "$VER" ] ||
# version number
VER=$(cat "$RDIR/VERSION")

# directory containing cross-compile arm toolchain
FLEVOR=NetHunterKernels
TOOLCHAIN=$RDIR/../toolchain
CCACHE=$RDIR/../ccache
zImage=$RDIR/build/arch/arm/boot/zImage
FWR=$RDIR/build/lib/firmware
MOD=$RDIR/build/lib/modules
TV=$RDIR/build/thevirus
ZS=Thevirus_kernel_flasher-signed.zip
ZIP=${FLEVOR}_${LOCALVERSION}-signed.zip
CPU_THREADS=$(grep -c "processor" /proc/cpuinfo)
# amount of cpu threads to use in kernel make process
THREADS=$((CPU_THREADS + 1))
# directory cloning cross-compile arm toolchain

 if [ -d $TOOLCHAIN ] ; then
   find $TOOLCHAIN -type f -exec chmod a+rwx {} \;
   echo "You have already toolchain..."
 else
  git clone https://bitbucket.org/UBERTC/arm-eabi-4.9.git $TOOLCHAIN
  find $TOOLCHAIN -type f -exec chmod a+rwx {} \;
  
 fi
############## SCARY NO-TOUCHY STUFF ###############

ABORT()
{
	[ "$1" ] && echo "Error: $*"
	exit 1
}

export ARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-eabi- 
export USE_CCACHE=1
export CCACHE_DIR=$CCACHE

[ -x "${CROSS_COMPILE}gcc" ] ||
ABORT "Unable to find gcc cross-compiler at location: ${CROSS_COMPILE}gcc"

[ "$TARGET" ] || TARGET=user
[ "$1" ] && DEVICE=$1
[ "$DEVICE" ] || DEVICE=mocha

 
  DEFCONFIG=${DEVICE}_${TARGET}_defconfig
  
 
[ -f "$RDIR/arch/$ARCH/configs/${DEFCONFIG}" ] ||
ABORT "Config $DEFCONFIG not found in $ARCH configs!"

export LOCALVERSION=-V$VER-$DEVICE

CLEAN_BUILD()
{
        echo " "
	echo " "
	echo "Cleaning build.."
	
	rm -rf $RDIR/build
	rm -rf $CCACHE
	
	echo " Done ! "

}

SETUP_BUILD()
{
	echo "Creating kernel config for $LOCALVERSION..."
	mkdir -p build
	if [ -d $CCACHE ] ; then
   echo "You have already ccache..."
  else 
	mkdir -p $CCACHE
	
fi
	
	make -C "$RDIR" O=build "$DEFCONFIG" \
		|| ABORT "Failed to set up build"
}

MENU_CONFIG()
{
	echo "Creating menu config for $LOCALVERSION..."
	
	make -C "$RDIR" O=build "menuconfig" \
		|| ABORT "Failed to make menuconfig.."
}

BUILD_KERNEL()
{
 echo " "
 echo " "
	echo "Starting build for $LOCALVERSION..."
	while ! make -C "$RDIR" O=build -j"$THREADS"; do
		read -rp "Build failed. Retry? " do_retry
		case $do_retry in
			Y|y) continue ;;
			*) return 1 ;;
		esac
	done
}

MAKE_DTB()
{
	echo "Creating dtb for $LOCALVERSION..."
	
	make -C "$RDIR" O=build "tegra124-mocha.dtb" \
		|| ABORT "Failed to make tegra124-mocha.dtb.."
}

INSTALL_MODULES() {
	echo "Installing kernel modules to build/lib/modules..."
	make -C "$RDIR" O=build \
		INSTALL_MOD_PATH="." \
		INSTALL_MOD_STRIP=1 \
		modules_install
	rm build/lib/modules/*/build build/lib/modules/*/source
}
MAKE_ZIP()
{
	echo "Making flashable zip.."
 echo " "
if [ -d $TV ]; then
 echo "you have already cloned"
else
 echo "Downloading required files...."
git clone https://github.com/RahulTheVirus/kernel_flasher.git $TV

  fi

if [ -d $MOD ]; then
     rm -rf $TV/src/*
    cp -R $MOD/*/* $TV/src/ 
         
      fi 
     
if [ -f $zImage ]; then
      rm -rf $TV/src/zImage
     cp $zImage $TV/src/zImage
      
      fi
      
if [ -d $FWR ]; then
    chmod 777 $TV/src/firmware
      rm -rf $TV/firmware
      cp -R $FWR $TV/src/
      
      fi

 cd $TV
 
 . build.sh
 
 if [ -f $TV/sign/$ZS ]; then
    chmod 777 $TV/sign/$ZS
    cp -R $TV/sign/$ZS $RDIR/$ZIP

   
    fi
	
	echo " Done ! "

}
echo " "
echo " "

 if [ -d $RDIR/build ]; then
  {
echo -e -n "Do you want to clean build directory (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg

   if echo "$answer" | grep -iq "^y" ;then
       {
       CLEAN_BUILD && 
        SETUP_BUILD
   echo " "    
   echo -e -n "Do you want to make menuconfig.. (y/n)? "
   old_stty_cfg=$(stty -g)
   stty raw -echo
   answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
   stty $old_stty_cfg

   if echo "$answer" | grep -iq "^y" ;then

   echo " If gettin error then Please use biger size screen"
   echo " or don't make menuconfig just edit your device defconfig file"

   MENU_CONFIG
    
       fi
      }
    fi
    
    BUILD_KERNEL &&
    MAKE_DTB &&
    INSTALL_MODULES &&
  echo "Finished building $LOCALVERSION!"   
  
  }
  
  else
     {
   
  if [ ! -f $RDIR/build/.config ]; then 
    SETUP_BUILD
    
    fi
  
   echo " "    
   echo -e -n "Do you want to make menuconfig.. (y/n)? "
   old_stty_cfg=$(stty -g)
   stty raw -echo
   answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
   stty $old_stty_cfg

   if echo "$answer" | grep -iq "^y" ;then

   echo " If gettin error then Please use biger size screen"
   echo " or don't make menuconfig just edit your device defconfig file"

   MENU_CONFIG
 
    fi
  
    BUILD_KERNEL &&
    MAKE_DTB &&
   INSTALL_MODULES &&
echo "Finished building $LOCALVERSION!"    
 
  }
  
  fi
  
if [ -f $zImage ] ; then
   {
echo " "
echo " "   
echo -e -n "Do you want to make Flashable zip.. (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg

if echo "$answer" | grep -iq "^y" ;then

      MAKE_ZIP &&
   echo " "
   echo " Collect ZIP from ${RDIR} ..."
      
      fi
  }
  
  fi

if [ -f $zImage ] ; then
   echo " "
   echo " "
   echo " Alternetively you can  "
   echo " "
   echo " Collect zImage from build/arch/arm/boot"
   echo " "
   echo " Collect modules & firmware from build/lib"
   echo " "
   echo " You Can connect us on https://t.me/mipad1 "
   echo " "
   echo "                          Thanks& Regards! "
   echo "                            RahulTheVirus! "
   echo " "
else
    echo " "
    echo "Please Review & Fix the errors"
    echo " "
    echo "And try again.."
    echo " "
    echo " You Can connect us on https://t.me/mipad1 "
    echo " "
    echo "                          Thanks& Regards! "
    echo "                            RahulTheVirus! "
    echo " "

 fi
   
cd $RDIR
