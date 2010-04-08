concrete SentencesFin of Sentences = NumeralFin ** SentencesI - [Is,NameNN] with 
  (Syntax = SyntaxFin),
  (Symbolic = SymbolicFin),
  (Lexicon = LexiconFin) ** open SyntaxFin, ExtraFin, (P = ParadigmsFin), (V = VerbFin) in {

  lin 
    Is item prop = mkCl item (V.UseComp (CompPartAP prop)) ; -- pizza on herkullista
    NameNN = mkNP (P.mkPN (P.mkN "NN" "NN:iä")) ;
  } ;
