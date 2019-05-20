# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=SmokeKernel 1.3.5
do.devicecheck=1
do.initd=1
do.modules=0
do.cleanup=1
device.name1=mocha
test $SDK ! SDK=$(cat /system/build.prop | grep "ro.build.version.sdk=" | dd bs=1 skip=21 count=2);
SDK=$(cat /system/build.prop | grep "ro.build.version.sdk=" | dd bs=1 skip=21 count=2);
ui_print "$SDK found by anykernel";

# shell variables
block=/dev/block/platform/sdhci-tegra.3/by-name/boot;
is_slot_device=0;
## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk

## AnyKernel install
dump_boot;

# begin ramdisk changes
remove_line init.rc "import /init.foxy.rc";
rm -f init.foxy.rc;
rm -f init.spectrum.rc;
rm -f init.spectrum.sh;
insert_line init.rc "mkdir /data/dalvik-cache 0771 system system" after "on post-fs-data" "mkdir /data/dalvik-cache 0771 system system";
replace_line init.rc "mount cgroup none /dev/cpuctl cpu,timer_slack" "    mount cgroup none /dev/cpuctl"

if [ "$SDK" = "25" ]; then
  insert_line init.t124.rc "
service conn_wifi /system/bin/conn_init -op"             after "mkdir /dev/pipes 0771 system system" "
service conn_wifi /system/bin/conn_init -op";
  insert_line init.t124.rc "    class main"                after "service conn_wifi /system/bin/conn_init -op" "    class main";
  insert_line init.t124.rc "    user root"                 after "class main"                                  "    user root";
  insert_line init.t124.rc "    group root"                after "user root"                                   "    group root";
  insert_line init.t124.rc "    seclabel u:r:conn_wifi:s0" after "group root"                                  "    seclabel u:r:conn_wifi:s0";
  insert_line init.t124.rc "    oneshot"                   after "seclabel u:r:conn_wifi:s0"                   "    oneshot";
fi;

if [ "$SDK" = "23" ]; then
  insert_line init.t124.rc "
service conn_wifi /system/bin/conn_init -op" after "mkdir /dev/pipes 0771 system system" "
service conn_wifi /system/bin/conn_init -op";
  insert_line init.t124.rc "    class main"    after "service conn_wifi /system/bin/conn_init -op" "    class main";
  insert_line init.t124.rc "    user root"     after "class main"                                  "    user root";
  insert_line init.t124.rc "    group root"    after "user root"                                   "    group root";
  insert_line init.t124.rc "    oneshot"       after "group root"                                  "    oneshot";
fi;

if [ "$SDK" = "19" ]; then
  rm -f init.t124.rc;
  mv init.t124.miui.rc init.t124.rc;
  remove_line init.t124.rc "insmod /system/lib/modules/symsearch.ko";
  remove_line init.t124.rc "insmod /system/lib/modules/cpufreq_smartmax.ko";
else
  rm -f init.t124.miui.rc;
fi;

write_boot;
## end install

