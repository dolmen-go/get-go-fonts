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

function ttf_version
{
	[[ -e "$1" ]] || return 1
	fc-query -f '%{fontversion}\n' "$1" | perl -E 'printf "%.3f", <>/65536.0'
}

if [[ -f "Go-Mono.ttf" ]]; then
	old_version=$(ttf_version Go-Mono.ttf)
fi

curl https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz | tar xvzf -

ls -la "$dir"

fc-cache -fv

new_version=$(ttf_version Go-Mono.ttf)
if [[ -z "$old_version" ]]; then
	echo "Go Fonts $new_version installed."
elif [[ "$new_version" != "$old_version" ]]; then
	echo "Go Fonts upgrade: $old_version -> $new_version"
fi
