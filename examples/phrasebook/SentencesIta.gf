concrete SentencesIta of Sentences = NumeralIta ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale
 ] 
  with 
    (DiffPhrasebook = DiffPhrasebookIta), 
    (Syntax = SyntaxIta), 
    (Symbolic = SymbolicIta), 
    (Lexicon = LexiconIta) ** 
  open SyntaxIta, ExtraIta, Prelude in {

    lin 
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkDet i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkDet youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkDet youPol_Pron};

}


