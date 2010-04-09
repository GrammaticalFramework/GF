concrete SentencesIta of Sentences = NumeralIta ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale
 ] 
  with 
    (Syntax = SyntaxIta), 
    (Symbolic = SymbolicIta), 
    (Lexicon = LexiconIta) ** 
  open SyntaxIta, ExtraIta, Prelude in {

    lin 
      IFemale = 
        {name = mkNP (ProDrop i8fem_Pron) ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamFemale = 
        {name = mkNP (ProDrop youSg8fem_Pron) ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolFemale = 
        {name = mkNP (ProDrop youPol8fem_Pron) ; isPron = True ; poss = mkQuant youPol_Pron};
      IMale = 
        {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = mkQuant i_Pron} ; 
      YouFamMale = 
        {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = mkQuant youSg_Pron} ; 
      YouPolMale = 
        {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = mkQuant youPol_Pron} ;

}


