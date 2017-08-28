concrete NumeralEus of Numeral = CatEus [Numeral,Digits] ** open Prelude, ResEus, ParamX in {

oper LinDigit : Type = { s : DForm => Str ; 
                         n : Number ; 
                         even20 : Even20 } ;

oper mk20Ten : Str -> Str -> Str -> Str -> LinDigit = \tri,t,fiche,h -> 
  { s = table { Unit   => tri ; 
                Teen   => t ; 
                Twenty => fiche ; 
                Hund   => h + "ehun"} ; 
    even20 = Ten ;
    n = Pl } ;

oper mkeven20 : Str -> Str -> Str -> Str -> LinDigit = \se,t,trifichid,h -> 
  { s = table { Unit => se ; 
                Teen => t ; 
                Twenty => trifichid ; 
                Hund => h + "ehun" } ; 
    even20 = Even ; 
    n = Pl } ;

param Even20 = Ten | Even ;
param DForm = Unit | Teen | Twenty | Hund ;
 
--lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; n : Number } ;
lincat Sub1000 = {s : Str ; n : Number ; isHundred : Bool } ;
lincat Sub1000000 = {s : Str ; n : Number } ;


----------------------------------------------------------------------------


--  num : Sub1000000 -> Numeral ;
lin num x0 = lin Numeral x0 ;

lin n2  = mkeven20 "bi" "hamabi" "hogei" "berr" ; 
lin n3  = mk20Ten "hiru" "hamahiru"{-"hamahirur"-} "hogei" "hirur";
lin n4  = mkeven20 "lau" "hamalau"{-"hamalaur"-}   "berrogei" "laur";
lin n5  = mk20Ten "bost" "hamabost"{-"hamabortz"-} "berrogei" "bost"; 
lin n6  = mkeven20 "sei" "hamasei" "hirurogei" "seir" ;
lin n7  = mk20Ten "zazpi" "hamazazpi" "hirurogei" "zazpi" ;
lin n8  = mkeven20 "zortzi" "hemezortzi" "laurogei" "zortzi" ;
lin n9  = mk20Ten "bederatzi" "hemeretzi" "laurogei" "bederatzi" ;

lin pot01  =
  {s = table {Unit => "bat" ; Hund => "ehun" ; _ => []} ; even20 = Ten ; n = Sg };
lin pot0 d = d ;
lin pot110 = {s = "hamar" ; n = Pl} ;
lin pot111 = {s = variants {"hamaika" ; "hameka"} ; n = Pl} ;
lin pot1to19 d = {s = d.s ! Teen ; n = Pl} ;
lin pot0as1 n = {s = n.s ! Unit ; n = n.n} ;
lin pot1 d =
  {s = case d.even20 of {
              Even => d.s ! Twenty ;  
              Ten  => glue (d.s ! Twenty) "tahamar" } ;
   n = Pl} ;
lin pot1plus d e =
  {s = case d.even20 of {
              Even => d.s ! Twenty ++ "ta" ++ e.s ! Unit ;   
              Ten  => d.s ! Twenty ++ "ta" ++ e.s ! Teen } ; 
   n = Pl} ;

lin pot1as2 n = n ** { isHundred = False } ; 
lin pot2 d = {s = d.s ! Hund ; n = Pl ; isHundred = True } ;
lin pot2plus d e =
  { s = d.s ! Hund ++ "ta" ++ e.s ;
    n = Pl ;
    isHundred = True } ;
lin pot2as3 n = n ;
lin pot3 n =
  {s = table {Sg => [] ; Pl => n.s } ! n.n ++ "mila" ;
   n = n.n } ;

  
lin pot3plus n m =
  let ta = if_then_Str m.isHundred [] "ta" ; --no `ta' between 1000 and 100
  in 
    { s = table {Sg => [] ; Pl => n.s } ! n.n ++ "mila" ++ ta ++ m.s ;
      n = n.n } ;

----------------------------------------------------------------------------

lincat Dig     = TDigit ;

oper
  TDigit : Type = { s : CardOrd => Str ; n : Number } ;
  mkDig : Str -> TDigit = \c -> mk2Dig c Pl ;

  mk2Dig : Str -> Number -> TDigit = \c,num -> 
   { s = table { NCard => c ; 
                 NOrd => c + "garren" } ;--TODO: make it more noun-like?
     n = num } ;



lin D_0 = mkDig "0" ;
lin D_1 = mk2Dig "1" Sg ;
lin D_2 = mkDig "2" ;
lin D_3 = mkDig "3" ;
lin D_4 = mkDig "4" ;
lin D_5 = mkDig "5" ;
lin D_6 = mkDig "6" ;
lin D_7 = mkDig "7" ;
lin D_8 = mkDig "8" ;
lin D_9 = mkDig "9" ;

    -- : Dig -> Digits ;
lin IDig dig = dig ;
    -- : Dig -> Digits -> Digits ; 
lin IIDig dig digs = digs ** {s = \\co => glue (dig.s ! co) (digs.s ! co) } ;

}
