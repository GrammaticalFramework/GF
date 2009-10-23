--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete AdverbPol of Adverb = CatPol ** open ResPol, Prelude in {
  flags  coding=utf8 ;

  lin
   PositAdvAdj a = {s = a.advpos } ;
   
--    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
    ComparAdvAdj c a n = {
      s = c.s ++ a.advpos ++ c.p ++ n.nom
    } ;

--     ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs
    ComparAdvAdjS c a s = {
      s = c.s ++ a.advpos ++ c.p ++ s.s
    } ;
    
--     AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    AdnCAdv cadv = { s=cadv.sn ++ cadv.pn };
    
    
    PrepNP na stol = ss (na.s ++ stol.dep ! na.c);

    AdAdv = cc2 ;

    SubjS = cc2 ;
}
