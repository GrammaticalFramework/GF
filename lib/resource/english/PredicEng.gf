--# -path=.:../abstract:../../prelude
--# -opt

concrete PredicEng of Predic = CategoriesEng ** 
  open Prelude, SyntaxEng, DeptypEng in {

  flags optimize=all ;

  lincat
    VType, CType = SS ;
    Verb  = {s : VForm => Str ; isAux : Bool ; s1 : Particle ; c : VComp} ;
    Compl = {s1, s2 : Agr => Str} ; 

  lin

    CtN, CtV, CtS, CtQ, CtA = ss [] ;
    Vt, VtN = \x -> x ;
    Vt_ = ss [] ;

    ComplNil    = {s1, s2 = \\_ => []} ;
    ComplNP  np = {s1 = \\_ => np.s ! AccP   ; s2 = \\_ => []} ;
    ComplA   ap = {s1 = ap.s                 ; s2 = \\_ => []} ;
    ComplQ   q  = {s1 = \\_ => q.s ! DirQ    ; s2 = \\_ => []} ;
    ComplS   s  = {s1 = \\_ => "that" ++ s.s ; s2 = \\_ => []} ;

    ComplAdd c np co = {s1 = \\_ => c.s ++ np.s ! AccP ; s2 = co.s1} ;


    SPredVerb vt np verb compl = 
      predVerbClause np verb 
        (\\a => vt.s ++
                cprep1 verb.c (compl.s1 ! a) ++
                cprep2 verb.c (compl.s2 ! a)
        ) ; 
    QPredVerb vt np verb compl = 
      intVerbClause np verb 
        (\\a => vt.s ++
                cprep1 verb.c (compl.s1 ! a) ++
                cprep2 verb.c (compl.s2 ! a)
        ) ; 
{- takes 80% !
    RPredVerb vt np verb compl = 
      relVerbClause np verb 
        (\\a => vt.s ++
                cprep1 verb.c (compl.s1 ! a) ++
                cprep2 verb.c (compl.s2 ! a)
        ) ; 
-}
    IPredVerb vt verb compl = 
      predVerbI verb 
        (\\a => vt.s ++
                cprep1 verb.c (compl.s1 ! a) ++
                cprep2 verb.c (compl.s2 ! a)
        ) ; 

    VeV1 v = v ** {isAux = False ; c = CVt_} ;
    VeV2 v = v ** {isAux = False ; c = CVt (CCtN CP_)} ; ---- other preps

{-
    Walk = {s = "walks" ; c = VC_} ;
    Love = {s = "loves" ; c = VC1 C_} ;
    Know = {s = "knows" ; c = VC_} ;
    Give = {s = "gives" ; c = VC2 C_ C_to} ;
    Tell = {s = "tells" ; c = VC_} ;
    Ask  = {s = "asks"  ; c = VC_} ;
-}

}
