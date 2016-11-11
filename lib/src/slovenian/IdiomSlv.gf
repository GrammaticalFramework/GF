----AR BEGIN the whole IdiomSlv
concrete IdiomSlv of Idiom = CatSlv ** 
  open ParadigmsSlv, ResSlv, Prelude in {

  lin
    ExistNP np = 
      mkClause [] np.a False {
        s  = \\p,vform => ne ! p ++ (mkV "obstajati" "obstaja").s ! vform ;
        s2 = \\a => np.s ! Nom ;
        isCop = False ;
        refl = []
      } ;

    

}
----AR END