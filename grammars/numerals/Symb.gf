concrete Symb of Nat = open Prelude in {
  lincat Nat, Bin = SS ;

  lin 
    One = ss "1" ;
    Succ = postfixSS "'" ;

    BOne = ss "1" ;
    BX = postfixSS "0" ;
    BXPlus = postfixSS "1" ;
}

