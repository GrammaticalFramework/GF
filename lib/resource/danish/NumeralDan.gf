concrete NumeralDan of Numeral = CatDan ** open MorphoDan in {


-- AR 12/10/2002 following www.geocities.com/tsca.geo/dansk/dknummer.html

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100, Sub1000, Sub1000000 = 
          {s :          CardOrd => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkTal "to"   "tolv"    "tyve"       "anden"  "tyvende" ;
lin n3 = mkTal "tre"  "tretten" "tredive"    "tredje" "tredivte" ;
lin n4 = mkTal "fire" "fjorten" "fyrre"      "fjerde" "fyrretyvende" ;
lin n5 = mkTal "fem"  "femten"  "halvtreds"  "femte"  "halvtredsindstyvende" ;
lin n6 = mkTal "seks" "seksten" "tres"       "sjette" "tredsindstyvende" ;
lin n7 = mkTal "syv"  "sytten"  "halvfjerds" "syvende""halvfjerdsindstyvende" ;
lin n8 = mkTal "otte" "atten"   "firs"       "ottende""firsindstyvende" ;
lin n9 = mkTal "ni"   "nitten"  "halvfems"   "niende" "halvfemsindstyvende" ;

  pot01 = {
    s = \\f => table {
          NCard g => case g of {Neutr => "et" ; _ => "en"} ;
          _ => "første"
          } ; 
    n = Sg
    } ;
  pot0 d = {s = \\f,g => d.s ! f ! g ; n = Pl} ;
  pot110 = numPl (cardReg "ti") ;
  pot111 = numPl (cardOrd "elleve" "elvte") ;
  pot1to19 d = numPl (d.s ! ton) ;
  pot0as1 n = {s = n.s ! ental ; n = n.n} ;
  pot1 d = numPl (d.s ! tiotal) ;

  pot1plus d e = {
    s = \\g => e.s ! ental ! invNum ++ "og" ++ d.s ! tiotal ! g ; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = numPl (\\_ => d.s ! ental ! invNum ++ "hundrede") ;
  pot2plus d e = 
    {s = \\g => d.s ! ental ! invNum ++ "hundrede" ++ "og" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = numPl (\\g => n.s ! invNum ++ cardOrd "tusind" "tusinde" ! g) ;
  pot3plus n m = {s = \\g => n.s ! invNum ++ "tusind" ++ "og" ++ m.s ! g ; n =Pl} ;

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ; 

    IIDig d i = {
      s = \\o => d.s ! o ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1e" Sg ;
    D_2 = mk2Dig "2" "2e" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "e") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = table {NCard _ => c ; NOrd _ => o} ;
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

}
