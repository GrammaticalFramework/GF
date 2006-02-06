concrete VerbFin of Verb = CatFin ** open Prelude, ResFin in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplV2 v np = insertObj (\\b,_ => appCompl True b v.c2 np) (predV v) ; ----
{-
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ v.c3 ++ np2.s ! Acc) (predV v) ;

    ComplVV v vp = insertObj (\\a => v.c2 ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObj (\\_ => conjThat ++ s.s) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA  v    ap = insertObj (ap.s) (predV v) ;
    ComplV2A v np ap = 
      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ ap.s ! np.a) (predV v) ;
-}

    UseComp comp = 
      insertObj (\\_ => comp.s) (predV (verbOlla ** {sc = NPCase Nom})) ;

    AdvVP vp adv = insertObj (\\_,_ => adv.s) vp ;

----    AdVVP adv vp = insertAdV adv.s vp ;

--    ReflV2 v = insertObj (\\a => v.c2 ++ reflPron ! a) (predV v) ;

--    PassV2 v = insertObj (\\_ => v.s ! VPPart) (predAux auxBe) ;

--    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; isRefl = vv.isRefl} ; -- no "to"

    CompAP ap = {
      s = \\agr => 
          let
            n = agr.n ; 
            c = case agr.n of {
              Sg => Nom ;  -- minä olen iso
              Pl => Part   -- me olemme isoja
              }            --- definiteness of NP ?
          in ap.s ! False ! AN (NCase agr.n c)
      } ;
    CompNP np = {s = \\_ => np.s ! NPCase Nom} ;
    CompAdv a = {s = \\_ => a.s} ;


}
