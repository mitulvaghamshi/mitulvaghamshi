# Define variables
SOURCE = data.txt
TARGET = count.txt

# Recursively expanded variable
DATA_FILE = $(SOURCE)

# Simply expanded variable
COUNT_FILE := $(TARGET)

# Targer1: Prerequisite for Target [all]
all: $(COUNT_FILE) # Access variable
# This Target does not have any recipes

# Note: Using automatic variables:
#
# $< - source file
# $@ - target file
# $* - target file w/o extension
# $? - all new prerequisite then target (space seprated), all if no target
# $+ - same as above with duplicates
# $^ - same as above w/o duplicates

# Targer2: Prerequisite for Target [count.txt] or here $(COUNT_FILE)
$(COUNT_FILE): $(DATA_FILE)
# Recipes for prerequisite
# Count characters
	wc -c $< > $@ # Same as: wc -c $(DATA_FILE) > $(COUNT_FILE)
# Count words
	wc -w $< >> $@ # Same as: wc -w $(DATA_FILE) >> $(COUNT_FILE)
# Count lines
	wc -l $< >> $@ # Same as: wc -l $(DATA_FILE) >> $(COUNT_FILE)

# Cleanup Rule/Target: rule w/o prerequisite executed always
clean:
# Recipes
# Using automatic variable
	rm $@
