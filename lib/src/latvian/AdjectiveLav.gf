concrete AdjectiveLav of Adjective = CatLav ** open ResLav, StructuralLav, Prelude in {
flags 
  coding = utf8 ;

  lin
	PositA a = { s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) } ;
    ComparA a np = { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) ++ "par" ++ np.s ! Acc ; }  |
				   { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) ++ "nekā" ++ np.s ! Nom ; };	
	UseComparA a = { s = \\d,g,n,c => a.s ! (AAdj Compar d g n c) } ;

    ComplA2 a np = {
      s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) ++ a.p.s ++ np.s ! (a.p.c ! (fromAgr np.a).n) ;       
    } ;
	
	ReflA2 a = {
      s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) ++ a.p.s ++ reflPron ! (a.p.c ! n) ;       
    } ;

    AdAP ada ap = { s = \\d,g,n,c => ada.s ++ ap.s ! d ! g ! n ! c ; } ;
	
    SentAP ap sc = { --FIXME - te vajag apstākļa vārdu nevis īpašības vārdu! Kuru nevar normāli no AP dabūt
      s = \\d,g,n,c => ap.s ! d ! g ! n ! c ++ "," ++ sc.s ; 
    } ;	

    AdjOrd ord = {
      s = \\d,g,n,c => ord.s ! g ! c ;   --FIXME - skaitļa agreement? noteiktība?
    } ;

    CAdvAP cadv ap np = {
      s = \\d,g,n,c => cadv.s ++ ap.s ! d ! g ! n ! c ++ cadv.p ++ np.s ! Nom ;   --TODO nominatīvs var ne vienmēr būt, pie tā CAdv jāliek parametrs par locījumu
    } ;

	  UseA2 a = {
      s = \\d,g,n,c => a.s ! (AAdj Posit d g n c) ;
    } ;	
{-
    PositA  a = {
      s = \\_ => a.s ! AAdj Posit Nom ;
      isPre = True
      } ;
    ComparA a np = {
      s = \\_ => a.s ! AAdj Compar Nom ++ "than" ++ np.s ! Nom ; 
      isPre = False
      } ;
    UseComparA a = {
      s = \\_ => a.s ! AAdj Compar Nom ; 
      isPre = True
      } ;

    AdjOrd ord = {
      s = \\_ => ord.s ! Nom ;
      isPre = True
      } ;

    CAdvAP ad ap np = {
      s = \\a => ad.s ++ ap.s ! a ++ ad.p ++ np.s ! Nom ; 
      isPre = False
      } ;

    ComplA2 a np = {
      s = \\_ => a.s ! AAdj Posit Nom ++ a.c2 ++ np.s ! Acc ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\ag => a.s ! AAdj Posit Nom ++ a.c2 ++ reflPron ! ag ; 
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = \\_ => a.s ! AAdj Posit Nom ;
      isPre = True
      } ;
-}
}
