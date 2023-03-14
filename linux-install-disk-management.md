# Linux installations

# Disk partitioning and filesystem sizing

## Reduce filesystem size
* boot alpha linux live ISO image
* get filesystem current size 
```
$ sudo dumpe2fs -h /dev/sda4 | grep Block
dumpe2fs 1.46.5 (30-Dec-2021)
Block count:              7864320     <<< I already shrunk the size, used to be 180G, now 30G
Block size:               4096
Blocks per group:         32768
```
* run resize2fs with desired new size (may take some time, took 5 minutes to reduce from 180G to 30G on my external USB drive)
```
$ resize2fs /dev/sda4 30G
```

## Shrink partition to fit smaller filesystem

* (Assuming linux ext? filesystem) Get file system size:
```shell
$ dumpe2fs -h /dev/sda4 | grep Block
dumpe2fs 1.46.5 (30-Dec-2021)
Block count:              7864320
Block size:               4096
Blocks per group:         32768
```
* Calculate total byte size of filesystem (includes everything, used/free/metadata)
```
>>> fs_total_blocks = 7864320
>>> fs_block_sz = 4096
>>> fs_bytes = fs_total_blocks * fs_block_sz
>>> fs_bytes
32212254720
>>> fs_gb = fs_bytes >> 30
>>> fs_gb
30
```
* Get disk partition information
(this example shows an already shrunk partition equal to the filesystem size,
before the shrink the partition size was much larger)
```
$ sudo fdisk -l /dev/sda
Disk /dev/sda: 931.51 GiB, 1000204885504 bytes, 1953525167 sectors
Disk model: Expansion       
Units: sectors of 1 * 512 = 512 bytes                     <<< This is the sector size for sizing
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 2C602783-9A2A-4BB8-95D4-866F1B8D3F45

Device          Start        End   Sectors   Size Type
/dev/sda1          40     409639    409600   200M EFI System
/dev/sda2      409640  977172223 976762584 465.8G Microsoft basic data
/dev/sda3   977172480 1039671295  62498816  29.8G Linux swap
/dev/sda4  1039671296 1102585855  62914560    30G Linux filesystem
/dev/sda5  1430296576 1953523711 523227136 249.5G Linux filesystem
```
* convert filesystem byte size into sectors
```
>>> sector_sz = 512
>>> fs_sectors = fs_bytes // sector_sz
>>> fs_sectors
62914560
>>> 
```
* calcualte the new (reduced) partition end sector number
```
>>> part_start_sector = 1039671296 
>>> part_end_sector = part_start_sector + fs_sectors - 1
>>> part_end_sector
1102585855
```
