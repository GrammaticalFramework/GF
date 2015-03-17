resource TagFin = open ResFin, Prelude in {

oper
  Tag : Type = Str ;

  mkTag : Str -> Tag = \t -> "+" + t ;

  tagNForm : NForm -> Str = \nf -> case nf of {
    NCase n c => tagNumber n + tagCase c ; 
    NComit => tagNumber Pl + mkTag "Comit" ;
    NInstruct => tagNumber Pl + mkTag "Instr" ; 
    NPossNom n => tagNumber n + tagCase Nom ;
    NPossGen n => tagNumber n + tagCase Gen ;
    NPossTransl n => tagNumber n + tagCase Transl ;
    NPossIllat n => tagNumber n + tagCase Illat ;
    NCompound => mkTag "Comp"
    } ;

  tagCase : Case -> Str = \c -> case c of {
    Nom => mkTag "Nom" ;
    Gen => mkTag "Gen" ;
    Part => mkTag "Part" ;
    Transl => mkTag "Transl" ;
    Ess => mkTag "Ess" ;
    Iness => mkTag "Iness" ;
    Elat => mkTag "Elat" ;
    Illat => mkTag "Illat" ;
    Adess => mkTag "Adess" ;
    Ablat => mkTag "Ablat" ;
    Allat => mkTag "Allat" ;
    Abess => mkTag "Abess" 
    } ;
  tagNumber : Number -> Str = \n -> case n of {
    Sg => mkTag "Sg" ;
    Pl => mkTag "Pl"
    } ;
}