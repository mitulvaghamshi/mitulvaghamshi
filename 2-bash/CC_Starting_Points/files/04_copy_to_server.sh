# Copies dir_or_file on the local machine to
# /path/to/dest/dir_or_file on a remote machine.

tar -czf - dir_or_file | ssh username@hostname "cd /path/to/dest; tar -xzf -"
