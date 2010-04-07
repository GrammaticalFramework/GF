concrete SentencesSpa of Sentences = NumeralSpa ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale
 ] 
  with 
    (Syntax = SyntaxSpa), 
    (Symbolic = SymbolicSpa), 
    (Lexicon = LexiconSpa) ** 
  open SyntaxSpa, ExtraSpa, Prelude in {

    lin 
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkDet i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkDet youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkDet youPol_Pron};

}


