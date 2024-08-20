# Working with os module
from os import path
import os
import time
import datetime

# Print the name of the OS
print(os.name)

# Check for item existence and type
print("Exists:", str(path.exists("file.txt")))
print("Is file:", str(path.isfile("file.txt")))
print("Is directory:", str(path.isdir("file.txt")))

# File/Dir path
print("Path:", str(path.realpath("file.txt")))
print("Path and name:", str(path.split(path.realpath("file.txt"))))

# Get the modification time
print(time.ctime(path.getmtime("file.txt")))
print(datetime.datetime.fromtimestamp(path.getmtime("file.txt")))

# calculate how long ago the item was modified
now = datetime.datetime.now()
since = datetime.datetime.fromtimestamp(path.getmtime("file.txt"))
sliced = now - since
print("It has been", str(sliced), "since last the file was modified")
print("Or,", str(sliced.total_seconds()), "seconds")
