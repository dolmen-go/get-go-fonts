#!/usr/bin/env bash

# Author: Olivier Mengué <dolmen@cpan.org>

set -o pipefail
set -o errexit

[[ -x /usr/bin/fc-cache ]] || { echo "Linux only :(" >&2 ; exit 1; }

dir=~/.fonts/Go
[[ -d "$dir" ]] || mkdir -p "$dir"
cd "$dir"

curl https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz | tar xvzf -

ls -la "$dir"

fc-cache -fv
