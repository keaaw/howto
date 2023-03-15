# Bootstrap an archlinux system from scratch
(As a secondary linux on a system with an existing bootloader/linux installation.  This means no mounting or formatting of the EFI partition and no bootloader installation!)

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
  
### Follow the installation guide instructions
This will create a bootable archlinux system, but you won't have a working network, make sure while still on the installation system to download network
management packages, e.g., ```iwd```, and an editor, like ```vim```.  The base archlinux has far fewer packages by default than the installation ISO!

Even though you're not creating a bootable EFI partition, you still need to create the grub configuration menu entry so you can copy this to your default linux
system's grub menu.   Don't mount the EFI partition, either, as we're not going to touch it when installing archlinux.

https://wiki.archlinux.org/title/GRUB  

From these instructions the only part we need is ```# grub-mkconfig -o /boot/grub/grub.cfg```   Copy the main grub menuentry from this new ```/boot/grub/grub.cfg``` to the primary linux's ```/etc/grub.d/40_custom``` and re-run the grub update config command.  Now you should be able to reboot the system and choose the newly installed archlinux and continue system configuration

### Enable basic services / networking
If you included a network manager during the installation process, you should be able to configure and enable it now.  I used [iwd](https://wiki.archlinux.org/title/Iwd#top-page)
* Remember to enable any installed services, as they typically are not enabled after installation of the package with archlinux!   An enabled systemd service is one that starts automatically on boot.   Staring/stopping and enabling/disabling of services are separate controls in systemd.
```bash
# systemctl enable iwd
# systemctl enable systemd-resolved
```
iwd needs to be manually configured to enable automatic network configuration on boot:  
https://wiki.archlinux.org/title/Iwd#Enable_built-in_network_configuration  
https://wiki.archlinux.org/title/Iwd#Select_DNS_manager

If you choose systemd-resolved as the DNS service, remember to enable it!  

```
# systemctl enable systemd-resolved
```


 

