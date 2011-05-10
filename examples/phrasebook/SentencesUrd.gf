concrete SentencesUrd of Sentences =  NumeralUrd ** SentencesI - [sing,YouFamFemale] with 
  (Syntax = SyntaxUrd),
  (Symbolic = SymbolicUrd),
  (Lexicon = LexiconUrd)  **
  open
  (S=SyntaxUrd),
  (P=ParadigmsUrd) in {
lin YouFamFemale = mkPersonUrd youSg_Pron "تیری" ;
  
oper   
  mkPersonUrd : Pron -> Str -> {name : NP ; isPron : Bool ; poss : Quant} = \p,s -> 
    {name = mkNP (P.mkN s) ; isPron = True ; poss = mkQuant p} ;
  } ;
