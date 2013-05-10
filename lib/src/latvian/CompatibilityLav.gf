--# -path=.:../abstract:../common:../prelude

concrete CompatibilityLav of Compatibility = CatLav ** open
  Prelude,
  ResLav
  in {

flags
  coding = utf8 ;

lin
  -- TODO: kāpēc citās valodās (piem., Eng, Bul) kategorijai Num (NumInt) ir lauks isNum (= True)?
  NumInt n = { s = \\_,_ => n.s ; num = Pl ; hasCard = False } ;
  OrdInt n = { s = \\_,_ => n.s ++ "." } ;

}
