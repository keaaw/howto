# Bootstrap an archlinux system from scratch
(On a system with an existing bootloader/linux installation.  This means no mounting or formatting of the EFI partition.)

## Install
 https://wiki.archlinux.org/title/installation_guide  
 
### Booting the Installation ISO image
* Download the installatiuon ISO image   
  https://archlinux.org/download/
* Boot the image  
  The easiest way to not hassle with burning the ISO to a USB flash drive is to use an existing linux installation as host of the ISOs: just store the ISOs
  in a linux filesystem that grub2 knows how to read (e.g., ext4), and add a menuentry to your existing linux's grub boot menu (and update the grub config, on
  Ubuntu this is done with ```sudo update-grub```)  
  https://wiki.archlinux.org/title/Multiboot_USB_drive#Arch_Linux  
  
  Example menuconfig (edit ```/etc/grub.d/40_custom```)
  ```
  menuentry '[loopback]archlinux-2020.10.01-x86_64.iso' {
	set isofile='/boot/iso/archlinux-2020.10.01-x86_64.iso'
	loopback loop $isofile
	linux (loop)/arch/boot/x86_64/vmlinuz-linux img_dev=$imgdevpath img_loop=$isofile earlymodules=loop
	initrd (loop)/arch/boot/intel-ucode.img (loop)/arch/boot/amd-ucode.img (loop)/arch/boot/x86_64/initramfs-linux.img
}
```
 

