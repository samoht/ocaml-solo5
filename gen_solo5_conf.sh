#!/bin/sh

checkopt() {
  if test -x ocaml/"$1".opt; then
    printf '.opt'
  else
    printf '.byte'
  fi
}

# [path(solo5)] names where the compiler and the libraries of a Solo5
# unikernel are found, and it holds the cross sysroot alone. A library the host
# compiler built is compiled against the host standard library: its [.cmx]
# files name symbols of the host's [Stdlib] units, which this compiler's
# standard library does not define once the two compilers are configured
# differently (flambda, link-time optimisation, patches), and its [.a] archives
# hold host objects. Such a library cannot link into a unikernel, so a package
# missing from the sysroot reads "not found" instead of resolving to the host
# switch's copy. [destdir(solo5)] is the same directory, so that a library
# installed for this toolchain is found by it.

cat << EOF
path(solo5) = "$SYSROOT/lib/ocaml:$SYSROOT/lib"
destdir(solo5) = "$SYSROOT/lib"
stdlib(solo5) = "$SYSROOT/lib/ocaml"
ocamlopt(solo5) = "$SYSROOT/bin/ocamlopt$(checkopt ocamlopt)"
ocamlc(solo5) = "$SYSROOT/bin/ocamlc$(checkopt ocamlc)"
ocamlmklib(solo5) = "$SYSROOT/bin/ocamlmklib"
ocamldep(solo5) = "$SYSROOT/bin/ocamldep$(checkopt tools/ocamldep)"
ocamlcp(solo5) = "$SYSROOT/bin/ocamlcp"
EOF
