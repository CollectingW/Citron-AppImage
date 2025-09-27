#!/bin/sh

set -ex
ARCH="$(uname -m)"

# This command installs all the full, official dependencies needed to build AND package Citron.
# The package names for httplib and jwt-cpp have been corrected.
pacman -Syu --noconfirm \
	base-devel          \
	boost               \
	boost-libs          \
t	catch2              \
	cmake               \
	curl                \
	enet                \
	fmt                 \
	ffmpeg              \
	gamemode            \
	gcc                 \
	git                 \
	glslang             \
	glu                 \
	hidapi              \
	httplib             \
	jwt-cpp             \
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
