# Project root directory
ROOT_DIR := .

# Build directory
BUILD_DIR := $(ROOT_DIR)/build

# Compiler (platform default)
CC := cc

# 'editeline' (macOS) and 'math' lib
C_LIBS := -ledit -lm

# Compiler flags
C_FLAGS := -std=c99 -g -Wall -Wextra -Werror -Wno-unused-parameter
# CFLAGS += -DUSE_MPC # OR $ make all USE_MPC=1
ifeq ($(USE_MPC_LIB), 1)
    C_FLAGS += -DUSE_MPC
endif

# Locate all '.c' files recusively within 'ROOT' dir, excluding 'mpc' dir
C_SRC := $(shell find $(ROOT_DIR) \
	-path $(ROOT_DIR)/mpc -prune -o -type f -name "*.c" -print0)

# Convert source file paths to object file paths
C_OBJ := $(patsubst $(ROOT_DIR)/%.c,$(BUILD_DIR)/%.o,$(C_SRC))

# Executable product name
C_EXE := $(BUILD_DIR)/lisp

# Default target
all: $(C_EXE)

# Link the executable
$(C_EXE): $(C_OBJ)
ifeq ($(USE_MPC_LIB), 1)
	@$(CC) $(C_LIBS) $(ROOT_DIR)/mpc/mpc.c $^ -o $@
else
	@$(CC) $(C_LIBS) $^ -o $@
endif

# Compile C files into object files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(@D)
	@$(CC) $(C_FLAGS) -c $< -o $@

lrun:
	@$(C_EXE) $(ROOT_DIR)/mpc/examples/prelude.lspy

run:
	@$(C_EXE)

clean:
	@rm -rf -- $(BUILD_DIR)
