LEX=Omat
CAT=N

all: nouns

verbs: 
	export CAT=V ; export LEX=VNSSK ; make -e tests
	export CAT=V ; export LEX=VOmat ; make -e tests
	export CAT=V ; export LEX=VSwadesh ; make -e tests
	export CAT=V ; export LEX=VDictionary ; make -e tests
	cat all-diff-V* >all-differences-V
	cat all-differences-V

nouns: 
	export LEX=NSSK ; make -e tests
	export LEX=Omat ; make -e tests
	export LEX=Swadesh ; make -e tests
	export LEX=Dictionary ; make -e tests
	export LEX=Duodecim ; make -e tests
	export LEX=Aino ; make -e tests
	cat all-diff-* >all-differences
	cat all-differences

gf-files:
	runghc MkLex.hs 0 $(CAT) $(LEX) > $(LEX)Abs.gf
	runghc MkLex.hs 1 $(CAT) $(LEX) > $(LEX)1.gf
	runghc MkLex.hs 2 $(CAT) $(LEX) > $(LEX)2.gf
	runghc MkLex.hs 3 $(CAT) $(LEX) > $(LEX)3.gf
	runghc MkLex.hs 4 $(CAT) $(LEX) > $(LEX)4.gf

experiments: gf-files
	echo "gt -cat=Utt | l | wf exper1-$(LEX).txt" | gf -s $(LEX)1.gf
	echo "gt -cat=Utt | l | wf exper2-$(LEX).txt" | gf -s $(LEX)2.gf
	echo "gt -cat=Utt | l | wf exper3-$(LEX).txt" | gf -s $(LEX)3.gf
	echo "gt -cat=Utt | l | wf exper4-$(LEX).txt" | gf -s $(LEX)4.gf

tests: experiments
	runghc MyDiff.hs correct-$(LEX).txt  exper1-$(LEX).txt >diff1-$(LEX).txt
	runghc MyDiff.hs correct-$(LEX).txt  exper2-$(LEX).txt >diff2-$(LEX).txt
	runghc MyDiff.hs correct-$(LEX).txt  exper3-$(LEX).txt >diff3-$(LEX).txt
	runghc MyDiff.hs correct-$(LEX).txt  exper4-$(LEX).txt >diff4-$(LEX).txt
	date >all-diff-$(LEX)
	echo $(LEX) >>all-diff-$(LEX)
	wc -l diff?-$(LEX).txt >>all-diff-$(LEX)
