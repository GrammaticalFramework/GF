concrete NumeralDut of Numeral = CatDut ** open ResDut in {

flags optimize = all_subs ;

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100, Sub1000, Sub1000000 = 
          {s :          CardOrd => Str ; n : Number} ;

lin 
  num x = x ;

  n2 = mkDigit  "twee"  "twaalf"  "twentig"  "tweede" ;
  n3 = mkDigit  "drie"  "dertien" "dertig"  "derde" ;
  n4 = mkDigit  "vier" "veertien" "veertig" "vierde" ;
  n5 = mkDigit  "vijf" "vijftien" "vijftig" "vifjde" ;
  n6 = mkDigit  "zes" "zestien" "zestig" "zeste" ;
  n7 = mkDigit  "zeven" "zeventien" "zeventig" "zevende" ;
  n8 = mkDigit  "acht" "achttien"   "tachtig"  "achtste" ;
  n9 = mkDigit  "negen" "negentien" "negentig" "negende" ;

  pot01 = {
    s = \\f => table {
          NCard g _ => "één" ;
          NOrd af => (regAdjective "eerst").s ! Posit ! af
          } ; 
    n = Sg
    } ;
  pot0 d = {s = \\f,g => d.s ! f ! g ; n = Pl} ;
  pot110 = {s = cardOrd "tien" "tiende" ; n = Pl} ;
  pot111 = {s = cardOrd "elf" "elfde" ; n = Pl} ;
  pot1to19 d = {s = d.s ! DTeen; n = Pl} ;
  pot0as1 n = {s = n.s ! DUnit; n = n.n } ;
  pot1 d = {s = d.s ! DTen; n = Pl} ;
  pot1plus d e = {s = \\g => e.s ! DUnit ! invNum ++ "en" ++ d.s ! DTen ! g; n = Pl} ;
  pot1as2 n = n ;
  pot2 d = 
    {s = \\g => d.s ! DUnit ! invNum ++ cardOrd "honderd" "honderde" ! g ; n = Pl} ;
  pot2plus d e = 
    {s = \\g => d.s ! DUnit ! invNum ++ "duizend" ++ e.s ! g ; n = Pl} ;
  pot2as3 n = n ;
  pot3 n = 
    {s = \\g => n.s ! invNum ++ cardOrd "duizend" "duizende" ! g ; n = Pl} ; 
  pot3plus n m = 
    {s = \\g => n.s ! invNum ++ "duizend" ++ m.s ! g ; n = Pl} ;


  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ; 

    IIDig d i = {
      s = \\o => d.s ! invNum ++ i.s ! o ;
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
      s = table {NCard _ _ => c ; NOrd _ => o} ;
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

  LinDigit = {s : DForm => CardOrd => Str} ;

  cardOrd : Str -> Str -> CardOrd => Str = \drei,dritte ->
    table {
      NCard _ _ => drei ;
      NOrd a => (regAdjective dritte).s ! Posit ! a
      } ;

  mkDigit : (x1,_,_,x4 : Str) -> LinDigit = 
    \drei,dreizehn,dreissig,dritte ->
    {s = table {
           DUnit => cardOrd drei dritte ;
           DTeen => cardOrd dreizehn (dreizehn + "de") ;
           DTen  => cardOrd dreissig (dreissig + "ste")
           }
     } ;
  invNum : CardOrd = NCard Utr Nom ;

}
