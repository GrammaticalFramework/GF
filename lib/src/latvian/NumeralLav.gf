--# -path=.:../abstract:../common:../prelude

concrete NumeralLav of Numeral = CatLav ** open
  ResLav,
  ParadigmsLav
  in {

flags
  coding = utf8 ;

lincat
  -- TODO: formas, kas pieprasa ģenitīvu - tūkstotis grāmatu, trīs simti meiteņu
  Digit = { s : DForm => CardOrd => Gender => Case => Str } ;
  Sub10 = { s : CardOrd => Gender => Case => Str ; n : Number } ;
  Sub100 = { s : CardOrd => Gender => Case => Str ; n : Number } ;
  Sub1000 = { s : CardOrd => Gender => Case => Str ; n : Number } ;
  Sub1000000 = { s : CardOrd => Gender => Case => Str ; n : Number } ;

lin
  num x = x ;

  n2 = mkNum "divi" "otrais" Pl ;

  n3 =
    let trijs = mkNumSpec "trijs" "trešais" "trīs" "trīs" Pl
    in {
      s = \\f,o,g,c => case <f, o, g, c> of {
        <unit, NCard, _, Nom> => "trīs" ;
        <unit, NCard, _, Dat> => "trim" ;
        <unit, NCard, _, Loc> => "trīs" ;
        _ => trijs.s ! f ! o ! g ! c
      }
    } | {
      s = \\f,o,g,c => case <f, o, g, c> of {
        <unit, NCard, _, Nom> => "trīs" ;
        _ => trijs.s ! f ! o ! g ! c
    }
  } ;

  n4 = mkNum "četri" "ceturtais" Pl ;
  n5 = mkNum "pieci" "piektais" Pl ;
  n6 = mkNum "seši" "sestais" Pl ;
  n7 = mkNum "septiņi" "septītais" Pl ;
  n8 = mkNum "astoņi" "astotais" Pl ;
  n9 = mkNum "deviņi" "devītais" Pl ;

  pot01 = { s = viens.s ! unit } ** { n = Sg } ;
  pot0 d = { s = d.s ! unit } ** { n = Pl } ;
  pot110 = { s = viens.s ! ten } ** { n = Pl } ;
  pot111 = { s = viens.s ! teen } ** { n = Pl } ;
  pot1to19 d = { s = d.s ! teen } ** { n = Pl } ;
  pot0as1 n = { s = n.s ; n = n.n } ;
  pot1 d = { s = d.s ! ten } ** { n = Pl } ;

  pot1plus d e = {
    s = \\o,g,c => d.s ! ten ! NCard ! Masc ! Nom ++ e.s ! o ! g ! c ;
    n = e.n
  } ;

  pot1as2 n = n ;

  -- FIXME: nav īsti labi, kārtas skaitlim ir jābūt 'trīssimtais' utml
  pot2 d = {
    s = \\o,g,c => d.s ! NCard ! Masc ! Nom ++ simts ! o ! g ! d.n ! c ;
    n = Pl
  } ;

  pot2plus d e = {
    s = \\o,g,c => d.s ! NCard ! Masc ! Nom ++ simts ! NCard ! Masc ! d.n ! Nom ++ e.s ! o ! g ! c ;
    n = e.n
  } ;

  pot2as3 n = n ;

  pot3 d = {
    s = \\o,g,c => d.s ! NCard ! Masc ! Nom ++ tuukstotis ! o ! g ! d.n ! c ;
    n = Pl
  } ;

  pot3plus d e = {
    s = \\o,g,c => d.s ! NCard ! Masc ! Nom ++ tuukstotis ! NCard ! Masc ! d.n ! Nom ++ e.s ! o ! g ! c ;
    n = e.n
  } ;

-- Numerals as sequences of digits:

lincat
  Dig = { n : Number ; s : CardOrd => Str } ;

lin
  IDig d = d ;

  IIDig d i = {
    s = \\o => d.s ! NCard ++ i.s ! o ;
    n = Pl ;	-- FIXME: 1 cilvēks, 11 cilvēki, 21 cilvēks, ...
  } ;

  D_0 = mkDig "0" ;
  D_1 = mk2Dig "1" Sg ;
  D_2 = mkDig "2" ;
  D_3 = mkDig "3" ;
  D_4 = mkDig "4" ;
  D_5 = mkDig "5" ;
  D_6 = mkDig "6" ;
  D_7 = mkDig "7" ;
  D_8 = mkDig "8" ;
  D_9 = mkDig "9" ;

oper
  mkDig : Str -> Dig = \c -> mk2Dig c Pl ;

  mk2Dig : Str -> Number -> Dig = \c,n -> lin Dig {
    s = table { NCard => c ; NOrd => c + "." } ;
    n = n
  } ;

}
