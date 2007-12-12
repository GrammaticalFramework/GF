concrete NounAra of Noun = CatAra ** open ResAra, Prelude in {

  flags optimize=all_subs ;

  lin

    DetCN det cn = 
      let {
        number = sizeToNumber det.n;
        determiner : Case -> Str = \c -> 
          det.s ! cn.h ! (detGender cn.g det.n) ! c;
        noun : Case -> Str = \c ->
          cn.s ! number ! (nounState det.d number) ! (nounCase c det.n det.d)
      } in 
      { s = \\c => 
          case detAsAdj det.isNum det.n det.d of {
            False => determiner c ++ noun c;
            --FIXME use the adj -> cn -> cn rule from below instead of repeating code
            True => cn.s ! number ! det.d ! c ++ det.s ! cn.h ! cn.g ! c
          };
        a = { pgn = agrP3 cn.h cn.g number;
              isPron = False }
      };
    
    UsePN pn = { 
      s =  pn.s; 
      a = {pgn = (Per3 pn.g Sg); isPron = False } 
      };

    UsePron p = p ;

    PredetNP pred np = {
      s = \\c => case pred.isDecl of {
        True => pred.s!c ++ np.s ! Gen ; -- akvaru l-awlAdi
        False => pred.s!c ++ np.s ! c
        };
      a = np.a
      } ;

    DetSg quant ord = {
      s = quant.s ; --++ ord.s 
      n = One;
      d = quant.d;
      isNum = quant.isNum
      } ;


    DetPl quant num ord = {
      s = \\h,g,c => 
        quant.s ! h ! g ! c ++ num.s ! g ! (toDef quant.d num.n) ! c ;  
      n = num.n;
      d = quant.d;
      isNum = 
        case num.n of {
          None => False;
          _ => True
        };
      } ;

    SgQuant quant = {s = quant.s ! Sg ; n = Sg; d = quant.d; isNum = False} ;
    PlQuant quant = {s = quant.s ! Pl ; n = Pl; d = quant.d; isNum = False} ;


--    PossPron p = {s = \\_ => p.s ! Gen} ;

    NoNum, NoOrd = {s = \\_,_,_ => [] ; 
                    n = None} ; 

--    NumInt n = n ;
--    OrdInt n = {s = n.s ++ "ته"} ; ---

    NumNumeral numeral = numeral ;
--    OrdNumeral numeral = {s = numeral.s ! NOrd} ;
--
--    AdNum adn num = {s = adn.s ++ num.s} ;
--
--    OrdSuperl a = {s = a.s ! AAdj Superl} ;
--
    DefArt = {s = \\_,_,_,_ => []; d = Def } ;

    IndefArt = {s = \\_,_,_,_ => []; d = Indef} ;

    MassDet = {s = \\_,_,_ => [] ; n = Sg; d = Indef; isNum = False} ;

    UseN n = n ;
--    UseN2 n = n ;
--    UseN3 n = n ;
--
--    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
--    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;
--
    AdjCN ap cn = {
      s = \\n,d,c => 
        cn.s ! n ! d ! c ++ ap.s ! cn.h ! cn.g ! n ! (definite ! d) ! c ;
      g = cn.g;
      h = cn.h
      };
--    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;
--    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s} ;
--
--    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;
--
}
