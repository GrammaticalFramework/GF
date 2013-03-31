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
      s = \\c => np.s ! c ++ "," ++ rs.s ! np.a ;
      a = np.a
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    DetQuant quant num = {
      s  = quant.s ! num.hasCard ! num.n ++ num.s ! Nom;
      sp = \\c => case num.hasCard of {
                     False => quant.sp ! num.hasCard ! num.n ! c ++ num.s ! Nom ;
                     True  => quant.s  ! num.hasCard ! num.n     ++ num.s ! npcase2case c
                  } ;
      n  = num.n ;
      hasNum = num.hasCard
      } ;

    DetQuantOrd quant num ord = {
      s  =        quant.s  ! num.hasCard ! num.n ++ num.s ! Nom ++ ord.s ! Nom; 
      sp = \\c => quant.s  ! num.hasCard ! num.n ++ num.s ! Nom ++ ord.s ! npcase2case c ; 
      n  = num.n ;
      hasNum = True
      } ;

    DetNP det = {
      -- s = case det.hasNum of {True => \\_ => det.s ; _ => \\c => det.sp ! c} ;
      s = det.sp ;
      a = agrP3 det.n
      } ;

    PossPron p = {
      s = \\_,_ => p.s ! NCase Gen ;
      sp = \\_,_,c => p.sp ! Gen
      } ;

    NumSg = {s = \\c => []; n = Sg ; hasCard = False} ;
    NumPl = {s = \\c => []; n = Pl ; hasCard = False} ;
---b    NoOrd = {s = []} ;

    NumCard n = n ** {hasCard = True} ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s = n.s ! NOrd} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    AdNum adn num = {s = \\c => adn.s ++ num.s!c ; n = num.n} ;

    OrdSuperl a = {s = \\c => a.s ! AAdj Superl c } ;

    DefArt = {
      s  = \\hasCard,n => artDef ;
      sp = \\hasCard,n => case <n,hasCard> of {
        <Sg,False> => table { NCase Gen => "its"; _ => "it" } ;
        <Pl,False> => table { NCase Nom => "they"; NPAcc => "them"; _ => "theirs" } ;
        _          => \\c => artDef
        }
      } ;

    IndefArt = {
      s = \\hasCard,n => case <n,hasCard> of {
        <Sg,False> => artIndef ;
        _          => []
        } ;
      sp = \\hasCard,n => case <n,hasCard> of {
        <Sg,False> => table {NCase Gen => "one's"; _ => "one" };
        <Pl,False> => table {NCase Gen => "ones'"; _ => "ones" } ;
        _          => \\c => []
        }
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

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s ; g = cn.g} ;

    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! NCase c ; g = cn.g} ;

    PossNP cn np = {s = \\n,c => cn.s ! n ! c ++ "of" ++ np.s ! NPNomPoss ; g = cn.g} ;

    PartNP cn np = {s = \\n,c => cn.s ! n ! c ++ "of" ++ np.s ! NPAcc ; g = cn.g} ;

    CountNP det np = {
      s = \\c => det.sp ! c ++ "of" ++ np.s ! NPAcc ;
      a = agrP3 det.n
      } ;

}
