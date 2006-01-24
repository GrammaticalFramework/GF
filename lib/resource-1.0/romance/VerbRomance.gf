incomplete concrete VerbRomance of Verb = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplV2 v np = insertObject v.c2 np (predV v) ;

    ComplV3 v np np2 = insertObject v.c3 np2 (insertObject v.c2 np (predV v)) ;

    ComplVV v vp = insertComplement (\\a => prepCase v.c2.c ++ infVP vp a) (predV v) ;

    ComplVS v s  = insertExtrapos (\\b => conjThat ++ s.s ! (v.m ! b)) (predV v) ;
    ComplVQ v q  = insertExtrapos (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA v ap = 
      insertComplement (\\a => ap.s ! AF a.g a.n) (predV v) ;
    ComplV2A v np ap = 
      insertComplement 
        (\\a => ap.s ! AF np.a.g np.a.n)
        (insertObject v.c2 np (predV v)) ;

    UseComp comp = insertComplement comp.s (predV copula) ;

    CompAP ap = {s = \\ag => ap.s ! AF ag.g ag.n} ;
    CompNP np = {s = \\_  => np.s ! Ton Acc} ;
    CompAdv a = {s = \\_  => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdv adv.s vp ;

    ReflV2 v = case v.c2.isDir of {
      True  => predV {s = v.s ; vtyp = vRefl} ;
      False => insertComplement 
                 (\\a => v.c2.s ++ reflPron ! a.n ! a.p ! v.c2.c) (predV v)
      } ;

    PassV2 v = insertComplement (\\a => v.s ! VPart a.g a.n) (predV auxPassive) ;

    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = complAcc ; vtyp = vv.vtyp} ;

}
