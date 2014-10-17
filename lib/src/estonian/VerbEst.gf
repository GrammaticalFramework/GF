--1 Verb Phrases in Estonian

concrete VerbEst of Verb = CatEst ** open Prelude, ResEst in {

  flags optimize=all_subs ; coding=utf8;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {c2 = v.c2} ;

    Slash2V3 v np = 
      insertObj 
        (\\fin,b,_ => appCompl fin b v.c2 np) (predV v) ** {c2 = v.c3} ;
    Slash3V3 v np = 
      insertObj 
        (\\fin,b,_ => appCompl fin b v.c3 np) (predV v) ** {c2 = v.c2} ;

    ComplVV v vp = 
      insertObj 
        (\\_,b,a => infVP v.sc b a vp v.vi) 
        (predV {s = v.s ; 
                p = v.p ;
                sc = case vp.sc of {
                  NPCase Nom => v.sc ; -- minul tuleb kirjutada (VV 'tulema' determines the subject case)
                  c => c               -- minul peab auto olema (VP 'olema' determines the subject case)
                  }
               }
         ) ;

    ComplVS v s  = insertExtrapos (etta_Conj ++ s.s) (predV v) ;
    ComplVQ v q  = insertExtrapos (          q.s) (predV v) ;
    ComplVA v ap = 
      insertObj 
        (\\_,b,agr => 
           let n = (complNumAgr agr) in
           ap.s ! False ! (NCase n (npform2case n v.c2.c))) --- v.cs.s ignored
        (predV v) ;

    SlashV2S v s = 
      insertExtrapos (etta_Conj ++ s.s) (predV v) ** {c2 = v.c2} ;
    SlashV2Q v q = 
      insertExtrapos (q.s) (predV v) ** {c2 = v.c2} ;
    SlashV2V v vp = 
      insertObj (\\_,b,a => infVP v.sc b a vp v.vi) (predV v) ** {c2 = v.c2} ;
      ---- different infinitives
    SlashV2A v ap = 
      insertObj 
        (\\fin,b,_ => 
          ap.s ! False ! (NCase Sg (npform2case Sg v.c3.c))) ----agr to obj
        (predV v) ** {c2 = v.c2} ;

    ComplSlash vp np = insertObjPre (\\fin,b,_ => appCompl fin b vp.c2 np) vp ;

    UseComp comp = 
      insertObj (\\_,_ => comp.s) (predV (verbOlema ** {sc = NPCase Nom})) ;

    SlashVV v vp = 
      insertObj 
        (\\_,b,a => infVP v.sc b a vp v.vi) 
        (predV {s = v.s ; 
                p = v.p ;
                sc = case vp.sc of {
                  NPCase Nom => v.sc ;   -- minun täytyy pestä auto
                  c => c                 -- minulla täytyy olla auto
                  } 
               }
         ) ** {c2 = vp.c2} ; ---- correct ??

    SlashV2VNP v np vp = 
      insertObjPre 
        (\\fin,b,a => appCompl True b v.c2 np ++ ---- fin -> stack overflow
                      infVP v.sc b a vp v.vi) 
          (predV v) ** {c2 = vp.c2} ;

    AdvVP vp adv = insertAdv adv.s vp ;

    AdVVP adv vp = insertAdv adv.s vp ;

    ReflVP v = insertObjPre (\\fin,b,agr => appCompl fin b v.c2 (reflPron agr)) v ;

    PassV2 v = 
    let 
      vp = predV v ;
      subjCase = case v.c2.c of { --this is probably a reason to not get rid of NPAcc; TODO check
        NPCase Gen => NPCase Nom ; --valisin koera -> koer valitakse
        _          => v.c2.c       --rääkisin koerale -> koerale räägitakse
      }
    in {
      s = \\_ => vp.s ! VIPass Pres ;
      s2 = \\_,_,_ => [] ;
      adv = [] ;
      p = vp.p ;
      ext = vp.ext ;
      sc = subjCase  -- koer valitakse ; koerale räägitakse 
      } ;

----b    UseVS, UseVQ = \v -> v ** {c2 = {s = [] ; c = NPAcc ; isPre = True}} ;

    CompAP ap = {
      s = \\agr => 
          let
            n = complNumAgr agr ; 
          in ap.s ! False ! (NCase n Nom)
      } ;
      
    CompCN cn = {
      s = \\agr => 
          let
            n = complNumAgr agr ;
          in cn.s ! (NCase n Nom)
      } ;
    CompNP np = {s = \\_ => np.s ! NPCase Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

}


--2 The object case
--
-- The rules involved are ComplV2 and ComplVV above.
-- The work is done jointly in ResEst.infVP and appCompl. 
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
