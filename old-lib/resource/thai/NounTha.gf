concrete NounTha of Noun = CatTha ** open StringsTha, ResTha, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = 
      let cnc = if_then_Str det.hasC cn.c []
      in  ss (cn.s ++ det.s1 ++ cnc ++ det.s2) ;
    UsePN pn = pn ;
    UsePron p = p ;
--
--    PredetNP pred np = {
--      s = \\c => pred.s ++ np.s ! c ;
--      a = np.a
--      } ;
--
--    PPartNP np v2 = {
--      s = \\c => np.s ! c ++ v2.s ! VPPart ;
--      a = np.a
--      } ;
--
--    AdvNP np adv = {
--      s = \\c => np.s ! c ++ adv.s ;
--      a = np.a
--      } ;

    DetQuant quant num = {
      s1 = [] ;
      s2 = quant.s ++ num.s ;
      hasC = quant.hasC ;
      } ;
    DetQuantOrd quant num ord = {
      s1 = num.s ;
      s2 = quant.s ++ ord.s ;
      hasC = orB num.hasC quant.hasC ;
      } ;

    PossPron p = {
      s = khoog_s ++ p.s ;
      hasC = False
      } ;

    NumSg, NumPl = {s = [] ; hasC = False} ;

    NumCard n = n ** {hasC = True} ;
--    OrdInt n = {s = n.s ++ "th"} ; ---
--
    NumNumeral numeral = numeral ** {hasC = True} ;
    OrdNumeral numeral = {s = thii_s ++ numeral.s} ;
--
--    AdNum adn num = {s = adn.s ++ num.s} ;
--
--    OrdSuperl a = {s = a.s ! AAdj Superl} ;
--
    DefArt = {s = [] ; hasC = False} ;
    IndefArt = {s = [] ; hasC = False} ;

    MassNP cn = cn ;

    UseN n = n ;
--    UseN2 n = n ;
--    UseN3 n = n ;
--
--    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
--    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;

    AdjCN ap cn = {s = cn.s ++ ap.s ; c = cn.c} ;

--    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;
--    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s} ;
--
--    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;
--
--    ApposCN cn np = {s = \\n,c => cn.s ! n ! Nom ++ np.s ! c} ;
--
}
