# How to SSH

1. Check the status of the SSH Client:
   ```sh
   sudo systemctl status ssh
   ```

- If it shows **condition failed** means SSH protocol is not allowed.

2. Allow SSH protocol:

- To allow SSH, remove the **sshd_not_meant_to_be_run** file:
  ```sh
  sudo rm /etc/ssh/sshd_not_meant_to_be_run
  ```

3. Check the Status of SSH again:
   ```sh
   sudo systemctl status ssh
   ```

- If SSH is still not working due to **condition failed**? Fix this issue by restarting the SSH protocol to allow the new changes of removing the file to take place.
- Since the SSH protocol has not technically started, we need to **start** the server from the new configuration instead of restarting it.
  ```sh
  sudo systemctl start ssh
  sudo systemctl status ssh
  ```
- SSH should be up and **active (running)** at this point.

4. Set a Root and User Password:

- To SSH, set up a root password to remotely login in.
- First, gain root access by running:
  ```sh
  sudo -i # or sudo su
  ```
- Set a password for the root account:
  ```sh
  passwd root
  ```
- After setting the root password, set a password for user.
  ```sh
  passwd <username>
  ```
- Exit root shell by running:
  ```sh
  exit
  ```

5. Change the SSH Port:

- Edit the SSH config file **sshd_config** and _not_ the **ssh_config**:
  ```sh
  sudo vim /etc/ssh/sshd_config
  ```
- Look for #**Port 22** line and change the port from **Port 22** to **Port [1024 > port < 65635]** then save and exit the vim.

6. Open SSH Port to Outside Network (Chromebook only):

- To SSH using Port `<port>`, forward it from the Linux VM to the outside network.
- Open up Chromebook's settings app.
- Search for **port forwarding** and selected **Linux port forwarding**.
- Click **Add** to add a forwarding rule.
- Type `<port>` (the port you set in the configuration earlier) into the **Port Number** entry.
- Make sure it is set to **TCP**.
- Label this **ssh-access**.

7. Restart SSH Server and check the status:
   ```sh
   sudo systemctl restart ssh
   sudo systemctl status ssh
   ```

8. Find Local IP Address:
   ```sh
   hostname -I
   ```

9. SSH into your system:
   ```sh
   ssh user@host -p <port>
   ```

10. Send Files to your Remote Machine:
    ```sh
    # Copy files from Local to Remote Machine
    scp -P <port> [-r] <path/to/source> <user@host:/path/to/dest>
    # Copy files from Remote to Local Machine
    scp -P <port> [-r] <user@host:/path/to/source> <path/to/dest>

    # Example: Copy image file from Local to Remote Machine
    scp -P <port> cat.png user@host:/home/user/Downloads/meow.png
    ```

11. Open Images on Remote Machine, install FEH image viewer:
    ```sh
    sudo apt install -y feh
    feh ~/Downloads/meow.png
    ```

12. Play Music on Remote Machine, install MPG123 audio player:
    ```sh
    sudo apt install -y mpg123
    mpg123 ~/Downloads/song.mp3
    ```

13. Skip login password using SSH keys (generic guide):
    ```sh
    # Generate key on local machine
    ssh-keygen -t ed25519 -C "email"
    # Set optional passphrase for key access
    ssh-keygen -p
    # Start ssh agent daemon
    eval "$(ssh-agent -s)"
    # Add key to ssh agent
    ssh-add ~/.ssh/id_ed25519
    # Copy key to remote machine
    ssh-copy-id -i -p <port> user@host
    # Optinally setup quick access using config
    vim ~/.ssh/config
    # Tryout new key based login
    ssh -T user@host
    ```
