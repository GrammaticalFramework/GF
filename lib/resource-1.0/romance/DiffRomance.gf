interface DiffRomance = open CommonRomance, Prelude in {


--2 Constants whose definitions depend on language.

-- Prepositions that fuse with the article vary.

param

  Prep ;
  VType ;

oper

  dative    : Case ;
  genitive  : Case ;

  prepCase  : Case -> Str ;

  partitive : Gender -> Case -> Str ;

  reflPron  : Number -> Person -> Str ;

  artDef    : Gender -> Number -> Case -> Str ;
  artIndef  : Gender -> Number -> Case -> Str ;

  auxVerb   : VType -> (VF => Str) ;
  negation  : Polarity => (Str * Str) ;
  copula    : Verb ;

  partAgr   : VType -> VPAgr ;

-- These needed above.

param
  Case = Nom | Acc | CPrep Prep ; 

oper
  Verb = {s : VF => Str ; vtyp : VType} ;

}

{-

--2 Constants uniformly defined in terms of language-dependent constants

param

  Case = Nom | Acc | CPrep Prep ; 

  NPForm = Ton Case | Aton Case | Poss {g : Gender ; n : Number} ; --- AAgr

  RelForm = RSimple Case | RComplex Gender Number Case ;


oper

  Compl : Type = {s : Str ; c : Case} ;

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


   Verb = {s : VF => Str ; aux : VAux ; isRefl : Bool} ;
{-
   predV : Verb -> VP = \verb -> 
    let
      diath = case verb.vtype of {
        VPass => Pass ;
        _ => Act
        } ;
      vfin : Tense -> Str = \t -> verb.s ! vFin t diath ;
      vsup = verb.s ! VI (VSupin diath) ;  
      vinf = verb.s ! VI (VInfin diath) ;

      har : Tense -> Str = \t -> verbHave.s ! vFin t Act ;
      ha  : Str = verbHave.s ! VI (VInfin Act) ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf
        } ;

    in {
    s = table {
      VPFinite t Simul => case t of {
        Pres | Past => vf (vfin t) [] ;
        Fut  => vf auxFut vinf ;
        Cond => vf auxCond vinf
        } ;
      VPFinite t Anter => case t of {
        Pres | Past => vf (har t) vsup ;
        Fut  => vf auxFut (ha ++ vsup) ;
        Cond => vf auxCond (ha ++ vsup) 
        } ;
      VPImperat => vf (verb.s ! VF (VImper diath)) [] ;
      VPInfinit Simul => vf [] vinf ;
      VPInfinit Anter => vf [] (ha ++ vsup)
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr  => Str = \\a => case verb.vtype of {
      VRefl => reflPron a ;
      _ => []
      } ;
    a2  : Str = [] ;
    ext : Str = [] ;
    en2,ea2,eext : Bool = False   -- indicate if the field exists
    } ;
-}


