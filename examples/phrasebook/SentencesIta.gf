concrete SentencesIta of Sentences = NumeralIta ** SentencesI - [
  IsMass,
  IFemale, YouFamFemale, YouPolFemale, IMale, YouFamMale, YouPolMale,
  WeMale, WeFemale, YouPlurFamMale, YouPlurFamFemale, YouPlurPolFemale, YouPlurPolMale, TheyMale, TheyFemale, 
  mkPerson, Superlative, SHaveNoMass
 ] 
  with 
    (Syntax = SyntaxIta), 
    (Symbolic = SymbolicIta), 
    (Lexicon = LexiconIta) ** 
  open SyntaxIta, ExtraIta, Prelude in {

    lincat
     Place = NPPlace ; -- {name : NP ; at : Adv ; to : Adv ; } ;
     Superlative = {s : A ; isPre : Bool} ;
 
    lin 
      IsMass m q = mkCl (mkNP the_Det m) q ; -- le vin allemand est bon

      IFemale = 
        {name = mkNP (ProDrop i8fem_Pron) ; isPron = True ; poss = PossFamQuant i_Pron} ; 
      IMale = 
        {name = mkNP (ProDrop i_Pron) ; isPron = True ; poss = PossFamQuant i_Pron} ; 
      YouFamMale = 
        {name = mkNP (ProDrop youSg_Pron) ; isPron = True ; poss = PossFamQuant youSg_Pron} ; 
      YouFamFemale = 
        {name = mkNP (ProDrop youSg8fem_Pron) ; isPron = True ; poss = PossFamQuant youSg_Pron} ; 
      YouPolMale = 
        {name = mkNP (ProDrop youPol_Pron) ; isPron = True ; poss = PossFamQuant youPol_Pron} ;
      YouPolFemale = 
        {name = mkNP (ProDrop youPol8fem_Pron) ; isPron = True ; poss = PossFamQuant youPol_Pron};
      He = 
        {name = mkNP (ProDrop he_Pron) ; isPron = True ; poss = PossFamQuant he_Pron} ; 
      She = 
        {name = mkNP (ProDrop she_Pron) ; isPron = True ; poss = PossFamQuant she_Pron} ; 
      WeMale = 
        {name = mkNP (ProDrop we_Pron) ; isPron = True ; poss = PossFamQuant we_Pron} ; 
      WeFemale = 
        {name = mkNP (ProDrop we8fem_Pron) ; isPron = True ; poss = PossFamQuant we_Pron} ; 
      YouPlurFamMale = 
        {name = mkNP (ProDrop youPl_Pron) ; isPron = True ; poss = PossFamQuant youPl_Pron} ; 
      YouPlurFamFemale = 
        {name = mkNP (ProDrop youPl8fem_Pron) ; isPron = True ; poss = PossFamQuant youPl_Pron} ; 
      YouPlurPolMale = 
        {name = mkNP (ProDrop youPolPl_Pron) ; isPron = True ; poss = PossFamQuant youPolPl_Pron} ;
      YouPlurPolFemale = 
        {name = mkNP (ProDrop youPolPl8fem_Pron) ; isPron = True ; poss = PossFamQuant youPolPl_Pron};
      TheyMale = 
        {name = mkNP (ProDrop they_Pron) ; isPron = True ; poss = PossFamQuant they_Pron} ; 
      TheyFemale = 
        {name = mkNP (ProDrop they8fem_Pron) ; isPron = True ; poss = PossFamQuant they_Pron} ; 

      SHaveNoMass p k =  mkS negativePol (mkCl p.name (ComplCN have_V2 k)) ;

    oper

  CNPlace : Type = {name : CN ; at : Prep ; to : Prep }  ;

  mkCNPlace : CN -> Prep -> Prep -> CNPlace = \p,i,t -> {
    name = p ;
    at = i ;
    to = t ;
    } ;

  placeNP : Det -> CNPlace -> NPPlace = \det,kind ->
    let name : NP = mkNP det kind.name in {
      name = name ;
      at = mkAdv kind.at name ;
      to = mkAdv kind.to name
    } ;

  mkPerson : Pron -> {name : NP ; isPron : Bool ; poss : Quant} = \p -> 
    {name = mkNP p ; isPron = True ; poss = PossFamQuant p} ;


}


