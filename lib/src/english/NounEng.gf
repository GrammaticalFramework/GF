concrete NounEng of Noun = CatEng ** open MorphoEng, ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = { 
      s = \\c => det.s ++ cn.s ! det.n ! npcase2case c ; 
      a = agrgP3 det.n cn.g
      } ;

    UsePN pn = {s = \\c => pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;
    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPPart ;
      a = np.a
      } ;

    RelNP np rs = {
      s = \\c => np.s ! c ++ frontComma ++ rs.s ! np.a ++ finalComma ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    ExtAdvNP np adv = {
      s = \\c => np.s ! c ++ embedInCommas adv.s ;
      a = np.a
      } ;


    DetQuant quant num = {
      s  = quant.s ! num.hasCard ! num.n ++ num.s ! quant.isDef ! Nom;
      sp = \\g,hasAdj,c => case num.hasCard of {
                             False => quant.sp ! g ! hasAdj ! num.n ! c ++ num.s  ! quant.isDef ! Nom ;
                             True  => quant.s  !     True   ! num.n     ++ num.sp ! quant.isDef ! npcase2case c
                           } ;
      n  = num.n ;
      hasNum = num.hasCard
      } ;

    DetQuantOrd quant num ord = {
      s  =            quant.s  ! num.hasCard ! num.n ++ num.s ! quant.isDef ! Nom ++ ord.s ! Nom; 
      sp = \\g,_,c => quant.s  ! num.hasCard ! num.n ++ num.s ! quant.isDef ! Nom ++ ord.s ! npcase2case c ; 
      n  = num.n ;
      hasNum = True
      } ;

    DetNP det = {
      -- s = case det.hasNum of {True => \\_ => det.s ; _ => \\c => det.sp ! c} ;
      s = det.sp ! Neutr ! False ;
      a = agrP3 det.n
      } ;

    PossPron p = {
      s = \\_,_ => p.s ! NCase Gen ;
      sp = \\_,hasAdj,_,c => case hasAdj of {
                               True  => p.s ! NCase Gen ;
                               False => p.sp ! npcase2case c
                             } ;
      isDef = True
      } ;

    NumSg = {s,sp = \\_,c => []; n = Sg ; hasCard = False} ;
    NumPl = {s,sp = \\_,c => []; n = Pl ; hasCard = False} ;

    NumCard n = n ** {hasCard = True} ;

    NumDigits n = {s,sp = \\_ => n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s    = n.s ! NOrd} ;

    NumNumeral numeral = {s,sp = \\_ => numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s    = numeral.s ! NOrd} ;

    AdNum adn num = {s  = \\_,c => adn.s ++ num.s !False!c ;
                     sp = \\_,c => adn.s ++ num.sp!False!c ;
                     n  = num.n} ;

    OrdSuperl a = {s = \\c => a.s ! AAdj Superl c } ;

    OrdNumeralSuperl n a = {s = \\c => n.s ! NOrd ! Nom ++ a.s ! AAdj Superl c } ;

    DefArt = {
      s  = \\hasCard,n => artDef ;
      sp = \\g,hasCard,n => case <n,hasCard> of {
        <Sg,False> => table { NCase Gen => table Gender ["its"; "his"; "her"] ! g; _ => table Gender ["it"; "he"; "she"] ! g } ;
        <Pl,False> => table { NCase Nom => "they"; NPAcc => "them"; _ => "theirs" } ;
        _          => \\c => artDef
        } ;
      isDef = True
      } ;

    IndefArt = {
      s = \\hasCard,n => case <n,hasCard> of {
        <Sg,False> => artIndef ;
        _          => []
        } ;
      sp = \\g,hasCard,n => case <n,hasCard> of {
        <Sg,False> => table {NCase Gen => "one's"; _ => "one" };
        <Pl,False> => table {NCase Gen => "ones'"; _ => "ones" } ;
        _          => \\c => []
        } ;
      isDef = False
      } ;

    MassNP cn = {
      s = \\c => cn.s ! Sg ! npcase2case c ;
      a = agrP3 Sg
      } ;

    UseN n = n ;
    UseN2 n = n ;
---b    UseN3 n = n ;

    Use2N3 f = {
      s = \\n,c => f.s ! n ! Nom ;
      g = f.g ;
      c2 = f.c2
      } ;

    Use3N3 f = {
      s = \\n,c => f.s ! n ! Nom ;
      g = f.g ;
      c2 = f.c3
      } ;

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! NPAcc ; g = f.g} ;
    ComplN3 f x = {
      s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! NPAcc ;
      g = f.g ;
      c2 = f.c3
      } ;

    AdjCN ap cn = {
      s = \\n,c => preOrPost ap.isPre (ap.s ! agrgP3 n cn.g) (cn.s ! n ! c) ;
      g = cn.g
      } ;
    RelCN cn rs = {
      s = \\n,c => cn.s ! n ! c ++ rs.s ! agrgP3 n cn.g ;
      g = cn.g
      } ;
    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s ; g = cn.g} ;

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ! agrgP3 n cn.g ; g = cn.g} ;

    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! NCase c ; g = cn.g} ;

    PossNP cn np = {s = \\n,c => cn.s ! n ! c ++ "of" ++ np.s ! NPNomPoss ; g = cn.g} ;

    PartNP cn np = {s = \\n,c => cn.s ! n ! c ++ "of" ++ np.s ! NPAcc ; g = cn.g} ;

    CountNP det np = {
      s = \\c => det.sp ! Neutr ! False ! c ++ "of" ++ np.s ! NPAcc ;
      a = agrP3 det.n
      } ;

    AdjDAP dap ap = {
      s = dap.s ++ ap.s ! agrgP3 dap.n Masc ;       --- post-ap's ? "this larger than life (movie)"
      sp = \\g,_,c => case c of {
                        NCase Gen => dap.sp ! g ! True ! NCase Nom ++ ap.s ! agrgP3 dap.n g ++ BIND ++ "'s" ;
                        c         => dap.sp ! g ! True ! c ++ ap.s ! agrgP3 dap.n g
                      } ;
      n = dap.n ;
      hasNum = dap.hasNum
      } ;

    DetDAP d = d ;

}
