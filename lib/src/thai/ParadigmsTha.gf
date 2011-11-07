resource ParadigmsTha = open CatTha, ResTha, Prelude in {

flags coding = utf8 ;

oper
  mkN = overload {
    mkN : Str -> N 
      = \s -> lin N {s = s ; c = "กำ ลัง"} ;     ---- for small objects, see LP PB p. 20
    mkN : Str -> Str -> N 
      = \s,c -> lin N {s = s ; c = c} ;
    } ;

  personN : Str -> N
      = \s -> mkN s "คน" ;
  fooddishN : Str -> N
      = \s -> mkN s "จาน" ;
  vehicleN : Str -> N
      = \s -> mkN s "คัน" ;
  houseN : Str -> N
      = \s -> mkN s "หลัง" ;

  mkA : Str -> A = \s -> lin A (mkAdj s) ;

  mkV = overload {
    mkV : Str -> Verb 
      = \s -> {s1 = [] ; s2 = s ; isCompl = False} ;
    mkV : Str -> Str -> Verb 
      = \s,c -> lin V {s1 = s ; s2 = c ; isCompl = True} ;
    } ;

  mkV2 = overload {
    mkV2 : Str -> V2
      = \s -> lin V2 (dirV2 (regV s)) ;
    mkV2 : V -> V2
      = \s -> lin V2 (dirV2 s) ;
    } ;

}
