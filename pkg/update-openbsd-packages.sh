#!/bin/sh
set -e

pkg_info -m | awk '{ print  }' | grep -v 'firmware' | sed 's/-[0-9].*//' >openbsd-packages.txt
