concrete NounTha of Noun = CatTha ** open StringsTha, ResTha, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      let cnc = if_then_Str det.hasC cn.c []
      in  mkNP (thbind cn.s det.s1 cnc det.s2) ;
    UsePN pn = pn ;
    UsePron p = p ;

    DetNP det = mkNP (thbind det.s1 det.s2) ;

    PredetNP pred np = mkNP (thbind pred.s1 np.s pred.s2) ;

    PPartNP np v2 = thbind np (ss ((predV v2).s ! Pos)) ; ---- ??

    AdvNP np adv = thbind np adv ;

    DetQuant quant num = {
      s1 = num.s ++ quant.s1 ; --- can there be quant.s1 ??
      s2 = quant.s2 ;
      hasC = orB num.hasC quant.hasC ;
      } ;
    DetQuantOrd quant num ord = {
      s1 = num.s ++ quant.s1 ; --- can there be quant.s1 ??
      s2 = ord.s ++ quant.s2 ; 
      hasC = True ;
      } ;

    PossPron p = {
      s1 = khoog_s ++ p.s ;
      s2 = [] ;
      hasC = False
      } ;

    NumSg, NumPl = {s = [] ; hasC = False} ;

    NumCard n = n ** {hasC = True} ;
    NumDigits d = d ;
    OrdDigits d = {s = thbind thii_s d.s} ;

    NumNumeral numeral = numeral ** {hasC = True} ;
    OrdNumeral numeral = {s = thbind thii_s numeral.s} ;

    AdNum adn num = thbind adn num ; ---- always?

    OrdSuperl a = {s = thbind a.s thii_s sut_s} ;

    DefArt = {s1,s2 = [] ; hasC = False} ;
    IndefArt = {s1,s2 = [] ; hasC = False} ;

    MassNP cn = cn ;

    UseN n = n ;
    UseN2 n = n ;
    Use2N3 f = {s = thbind f.s ; c = f.c ; c2 = f.c2} ;
    Use3N3 f = {s = thbind f.s ; c = f.c ; c2 = f.c3} ;

    ComplN2 f x = {s = thbind f.s f.c2 x.s ; c = f.c} ;
    ComplN3 f x = {s = thbind f.s f.c2 x.s ; c = f.c ; c2 = f.c3} ;

    AdjCN ap cn = {s = cn.s ++ ap.s ; c = cn.c} ;

    RelCN cn rs = {s = thbind cn.s rs.s ; c = cn.s} ;
    AdvCN cn ad = {s = thbind cn.s ad.s ; c = cn.s} ;
    SentCN cn cs = {s = thbind cn.s cs.s ; c = cn.s} ;
    ApposCN cn np = {s = thbind cn.s np.s ; c = cn.s} ;

    RelNP np rs = thbind np rs ;

}
