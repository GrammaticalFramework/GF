incomplete concrete NounRomance of Noun =
   CatRomance ** open CommonRomance, ResRomance, Prelude in {

  flags optimize=all_subs ; coding = utf8 ;

  lin
    DetCN det cn =
      let
        g = cn.g ;
        n = det.n
      in heavyNPpol det.isNeg {
        s = \\c => det.s ! g ! c ++ cn.s ! n ++ det.s2 ;
        a = agrP3 g n ;
        hasClit = False
        } ;

    UsePN = pn2np ;

    UsePron p = p ** {isNeg = False} ;

    PredetNP pred np =
      let agr = complAgr np.a in
      heavyNPpol np.isNeg {
        s = \\c => pred.s ! agr ! c ++ (np.s ! pred.c).ton ;
        a = case pred.a of {PAg n => agrP3 agr.g n ; _ => np.a} ;
        hasClit = False
      } ;

    PPartNP np v2 =
      let agr = complAgr np.a in
      heavyNPpol np.isNeg {
        s = \\c => (np.s ! c).ton ++ v2.s ! VPart agr.g agr.n ;
        a = np.a ;
        hasClit = False
      } ;

    RelNP np rs = heavyNPpol np.isNeg {
      s = \\c => (np.s ! c).ton ++ rs.s ! Indic ! np.a ;
      a = np.a ;
      hasClit = False
      } ;

    AdvNP np adv = heavyNPpol np.isNeg {
      s = \\c => (np.s ! c).ton ++ adv.s ;
      a = np.a ;
      hasClit = False
      } ;

    ExtAdvNP np adv = heavyNPpol np.isNeg {
      s = \\c => (np.s ! c).ton ++ embedInCommas adv.s ;
      a = np.a ;
      hasClit = False
      } ;

    DetQuantOrd quant num ord = {
      s,sp = \\g,c => quant.s ! num.isNum ! num.n ! g ! c ++ num.s ! g ++
                   ord.s ! aagr g num.n ;
      s2 = quant.s2 ;
      n = num.n ;
      isNeg = quant.isNeg
      } ;

    DetQuant quant num = {
      s  = \\g,c => quant.s ! num.isNum ! num.n ! g ! c ++ num.s ! g ;
      sp = \\g,c => case num.isNum of {
        True  => quant.s ! True ! num.n ! g ! c ++ num.s ! g ;
        False => quant.sp ! num.n ! g ! c ++ num.s ! g
        } ;
      s2 = quant.s2 ;
      n  = num.n ;
      isNeg = quant.isNeg
      } ;

    DetNP det =
      let
        g = Masc ;  ---- Fem in Extra
        n = det.n
      in heavyNPpol det.isNeg {
        s = det.sp ! g ;
        a = agrP3 g n ;
        hasClit = False
        } ;

    PossPron p = {
      s = \\_,n,g,c => possCase g n c ++ p.poss ! n ! g ; ---- il mio!
      sp = \\ n,g,c => possCase g n c ++ p.poss ! n ! g ; ---- not for Fre
      s2 = [] ;
      isNeg = False
      } ;

    NumSg = {s = \\_ => [] ; isNum = False ; n = Sg} ;
    NumPl = {s = \\_ => [] ; isNum = False ; n = Pl} ;

    NumCard n = n ** {isNum = True} ;

    NumDigits nu = {s = \\g => nu.s ! NCard g ; n = nu.n} ;
    OrdDigits nu = {s = \\a => nu.s ! NOrd a.g a.n} ;

    NumNumeral nu = {s = \\g => nu.s ! NCard g ; n = nu.n} ;
    OrdNumeral nu = {s = \\a => nu.s ! NOrd a.g a.n} ;

    AdNum adn num = {s = \\a => adn.s ++ num.s ! a ; isNum = num.isNum ; n = num.n} ;

    OrdSuperl adj = {s = \\a => adj.s ! Superl ! AF a.g a.n} ;

    OrdNumeralSuperl num adj = {s = \\a => num.s ! NOrd a.g a.n ++ adj.s ! Superl ! AF a.g a.n} ; -- la terza più grande
    ---- could be discontinuous: la terza città più grande

    DefArt = {
      s = \\_,n,g,c => artDef False g n c ;
      sp = \\n,g,c => artDef True g n c ;
      s2 = [] ;
      isNeg = False
      } ;

    IndefArt = {
      s = \\b,n,g,c => if_then_Str b (prepCase c) (artIndef False g n c) ;
      sp = \\n,g,c => artIndef True g n c ;
      s2 = [] ;
      isNeg = False
      } ;

    MassNP cn = let
        g = cn.g ;
        n = Sg
      in heavyNP {
        s = table {Nom => artDef False g n Nom ++ cn.s ! n ; c => partitive g c ++ cn.s ! n} ; -- le vin est bon ; je bois du vin
        a = agrP3 g n ;
        hasClit = False ;
        isNeg = False
        } ;

-- This is based on record subtyping.

    UseN, UseN2 = \noun -> noun ;

    Use2N3 f = f ;

    Use3N3 f = f ** {c2 = f.c3} ;

    ComplN2 f x = {
      s = \\n => f.s ! n ++ appCompl f.c2 x ;
      g = f.g ;
      } ;

    ComplN3 f x = {
      s = \\n => f.s ! n ++ appCompl f.c2 x ;
      g = f.g ;
      c2 = f.c3
      } ;

    AdjCN ap cn =
      let
        g = cn.g
      in {
        s = \\n => preOrPost ap.isPre (ap.s ! (AF g n)) (cn.s ! n) ;
        g = g ;
        } ;

    RelCN cn rs = let g = cn.g in {
      s = \\n => cn.s ! n ++ rs.s ! Indic ! agrP3 g n ; --- mood
      g = g
      } ;
    SentCN  cn sc = let g = cn.g in {
      s = \\n => cn.s ! n ++ sc.s ! genitive ;  -- raison de dormir
      g = g
      } ;
    AdvCN  cn sc = let g = cn.g in {
      s = \\n => cn.s ! n ++ sc.s ;
      g = g
      } ;

    ApposCN  cn np = let g = cn.g in {
      s = \\n => cn.s ! n ++ (np.s ! Nom).ton ;
      g = g
      } ;

    PossNP cn np = {
      s = \\n => cn.s ! n ++ appCompl {s = [] ; c = genitive ; isDir = False} np ;
      g = cn.g ;
      } ;

    -- PartNP and CounNP missing: how to define 'of' in the functor?

    AdjDAP det ap = {
      s = \\g => det.s ! g ++ ap.s ! AF g det.n ;
      n = det.n ;
      } ;

    DetDAP det = {s = \\g => det.s ! g ! Nom ; n = det.n } ;

}
