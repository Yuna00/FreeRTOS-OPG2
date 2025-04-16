include cfg/opts.mk

vpath %.c $(C_DIRS)
vpath %.S $(ASM_DIRS)

C_SRC = $(foreach DIR, $(C_DIRS), $(wildcard $(DIR)/*.c)) $(MEMMANG_DIR)/$(MEMMANG_VER)
ASM_SRC = $(foreach DIR, $(ASM_DIRS), $(wildcard $(DIR)/*.S))

C_OBJ = $(patsubst %.c, build/%.o, $(notdir $(C_SRC)))
ASM_OBJ = $(patsubst %.S, build/%.o, $(notdir $(ASM_SRC)))

INC = $(foreach DIR, $(INC_DIRS), -I$(DIR))

all: $(TARGET)

$(TARGET): $(C_OBJ) $(ASM_OBJ)
	$(CC) $(LDFLAGS) $^ -o bin/$@.elf

build/%.o: %.S
	$(CC) $(ASFLAGS) $(LDFLAGS) $(INC) -c $< -o $@

build/%.o: %.c
	$(CC) $(CFLAGS) $(INC) -c $< -o $@

clean:
	rm -rf build
	mkdir -p build

.PHONY: all clean
