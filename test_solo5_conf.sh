#!/bin/sh
# The solo5 findlib toolchain reads libraries from the cross sysroot alone: a
# package the host compiler built carries the host stdlib's symbols and does not
# link with this compiler, so one missing from the sysroot must read "not
# found" rather than resolve to the host switch's copy.

set -eu
conf=$(PREFIX=/switch SYSROOT=/switch/lib/sysroot ./gen_solo5_conf.sh)
expect() {
  printf '%s\n' "$conf" | grep -qxF "$1" || {
    printf 'missing: %s\ngot:\n%s\n' "$1" "$conf" >&2
    exit 1
  }
}
expect 'path(solo5) = "/switch/lib/sysroot/lib/ocaml:/switch/lib/sysroot/lib"'
expect 'destdir(solo5) = "/switch/lib/sysroot/lib"'
