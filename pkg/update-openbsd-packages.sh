#!/bin/sh
set -e

pkg_info -m | awk '{ print  }' | grep -v 'firmware' | cut -d '-' -f 1 >openbsd-packages.txt
