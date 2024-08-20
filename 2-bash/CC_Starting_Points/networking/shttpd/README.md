## Shell Web Server

To set up this shell-based web server, you just install several helpers. This script downloads and builds most of those helpers.

To build the helpers, type:

```sh
make
sudo make install
```

This does not install the shell-based web server in any way.

Before you run the server:

1. Install php-cgi if desired. This could not be scripted due to the way the PHP website is designed.

To install this, do the following:

- Download and extract the PHP soruces,
- cd into the resulting source directory.
- Type and press return. (You can add additional flags if desired.)

```sh
./configure \
    --prefix=/usr/local/php5-cgi \
    --with-zlib \
    --enable-cgi \
    --enable-force-cgi-redirect=false
```

- Type and press return:

```sh
make
sudo make intall
```

2. Adjust the configuration file.

Modify the file `shttpd.conf` in the `shttpd` directory as needed for your local environment.

3. Add symbolic links in the sites directory.

Each combination of host name (or IP number) and port that you want to actually serve must have a folder or symbolic link to a folder within the sites directory. This design greatly simplifies the configuration file format.

Now you're ready to run the server. Change back into the `shttp` directory and type:

```sh
sh shttps.sh
```

Now connect to `localhost:8081` and have fun.
