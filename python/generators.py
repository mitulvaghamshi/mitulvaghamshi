import time
import math
import memory_profiler

def make_even(size):
    return [i * i for i in range(size) if i % 2 == 0]

def gen_even(size):
    for i in range(size):
        if i % 2 == 0:
            yield i * i

print("Processing... 100_000_000 items, to find square of even numbers.")

SIZE = 100000000

# Start time and mem
startMem = memory_profiler.memory_usage()
startTime = time.process_time()

# Execution
# make_even(SIZE)
gen_even(SIZE)

# Finish time and mem
endTime = time.process_time()
endMem = memory_profiler.memory_usage()

# Result
print("Time: ", math.ceil(endTime - startTime), "seconds")
print("Space:", endMem[0] - startMem[0], "MB")
