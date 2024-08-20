import shutil
from os import path
from zipfile import ZipFile

# Make a duplicate of an existing file
if(path.exists("file.txt")):
    # get the path to the file in the current directory
    src = path.realpath("file.txt")
    print(src)

    # let's make a backup copy by appending "bak" to the name
    bakFile = src + ".bak"
    print(bakFile)

    # now use the shell to make a copy of the file
    shutil.copy(src, bakFile)

    # copy over the permissions, modification times, and other info
    shutil.copystat(src, bakFile)

    # rename the original file
    os.rename("file.txt.bak", "newfile.dat")

    # now put things into a ZIP archive
    root_dir, tail = path.split(src)
    print(root_dir)
    print(tail)
    shutil.make_archive("archive", "zip", root_dir)

    # more fine-grained control over ZIP files
    with ZipFile("testzip.zip", "w") as newzip:
        newzip.write("newfile.dat")
        newzip.write("file.txt")
