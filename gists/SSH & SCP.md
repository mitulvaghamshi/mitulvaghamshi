## How to SSH into your Chromebook through Linux Beta

### 1. Check the status of the SSH Client:

Check the status of the SSH client:

```sh
$ sudo systemctl status ssh
```

You should see **condition failed**. This is because, by default, ChromeOS blocks incoming SSH traffic. We need to allow the SSH protocol next.

### 3. Allow SSH

In order to allow SSH, we must remove the **sshd_not_meant_to_be_run** file preventing the protocol from running.

```sh
$ sudo rm /etc/ssh/sshd_not_meant_to_be_run
```

### 4. Check the Status of SSH

After removing the file, check the status of SSH.

```sh
$ sudo systemctl status ssh
```

SSH is still not working due to **condition failed**? Fix this issue by restarting the SSH protocol to allow the new changes of removing the file to take place.\
Since the SSH protocol has not technically started, we need to **start** the server from the new configuration instead of restarting it.

```sh
$ sudo systemctl start ssh
```

After we have deleted the file preventing SSH from running and restarted the server, check the status of SSH.

```sh
$ sudo systemctl status ssh
```

Here, that SSH up successfully up and **active (running)** as we wish. Now continue with setting up SSH.

### 5. Set a Root and User Password

To SSH into our Chromebook, we need to set up a root password to remotely login in.\
Run the following command with sudo privileges to gain access to the root shell:

```sh
$ sudo su
```

Once you have access to the root shell, set a password for the root account.

```sh
$ passwd root
```

Make sure you remember this password. You are essentially creating a password to sign into your computer for your Linux VM just as you would create a password to sign into your Windows or Mac computer.\
After setting the root password, set a password for username.

```sh
$ passwd username
```

Exit by running:

```sh
$ exit
```

### 6. Change the SSH Port

To access SSH on our Chromebook, set up a specific port as the normal ports, (i.e. 1-1023) are reserved for normal Chromebook functions.\
Access the SSH configuration file. We want to access the **sshd_config** and _not_ the **ssh_config** file.

```sh
$ sudo vim /etc/ssh/sshd_config
```

Scroll down to #**Port 22**.\
Change the port from **Port 22** to **Port [1024 > port < 65635]** then save and exit.

### 7. Open SSH Port to Outside Network

To SSH using Port 3002, forward it from the Linux VM to the outside network.\
To do this, use Linux's built in Port Forwarding to set up Port 3002 to the outside network.\
Open up Chromebook's settings app.\
Search for **port forwarding** and selected **Linux port forwarding**.\
Click **Add** to add a forwarding rule.\
Type **3002** (the port you set in the configuration earlier) into the **Port Number** entry. Make sure it is set to **TCP**.\
Label this something like **ssh server**.

### 8. Restart SSH Server

Check the status of the SSH server:

```sh
$ sudo systemctl status ssh
```

SSH server is **active (running)**, but it is still listening to the old port (**Port 22)**.\
In order for the new configuration to take place, just restart the SSH server:

```sh
$ sudo systemctl restart ssh
```

After restart, check the status again:

```sh
$ sudo systemctl status ssh
```

Configuration worked as the SSH server is now listening on Port 3002.

### 9. Find your Local IP Address

Find the local IP address of your computer:

```sh
$ hostname -I
```

### 10. SSH into your Chromebook

SSH command to remotely login to your Chromebook:

```sh
$ ssh username@ip-address -p 3002
```

The first time you SSH into a device, you will be greeted with this message as shown above.\
Type in **yes** to confirm you wish to connect to the new device.\
Then, type in the password we set for the user account (not root).

## Using the Linux Terminal over SSH

Install Htop for resource monitoring:

```sh
$ sudo apt install htop
```

After installing Htop through APT, we are able to see and access it over our remote connection.

```sh
$ htop
```

This allows to remotely check in on Chromebook's performance and eliminate and processes that are taking up unnecessary resources.

**SCP: Send Files to your Chromebook**

SSH does not only allow us to remotely login, but also send files over SCP (Secure Copy Protocol).

```sh
$ scp -P 3002 cat.png username@ip-address:/home/username/Downloads/
```



```sh
scp -P 3002 [-r] username@ip-address:/path/to/source path/to/destination
```

**Open Images on Chromebook Remotely**

After copying the file over the network over SCP, Run the **ls **command to view the files in the current directory.

```sh
$ ls
```

Install an image viewer to open the file. Install the FEH image viewer:

```sh
$ sudo apt install feh
```

Use the feh command to launch a file:

```sh
$ feh cat.png
```

**Play Audio Files on Chromebook Remotely through SSH**

To play an audio file, send over a file to play using SCP.

```sh
$ scp -P 3002 song.mp3 username@ip-address:/home/username/Downloads/
```

Install an audio player that can be used through the Terminal using APT, like MPG123:

```sh
$ sudo apt install mpg123
```

Play the audio file:

```
mpg123 song.mp3
```

Press **CTRL** + **C** to stop it. Otherwise, you will return to the shell once the song is over.
