concrete UntensedEng of Untensed = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    PosCl cl = {s = cl.s ! Pres ! Simul ! Pos ! ODir} ;
    NegCl cl = {s = cl.s ! Pres ! Simul ! Neg ! ODir} ;

}
