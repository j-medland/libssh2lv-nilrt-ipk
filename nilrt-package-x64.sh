#!/usr/bin/env bash
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command failed with exit code $?."' EXIT

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# add toolchain-dir to path
# cmake toolchain will search path for correct compiler,includes etc
PATH=$TOOLCHAIN_PATH/sysroots/x86_64-nilrtsdk-linux/usr/bin/x86_64-nilrt-linux:$PATH

mkdir -p /build/x64/ssh2
cd /build/x64/ssh2
cmake $SCRIPT_DIR/libssh2-nilrt-ipk -DCMAKE_TOOLCHAIN_FILE=$SCRIPT_DIR/x64-toolchain.cmake
cmake --build . --target ipk