concrete NatAscii of Nat = {

lincat Nat = Str ;

lin zero   = "" ;
    succ n = "_" ++ n ;

lincat LT = Str ;
       NE = {} ;

lin zLT n = n ;
    sLT _ _ l = l ;

}