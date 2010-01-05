incomplete concrete NounScand of Noun =
   CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

-- The rule defines $Det Quant Num Ord CN$ where $Det$ is empty if
-- it is the definite article ($DefSg$ or $DefPl$) and both $Num$ and
-- $Ord$ are empty and $CN$ is not adjectivally modified
-- ($AdjCN$). Thus we get $huset$ but $de fem husen$, $det gamla huset$.

  lin
    DetCN det cn = 
      let 
        g = cn.g ;
        m = cn.isMod ;
        dd = case <det.det,detDef,m> of {
          <DDef Def, Indef, True> => DDef Indef ;
          <d,_,_> => d
          }
      in {
      s = \\c => det.s ! m ! g ++
                 cn.s ! det.n ! dd ! caseNP c ; 
      a = agrP3 (ngen2gen g) det.n
      } ;

    UsePN pn = {
      s = \\c => pn.s ! caseNP c ; 
      a = agrP3 pn.g Sg
      } ;

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ! np.a.g ! np.a.n ++ pred.p ++ np.s ! c ;
      a = case pred.a of {PAg n => agrP3 np.a.g n ; _ => np.a}
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! (VI (VPtPret (agrAdjNP np.a DIndef) Nom)) ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuantOrd quant num ord = {
      s = \\b,g => quant.s ! num.n ! b ! (orB b num.isDet) ! g ++ 
                   num.s ! g ++ ord.s ;
      sp = \\b,g => quant.s ! num.n ! b ! (orB b num.isDet) ! g ++ 
                    num.s ! g ++ ord.s ;
      n = num.n ;
      det = quant.det
      } ;

    DetQuant quant num = 
      let 
        md : Bool -> Bool = \b -> case quant.det of {
         DDef _ => orB b num.isDet ;
         DIndef => num.isDet
         -- _ => False
         }
      in {
      s = \\b,g => quant.s ! num.n ! b ! md b ! g ++ 
                   num.s ! g ;
      sp = \\b,g => quant.sp ! num.n ! b ! md b ! g ++ 
                    num.s ! g ;
      n = num.n ;
      det = quant.det
      } ;

    DetNP det = 
      let 
        g = neutrum ; ----
        m = True ;  ---- is this needed for other than Art?
      in {
        s = \\c => det.sp ! m ! g ;
        a = agrP3 (ngen2gen g) det.n
      } ;

    PossPron p = {
      s,sp = \\n,_,_,g => p.s ! NPPoss (gennum (ngen2gen g) n) ; 
      det = DDef Indef
      } ;

    NumCard c = c ** {isDet = True} ;

    NumSg = {s = \\_ => [] ; isDet = False ; n = Sg} ;
    NumPl = {s = \\_ => [] ; isDet = False ; n = Pl} ;

    NumDigits nu = {s = \\g => nu.s ! NCard g ; n = nu.n} ;
    OrdDigits nu = {s = nu.s ! NOrd SupWeak} ;

    NumNumeral nu = {s = \\g => nu.s ! NCard g ; n = nu.n} ;
    OrdNumeral nu = {s = nu.s ! NOrd SupWeak} ;

    AdNum adn num = {s = \\g => adn.s ++ num.s ! g ; isDet = True ; n = num.n} ;

    OrdSuperl a = {
      s = case a.isComp of {
        True => "mest" ++ a.s ! AF (APosit (Weak Sg)) Nom ;
        _    => a.s ! AF (ASuperl SupWeak) Nom
        }  ; 
      isDet = True
      } ;

    DefArt = {
      s  = \\n,bm,bn,g => if_then_Str (orB bm bn) (artDef (gennum (ngen2gen g) n)) [] ; 
      sp = \\n,bm,bn,g => artDef (gennum (ngen2gen g) n) ;
      det = DDef Def
      } ;

    IndefArt = {
      s = table {
        Sg => \\_,bn,g => if_then_Str bn [] (artIndef ! g) ; 
        Pl => \\_,bn,_ => []
        } ; 
      sp = table {
        Sg => \\_,bn,g => artIndef ! g ; 
        Pl => \\_,bn,_ => detIndefPl
        } ; 
      det = DIndef
      } ;

    MassNP cn = {
      s = \\c => cn.s ! Sg ! DIndef ! caseNP c ; 
      a = agrP3 (ngen2gen cn.g) Sg
      } ;

    UseN, UseN2 = \noun -> {
      s = \\n,d,c => noun.s ! n ! specDet d ! c ; 
           ---- part app wo c shows editor bug. AR 8/7/2007
      g = noun.g ;
      isMod = False
      } ;

    Use2N3 f = {
      s = f.s ;
      g = f.g ;
      c2 = f.c2 ;
      isMod = False
      } ;

    Use3N3 f = {
      s = f.s ;
      g = f.g ;
      c2 = f.c3 ;
      isMod = False
      } ;

-- The genitive of this $NP$ is not correct: "sonen till mig" (not "migs").

    ComplN2 f x = {
      s = \\n,d,c => f.s ! n ! specDet d ! Nom ++ f.c2.s ++ x.s ! accusative ;
      g = f.g ;
      isMod = False
      } ;
    ComplN3 f x = {
      s = \\n,d,c => f.s ! n ! d ! Nom ++ f.c2.s ++ x.s ! accusative ; 
      g = f.g ;
      c2 = f.c3 ;
      isMod = False
      } ;

    AdjCN ap cn = let g = cn.g in {
      s = \\n,d,c =>
            preOrPost ap.isPre 
             (ap.s ! agrAdj (gennum (ngen2gen g) n) d) 
             (cn.s ! n ! d ! c) ;
      g = g ;
      isMod = True
      } ;

    RelCN cn rs = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ rs.s ! agrP3 (ngen2gen g) n ;
      g = g ;
      isMod = cn.isMod
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      a = np.a ;
      isMod = np.isMod
      } ;

    AdvCN  cn sc = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ sc.s ;
      g = g ;
      isMod = cn.isMod
      } ;
    SentCN  cn sc = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! c ++ sc.s ;
      g = g ;
      isMod = cn.isMod
      } ;
    ApposCN  cn np = let g = cn.g in {
      s = \\n,d,c => cn.s ! n ! d ! Nom ++ np.s ! NPNom ; --c
      g = g ;
      isMod = cn.isMod
      } ;
}
