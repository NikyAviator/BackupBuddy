# BackupBuddy

_"Is it secret? Is it safe?" -Gandalf_

#### The idea behind this script / repo is to teach myself and by extension others how to properly do a backup of our stuff. We need to keep it secret and safe as Gandalf said!

For this to make sense we will use my structure and the types of files I am interested in backup. We will walkthrough how to see the structure of what for instance is saved on a usb-stick, then write a script that synchronizes your computer and another storage device.

---

### Dependencies

1. **tree**: To analyze USB file structure
2. **rsync**: For file synchronization.

### Install on Linux

Use the following command to install the required dependencies:

**For Arch based systems:**

```bash
sudo pacman -S rsync tree
```

**For Debian based systems:**

```bash
sudo apt update
sudo apt install rsync tree
```

#### Note: If you're using another Linux distribution, consult your package manager's documentation to install these dependencies.

---

### Generate Directory Tree

Once tree is installed, we can create a structured view of your USB contents:

**1. Mount your USB Stick:**

- Identify the USB device:

```bash
lsblk
```

Example output:

```graphql
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sdc           8:32   1  14,5G  0 disk
└─sdc1        8:33   1  14,5G  0 part
```

In this example, the USB partition is `/dev/sdc1`.

2. **Create a Mount Point**: Create a directory to mount the USB stick:

```bash
mkdir -p /mnt/usb
```

3. **Mount the USB Stick**: Use the `mount` command to manually mount the USB stick to the directory you just created:

```bash
sudo mount /dev/sdc1 /mnt/usb
```

4. **Verify the Mount:** Check if the USB stick is mounted:

```bash
lsblk
```

You should see the mount point listed under the **MOUNTPOINTS** column:

```graphql
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sdc           8:32   1  14,5G  0 disk
└─sdc1        8:33   1  14,5G  0 part /mnt/usb
```

5. **Access the USB Contents:** Navigate to the USB stick's directory:

```bash
cd /mnt/usb
ls -lah
```

6. **Unmount the USB Stick (When Finished):** After you’re done working with the USB stick, unmount it to safely remove it:

```bash
sudo umount /mnt/usb
```

---

### Common Issues and Fixes

1. **Error: "Mount: only root can do that":**

- Use `sudo` to run the `mount` command as an administrator.

2. **Error: "No such device":**

- Ensure you are using the correct device name (e.g., `/dev/sdc1`) from the `lsblk` output.

3. **Permission Denied:**

- Change ownership of the mount directory:

```bash
sudo chown $USER:$USER /mnt/usb
```

4. **Unmount Fails:**

- If you encounter an error unmounting the device, ensure no processes are accessing the USB stick:

```bash
lsof /mnt/usb
```

Kill any processes using the device before unmounting.

**What `lsof /mnt/usb` Does:**

`lsof` is a powerful Linux command used to list open files and the processes using them. Since in Linux, "everything is a file" (including directories, devices, and sockets), this command can also show processes accessing files on a mounted device like your USB stick.

---
