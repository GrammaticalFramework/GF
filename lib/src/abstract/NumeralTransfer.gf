abstract NumeralTransfer = Numeral ** {

fun digits2num : Digits -> Numeral ;
def digits2num                                                    (IDig d1)       = num (pot2as3 (pot1as2 (pot0as1 (dn10 d1)))) ;
    digits2num                                          (IIDig d2 (IDig d1))      = num (pot2as3 (pot1as2 (dn100 d2 d1))) ;
    digits2num                                (IIDig d3 (IIDig d2 (IDig d1)))     = num (pot2as3 (dn1000 d3 d2 d1)) ;
    digits2num                      (IIDig d4 (IIDig d3 (IIDig d2 (IDig d1))))    = num (dn1000000a d4 d3 d2 d1) ;
    digits2num            (IIDig d5 (IIDig d4 (IIDig d3 (IIDig d2 (IDig d1)))))   = num (dn1000000b d5 d4 d3 d2 d1) ;
    digits2num (IIDig d6 ((IIDig d5 (IIDig d4 (IIDig d3 (IIDig d2 (IDig d1))))))) = num (dn1000000c d6 d5 d4 d3 d2 d1) ;

fun num2digits : Numeral -> Digits ;
def num2digits (num x) = nd1000000 x ;

fun dn10 : Dig -> Sub10 ;
def dn10 D_1 = pot01 ;
    dn10 d1  = pot0 (dn d1) ;

fun dn100 : Dig -> Dig -> Sub100 ;
def dn100 D_0 d1  = pot0as1 (dn10 d1) ;
    dn100 D_1 D_0 = pot110 ;
    dn100 D_1 D_1 = pot111 ;
    dn100 D_1 d1  = pot1to19 (dn d1) ;
    dn100 d2  D_0 = pot1 (dn d2) ;
    dn100 d2  d1  = pot1plus (dn d2) (dn10 d1) ;

fun dn1000 : Dig -> Dig -> Dig -> Sub1000 ;
def dn1000 D_0 d2  d1  = pot1as2 (dn100 d2 d1) ;
    dn1000 d3  D_0 D_0 = pot2 (dn10 d3) ;
    dn1000 d3  d2  d1  = pot2plus (dn10 d3) (dn100 d2 d1) ;

fun dn1000000a : Dig -> Dig -> Dig -> Dig -> Sub1000000 ;
def dn1000000a D_0 d3  d2  d1  = pot2as3 (dn1000 d3 d2 d1) ;
    dn1000000a d4  D_0 D_0 D_0 = pot3 (pot1as2 (pot0as1 (dn10 d4))) ;
    dn1000000a d4  d3  d2  d1  = pot3plus (pot1as2 (pot0as1 (dn10 d4))) (dn1000 d3 d2 d1) ;

fun dn1000000b : Dig -> Dig -> Dig -> Dig -> Dig -> Sub1000000 ;
def dn1000000b D_0 d4  d3  d2  d1  = dn1000000a d4 d3 d2 d1 ;
    dn1000000b d5  d4  D_0 D_0 D_0 = pot3 (pot1as2 (dn100 d5 d4)) ;
    dn1000000b d5  d4  d3  d2  d1  = pot3plus (pot1as2 (dn100 d5 d4)) (dn1000 d3 d2 d1) ;

fun dn1000000c : Dig -> Dig -> Dig -> Dig -> Dig -> Dig -> Sub1000000 ;
def dn1000000c D_0 d5  d4  d3   d2   d1  = dn1000000b d5 d4 d3 d2 d1 ;
    dn1000000c d6  d5  d4  D_0  D_0  D_0 = pot3 (dn1000 d6 d5 d4) ;
    dn1000000c d6  d5  d4  d3   d2   d1  = pot3plus (dn1000 d6 d5 d4) (dn1000 d3 d2 d1) ;

fun dn : Dig -> Digit ;
def dn D_2 = n2 ;
    dn D_3 = n3 ;
    dn D_4 = n4 ;
    dn D_5 = n5 ;
    dn D_6 = n6 ;
    dn D_7 = n7 ;
    dn D_8 = n8 ;
    dn D_9 = n9 ;

fun nd10 : Sub10 -> Digits ;
def nd10 pot01     = IDig D_1 ;
    nd10 (pot0 d1) = IDig (nd d1) ;

fun nd100 : Sub100 -> Digits ;
def nd100 (pot0as1 d)    = nd10 d ;
    nd100 pot110         = IIDig D_1    (IDig D_0) ;
    nd100 pot111         = IIDig D_1    (IDig D_1) ;
    nd100 (pot1to19 d)   = IIDig D_1    (IDig (nd d)) ;
    nd100 (pot1 d)       = IIDig (nd d) (IDig D_0) ;
    nd100 (pot1plus d x) = IIDig (nd d) (nd10 x) ;

fun nd1000 : Sub1000 -> Digits ;
def nd1000 (pot1as2 x)    = nd100 x ;
    nd1000 (pot2 x)       = dconcat (nd10 x) (IIDig D_0 (IDig D_0)) ;
    nd1000 (pot2plus x y) = dconcat (nd10 x) (nd100 y) ;

fun nd1000000 : Sub1000000 -> Digits ;
def nd1000000 (pot2as3 x)    = nd1000 x ;
    nd1000000 (pot3 x)       = dconcat (nd1000 x) (IIDig D_0 (IIDig D_0 (IDig D_0))) ;
    nd1000000 (pot3plus x y) = dconcat (nd1000 x) (nd1000 y) ;

fun dconcat : Digits -> Digits -> Digits ;
def dconcat (IDig  d)    ys = IIDig d ys ;
    dconcat (IIDig d xs) ys = IIDig d (dconcat xs ys) ;

fun nd : Digit -> Dig ;
def nd n2 = D_2 ;
    nd n3 = D_3 ;
    nd n4 = D_4 ;
    nd n5 = D_5 ;
    nd n6 = D_6 ;
    nd n7 = D_7 ;
    nd n8 = D_8 ;
    nd n9 = D_9 ;

}