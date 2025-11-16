sudo pacman -S devtools
mkdir ~/chroot
CHROOT=~/chroot
mkarchroot $CHROOT/root base-devel
arch-nspawn $CHROOT/root pacman -Syu
cd dir-with-PKGBUILD
makechrootpkg -c -r $CHROOT
