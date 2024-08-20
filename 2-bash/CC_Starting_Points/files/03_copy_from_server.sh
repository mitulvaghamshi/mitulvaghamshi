# Copies the directory called dir_name from /path/to/source/dir_name
# on a remote server to the current directory on the local machine.

ssh username@hostname "cd /path/to/source; tar -czf - dir_name" | tar -xzf -
