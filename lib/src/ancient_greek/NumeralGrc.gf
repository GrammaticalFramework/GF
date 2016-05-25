--# -path=.:../abstract:../common:../prelude:

concrete NumeralGrc of Numeral = CatGrc ** open ResGrc, MorphoGrc in {

lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100     = {s : CardOrd => Str ; n : Number} ;
  Sub1000    = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;

oper -- n1 not in abstract
  thousand    : CardOrd => Str = cardOrd "ci'lioi" "ciliosto's" "cilia'kis" ;
  tenthousand : CardOrd => Str = cardOrd "my'rioi" "myriosto's" "myria'kis" ;
  n1 = mkDigit "ei(~s"   "e('ndeka"      "de'ka"         "prw~tos"    "a('pax" ;  

lin -- mkDigit   d       (d+10)           (d*10)          d-th         d-times
    -- -----------------------------------------------------------------------
  n2 = mkDigit "dy'o"    "dw'deka"        "ei)'kosi"      "dey'teros"  "di's" ; 
  n3 = mkDigit "trei~s" ("trei~s"++"kai`"++"de'ka") 
                                          "tria'konta"    "tri'tos"   "tri's" ;
  n4 = mkDigit "te'ttares" ("te'ttares"++"kai`"++"de'ka") 
                                          "tettara'konta" "te'tartos" "tetra'kis" ;
  n5 = mkDigit "pe'nte"  "pentekai'deka"  "penth'konta"   "pe'mptos"  "penta'kis" ;
  n6 = mkDigit "e('x"    "e(kkai'deka"    "e(xh'konta"    "e('ktos"   "e(xa'kis" ;
  n7 = mkDigit "e(pta'"  "e(ptakai'deka"  "e(bdomh'konta" "e('bdomos" "e(pta'kis" ;
  n8 = mkDigit "o)ktw'"  "o)ktwkai'deka"  "o)gdoh'konta"  "o)'gdoos"  "o)kta'kis" ;
  n9 = mkDigit "e)nne'a" "e)nneakai'deka" "e)nenh'konta"  "e)'natos"  "e)na'kis" ;

  pot01  = n1 ** {n = Sg} ;                     -- 1
  pot0 d = d ** {n = Pl} ;                      -- d * 1 
  pot1 d = {s = d.s ! DTen} ** {n = Pl} ;       -- d * 10
  pot110 = pot1 n1 ;                            -- 10 
  pot1to19 d = {s = d.s ! DTeen} ** {n = Pl} ;  -- 10 + d  
  pot111 = pot1to19 n1 ;                        -- 11
  pot0as1 n = {s = n.s ! DUnit}  ** {n = n.n} ; -- coerce : Sub10 -> Sub100
  pot1plus d e =                                -- d * 10 + e
      -- let kai : Str = ("kai`" | "") in  -- too expensive!         -- BR 73.2
      { s = \\f => d.s ! DTen ! f ++ "kai`" ++ e.s ! DUnit ! f ; n = Pl} ;

  pot1as2 n = n ;                               -- coerce : Sub100 -> Sub1000
                                                
  pot2 d = { s = \\f => d.s ! DHundred ! f ; n = Pl} ;  -- d * 100
  pot2plus d m = {                                      -- d * 100 + m
     s = \\f => d.s ! DHundred ! f ++ "kai`" ++ m.s ! f ; n = Pl} ;  -- BR 73.2
  pot2as3 n = n ;

                                                -- d * 1000 
  pot3 d = { s = \\f => d.s ! NAdv ++ (thousand ! f) ; n = Pl} ;
  pot3plus d m = {
     s = \\f => d.s ! NAdv ++ thousand ! f ++ "kai`" ++ m.s ! f ; n = Pl} ;


-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = {s = d.s ! one; unit = ten} ;

    IIDig d i = {
      s = d.s ! i.unit ++ i.s ;
      unit = inc i.unit
    } ;

    D_0 = mkDig "-"  "-" "-"  ;  -- avoid empty Dig
    D_1 = mkDig "a"  "i" "r"  ;
    D_2 = mkDig "b"  "k" "s"  ;
    D_3 = mkDig "g"  "l" "t"  ;
    D_4 = mkDig "d"  "m" "y"  ;
    D_5 = mkDig "e"  "n" "f"  ;
    D_6 = mkDig "s*" "x" "c"  ;  -- TODO: replace s* by stigma (not in ut -ancientgreek)
    D_7 = mkDig "z"  "o" "q"  ;
    D_8 = mkDig "h"  "p" "w"  ;
    D_9 = mkDig "v"  "K" "P"  ;  -- TODO: replace K by koppa, P by sampi (not in ut -ancientgreek)

  oper
    TDigit = {
      s : Unit => Str
    } ;

    mkDig : Str -> Str -> Str -> TDigit = 
      \one,ten,hundred -> { s = table Unit [one;ten;hundred] } ;
        
    inc : Unit -> Unit = \u ->
      case u of {
        one              => ten ;
        ten              => hundred ;
        -- hundred          => thousand ;
        -- thousand         => myriad ;
        -- myriad           => myriad 
        hundred          => hundred 
      } ;
}
