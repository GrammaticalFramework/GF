
concrete SentencesRon of Sentences = NumeralRon ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale
 ] 
  with 
    (Syntax = SyntaxRon), 
    (Symbolic = SymbolicRon), 
    (Lexicon = LexiconRon) ** 
  open SyntaxRon, ExtraRon in {

    lin 
      IFemale = 
        {name = mkNP i8fem_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamFemale = 
        {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkQuant youPol_Pron};
      IMale = 
        {name = mkNP i_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamMale = 
        {name = mkNP youSg_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolMale = 
        {name = mkNP youPol_Pron ; isPron = True ; poss = mkQuant youPol_Pron} ;

}


