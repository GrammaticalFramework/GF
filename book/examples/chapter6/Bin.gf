abstract Bin = {

cat Nat ; Bin ; Pos ;

data 
  Zero : Nat ; 
  Succ : Nat -> Nat ;

  BZero : Bin ;         -- 0
  BPos  : Pos -> Bin ;  -- p
  BOne  : Pos ;         -- 1
  AZero : Pos -> Pos ;  -- p0
  AOne  : Pos -> Pos ;  -- p1

fun
  bin2nat : Bin -> Nat ;
def
  bin2nat BZero = Zero ;
  bin2nat (BPos p) = pos2nat p ;
fun 
  pos2nat : Pos -> Nat ;
def
  pos2nat BOne = one ;
  pos2nat (AZero p) = twice (pos2nat p) ;
  pos2nat (AOne  p) = Succ (twice (pos2nat p)) ;
fun one : Nat ;
def one = Succ Zero ;
fun twice : Nat -> Nat ;
def 
  twice Zero = Zero ;
  twice (Succ n) = Succ (Succ (twice n)) ;

fun
  nat2bin : Nat -> Bin ;
def
  nat2bin Zero = BZero ;
  nat2bin (Succ n) = bSucc (nat2bin n) ;
fun
  bSucc : Bin -> Bin ;
def
  bSucc BZero = BPos BOne ;
  bSucc (BPos p) = BPos (pSucc p) ;
fun
  pSucc : Pos -> Pos ;
def
  pSucc BOne = AZero BOne ;
  pSucc (AZero p) = AOne p ;
  pSucc (AOne p) = AZero (pSucc p) ;

}