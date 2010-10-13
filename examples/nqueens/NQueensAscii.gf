concrete NQueensAscii of NQueens = NatAscii ** {

lincat S, Matrix, Vec = Str ;
       ListNat, Sat = {} ;

lin queens m = m ;

lin nilV _ _ = "" ;
    consV _ j k _ _ v = j ++ "X" ++ k ++ ";" ++ v ;

    matrix _ v = v ;

}
