#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f Makefile || ! -f app/Makefile || ! -f plugin/Makefile ]]; then
    echo 'Mount the Cirrus repository at /src.' >&2
    exit 1
fi

if [[ ! -f patches/ssl/src/main.s ]]; then
    echo 'SSL submodule missing. Run: git submodule update --init --recursive' >&2
    exit 1
fi

missing=0
for module in act friends http miiverse socket ssl; do
    if [[ ! -s "patches/$module/code.bin" ]]; then
        echo "Missing decompressed patches/$module/code.bin (see DECOMPRESSING.md)." >&2
        missing=1
    fi
done
if (( missing )); then exit 1; fi

make clean
exec make "$@"
