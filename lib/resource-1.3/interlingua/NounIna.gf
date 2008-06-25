concrete NounIna of Noun = CatIna ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lin
    DetCN det cn = {
      s = \\c => det.s!c ++ cn.s ! det.n ; 
      a = agrP3 det.n ;
      isPronoun = False
      };  -- iste pizza

    UsePN pn = {
      s = \\_ => pn.s; 
      a = agrP3 Sg;
      isPronoun = False
      }; 

    UsePron p = p; -- io, tu, ille, etc.

    PredetNP pred np = {
      s = \\c => pred.s ++ np.s ! c ;
      isPronoun = False;
      a = np.a
      } ;

    PPartNP np v2 = {
      s = \\c => np.s ! c ++ v2.s ! VPPart ;
      isPronoun = False;
      a = np.a
      } ;

    AdvNP np adv = {
      isPronoun = False;
      s = \\c => np.s ! c ++ adv.s ;
      a = Sp3;
      } ;

    DetSg quant ord = {
      s = \\c=>quant.s ! Sg ! c ++ ord.s ; 
      n = Sg
      } ;

    DetPl quant num ord = {
      s = \\c=>(quant.s ! num.n !c) ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    PossPron p = {s = \\_,c => casePrep [] c ++ p.possForm} ;

    NoNum = {s = []; n = Pl } ;
    NoOrd = {s = []} ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;
    NumInt n = {s = n.s ; n = Pl} ;
    
    OrdInt n = {s = n.s ++ "e"} ; --- DEPRECATED
    OrdDigits n = {s = n.s ! NOrd} ;

    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n } ;
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;
    
    AdNum adn num = {s = adn.s ++ num.s; n = num.n } ;

    OrdSuperl a = {s = a.s ! AAdj Superl} ;

    DefArt = {s = \\_ => table {
		Dat => "al";
		Gen | Abl => "del";
		_ => "le"}} ;

    IndefArt = {s =
      \\n,c => casePrep [] c ++ case n of {
        Sg => "un" ; 
        Pl => []
        }
      } ;
    
    MassDet = {s = \\_,_ => []} ;

    UseN n = n ;
    UseN2 n = n ;
    UseN3 n = n ;

    ComplN2 f x = {s = \\n => f.s ! n ++ f.p2 ++ x.s ! f.c2} ;
    ComplN3 f x = {s = \\n => f.s ! n ++ f.p2 ++ x.s ! f.c2 ; c2 = f.c3; p2 = f.p3} ;

    AdjCN ap cn = {
      s = \\n => preOrPost ap.isPre (ap.s ! agrP3 n) (cn.s ! n)
      } ;

    RelCN cn rs = {s = \\n => cn.s ! n ++ rs.s ! agrP3 n} ;
    AdvCN cn ad = {s = \\n => cn.s ! n ++ ad.s} ;

    SentCN cn sc = {s = \\n => cn.s ! n ++ sc.s} ;
    
    ApposCN cn np = {s = \\n => cn.s ! n ++ np.s ! Nom} ; 
    --- ??? The use of the Nom case is somewhat strange here. The
    --- abstract rule is dubious anyway, so ...

}
