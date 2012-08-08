--# -path=.:../abstract:../common:../prelude

concrete ExtraLav of ExtraLavAbs = CatLav ** open ResLav in {

flags
  coding = utf8 ;

lin
  GenNP np = {s = \\_,_,_ => np.s ! Gen ; d = Def} ;

  --ICompAP ap = {s = \\g,n => "cik" ++ ap.s ! Indef ! g ! n ! Nom } ;

  IAdvAdv adv = {s = "cik" ++ adv.s} ;

}
