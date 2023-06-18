#!/usr/bin/env bash
set -e

cp xconfigure.sh secp256k1-zkp

cd secp256k1-zkp

./autogen.sh
sh xconfigure.sh --enable-experimental --enable-module_ecdh --enable-module-recovery --enable-module-schnorrsig --enable-module-musig --enable-benchmark=no --enable-shared=no --enable-exhaustive-tests=no --enable-tests=no

mkdir -p ../build/ios
cp -v _build/universal/* ../build/ios/

rm -rf _build
make clean
