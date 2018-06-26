incomplete concrete VerbScand of Verb = CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predV v ** {n3 = \\_ => [] ; c2 = v.c2} ;

    Slash2V3 v np = 
      insertObjPron np.isPron (\\_ => v.c2.s ++ np.s ! accusative) (predV v) ** 
        {n3 = \\_ => [] ; c2 = v.c3} ;  -- to preserve the order of args
    Slash3V3 v np = predV v ** {
      n3 = \\_ => v.c3.s ++ np.s ! accusative ; 
      c2 = v.c2
      } ;

    ComplVV v vp = insertObjPost (\\a => v.c2.s ++ infVP vp a) (predV v) ;
    ComplVS v s  = insertObjPost (\\_ => conjThat ++ s.s ! Sub) (predV v) ;  --- insertExt ?
    ComplVQ v q  = insertObjPost (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObjPost (\\a => ap.s ! agrAdjNP a DIndef) (predV v) ;

    SlashV2V v vp = predV v ** {
      n3 = \\a => v.c3.s ++ infVP vp a ; 
      c2 = v.c2
      } ;
    SlashV2S v s = predV v ** {
      n3 = \\_ => conjThat ++ s.s ! Sub ;
      c2 = v.c2
      } ; 
    SlashV2Q v q = predV v ** {
      n3 = \\_ => q.s ! QIndir ;
      c2 = v.c2
      } ;
    SlashV2A v ap = predV v ** {
      n3 = \\a => ap.s ! agrAdjNP a DIndef ;
      c2 = v.c2
      } ; 

    ComplSlash vp np =
      insertObjPost (\\_ => vp.n3 ! np.a)
        (insertObjPron (andB np.isPron (notB vp.c2.hasPrep)) (\\_ => vp.c2.s ++ np.s ! accusative)
          vp) ;

    SlashVV v vp = 
      insertObj (\\a => v.c2.s ++ infVP vp a) (predV v) ** {n3 = vp.n3 ; c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      insertObj
        (\\a => v.c2.s ++ np.s ! accusative ++ v.c3.s ++ infVP vp a) (predV v) 
        ** {n3 = vp.n3 ; c2 = v.c2} ;

    UseComp comp = insertObj
      comp.s (predV verbBe) ;

    CompAP ap = {s = \\a => ap.s ! agrAdjNP a DIndef} ;
    CompNP np = {s = \\_ => np.s ! accusative} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    ReflVP vp = insertObjPron (notB vp.c2.hasPrep) (\\a => reflPron a) (insertObj (\\a => vp.c2.s ++ vp.n3 ! a) vp) ;

    VPSlashPrep vp prep = vp ** {n3 = \\_ => [] ; c2 = {s = prep.s ; hasPrep = True}} ;

    PassV2 v = 
      insertObj
        (\\a => v.s ! VI (VPtPret (agrAdjNP a DIndef) Nom)) 
        (predV verbBecome) ;

    CompCN cn = {s = \\a => case a.n of { 
      Sg => artIndef ! cn.g ++ cn.s ! Sg ! DIndef ! Nom ;
      Pl => cn.s ! Pl ! DIndef ! Nom
      }
    } ;

    UseCopula = predV verbBe ;

    AdvVPSlash vps adv = insertAdv adv.s vps ** {c2 = vps.c2 ; n3 = vps.n3} ;
    AdVVPSlash adv vps = insertAdV adv.s vps ** {c2 = vps.c2 ; n3 = vps.n3} ;
    ExtAdvVP vp adv = insertExt (comma ++ adv.s) vp ;

}
