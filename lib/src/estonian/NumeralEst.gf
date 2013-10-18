concrete NumeralEst of Numeral = CatEst [Numeral,Digits] **  open Prelude, ParadigmsEst, MorphoEst in {

-- Notice: possessive forms are not used. They get wrong, since every
-- part is made to agree in them.

flags optimize=all_subs ; coding=utf8;

lincat
  Sub1000000 = {s : CardOrd => Str ; n : MorphoEst.Number} ;
  Digit = {s : CardOrd => Str} ;
  Sub10, Sub100, Sub1000 = {s : NumPlace => CardOrd => Str ; n : MorphoEst.Number} ;

lin
  num x = x ;
  n2 = co (mkN "kaks" "kahe" "kahte" "kahte" "kahtede" "kahtesid")
		(mkN "teine" "teise" "teist" "teisesse" "teiste" "teisi") ;
  n3 = co (mkN "kolm" "kolme" "kolme" "kolme" "kolmede" "kolmi")
		(mkN "kolmas" "kolmanda" "kolmandat" "kolmandasse" "kolmandate" "kolmandaid") ;
  n4 = co (mkN "neli" "nelja" "nelja" "nelja" "neljade" "neljasid")
		(mkN "neljas" "neljanda" "neljandat" "neljandasse" "neljandate" "neljandaid") ;
  n5 = co (mkN "viis" "viie" "viit" "viide" "viite" "viisi")
		(mkN "viies" "viienda" "viiendat" "viiendasse" "viiendate" "viiendaid") ;
  n6 = co (mkN "kuus" "kuue" "kuut" "kuude" "kuute" "kuusi")
		(mkN "kuues" "kuuenda" "kuuendat" "kuuendasse" "kuuendate" "kuuendaid") ;
  n7 = co (mkN "seitse" "seitsme" "seitset" "seitsmesse" "seitsmete" "seitsmeid")
		(mkN "seitsmes" "seitsmenda" "seitsmendat" "seitsmendasse" "seitsmendate" "seitsmendaid") ;
  n8 = co (mkN "kaheksa")
		(mkN "kaheksas" "kaheksanda" "kaheksandat" "kaheksandasse" "kaheksandate" "kaheksandaid") ;
  n9 = co (mkN "üheksa")
		(mkN "üheksas" "üheksanda" "üheksandat" "üheksandasse" "üheksandate" "üheksandaid") ;

  pot01 =
   {s = table {
      NumAttr => \\_ => [] ;
      NumIndep => yksN.s
      } ;
    n = Sg
    } ;
  pot0 d = {n = Pl ; s = \\_ => d.s} ;
  pot110 =
   {s = \\_ => kymmeN.s ;
    n = Pl
    } ;

  pot111 = {n = Pl ; s = \\_,c => yksN.s ! c ++ BIND ++ "teist"} ;
  pot1to19 d = {n = Pl ; s = \\_,c => d.s ! c ++ BIND ++ "teist"} ;
  pot0as1 n = n ;

  pot1 d = {n = Pl ; s = \\_,c => d.s ! c ++ BIND ++ kymmendN.s ! c} ;
  pot1plus d e = {
    n = Pl ;
    s = \\_,c => d.s ! c ++ BIND ++ kymmendN.s ! c ++ e.s ! NumIndep ! c
    } ;
  pot1as2 n = n ;
  pot2 d = {n = Pl ; s = \\_,c => d.s ! NumAttr ! c ++ nBIND d.n ++ sataaN.s ! d.n ! c} ;
  pot2plus d e = {
    n = Pl ;
    s = \\_,c => d.s ! NumAttr ! c ++ nBIND d.n ++ sataaN.s ! d.n ! c ++
                 e.s ! NumIndep ! c
    } ;
  pot2as3 n = {n = n.n  ; s = n.s ! NumIndep} ;
  pot3 d = {n = Pl ; s = \\c => d.s ! NumAttr ! c ++ tuhattaN.s ! d.n ! c} ;
  pot3plus d e = {
    n = Pl ;
    s = \\c => d.s ! NumAttr ! c ++ tuhattaN.s ! d.n ! c ++ e.s ! NumIndep ! c
    } ;

oper
  co : (c,o : {s : NForm => Str}) -> {s : CardOrd => Str} = \c,o -> {
    s = table {
      NCard nf => c.s ! nf ;
      NOrd  nf => o.s ! nf
      }
    } ;

  nBIND : Number -> Str = \n -> case n of {Sg => [] ; _ => BIND} ; -- no BIND after silent 1

param
  NumPlace = NumIndep | NumAttr  ;

oper
  yksN = co
    (mkN "üks" "ühe" "ühte" "ühte" "ühtede" "ühtesid")
    (mkN "esimene" "esimese" "esimest" "esimesse" "esimeste" "esimesi") ;

  kymmeN = co
    (mkN "kümme" "kümne" "kümmet" "kümnesse" "kümnete" "kümneid")
    (mkN "kümnes" "kümnenda" "kümnendat" "kümnendasse" "kümnendate" "kümnendaid") ;

  sadaN = co
    (mkN "sada" "saja" "sadat" "sajasse" "sadade" "sadu")
    (mkN "sajas" "sajanda" "sajandat" "sajandasse" "sajandate" "sajandaid") ;

  tuhatN = co
    (mkN "tuhat" "tuhande" "tuhandet" "tuhandesse" "tuhandete" "tuhandeid")
    (mkN "tuhandes" "tuhandenda" "tuhandendat" "tuhandendasse" "tuhandete" "tuhandendaid")  ;

  kymmendN =
   {s = table {
      NCard (NCase Sg Nom) => "kümmend" ;
      k => kymmeN.s ! k
      }
    } ;

  sataaN : {s : MorphoEst.Number => CardOrd => Str} = {s = table {
    Sg => sadaN.s ;
    Pl => table {
      NCard (NCase Sg Nom) => "sada" ;
      k => sadaN.s ! k
      }
    }
  } ;

  tuhattaN = {s = table {
    Sg => tuhatN.s ;
    Pl => table {
      NCard (NCase Sg Nom) => "tuhat" ;
      k => tuhatN.s ! k
      }
    }
  } ;


  lincat
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = \\o => d.s ! NCard (NCase Sg Nom) ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1." MorphoEst.Sg ;
    D_2 = mkDig "2" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o MorphoEst.Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + ".") ;

    mk3Dig : Str -> Str -> MorphoEst.Number -> TDigit = \c,o,n -> {
      s = table {NCard _ => c ; NOrd _ => o} ;
      n = n
      } ;

    TDigit = {
      n : MorphoEst.Number ;
      s : CardOrd => Str
    } ;

}
