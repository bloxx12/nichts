# Dualbooting NixOS and FreeBSD

Out of curiosity, I decided to dual-boot NixOS and FreeBSD on my laptop, sharing
one disk. I document the process here for future reference:

## Linux install

First, flash a stick with NixOS, then boot into it, wipe your disk, create two
partitions, one being boot, the other your main NixOS partition. Then, follow
these commands:

```bash
sudo su

cryptsetup luksFormat /dev/diskname/partition

cryptsetup open /dev/diskname/partition crypt

mkfs.btrfs -L nixos /dev/mapper/crypt

mount /dev/mapper/crypt /mnt

btrfs create subvolume /mnt/nix
btrfs create subvolume /mnt/home
btrfs create subvolume /mnt/persist

mkdir /mnt/boot
mount /dev/partition # boot partition
```

Then, copy [my nixos flake](https://github.com/bloxx12/nichts) to `/mnt`, you
can remove it from there later on.

```bash
git clone https://github.com/bloxx12/nichts /mnt
```

In there, change the file system uuids to the correct ones, you can see them
using

```bash
sudo blkid
```

Then, install NixOS itself:

```bash
nixos-install --impure --flake /mnt/nichts#<hostname> -j 1 --cores 2
```

Wait for that to finish, then reboot.

If your system works, great! if not, redo from the beginning.

After that, set up FreeBSD the following way:
