concrete AdverbSnd of Adverb = CatSnd ** open ResSnd, Prelude in {

  flags coding = utf8;
  lin
    PositAdvAdj a = {s = \\g => a.s ! Sg ! g ! Obl } ;
    ComparAdvAdj cadv a np = {
      s = \\g => np.s ! NPObj  ++ cadv.p ++ cadv.s ++ a.s ! Sg ! g ! Obl ;  
      } ;
    ComparAdvAdjS cadv a s = {
      s = \\g => cadv.p ++ cadv.s ++ a.s ! Sg ! g ! Obl   ++  s.s;
      } ;

    PrepNP prep np = {s = \\_ => np.s ! NPObj ++ prep.s } ;

    AdAdv ada adv = { s = \\g => ada.s ++ adv.s ! g} ;

    SubjS sub snt = {s = \\_ => sub.s ++ snt.s } ;
    AdnCAdv cadv = {s = "سان گڏ " ++ cadv.s} ;

}
