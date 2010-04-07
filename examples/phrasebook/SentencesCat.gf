concrete SentencesCat of Sentences = NumeralCat ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale
 ] 
  with 
    (Syntax = SyntaxCat), 
    (Symbolic = SymbolicCat), 
    (Lexicon = LexiconCat) ** 
  open SyntaxCat, ExtraCat, Prelude in {

    lin 
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkDet i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkDet youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkDet youPol_Pron};

}


