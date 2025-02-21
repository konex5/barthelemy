# usb

```bash
# unmount the device
sudo umount /dev/sd<?:b1>

# parted
sudo parted /dev/sd<?:b> # set 1 boot on for iso

# decompress ISO example
sudo dd bs=4M if=/<path>/<input>.iso of=/dev/sd<?:b>  conv=fdatasync

# in case the usb cannot be formated, have a look to
sudo dd if=/dev/zero count=1 bs=2 of=/dev/sd<?b>
# and then
sudo parted /dev/sdb
```
