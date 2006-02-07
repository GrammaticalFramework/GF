--1 Verb Phrases in Finnish

concrete VerbFin of Verb = CatFin ** open Prelude, ResFin in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplV2 v np = insertObj (\\fin,b,_ => appCompl fin b v.c2 np) (predV v) ;

    ComplV3 v np np2 = 
      insertObj 
        (\\fin,b,_ => appCompl fin b v.c2 np ++ appCompl fin b v.c3 np2) (predV v) ;

    ComplVV v vp = 
      insertObj 
        (\\_,b,a => infVP v.sc b a vp) 
        (predV {s = v.s ; 
                sc = case vp.sc of {
                  NPCase Nom => v.sc ;   -- minun täytyy pestä auto
                  c => c                 -- minulla täytyy olla auto
                  }
               }
         ) ;

    ComplVS v s  = insertExtrapos ("että" ++ s.s) (predV v) ;
    ComplVQ v q  = insertExtrapos (          q.s) (predV v) ;

    ComplVA v ap = 
      insertObj 
        (\\_,b,agr => 
           ap.s ! False ! AN (NCase agr.n (npform2case v.c2.c))) --- v.cs.s ignored
        (predV v) ;
    ComplV2A v np ap = 
      insertObj 
        (\\fin,b,_ => appCompl fin b v.c2 np ++ 
                     ap.s ! False ! AN (NCase np.a.n (npform2case v.c2.c))) --agr to obj
        (predV v) ;

    UseComp comp = 
      insertObj (\\_,_ => comp.s) (predV (verbOlla ** {sc = NPCase Nom})) ;

    AdvVP vp adv = insertObj (\\_,_,_ => adv.s) vp ;

    AdVVP adv vp = insertObj (\\_,_,_ => adv.s) vp ;

    ReflV2 v = insertObj (\\fin,b,agr => appCompl fin b v.c2 (reflPron agr)) (predV v) ;

    PassV2 v = let vp = predV v in {
      s = \\_ => vp.s ! VIPass ;
      s2 = \\_,_,_ => [] ;
      ext = [] ;
      sc = v.c2.c  -- minut valitaan ; minua rakastetaan ; minulle kuiskataan 
      } ;          ---- talon valitaan: should be marked like inf.

    UseVS, UseVQ = \v -> v ** {c2 = {s = [] ; c = NPAcc ; isPre = True}} ;

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


--2 The object case
--
-- The rules involved are ComplV2 and ComplVV above.
-- The work is done jointly in ResFin.infVP and appCompl. 
-- Cases to test: l -table (to see negated forms)
--```
--   minun täytyy ostaa auto
--   PredVP (UsePron i_Pron) (ComplVV must_VV 
--     (ComplV2 buy_V2 (DetCN (DetSg (SgQuant DefArt) NoOrd) (UseN car_N))))
--   minä tahdon ostaa auton
--   PredVP (UsePron i_Pron) (ComplVV want_VV 
--     (ComplV2 buy_V2 (DetCN (DetSg (SgQuant DefArt) NoOrd) (UseN car_N))))
--   minulla täytyy olla auto
--   PredVP (UsePron i_Pron) (ComplVV must_VV 
--     (ComplV2 have_V2 (DetCN (DetSg (SgQuant DefArt) NoOrd) (UseN car_N))))
--```
-- Unfortunately, there is no nice way to say "I want to have a car".
-- (Other than the paraphrases "I want a car" or "I want to own a car".)
