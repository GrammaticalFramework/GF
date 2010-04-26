
concrete SentencesRon of Sentences = NumeralRon ** SentencesI - [
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  ThePlace
] 
  with 
    (Syntax = SyntaxRon), 
    (Symbolic = SymbolicRon), 
    (Lexicon = LexiconRon) ** 
  open SyntaxRon, ExtraRon in {


lin 
 IFemale = {name = mkNP i8fem_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
 YouFamFemale = {name = mkNP youSg8fem_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
 YouPolFemale = {name = mkNP youPol8fem_Pron ; isPron = True ; poss = mkQuant youPol_Pron};
 IMale = {name = mkNP i_Pron ; isPron = True ; poss = mkQuant i_Pron} ; 
 YouFamMale = {name = mkNP youSg_Pron ; isPron = True ; poss = mkQuant youSg_Pron} ; 
 YouPolMale = {name = mkNP youPol_Pron ; isPron = True ; poss = mkQuant youPol_Pron} ;
 ThePlace kind = let name : NP = mkNP the_Quant kind.name in {
         name = name ;
         at = if_then_else Adv kind.at.needIndef (mkAdv kind.at name) (mkAdv kind.at (mkNP kind.name));
         to = if_then_else Adv kind.at.needIndef (mkAdv kind.to name) (mkAdv kind.at (mkNP kind.name))
       } ;

}


