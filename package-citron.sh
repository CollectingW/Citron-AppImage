#!/bin/sh
set -ex
ARCH="${ARCH:-$(uname -m)}"
if [ "$1" = 'v3' ] && [ "$ARCH" = 'x86_64' ]; then
	ARCH="${ARCH}_v3"
fi
VERSION="$(cat ~/version)"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
export OUTNAME=Citron-"$VERSION"-anylinux-"$ARCH".AppImage
export DESKTOP=/usr/share/applications/org.citron_emu.citron.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/org.citron_emu.citron.svg
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1

wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun

./quick-sharun /usr/bin/citron* /usr/lib/libgamemode.so* /usr/lib/libpulse.so*

echo "Copying Qt resource and translation files..."
# Create the target directory
mkdir -p ./AppDir/usr/share/qt6

# Copy resources from their correct location
cp -rv /usr/lib/qt6/resources ./AppDir/usr/share/qt6

# Copy translations from their correct location
cp -rv /usr/share/qt6/translations ./AppDir/usr/share/qt6

if [ "$DEVEL" = 'true' ]; then
	sed -i 's|Name=citron|Name=citron nightly|' ./AppDir/*.desktop
fi
if [ "$ARCH" = 'aarch64' ]; then
	echo 'SHARUN_ALLOW_SYS_VKICD=1' > ./AppDir/.env
fi

wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage

mkdir -p ./dist
mv -v ./*.AppImage* ./dist
mv -v ~/version ./dist
