#LEX=Duodecim
#LEX=Aino
#LEX=Omat
#LEX=NSSK
LEX=Swadesh

all: tests

gf-files:
	runghc MkLex.hs 0 $(LEX) > $(LEX)Abs.gf
	runghc MkLex.hs 1 $(LEX) > $(LEX)1.gf
	runghc MkLex.hs 2 $(LEX) > $(LEX)2.gf
	runghc MkLex.hs 3 $(LEX) > $(LEX)3.gf
	runghc MkLex.hs 4 $(LEX) > $(LEX)4.gf

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
