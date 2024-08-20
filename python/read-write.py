# Open a file for writing and create it if it doesn't exist
file1 = open("file.txt", "w+")  # use "a+" append to existing file

# write 100 lines of data to the file
for i in range(100):
    file1.write("This is line %d\n" % (i+1))

# don't forget to close file when done
file1.close()

# open the file and read data
file2 = open("file.txt", "r")

# check wether file was open?
if(file2.mode == 'r'):
    # read the entire file
    # print(f.read())

    # reads the individual lines
    for line in file2.readlines():
        print(line)
