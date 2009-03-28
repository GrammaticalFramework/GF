.PHONY: abstract synopsis

all: synopsis abstract

index:
	txt2tags -thtml index.txt
synopsis:
	runghc MkSynopsis.hs

categories-imagemap.html: categories.dot
	dot -Tcmapx $^ > $@

abstract:
	gfdoc -txthtml ../src/abstract/*.gf
	mv ../src/abstract/*.html abstract

