[3J[H[2J---------------------------------------------------
Выполнить чистую сборку?                          -
---------------------------------------------------
1 -clean_build=1;compile;;                                           -
---------------------------------------------------
2 - compile;;                                       -
---------------------------------------------------
3 - compile dtb                                   -
---------------------------------------------------
4 - return                                         -
---------------------------------------------------
Ваш выбор: [3J[H[2J#
# configuration written to .config
#
scripts/kconfig/conf --silentoldconfig Kconfig
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CC      scripts/mod/devicetable-offsets.s
make[1]: 'include/generated/mach-types.h' está actualizado.
  CALL    scripts/checksyscalls.sh
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CHK     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
<<<<<<< HEAD
  CC      arch/arm/mach-tegra/board-ardbeg-sdhci.o
  CC      arch/arm/mach-tegra/board-loki-sdhci.o
=======
  CC      kernel/sys.o
>>>>>>> 2b6696a3c0f... mocha: drivers: platform: tegra: add serial number parsing
  CC      drivers/base/firmware_class.o
  LD      arch/arm/mach-tegra/built-in.o
  CC      kernel/trace/trace.o
  LD      drivers/base/built-in.o
  CC      kernel/module.o
  CC      drivers/mmc/card/block.o
  CC      drivers/mmc/card/queue.o
  LD      kernel/trace/built-in.o
  CC      drivers/mmc/card/mmc_test.o
  GZIP    kernel/config_data.gz
  LD      drivers/mmc/card/mmc_block.o
  CC      drivers/net/wireless/bcmdhd/bcmsdh_sdmmc.o
  CHK     kernel/config_data.h
  LD      kernel/built-in.o
  CC      drivers/mmc/core/core.o
  CC      drivers/mmc/host/sdhci.o
  LD      drivers/mmc/card/built-in.o
  CC      drivers/mmc/core/bus.o
  CC      drivers/net/wireless/bcmdhd/bcmsdh_sdmmc_linux.o
  CC      drivers/mmc/core/host.o
  LD      drivers/net/wireless/bcmdhd/bcmdhd.o
  LD      drivers/net/wireless/bcmdhd/built-in.o
  CC      drivers/mmc/core/mmc.o
  LD      drivers/net/wireless/built-in.o
  LD      drivers/net/built-in.o
  CC      drivers/mmc/core/mmc_ops.o
  CC      drivers/mmc/core/sd.o
  CC      drivers/mmc/core/sd_ops.o
  CC      drivers/mmc/core/sdio.o
  CC      drivers/mmc/core/sdio_ops.o
  CC      drivers/mmc/core/sdio_bus.o
  CC      drivers/mmc/host/sdhci-pltfm.o
  CC      drivers/mmc/core/sdio_cis.o
  CC      drivers/mmc/core/sdio_io.o
  CC      drivers/mmc/core/sdio_irq.o
  CC      drivers/mmc/host/sdhci-tegra.o
  CC      drivers/mmc/core/slot-gpio.o
  CC      drivers/mmc/core/debugfs.o
  LD      drivers/mmc/core/mmc_core.o
  LD      drivers/mmc/core/built-in.o
  LD      drivers/mmc/host/built-in.o
  LD      drivers/mmc/built-in.o
  LD      drivers/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gzip
  AS      arch/arm/boot/compressed/piggy.gzip.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
[1;32m
Компиляция дерева устройства

[0m  CC      scripts/mod/devicetable-offsets.s
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
make[1]: 'arch/arm/boot/dts/tegra124-mocha.dtb' está actualizado.
[1;32m
<<<<<<< HEAD
Ядро скомпилировано за 00:28
[0m[1;32mСборка номер 64 в ветке 
=======
Ядро скомпилировано за 00:22
[0m[1;32mСборка номер 69 в ветке 
>>>>>>> 2b6696a3c0f... mocha: drivers: platform: tegra: add serial number parsing
[0m[1;32m
Создание zip архива

[0m  adding: META-INF/ (stored 0%)
  adding: META-INF/com/ (stored 0%)
  adding: META-INF/com/google/ (stored 0%)
  adding: META-INF/com/google/android/ (stored 0%)
  adding: META-INF/com/google/android/updater-script (deflated 5%)
  adding: META-INF/com/google/android/update-binary (deflated 65%)
  adding: anykernel.sh (deflated 70%)
  adding: dt2w/ (stored 0%)
  adding: dt2w/dt2w (deflated 49%)
  adding: kernel/ (stored 0%)
  adding: kernel/zImage (deflated 0%)
  adding: kernel/dtb (deflated 82%)
  adding: ramdisk/ (stored 0%)
  adding: ramdisk/init.t124.rc (deflated 74%)
  adding: ramdisk/init.t124.miui.rc (deflated 77%)
  adding: tools/ (stored 0%)
  adding: tools/unpackbootimg (deflated 34%)
  adding: tools/ak2-core.sh (deflated 72%)
  adding: tools/busybox (deflated 38%)
  adding: tools/mkbootimg (deflated 34%)
  adding: zImage_legacy (deflated 0%)
[1;32m
<<<<<<< HEAD
v3.10.96(24.10.2019-22.53).zip создан, перемещение в /home/dargons10/mkernel/output[0m
=======
v3.10.96(24.10.2019-23.19).zip создан, перемещение в /home/dargons10/mkernel/output[0m
>>>>>>> 2b6696a3c0f... mocha: drivers: platform: tegra: add serial number parsing
[1;32m
Завершено
[0m