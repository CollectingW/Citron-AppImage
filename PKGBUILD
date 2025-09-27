# Maintainer: Collecting <collecting@citron-emu.org>

# The '-git' suffix signifies this is a bleeding-edge build from the git repo
pkgname=citron-git
pkgver=0.1.r0.g1a2b3c4 # This will be replaced by the pkgver() function
pkgrel=1
pkgdesc="A Nintendo Switch emulator"
arch=('x86_64' 'aarch64')
url="https://citron-emu.org/"
license=('GPL2')

# Dependencies needed to run the emulator
depends=(
    'boost-libs' 'enet' 'fmt' 'ffmpeg' 'gamemode' 'glslang' 'hicolor-icon-theme'
    'libdecor' 'libxkbcommon-x11' 'mbedtls2' 'nlohmann-json' 'qt6-base'
    'qt6-multimedia' 'sdl2' 'vulkan-icd-loader'
)

# Dependencies needed only to build the emulator from source
makedepends=(
    'boost' 'catch2' 'cmake' 'git' 'ninja' 'nasm' 'qt6-tools' 'vulkan-headers'
)

# This points to the source code repository
source=("git+https://git.citron-emu.org/citron/emulator.git")
sha256sums=('SKIP')

# This function automatically generates a version string based on the latest git commit
pkgver() {
  cd "$pkgname"
  git describe --long --tags | sed 's/\([^-]*-g\)/r\1/;s/-/./g'
}

# This function runs before the build and is used to apply patches
prepare() {
  cd "$pkgname"
  # Apply compatibility patches for newer Boost versions
  find . -type f \( -name '*.cpp' -o -name '*.h' \) | xargs sed -i 's/\bboost::asio::io_service\b/boost::asio::io_context/g'
  find . -type f \( -name '*.cpp' -o -name '*.h' \) | xargs sed -i 's/\bboost::asio::io_service::strand\b/boost::asio::strand<boost::asio::io_context::executor_type>/g'
  find . -type f \( -name '*.cpp' -o -name '*.h' \) | xargs sed -i 's|#include *<boost/process/async_pipe.hpp>|#include <boost/process/v1/async_pipe.hpp>|g'
  find . -type f \( -name '*.cpp' -o -name '*.h' \) | xargs sed -i 's/\bboost::process::async_pipe\b/boost::process::v1::async_pipe/g'
}

# This function contains the build commands
build() {
  cd "$pkgname"
  # makepkg sets CFLAGS and CXXFLAGS, so we don't need to specify arch flags
  cmake -B build -S . -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCITRON_USE_BUNDLED_VCPKG=OFF \
    -DCITRON_USE_BUNDLED_QT=OFF \
    -DUSE_SYSTEM_QT=ON \
    -DCITRON_USE_BUNDLED_FFMPEG=OFF \
    -DCITRON_USE_BUNDLED_SDL2=OFF \
    -DCITRON_TESTS=OFF \
    -DCITRON_CHECK_SUBMODULES=OFF \
    -DCITRON_ENABLE_LTO=ON \
    -DCITRON_USE_QT_MULTIMEDIA=ON \
    -DENABLE_QT_TRANSLATION=ON
  
  ninja -C build
}

# This function installs the built files into a temporary directory
package() {
  cd "$pkgname"
  DESTDIR="$pkgdir/" ninja -C build install
}
