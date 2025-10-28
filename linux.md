### caps -> control on the linux console (before GUI starts)
```
    check the keycode of the key you want to change. showkey will echo the keycode of the pressed key. Remember: to stop it just don't type anything for 10 seconds and it will exit.

    copy your currently map file somewhere. For example mine is /usr/share/kbd/keymaps/i386/dvorak/dvorak.map.gz

    un(g)zip that

    open that file with your editor of choice

    for me the caps lock is the 58 while left-ctrl 29. Just swap the number at the start of the line

    recompress the map file gzip -c < dvorak.map > dvorak.map.gz

    copy that to the original folder

    Automatize that with a PKGBUILD and you're done!
```

### caps -> control in X
```
setxkbmap -option caps:ctrl_modifier
```
