#!/usr/bin/env bash

# Author: Olivier Mengué <dolmen@cpan.org>

set -o pipefail
set -o errexit

[[ -x /usr/bin/fc-cache ]] || { echo "Linux only :(" >&2 ; exit 1; }

dir="$1"
if [[ -z "$1" ]]; then
	for d in ~/.fonts ~/.local/share/fonts
	do
		if [[ -e "$d" ]]; then
			dir="$d/Go"
			break
		fi
	done
	dir="${dir:-~/.fonts/Go}"
fi

echo "Installing into $dir..."
[[ -d "$dir" ]] || mkdir -p "$dir"
cd "$dir"

curl https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz | tar xvzf -

ls -la "$dir"

fc-cache -fv
