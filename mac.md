# Mac OS tips/hints/tricks/how-to

### iCloud Drive local path
```
~/Library/Mobile\ Documents/com~apple~CloudDocs/
/Users/USERNAME/Library/Mobile\ Documents/com~apple~CloudDocs/
```

### Stop mac tar from adding ._ turds to archives
COPYFILE_DISABLE=1 tar cvf foo.tar foo/
or
export COPYFILE_DISABLE=1
tar cvf foo.tar foo/


