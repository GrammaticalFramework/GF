--# -path=.:../abstract:../common:../prelude

concrete AdjectiveLav of Adjective = CatLav ** open
  ResLav,
  StructuralLav,
  Prelude
  in {

flags
  coding = utf8 ;

lin
  PositA a = { s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) } ;

  ComparA a np = { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) ++ "par" ++ np.s ! Acc }  |
                 { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) ++ "nekā" ++ np.s ! Nom } ;

  UseComparA a = { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) } ;

  ComplA2 a np = {
    s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) ++ a.prep.s ++ np.s ! (a.prep.c ! (fromAgr np.agr).num)
  } ;

  ReflA2 a = { s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) ++ a.prep.s ++ reflPron ! (a.prep.c ! n) } ;

  AdAP ada ap = { s = \\d,g,n,c => ada.s ++ ap.s ! d ! g ! n ! c } ;

  -- FIXME: te vajag apstākļa vārdu nevis īpašības vārdu! bet apst.v. nevar normāli no AP dabūt
  SentAP ap sc = { s = \\d,g,n,c => ap.s ! d ! g ! n ! c ++ "," ++ sc.s } ;

  -- FIXME: skaitļa agreement? noteiktība?
  AdjOrd ord = { s = \\d,g,n,c => ord.s ! g ! c } ;

  --TODO: nominatīvs var ne vienmēr būt, pie CAdv jāliek parametrs par locījumu
  CAdvAP cadv ap np = { s = \\d,g,n,c => cadv.s ++ ap.s ! d ! g ! n ! c ++ cadv.prep ++ np.s ! Nom } ;

  UseA2 a = { s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) } ;

}
