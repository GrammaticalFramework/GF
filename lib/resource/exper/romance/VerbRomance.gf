incomplete concrete VerbRomance of Verb = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

{---b
    ComplV2 v np1 = insertObject v.c2 np1 (predV v) ;

    ComplV3 v np1 np2 = insertObject v.c3 np2 (insertObject v.c2 np1 (predV v)) ;

    ComplVV v vp = 
      insertComplement (\\a => prepCase v.c2.c ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertExtrapos (\\b => conjThat ++ s.s ! (v.m ! b)) (predV v) ;
    ComplVQ v q  = insertExtrapos (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap = 
      insertComplement (\\a => ap.s ! AF a.g a.n) (predV v) ;

    ComplV2V v np vp = 
      insertComplement (\\a => prepCase v.c2.c ++ infVP vp a) 
        (insertObject v.c2 np (predV v)) ;
    ComplV2S v np s = 
      insertExtrapos (\\b => s.s ! Indic) ---- mood
        (insertObject v.c2 np (predV v)) ;
    ComplV2Q v np q = 
      insertExtrapos (\\_ => q.s ! QIndir)
        (insertObject v.c2 np (predV v)) ;

    ComplV2A v np ap = 
      let af = case v.c3.isDir of {
        True => AF np.a.g np.a.n ;  -- ... bleues
        _ => AF Masc Sg             -- il les peint en bleu
        }
      in
      insertComplement 
        (\\a => v.c3.s ++ prepCase v.c3.c ++ ap.s ! af)
          (insertObject v.c2 np (predV v)) ;

    ReflV2 v = case v.c2.isDir of {
      True  => predV {s = v.s ; vtyp = vRefl} ;
      False => insertComplement 
                 (\\a => v.c2.s ++ reflPron a.n  a.p v.c2.c) (predV v)
      } ;

-}
    UseComp comp = insertComplement comp.s (predV copula) ;

    CompAP ap = {s = \\ag => ap.s ! AF ag.g ag.n} ;
    CompNP np = {s = \\_  => np.s ! Ton Acc} ;
    CompAdv a = {s = \\_  => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    PassV2 v = insertComplement (\\a => v.s ! VPart a.g a.n) (predV auxPassive) ;

---b    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = complAcc ; vtyp = vv.vtyp} ;

}
