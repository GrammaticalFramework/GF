concrete TensedEng of Tensed = CatEng, TenseX ** open ResEng in {

  flags optimize=all_subs ;

  lin
    UseCl t a p cl = {s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! ODir} ;

}
