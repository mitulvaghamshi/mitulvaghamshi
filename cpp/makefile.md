## Makefile

```makefile
# Define variables
SOURCE = data.txt
TARGET = count.txt

# Recursively expanded variable
DATA_FILE = $(SOURCE)

# Simply expanded variable
COUNT_FILE := $(TARGET)

# Targer1: Prerequisite for Target [all]
all: $(COUNT_FILE)
    # Recipe

# Automatic variables:
#- $< : source file
#- $@ : target file
#- $* : target file w/o extension
#- $? : all new prerequisite then target (space seprated), all if no target
#- $+ : same as above with duplicates
#- $^ : same as above w/o duplicates

# Targer2: Prerequisite for Target [count.txt] or here $(COUNT_FILE)
$(COUNT_FILE): $(DATA_FILE)
    	# Count characters as: wc -c $(DATA_FILE) > $(COUNT_FILE)
	wc -c $< > $@ 
    	# Count words as: wc -w $(DATA_FILE) >> $(COUNT_FILE)
	wc -w $< >> $@ 
    	# Count lines as: wc -l $(DATA_FILE) >> $(COUNT_FILE)
	wc -l $< >> $@

# Cleanup Rule: rules w/o prerequisite executed always
clean:
	rm $@
```

## Example

```makefile
CC=gcc
ODIR=obj
LDIR =../lib
IDIR =../include
CFLAGS=-I$(IDIR)

_DEPS = hellomake.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = hellomake.o hellofunc.o 
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

hellomake: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf -- $(ODIR)/*.o *~ $(IDIR)/*~
```
