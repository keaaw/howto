# Bootstrap an archlinux system from scratch (secondary)
(As a secondary linux on a system with an existing EFI/MBR bootloader/linux installation.  This means no mounting or formatting of the EFI partition and no bootloader installation!)

See the next section for how I troubleshooted a EFI/GPT/GRUB archlinx installation on a brand new SSD

## Install
 https://wiki.archlinux.org/title/installation_guide  
 
### Booting the Installation ISO image
* Download the installatiuon ISO image   
  https://archlinux.org/download/
* Boot the image  
  The easiest way to not hassle with burning the ISO to a USB flash drive is to use an existing linux installation as host of the ISOs: just store the ISOs
  in a linux filesystem that grub2 knows how to read (e.g., ext4), and add a menuentry to your existing linux's grub boot menu (and update the grub config, on
  Ubuntu this is done with `sudo update-grub`)  
  https://wiki.archlinux.org/title/Multiboot_USB_drive#Arch_Linux  
  
<details>
	<summary>Example menuconfig (edit <code>/etc/grub.d/40_custom</code>) </summary>

```
  menuentry "archlinux-2023.02.01-x86_64.iso" {
  insmod ext2
  set isofile="/kmw/Downloads/archlinux-2023.02.01-x86_64.iso"
  loopback loop (hd0,5)$isofile
  linux (loop)/arch/boot/x86_64/vmlinuz-linux archisolabel=ARCH_202103 img_dev=/dev/sda5 img_loop=$isofile earlymodules=loop
  initrd (loop)/arch/boot/x86_64/initramfs-linux.img
}
```

</details>


### Follow the installation guide instructions
This will create a bootable archlinux system, but you won't have a working network, make sure while still on the installation system to download network
management packages, e.g., `iwd`, and an editor, like `vim`.  The base archlinux has far fewer packages by default than the installation ISO!

Even though you're not creating a bootable EFI partition, you still need to create the grub configuration menu entry so you can copy this to your default linux
system's grub menu.   Don't mount the EFI partition, either, as we're not going to touch it when installing archlinux.

https://wiki.archlinux.org/title/GRUB  

From these instructions the only part we need is `# grub-mkconfig -o /boot/grub/grub.cfg`   Copy the main grub menuentry
from this new `/boot/grub/grub.cfg` to the primary linux's `/etc/grub.d/40_custom` and re-run the grub update config command.  
Now you should be able to reboot the system and choose the newly installed archlinux and continue system configuration

<details>
	<summary>Example Alphalinux full install grub menuconfig (edit <code>/etc/grub.d/40_custom</code>)</summary>

```
menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-6792ad20-8fda-493f-ab84-14f8c6146bfc' {
	load_video
	set gfxpayload=keep
	insmod gzio
	insmod part_gpt
	insmod ext2
	set root='hd0,gpt6'
	if [ x$feature_platform_search_hint = xy ]; then
	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt6 --hint-efi=hd0,gpt6 --hint-baremetal=ahci0,gpt6  6792ad20-8fda-493f-ab84-14f8c6146bfc
	else
	  search --no-floppy --fs-uuid --set=root 6792ad20-8fda-493f-ab84-14f8c6146bfc
	fi
	echo	'Loading Linux linux ...'
	linux	/boot/vmlinuz-linux root=UUID=6792ad20-8fda-493f-ab84-14f8c6146bfc rw  loglevel=3 quiet
	echo	'Loading initial ramdisk ...'
	initrd	/boot/initramfs-linux.img
}
```

</details>

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
# Bootstrap an archlinux system from scratch (first install, UEFI, GPT, GRUB)
Followed the archlinux install instructions, including installation of bootloader, using all the recommended settings and locations.   My laptop did not find the bootloader.

I started by comparing the working external USB boot partition to the new non-working GPT one on the SSD.  In the EFI partition, I removed the "EFI" partition label (setting it empty), as this can be a problem on some systems, but it did not help.

Then I found this, which fixed it: https://wiki.archlinux.org/title/GRUB#Default/fallback_boot_path

```
# mv esp/EFI/grub esp/EFI/BOOT
# mv esp/EFI/BOOT/grubx64.efi esp/EFI/BOOT/BOOTX64.EFI
```

 

