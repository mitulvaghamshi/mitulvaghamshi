# Project root directory
ROOT := .
# Build directory
BUILD := $(ROOT)/build
# Compiler (platform default)
CC := cc
# 'editeline' (macOS) and 'math' lib
LIBS := -ledit -lm
# Compiler flags
CFLAGS := -std=c99 -g -Wall -Wextra -Werror -Wno-unused-parameter #-DUSE_MPC_LIB=$(USE_MPC_LIB)
# Locate all '.c' files within 'ROOT/' and its subdirs/, exluding 'mpc/' dir
SRCS := $(shell find $(ROOT) -path $(ROOT)/mpc -prune -o -type f -name "*.c" -print0)
# Convert source file paths to object file paths
OBJS := $(patsubst $(ROOT)/%.c,$(BUILD)/%.o,$(SRCS))
# Executable product name
EXEC := $(BUILD)/lisp

# Default target
all: $(EXEC)

# Link the executable
$(EXEC): $(OBJS)
ifeq ($(USE_MPC_LIB), 1)
	@$(CC) $(LIBS) $(ROOT)/mpc/mpc.c $^ -o $@
else
	@$(CC) $(LIBS) $^ -o $@
endif

# Compile C files into object files
$(BUILD)/%.o: %.c
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c $< -o $@

lrun:
	@$(EXEC) $(ROOT)/mpc/examples/prelude.lspy

run:
	@$(EXEC)

clean:
	@rm -rf $(BUILD)
