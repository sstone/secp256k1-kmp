#!/usr/bin/env bash
set -e

CMAKE_DEFAULT_OPTS="-DBUILD_SHARED_LIBS=OFF -DSECP256K1_ENABLE_MODULE_ECDH=ON -DSECP256K1_ENABLE_MODULE_MUSIG=ON -DSECP256K1_ENABLE_MODULE_RECOVERY=ON -DSECP256K1_ENABLE_MODULE_SCHNORRSIG=ON -DSECP256K1_BUILD_BENCHMARK=OFF -DSECP256K1_BUILD_CTIME_TESTS=OFF -DSECP256K1_BUILD_EXHAUSTIVE_TESTS=OFF -DSECP256K1_BUILD_TESTS=OFF"

rm -rf buid_ios build_iosSimulator
cd secp256k1
cmake -B ../build_ios -G Xcode -DCMAKE_INSTALL_PREFIX=../build_ios -DCMAKE_TOOLCHAIN_FILE=../ios.toolchain.cmake -DPLATFORM=OS64COMBINED ${CMAKE_DEFAULT_OPTS}
cmake --build ../build_ios --config Release
cmake --install ../build_ios --config Release
cmake -B ../build_iosSimulator -G Xcode -DCMAKE_INSTALL_PREFIX=../build_iosSimulator -DCMAKE_TOOLCHAIN_FILE=../ios.toolchain.cmake -DPLATFORM=SIMULATOR64COMBINED ${CMAKE_DEFAULT_OPTS}
cmake --build ../build_iosSimulator --config Release
cmake --install ../build_iosSimulator --config Release
cd ..

mkdir -p build/ios
cp -v build_ios/lib/libsecp256k1.a build/ios
mkdir -p build/iosSimulator
cp -v build_iosSimulator/lib/libsecp256k1.a build/iosSimulator
