rf -file=transliterated/IdiomAmh.gf   | ps -env=quotes -to_amharic | wf -file=IdiomAmh.gf
rf -file=transliterated/LexiconAmh.gf | ps -env=quotes -to_amharic | wf -file=LexiconAmh.gf
rf -file=transliterated/MorphoAmh.gf  | ps -env=quotes -to_amharic | wf -file=MorphoAmh.gf
rf -file=transliterated/NumeralAmh.gf | ps -env=quotes -to_amharic | wf -file=NumeralAmh.gf
rf -file=transliterated/ResAmh.gf     | ps -env=quotes -to_amharic | wf -file=ResAmh.gf
rf -file=transliterated/StructuralAmh.gf | ps -env=quotes -to_amharic | wf -file=StructuralAmh.gf

rf -file=LexiconAmh.gf   | ps -env=quotes -from_amharic | wf -file=LexAmhTran.gf
