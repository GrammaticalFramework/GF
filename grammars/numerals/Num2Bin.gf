transfer Num2Bin : Numerals -> Nat = {
  transfer Numeral = num2bin ;

  fun num2bin : Numeral -> Bin ;
  def num2bin n = num2nat (nat2bin n) ;

  fun 
    num2nat : Numeral -> Nat ;
    sub1000000_2nat : Sub1000000 -> Nat ;
    sub1000_2nat : Sub1000 -> Nat ;
    sub100_2nat : Sub100 -> Nat ;
    sub10_2nat : Sub10 -> Nat ;
    digit2nat : Digit -> Nat ;

  def 
    num2nat (num n) = sub1000000_2nat n ;
    ---
    sub1000000_2nat (pot2as3 n) = sub1000_2nat n ;
    ---
    sub1000_2nat (pot1as2 n) = sub100_2nat n ;
    ---
    sub100_2nat (pot0as1 n) = sub10_2nat n ;
    sub100_2nat (pot1 d) = tenTimes (digit2nat d) ;
    ---
    sub10_2nat (pot0 d) = digit2nat d ;

    digit2nat n2 = Succ One ;
    digit2nat n3 = Succ (digit2nat n2) ;
    digit2nat n4 = Succ (digit2nat n3) ;
    digit2nat n5 = Succ (digit2nat n4) ;
    digit2nat n6 = Succ (digit2nat n5) ;
    digit2nat n7 = Succ (digit2nat n6) ;
    digit2nat n8 = Succ (digit2nat n7) ;
    digit2nat n9 = Succ (digit2nat n8) ;

  fun 
    tenTimes : Nat -> Nat ;
    tenPlus, ninePlus : Nat -> Nat ;
  def 
    tenTimes One = ninePlus One ; -- the price to pay for starting from One
    tenTimes (Succ n) = tenPlus (tenTimes n) ;

    tenPlus n = Succ (ninePlus n) ;
    ninePlus n = Succ (double (double (double One))) ;
}
