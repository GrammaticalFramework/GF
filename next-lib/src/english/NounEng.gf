concrete NounEng of Noun = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrgP3 det.n cn.g
      } ;

    UsePN pn = pn ** {a = agrgP3 Sg pn.g} ;
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

    DetQuantOrd quant num ord = {
      s  = quant.s ! num.hasCard ! num.n ++ num.s ++ ord.s ; 
      sp = quant.sp ! num.hasCard ! num.n ++ num.s ++ ord.s ; 
      n  = num.n
      } ;

    DetQuant quant num = {
      s  = quant.s ! num.hasCard ! num.n ++ num.s ;
      sp = quant.sp ! num.hasCard ! num.n ++ num.s ;
      n  = num.n
      } ;

    DetNP det = {
      s = \\c => det.sp ; ---- case
      a = agrP3 det.n
      } ;

    PossPron p = {
      s = \\_,_ => p.s ! Gen ;
      sp = \\_,_ => p.sp 
      } ;

    NumSg = {s = []; n = Sg ; hasCard = False} ;
    NumPl = {s = []; n = Pl ; hasCard = False} ;
---b    NoOrd = {s = []} ;

    NumCard n = n ** {hasCard = True} ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
    OrdDigits n = {s = n.s ! NOrd} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    AdNum adn num = {s = adn.s ++ num.s ; n = num.n} ;

    OrdSuperl a = {s = a.s ! AAdj Superl} ;

    DefArt = {
      s = \\c,n => artDef ;
      sp = \\c,n => case <n,c> of {
        <Sg,False> => "it" ;
        <Pl,False> => "they" ;
        _ => artDef
        }
      } ;

    IndefArt = {
      s = \\c,n => case <n,c> of {
        <Sg,False> => artIndef ;
        _ => []
        } ;
      sp = \\c,n => case <n,c> of {
        <Sg,False> => "one" ;
        <Pl,False> => "ones" ;
        _ => []
        }
      } ;

    MassNP cn = {
      s = cn.s ! Sg ;
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

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; g = f.g} ;
    ComplN3 f x = {
      s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ;
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

    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! c ; g = cn.g} ;

}
