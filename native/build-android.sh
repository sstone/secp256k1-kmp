#!/usr/bin/env bash
set -ex

[[ -z "$ANDROID_NDK" ]] && echo "Please set the ANDROID_NDK variable" && exit 1
[[ -z "$ARCH" ]] && echo "Please set the ARCH variable" && exit 1

CMAKE_DEFAULT_OPTS="-DBUILD_SHARED_LIBS=OFF -DSECP256K1_ENABLE_MODULE_ECDH=ON -DSECP256K1_ENABLE_MODULE_MUSIG=ON -DSECP256K1_ENABLE_MODULE_RECOVERY=ON -DSECP256K1_ENABLE_MODULE_SCHNORRSIG=ON -DSECP256K1_BUILD_BENCHMARK=OFF -DSECP256K1_BUILD_CTIME_TESTS=OFF -DSECP256K1_BUILD_EXHAUSTIVE_TESTS=OFF -DSECP256K1_BUILD_TESTS=OFF"

rm -rf build_android_$ARCH
cd secp256k1
cmake -B ../build_android_$ARCH -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK}/build/cmake/android.toolchain.cmake" -DANDROID_ABI=$ARCH -DANDROID_PLATFORM=21 ${CMAKE_DEFAULT_OPTS}
cmake --build ../build_android_$ARCH
cd ..

mkdir -p build/android-$ARCH
cp -v build_android_$ARCH/lib/libsecp256k1.a build/android-$ARCH
