concrete NounAra of Noun = CatAra ** open ResAra, Prelude in {

flags optimize=noexpand ;

lin

  DetCN det cn = let {
    number = sizeToNumber det.n;
    determiner : Case -> Str = \c -> 
      det.s ! cn.h ! (detGender cn.g det.n) ! c;
    noun : Case -> Str = \c -> cn.s ! 
      number ! (nounState det.d number) ! (nounCase c det.n det.d)
    } in { 
      s = \\c => 
        case cnB4det det.isPron det.isNum det.n det.d of {
          False => determiner c ++ noun c;
          --FIXME use the adj -> cn -> cn rule from below instead of 
          --repeating code
          True => cn.s ! number ! det.d ! c ++ det.s ! cn.h ! cn.g ! c 
            ++ cn.adj ! number ! det.d ! c
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
  {-
  --should compile.. not working :( wierd error message.. bug?
  PPartNP np v2 = 
    let x = case np.a.pgn of {
      Per3 g n =>  ( positAdj (v2.s ! VPPart) ) ! g ! n ! Indef ;
  _ => \\_ => [] -- not occuring anyway
    } in {
      s = \\c => np.s ! c ++ x ! c ;
  a = np.a
    };
  -}    
  
  -- FIXME try parsing something like "this house now" and you'll get
  -- an internal compiler error, but it still works.. wierd..
  AdvNP np adv = {
    s = \\c => np.s ! c ++ adv.s;
    a = np.a
    };
{-  
  DetSg quant ord = {
    s = \\h,g,c => 
      quant.s ! Sg ! h ! g ! c ++ ord.s ! g ! quant.d ! c ;
    n = One;
    d = quant.d;
    isPron = quant.isPron;
    isNum = 
      case ord.n of {
        None => False;
        _ => True
      }
    } ;
-}  
  
  DetQuantOrd quant num ord = {
    s = \\h,g,c => quant.s ! Pl ! h ! g ! c 
      ++ num.s ! g ! (toDef quant.d num.n) ! c 
      --FIXME check this:
      ++ ord.s ! g ! (toDef quant.d num.n) ! c ;  
    n = num.n;
    d = quant.d;
    isPron = quant.isPron;
    isNum = 
      case num.n of {
        None => False;
        _ => True
      }
    } ;
  
  DetQuant quant num = {
    s = \\h,g,c => quant.s ! Pl ! h ! g ! c 
      ++ num.s ! g ! (toDef quant.d num.n) ! c ;
    n = num.n;
    d = quant.d;
    isPron = quant.isPron;
    isNum = 
      case num.n of {
        None => False;
        _ => True
      }
    } ;
  

  --DEPRECATED
  --    SgQuant quant = {s = quant.s ! Sg ; d = quant.d; 
  --                     isPron = quant.isPron; isNum = False} ;
  --    PlQuant quant = {s = quant.s ! Pl ; d = quant.d; 
  --                     isPron = quant.isPron; isNum = False} ;
  
  PossPron p = {
    s = \\_,_,_,_ => p.s ! Gen; 
    d = Const; 
    isPron = True; 
    isNum = False } ;
  
  NumSg = {
    s = \\_,_,_ => [] ; 
    n = One } ; 

  NumPl = {
    s = \\_,_,_ => [] ; 
    n = None } ; 
  
  NumDigits digits = {
    s = \\_,_,_ => digits.s;
    n = digits.n
    };
  
  NumNumeral numeral = {
    s = numeral.s ! NCard ;
    n = numeral.n
    };

  NumCard n = n ;

  AdNum adn num = {
    s = \\g,d,c => adn.s ++ num.s ! g ! d ! c ;
    n = num.n } ;
  
  OrdDigits digits = {
    s = \\_,d,_ => Al ! d ++ digits.s;
    n = digits.n
    };
  
  -- OrdNumeral : Numeral -> Ord ; -- fifty-first
  OrdNumeral numeral = {
    s = numeral.s ! NOrd ;
    n = numeral.n
    };
  
  -- FIXME, "the biggest house" would better translate into
  -- akbaru baytin rather than al-baytu l-2akbaru
  -- DetCN (DetSg DefArt (OrdSuperl big_A)) (UseN house_N)
  OrdSuperl a = {
    s = \\_,d,c => a.s ! AComp d c;
    n = One
    } ;
  
  DefArt = {
    s = \\_,_,_,_ => []; 
    d = Def ;
    isNum,isPron = False
    } ;
  
  IndefArt = {
    s = \\_,_,_,_ => []; 
    d = Indef ;
    isNum,isPron = False
    } ;
  
  MassNP cn = ---- AR
    {s = cn.s ! Sg ! Indef ; a = {pgn = Per3 cn.g Sg ; isPron = False}} ;

--  MassDet = {s = \\_,_,_,_ => [] ; d = Indef; 
--             isNum = False; isPron = False} ;
  
  UseN n = n ** {adj = \\_,_,_ => []};
  --    ComplN2 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c} ;
  --    ComplN3 f x = {s = \\n,c => f.s ! n ! Nom ++ f.c2 ++ x.s ! c ; c2 = f.c3} ;
  --
  --    UseN2 n = n ;
  --    UseN3 n = n ;
  --
  AdjCN ap cn = {
    s = \\n,d,c => cn.s ! n ! d ! c;
    adj = \\n,d,c => ap.s ! cn.h ! cn.g ! n ! (definite ! d) ! c ;
    g = cn.g;
    h = cn.h
    };
  --    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;
  --    AdvCN cn ad = {s = \\n,c => cn.s ! n ! c ++ ad.s} ;
  --
  --    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;
  --    ApposCN cn np =
}
