.PHONY: all clean distclean

all:
	dune build

test:
	dune test

clean:
	dune clean

VENDORS=solo5 ocaml freestanding

vendor:
	mkdir -p vendor
	cd vendor && ../scripts/vendor-solo5.sh
	cd vendor && ../scripts/vendor-ocaml.sh
	cd vendor && ../scripts/vendor-freestanding.sh
	git add vendor
	git commit vendor -m "Updating ${VENDORS}"

distclean: clean
	rm -rf vendor
