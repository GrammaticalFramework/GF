interface DiffRomance = open ResRomance, Prelude in {

--2 Parameters.

-- Prepositions that fuse with the article vary.

param

  Prep ;

  Case = Nom | Acc | CPrep Prep ; 

  NPForm = Ton Case | Aton Case | Poss {g : Gender ; n : Number} ; --- AAgr

  RelForm = RSimple Case | RComplex Gender Number Case ;

  VAux ;

oper

  Compl : Type = {s : Str ; c : Case} ;

  dative : Case ;
  genitive : Case ;

  prepCase : Case -> Str ;

  npform2case : NPForm -> Case = \p -> case p of {
    Ton  x => x ;
    Aton x => x ;
    Poss _ => genitive
    } ;

  case2npform : Case -> NPForm = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    _   => Ton c
    } ;

  npRelForm : NPForm -> RelForm = \np -> case np of {
    Ton  c => RSimple c ;
    Aton c => RSimple c ;
    Poss _ => RSimple genitive
    } ;

  appCompl : Compl -> (NPForm => Str) -> Str = \comp,np ->
    comp.s ++ np ! Ton comp.c ;

  artDef   : Gender -> Number -> Case -> Str ;
  artIndef : Gender -> Number -> Case -> Str ;

  partitive : Gender -> Case -> Str ;

}

