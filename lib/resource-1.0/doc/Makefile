all: index synopsis

index:
	txt2tags -thtml index.txt
synopsis:
	runghc MkSynopsis.hs

categories-imagemap.html: categories.dot
	dot -Tcmapx $^ > $@

clt:
	txt2tags clt2006.txt
	htmls clt2006.html
gslt:
	txt2tags gslt-sem-2006.txt
	htmls gslt-sem-2006.html

