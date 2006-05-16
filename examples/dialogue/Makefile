lights:
	echo "s ;; pm | wf lights.gfcm" | gf Lights*.gf

agenda:
	echo "s ;; pm | wf agenda.gfcm" | gf Agenda*.gf

engcorpus:
	echo "gt -depth=4 | pt -transform=typecheck | l -all" | gf LightsEng.gf

swecorpus:
	echo "gt -depth=4 | pt -transform=typecheck | l -all" | gf LightsSwe.gf

doc:
	txt2tags -thtml -ogf-dialogue.html README.txt
