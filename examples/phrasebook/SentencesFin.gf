concrete SentencesFin of Sentences = NumeralFin ** SentencesI - [Is] with 
  (Syntax = SyntaxFin),
  (Symbolic = SymbolicFin),
  (Lexicon = LexiconFin) ** open SyntaxFin, ExtraFin, (V = VerbFin) in {

  lin Is item prop = mkCl item (V.UseComp (CompPartAP prop)) ; -- pizza on herkullista

  } ;
