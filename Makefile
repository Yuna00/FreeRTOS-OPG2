include cfg/opts.mk

# C src to obj
C_SRC = $(foreach DIR, $(SRC_DIRS), $(wildcard $(DIR)/*.c)) $(MEMMANG_DIR)/$(MEMMANG_VER)
C_OBJ = $(patsubst %.c, build/%.o, $(notdir $(SRC)))

# ASM src to obj
ASM_SRC = $(foreach DIR, $(ASM_DIRS), $(wildcard $(DIR)/*.S))
ASM_OBJ = $(patsubst %.S, build/%.o, $(notdir $(ASM_SRC)))

INC = $(foreach DIR, $(INC_DIRS), -I$(DIR))

all: $(TARGET)

$(TARGET): $(C_OBJ) $(ASM_OBJ)
	$(CC) $(LDFLAGS) $^ -o bin/$@.elf

build/%.o: $(C_DIRS)/%.c
	$(CC) $(CFLAGS) $(INC) -c $< -o $@

build/%.o: $(ASM_DIRS)/%.S
	$(CC) $(ASFLAGS) $(LDFLAGS) $(INC) -c $< -o $@

clean:
	rm -rf build
	mkdir -p build

.PHONY: all clean
