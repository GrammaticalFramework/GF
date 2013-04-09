incomplete concrete AdverbHindustani of Adverb = CatHindustani ** open CommonHindustani, ResHindustani, Prelude in {

  lin
    PositAdvAdj a = {s = \\g => a.s ! Sg ! g ! Obl ! Posit} ;
    PositAdAAdj a = {s = a.s ! Sg ! Masc ! Obl ! Posit} ;
    ComparAdvAdj cadv a np = {
      s = \\g => np.s ! NPObj  ++ cadv.p ++ cadv.s ++ a.s ! Sg ! g ! Obl ! Posit;  
      } ;
    ComparAdvAdjS cadv a s = {
      s = \\g => cadv.p ++ cadv.s ++ a.s ! Sg ! g ! Obl ! Posit  ++  s.s;
      } ;

    PrepNP prep np = {s = \\g => np.s ! NPObj ++ prep.s ! g } ;

    AdAdv ada adv = { s = \\g => ada.s ++ adv.s ! g} ;

    SubjS sub s = {s = \\_ => sub.s ++ s.s } ;

    AdnCAdv cadv = {s = sE ++ cadv.s ; p = True} ;

}
