concrete NQueensAscii of NQueens = NatAscii ** {

lincat Matrix, Vec = Str ;
       ListNat, Sat = {} ;

lin nilV _ _ = "" ;
    consV _ j k _ _ v = j ++ "X" ++ k ++ ";" ++ v ;

    matrix _ v = v ;

}
