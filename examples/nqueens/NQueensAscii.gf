concrete NQueensAscii of NQueens = NatAscii ** {

lincat Matrix, Vec = Str ;
       Constr, Sat = {} ;

lin nilV _ _ = "" ;
    consV _ j k _ _ v = j ++ "X" ++ k ++ "\n" ++ v ;

    matrix _ v = v ;

}