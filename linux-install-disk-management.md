# linux installations

# disk partitioning and filesystem sizing

## Shrink file system within partition

(Assuming linux filesystem) Get file system size:
```
dumpe2fs -h /dev/sda4 | grep Block
