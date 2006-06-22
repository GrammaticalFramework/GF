incomplete concrete ExtRomance of ExtRomanceAbs = 
  CatRomance ** open DiffRomance, ResRomance in {

  lin
    DefSgN predet noun = let g = noun.g in {
      s = \\c => predet.s ! gennum g Sg ++ noun.s ! Sg ! Def ! caseNP c ;
      a = agrP3 g Sg
      } ;
    DefPlN predet noun = let g = noun.g in {
      s = \\c => predet.s ! Plg ++ noun.s ! Pl ! Def ! caseNP c ;
      a = agrP3 g Sg
      } ;

}
