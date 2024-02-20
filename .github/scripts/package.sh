#!/usr/bin/env bash

if [[ "$GITHUB_REF" =~ ^refs/tags/snitch-v.*$ ]]; then
    readonly pkgver="$(echo $GITHUB_REF | sed -n 's/^refs\/tags\/snitch-v//p')"
else
    echo "Github reference does not match Snitch version tag pattern"
    exit 1
fi

tar -czf "snitch-spike-dasm-$pkgver-x86_64-linux-gnu-$1.tar.gz" \
    -C ./build --owner=0 --group=0 spike-dasm