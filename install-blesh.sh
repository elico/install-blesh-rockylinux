#!/usr/bin/env bash

VERSION="0.3.4"

URL="https://github.com/akinomyoga/ble.sh/releases/download/v${VERSION}/ble-${VERSION}.tar.xz"
INSTDIR="/usr/local/share/blesh"

wget "${URL}" -O "ble-${VERSION}.tar.xz"

mkdir -p "${INSTDIR}"

tar xJf "ble-${VERSION}.tar.xz" -C "/usr/local/share/"

rsync -av "/usr/local/share/ble-${VERSION}/" "${INSTDIR}/"

echo '[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --attach=none' > bashrc_head
echo '[[ ${BLE_VERSION-} ]] && ble-attach' > bashrc_tail

grep '\[\[ ${BLE_VERSION-} \]\] && ble-attach' ~/.bashrc >/dev/null 2>&1
RES="$?"

if [ "${RES}" -gt "0" ];then 
	stat ~/.bashrc && \
		cp -vi ~/.bashrc ~/.bashrc.backup && \
		cat bashrc_head ~/.bashrc bashrc_tail > ~/.bashrc.in && \
		mv -vf ~/.bashrc.in ~/.bashrc 
fi

echo "Cleaning up..."
rm -rvf "/usr/local/share/ble-${VERSION}/"
rm -vf bashrc_head
rm -vf bashrc_tail
rm -vf "ble-${VERSION}.tar.xz"

