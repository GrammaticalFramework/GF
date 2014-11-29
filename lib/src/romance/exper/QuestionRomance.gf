incomplete concrete QuestionRomance of Question = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = cl ** {ip = [] ; isSent = True} ;

    QuestVP qp vp = {np = heavyNP {s = qp.s ; a = agrP3 qp.a.g qp.a.n} ; vp = vp ; ip = [] ; isSent = False} ;

    QuestSlash ip slash = slash ** {ip = ip.s ! slash.c2.c ; isSent = False} ;

{- ----
      s = \\t,a,p => 
            let 
              cl = oldClause slash ;
              cls : Direct -> Str = 
                    \d -> cl.s !        d ! t ! a ! p ! Indic ;
----                \d -> cl.s ! ip.a ! d ! t ! a ! p ! Indic ;
              who = slash.c2.s ++ ip.s ! slash.c2.c
            in table {
              QDir   => who ++ cls DInv ;
              QIndir => who ++ cls DDir
              }
-} 

    QuestIAdv iadv cl = cl ** {ip = iadv.s ; isSent = False} ;
{-
      s = \\t,a,p,q => 
            let 
              ord = case q of {
                QDir   => DInv ;
                QIndir => DInv 
              } ;
              cl = oldClause ncl ;
              cls = cl.s ! ord ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ cls
-}

    QuestIComp icomp np = {np = np ; vp = predV copula ; ip = icomp.s ! complAgr np.a ; isSent = False} ;
{-
      s = \\t,a,p,_ => 
            let 
              vp  = predV copula ;
              cls = (mkClause (np.s ! Nom).comp np.hasClit np.isPol np.a vp).s ! 
                       DInv ! t ! a ! p ! Indic ;
              why = icomp.s ! complAgr np.a ;
            in why ++ cls
-}

    PrepIP p ip = {
      s = p.s ++ ip.s ! p.c
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      a = ip.a
      } ;

    IdetCN idet cn = 
      let 
        g = cn.g ;
        n = idet.n ;
        a = aagr g n
      in {
      s = \\c => idet.s ! g ! c ++ cn.s ! n ; 
      a = a
      } ;

    IdetIP idet = 
      let 
        g = Masc ; ---- Fem in Extra
        n = idet.n ;
        a = aagr g n
      in {
      s = \\c => idet.s ! g ! c ; 
      a = a
      } ;

    IdetQuant idet num = 
      let 
        n = num.n ;
      in {
      s = \\g,c => idet.s ! n ! g ! c ++ num.s ! g ;
      n = n
      } ;

    AdvIAdv i a = {s = i.s ++ a.s} ;

    CompIAdv a = {s = \\_  => a.s} ;

    CompIP p = {s = \\_  => p.s ! Nom} ;

  lincat 
    QVP = ResRomance.VP ;
  lin
    ComplSlashIP vp ip = insertObject vp.c2 (heavyNP {s = ip.s ; a = {g = ip.a.g ; n = ip.a.n ; p = P3}}) vp ;
    AdvQVP vp adv = insertAdv adv.s vp ;
    AddAdvQVP vp adv = insertAdv adv.s vp ;

    QuestQVP qp vp = {np = heavyNP {s = qp.s ; a = agrP3 qp.a.g qp.a.n} ; vp = vp ; ip = [] ; isSent = False} ; ----

{- 
      s = \\t,a,b,_ => 
        let
          cl = mkClause (qp.s ! Nom) False False (agrP3 qp.a.g qp.a.n) vp  
        in
        cl.s ! DDir ! t ! a ! b ! Indic
-}

}

