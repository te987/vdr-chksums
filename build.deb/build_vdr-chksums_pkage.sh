#!/bin/sh

# * depends: dpkg,  dpkg-dev
# * packages for building and compiling: build-essential, deb-helper,
#     devscripts, dh-make, etc...

# dpkg --info ./vdr-chksums_*.deb
# dpkg --contents ./vdr-chksums_*.deb
# dpkg --install ./vdr-chksums_*.deb
# dpkg --purge vdr-chksums

# *** assumes vdr-chksums holds latest updated files

# *** assumes build.deb/debian directories exist ***
#     cd ./build.deb/
#     add/change:
#       debian/control,
#       debian/changelog,
#       debian/copyright
#       debian/vdr-chksums.install
#     run:  dpkg-buildpackage -us -uc
#     see debianhandbook.pdf, how to make a debian package

#   ./build_vdr-chksums_pkage.sh

VER=$(../vdr-chksums -V)

dpkg-buildpackage -us -uc

echo "build binary..."
dpkg -b ./debian/vdr-chksums vdr-chksums_"${VER}"_all.deb

echo "organize move..."
mv -v ../vdr-chksums_*.tar.gz .
mv -v ../vdr-chksums_*.dsc .

echo "organize remove..."
rm -v ../vdr-chksums_*.deb
rm -v ../vdr-chksums_*_amd64.*
