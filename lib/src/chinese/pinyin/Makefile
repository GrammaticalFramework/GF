all: cmn pinyin

pinyin:
	runghc MkPinyin.hs

cmn:
	cd .. ; runghc ../Clone.hs Chi Cmn ; mv *Cmn.gf pinyin/ ; cd pinyin

