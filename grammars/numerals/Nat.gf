-- Unary and binary natural numbers, and conversions between them. AR 8/10/2003
-- To be used as an example of transfer.

abstract Nat = {

  cat Nat ;
  fun 
    One : Nat ;              -- 1
    Succ : Nat -> Nat ;      -- n'
  data Nat = One | Succ ;

  cat Bin ; 
  fun 
    BOne   : Bin ;           -- 1
    BX     : Bin -> Bin ;    -- b 0
    BXPlus : Bin -> Bin ;    -- b 1
  data Bin = BOne | BX | BXPlus ;

  fun succ : Bin -> Bin ;
  def
    succ BOne = BX BOne ;
    succ (BX b) = BXPlus b ;
    succ (BXPlus BOne) = BX (BX BOne) ;
    succ b = succAux b (lastZero b) ;

  fun lastZero : Bin -> Nat ;
  def
    lastZero (BX _) = One ;
    lastZero (BXPlus b) = Succ (lastZero b) ;

  fun succAux : Bin -> Nat -> Bin ;
  def
    succAux (BXPlus b) One = BX (succ b) ;
    succAux (BXPlus b) (Succ n) = BX (succAux b n) ;
    succAux b _ = succ b ;

  -- this is the transfer function
  fun nat2bin : Nat -> Bin ;
  def
    nat2bin One = BOne ;
    nat2bin (Succ n) = succ (nat2bin n) ;

  -- and the other way round
  fun bin2nat : Bin -> Nat ;
  def 
    bin2nat BOne = One ;
    bin2nat (BX b) = double (bin2nat b) ;
    bin2nat (BXPlus b) = Succ (double (bin2nat b)) ;

  fun double : Nat -> Nat ;
  def  
    double One = Succ One ;
    double (Succ n) = Succ (Succ (double n)) ;

}
