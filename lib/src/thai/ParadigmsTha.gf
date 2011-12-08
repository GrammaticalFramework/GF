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
  animalN : Str -> N
      = \s -> mkN s "ตัว" ;
  placeN : Str -> N
      = \s -> mkN s "แห่ง" ;
  verbalN : Str -> N
      = \s -> mkN s "ข้อ" ;

  mkN2 : N -> Str -> N2
      = \n,p -> lin N2 (n ** {c2 = p}) ;

  mkN3 : N -> Str -> Str -> N3
      = \n,p,q -> lin N3 (n ** {c2 = p ; c3 = q}) ;

  mkA : Str -> A = \s -> lin A (mkAdj s) ;

  mkPN : Str -> PN
     = \s -> lin PN (ss s) ;

  mkA2 : A -> Str -> A2
      = \n,p -> lin A2 (n ** {c2 = p}) ;

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
    mkV2 : V -> Str -> V2
      = \v,p -> lin V2 (v ** {c2 = p}) ;
    } ;

  mkV3 = overload {
    mkV3 : Str -> V3
      = \s -> lin V3 (regV s ** {c2,c3 = []}) ;
    mkV3 : V -> V3
      = \s -> lin V3 (s ** {c2,c3 = []}) ;
    mkV3 : V -> Str -> Str -> V3
      = \v,p,q -> lin V3 (v ** {c2 = p ; c3 = q}) ;
    } ;

  mkVQ : V -> VQ =
    \v -> lin VQ v ;

  mkVS : V -> VS =
    \v -> lin VS v ;

  mkVA : V -> VA =
    \v -> lin VA v ;

  mkV2Q : V -> Str -> V2Q =
    \v,p -> lin V2Q (v ** {c2 = p}) ; 

  mkV2V : V -> Str -> Str -> V2V =
    \v,p,q -> lin V2V (v ** {c2 = p ; c3 = q}) ; 

  mkV2S : V -> Str -> V2S =
    \v,p -> lin V2S (v ** {c2 = p}) ; 

  mkV2A : V -> Str -> Str -> V2A =
    \v,p,q -> lin V2A (v ** {c2 = p ; c3 = q}) ; 

  mkAdv : Str -> Adv = 
    \s -> lin Adv (ss s) ;

  mkPrep : Str -> Prep = 
    \s -> lin Prep (ss s) ;

  
}
