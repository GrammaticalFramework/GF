concrete NounCmn of Noun = CatCmn ** open ResCmn, Prelude in {

  lin
    DetCN det cn = case det.detType of {
            DTFull Sg => {s = det.s ++ cn.c  ++ cn.s} ;  -- this house
            DTFull Pl => {s = det.s ++ xie_s ++ cn.s} ;  -- these houses
            DTNum     => {s = det.s ++ cn.c  ++ cn.s} ;  -- (these) five houses
            DTPoss    => {s = det.s          ++ cn.s}    -- our (five) houses
      } ;
    UsePN pn = pn ;
    UsePron p = p ;

    DetNP det = {s = det.s ++ ge_s} ; ----

    PredetNP pred np = mkNP (pred.s ++ possessive_s ++ np.s) ;

    PPartNP np v2 = mkNP ((predV v2).verb.s ++ possessive_s ++ np.s) ; ---- ??

    AdvNP np adv = mkNP (adv.s ++ possessive_s ++ np.s) ;

    DetQuant quant num = {
      s = case num.numType of {
        NTFull => quant.pl ++ num.s ;  -- to avoid yi in indef
        _ => quant.s ++ num.s
        } ; 
      detType = case num.numType of {
        NTFull => DTNum ;                     -- five
        NTVoid n => case quant.detType of {
          DTPoss => DTPoss ;                  -- our
          _ => DTFull n                       -- these/this
          }
       }
    } ;

    DetQuantOrd quant num ord = {
      s = quant.s ++ num.s ++ ord.s ;
      detType = case num.numType of {
        NTFull => DTNum ;                     -- five
        NTVoid n => DTFull n                  -- these/this ; also our, when ord is present
        }
      } ;

    PossPron p = {
      s,pl = p.s ++ possessive_s ;
      detType = DTPoss
      } ;

    NumSg = {s = [] ; numType = NTVoid Sg} ;
    NumPl = {s = [] ; numType = NTVoid Pl} ;

    NumCard n = n ** {numType = NTFull} ;
    NumDigits d = d ** {numType = NTFull} ;
    OrdDigits d = {s = ordinal_s ++ d.s} ;

    NumNumeral numeral = {s = numeral.p} ; -- liang instead of yi
    OrdNumeral numeral = {s = ordinal_s ++ numeral.s} ;

    AdNum adn num = {s = adn.s ++ num.s ; hasC = True} ;

    OrdSuperl a = {s = superlative_s ++ a.s} ;

    DefArt = mkQuant [] [] DTPoss ;             -- use that_Quant if you want the_s
    IndefArt = mkQuant yi_s [] (DTFull Sg) ;    -- empty in the plural

    MassNP cn = cn ;

    UseN n = n ;
    UseN2 n = n ;
    Use2N3 f = {s = f.s ; c = f.c ; c2 = f.c2} ;
    Use3N3 f = {s = f.s ; c = f.c ; c2 = f.c3} ;

    ComplN2 f x = {s = appPrep f.c2 x.s ++ f.s ; c = f.c} ;
    ComplN3 f x = {s = appPrep f.c2 x.s ++ f.s ; c = f.c ; c2 = f.c3} ;

    AdjCN ap cn = case ap.monoSyl of {
            True => {s = ap.s ++ cn.s ; c = cn.c} ;
            False => {s = ap.s ++ possessive_s ++ cn.s ; c = cn.c} 
            } ;

    RelCN cn rs = {s = rs.s ++ cn.s ; c = cn.c} ;
    AdvCN cn ad = {s = ad.s ++ possessive_s ++ cn.s ; c = cn.c} ;
    SentCN cn cs = {s = cs.s ++ cn.s ; c = cn.c} ;
    ApposCN cn np = {s = np.s ++ cn.s ; c = cn.c} ;

    RelNP np rs = mkNP (rs.s ++ np.s) ;

}
