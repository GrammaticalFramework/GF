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

-- version 1.4 changes by AR 16/6/2008

    DetNP det = {
      s = \\c => det.s ! c ;
      a = agrP3 det.n ;
      isPronoun = False
      };  -- iste pizza

    DetQuantOrd quant num ord = {
      s = \\c=>(quant.s ! num.n !c) ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    DetQuant quant num = {
      s = \\c=>(quant.s ! num.n !c) ++ num.s ; 
      n = num.n
      } ;

    DetArtOrd art num ord = {
      s = \\c=>(art.s ! num.n !c) ++ num.s ++ ord.s ; 
      n = num.n
      } ;

    DetArtCard art num = {
      s = \\c=>(art.s ! num.n !c) ++ num.s ; 
      n = num.n
      } ;

    DetArtSg art cn = {
      s = \\c => art.s ! Sg ! c ++ cn.s ! Sg ; 
      a = agrP3 Sg ;
      isPronoun = False
      };  -- iste pizza

    DetArtPl art cn = {
      s = \\c => art.s ! Pl ! c ++ cn.s ! Pl ; 
      a = agrP3 Pl ;
      isPronoun = False
      };  -- iste pizza

    PossPron p = {s = \\_,c => casePrep [] c ++ p.possForm} ;

    NumPl = {s = []; n = Pl } ;
    NumSg = {s = []; n = Sg } ;

    NumCard c = c ;

    NumDigits n = {s = n.s ! NCard ; n = n.n} ;

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

    MassNP cn = {
      s = \\_ => cn.s ! Sg ; 
      a = agrP3 Sg;
      isPronoun = False
      }; 

    UseN n = n ;
    UseN2 n = n ;
--    UseN3 n = n ;
    Use2N3 f = {s = \\n => f.s ! n ; c2 = f.c2; p2 = f.p2} ;
    Use3N3 f = {s = \\n => f.s ! n ; c2 = f.c3; p2 = f.p3} ;

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

    RelNP np rs = {s = 
      \\c => np.s ! c ++ "," ++ rs.s ! np.a ; 
      a = np.a ;
      isPronoun = np.isPronoun ---- ?? AR
      } ;

}
