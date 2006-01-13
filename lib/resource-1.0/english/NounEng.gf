concrete NounEng of Noun = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s ++ cn.s ! det.n ! c ; 
      a = agrP3 det.n
      } ;
    UsePN pn = pn ** {a = agrP3 Sg} ;
    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      a = np.a
      } ;

    DetSg quant ord = {
      s = quant.s ++ ord.s ; 
      n = Sg
      } ;

    DetPl quant num ord = {
      s = quant.s ++ num.s ++ ord.s ; 
      n = Pl
      } ;

    PossSg p = {s = p.s ! Gen} ;
    PossPl p = {s = p.s ! Gen} ;

    NoNum, NoOrd = {s = []} ;

    NumInt n = n ;
    OrdInt n = {s = n.s ++ "th"} ; ---

    NumNumeral numeral = {s = numeral.s ! NCard} ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    AdNum adn num = {s = adn.s ++ num.s} ;

    OrdSuperl a = {s = a.s ! AAdj Superl} ;

    DefSg = {s = artDef ; n = Sg} ;
    DefPl = {s = artDef ; n = Pl} ;

    IndefSg = {s = artIndef ; n = Sg} ;
    IndefPl = {s = [] ; n = Pl} ;

    MassDet = {s = [] ; n = Sg} ;

    UseN n = n ;
    UseN2 n = n ;
    UseN3 n = n ;

    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;

    AdjCN ap cn = {
      s = \\n,c => preOrPost ap.isPre (ap.s ! agrP3 n) (cn.s ! n ! c)
      } ;
    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;

    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;

}
