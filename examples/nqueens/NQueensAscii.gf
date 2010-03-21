concrete NQueensAscii of NQueens = NatAscii ** {

lincat Matrix, Vec = Str ;
       Constr, Sat = {} ;

lin nilV _ _ = "" ;
    consV _ _ f _ l _ v = f ++ "X" ++ l ++ "\n" ++ v ;

    matrix _ v = v ;

}