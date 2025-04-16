TARGET=prog
CC=arm-none-eabi-gcc
SDK_ROOT=e:/SDK-FRDM-KL25Z

COMMONFLAGS = -mcpu=cortex-m0plus -mthumb -mfloat-abi=soft
CFLAGS = $(COMMONFLAGS) -fdata-sections -ffunction-sections -Wall -O0 -g3
LDFLAGS = $(COMMONFLAGS) $(LD_SCRIPT) -specs=nano.specs -lc -lm -lnosys -Wl,-Map=build/$(TARGET:.elf=.map),--cref -Wl,--gc-sections -Xlinker
ASFLAGS = $(COMMONFLAGS) -Wall -g3

INC_DIRS = inc $(SDK_ROOT)/devices $(SDK_ROOT)/devices/MKL25Z4 $(SDK_ROOT)/devices/MKL25Z4/drivers $(SDK_ROOT)/devices/MKL25Z4/utilities  $(SDK_ROOT)/CMSIS/Include $(SDK_ROOT)/CMSIS/Lib/ARM $(SDK_ROOT)/CMSIS/Driver/Include $(SDK_ROOT)/CMSIS/Lib/GCC $(SDK_ROOT)/rtos/freertos/include $(SDK_ROOT)/rtos/freertos/portable/GCC/ARM_CM0

# Directories with C files
C_DIRS = src \
	$(SDK_ROOT)/CMSIS/Driver/DriverTemplates \
	$(SDK_ROOT)/devices/MKL25Z4/ \
	$(SDK_ROOT)/devices/MKL25Z4/drivers/ \
	$(SDK_ROOT)/devices/MKL25Z4/utilities/ \
	$(SDK_ROOT)/rtos/freertos \
	$(SDK_ROOT)/rtos/freertos/portable/GCC/ARM_CM0

LD_SCRIPT = -Tcfg/kl25z.ld -T$(SDK_ROOT)/devices/MKL25Z4/gcc/MKL25Z128xxx4_flash.ld

ASM_DIRS = $(SDK_ROOT)/devices/MKL25Z4/gcc

MEMMANG_DIR = $(SDK_ROOT)/rtos/freertos/portable/MemMang
MEMMANG_VER = heap_4.c
