#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION="$1"
BASE_URL="https://github.com/Jonathan1324/lct/releases/download/${VERSION}"
ARCHIVES_DIR="archives"
LOGS_DIR="logs"

mkdir -p "$ARCHIVES_DIR" "$LOGS_DIR"

# Source
curl -L -o "${ARCHIVES_DIR}/${VERSION}.tar.gz" "https://github.com/Jonathan1324/lct/archive/refs/tags/${VERSION}.tar.gz" &> "${LOGS_DIR}/${VERSION}.txt"
echo "Checksum for Source:"
shasum -a 256 "${ARCHIVES_DIR}/${VERSION}.tar.gz"
echo

# Prebuilds
PLATFORMS=("macos" "linux")
ARCHS=("arm64" "x86_64")

for PLATFORM in "${PLATFORMS[@]}"; do
    for ARCH in "${ARCHS[@]}"; do
        FILE="lct-${PLATFORM}-${ARCH}.tar.gz"
        URL="${BASE_URL}/${FILE}"
        LOG_FILE="${LOGS_DIR}/${FILE}.txt"

        curl -L -o "${ARCHIVES_DIR}/${FILE}" "$URL" &> "$LOG_FILE"

        echo "Checksum for ${PLATFORM} ${ARCH}:"
        shasum -a 256 "${ARCHIVES_DIR}/${FILE}"
        echo
    done
done
