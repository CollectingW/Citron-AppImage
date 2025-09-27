#!/bin/sh

set -ex
ARCH="$(uname -m)"

# This command installs all the full, official dependencies needed to build AND package Citron.
pacman -Syu --noconfirm \
	base-devel          \
	boost               \
	boost-libs          \
	catch2              \
	cmake               \
	cpp-httplib         \
	cpp-jwt             \
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
