#!/bin/sh

set -ex
ARCH="$(uname -m)"
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

pacman -Syu --noconfirm \
	base-devel          \
	boost               \
	boost-libs          \
	catch2              \
	cmake               \
	curl                \
	enet                \
	fmt                 \
	gamemode            \
	gcc                 \
	git                 \
	glslang             \
	glu                 \
	hidapi              \
	libdecor            \
	libvpx              \
	libxi               \
	libxkbcommon-x11    \
	libxss              \
	mbedtls2            \
	mesa                \
	nasm                \
	ninja               \
	nlohmann-json       \
	numactl             \
	openal              \
	pulseaudio          \
	pulseaudio-alsa     \
	qt6-base            \
	qt6-networkauth     \
	qt6-multimedia      \
	qt6-tools           \
	qt6-wayland         \
	sdl2                \
	unzip               \
	vulkan-headers      \
	vulkan-mesa-layers  \
	wget                \
	xcb-util-cursor     \
	xcb-util-image      \
	xcb-util-renderutil \
	xcb-util-wm         \
	xorg-server-xvfb    \
	zip                 \
	zsync

echo "Downloading debloated packages script..."
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"

# Retry loop for the package download script
count=0
until [ $count -ge 3 ]
do
    # Removed qt6-base-mini from this line to ensure the full Qt6 package is used
	./get-debloated-pkgs.sh --add-mesa llvm-libs-nano opus-nano && break
	count=$(($count+1))
	echo "Attempt $count failed. Retrying in 10 seconds..."
	sleep 10
done

if [ $count -ge 3 ]; then
	echo "Failed to install debloated packages after 3 attempts."
	exit 1
fi
