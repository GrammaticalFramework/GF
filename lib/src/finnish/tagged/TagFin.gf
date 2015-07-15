resource TagFin = open ResFin, Prelude in {

oper
  Tag : Type = Str ;

  mkTag : Str -> Tag = \t -> "+" + t ;

  tagNForm : NForm -> Str = \nf -> case nf of {
    NCase n c => tagNumber n + tagCase c ; 
    NComit => tagNumber Pl + mkTag "Com" ;
    NInstruct => tagNumber Pl + mkTag "Ins" ; 
    NPossNom n => tagNumber n + tagCase Nom ;
    NPossGen n => tagNumber n + tagCase Gen ;
    NPossTransl n => tagNumber n + tagCase Transl ;
    NPossIllat n => tagNumber n + tagCase Illat ;
    NCompound => mkTag "Comp"
    } ;

  tagCase : Case -> Str = \c -> case c of {
    Nom => mkTag "Nom" ;
    Gen => mkTag "Gen" ;
    Part => mkTag "Par" ;
    Transl => mkTag "Tra" ;
    Ess => mkTag "Ess" ;
    Iness => mkTag "Ine" ;
    Elat => mkTag "Ela" ;
    Illat => mkTag "Ill" ;
    Adess => mkTag "Ade" ;
    Ablat => mkTag "Abl" ;
    Allat => mkTag "All" ;
    Abess => mkTag "Abe" 
    } ;
  tagNumber : Number -> Str = \n -> case n of {
    Sg => mkTag "Sg" ;
    Pl => mkTag "Pl"
    } ;
}