concrete SentencesFre of Sentences = NumeralFre ** SentencesI - [
  QProp,
  IFemale, YouFamFemale, YouPolFemale
 ] 
  with 
    (Syntax = SyntaxFre), 
    (Symbolic = SymbolicFre), 
    (Lexicon = LexiconFre) ** 
  open SyntaxFre, ExtraFre, Prelude in {

    lin 
      QProp a = 
        lin QS {s = \\_ => (EstcequeS (mkS a)).s} ;
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkDet i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkDet youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkDet youPol_Pron};

}
