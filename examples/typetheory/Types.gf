abstract Types = {

-- Martin-Löf's set theory 1984

-- categories
cat 
  Set ; 
  El Set ;

-- basic forms of sets
data
  Plus   : Set -> Set -> Set ;
  Pi     : (A : Set) -> (El A -> Set) -> Set ;
  Sigma  : (A : Set) -> (El A -> Set) -> Set ;
  Falsum : Set ;
  Nat    : Set ; 
  Id     : (A : Set) -> (a,b : El A) -> Set ;

-- defined forms of sets
fun Impl : Set -> Set -> Set ;
def Impl A B = Pi A (\x -> B) ;

fun Conj : Set -> Set -> Set ;
def Conj A B = Sigma A (\x -> B) ;

fun Neg : Set -> Set ;
def Neg A = Impl A Falsum ;

-- constructors

data
  i : ({A,B} : Set) -> El A -> El (Plus A B) ;
  j : ({A,B} : Set) -> El B -> El (Plus A B) ;

  lambda : ({A} : Set) -> ({B} : El A -> Set) -> ((x : El A) -> El (B x)) -> El (Pi A B) ;

  pair : ({A} : Set) -> ({B} : El A -> Set) -> (x : El A) -> El (B x) -> El (Sigma A B) ;

  Zero : El Nat ;
  Succ : El Nat -> El Nat ;

  r : (A : Set) -> (a : El A) -> El (Id A a a) ;

-- selectors

fun D :  ({A,B} : Set) -> ({C} : El (Plus A B) -> Set) -> 
           (c : El (Plus A B)) -> 
           ((x : El A) -> El (C (i A B x))) -> 
           ((y : El B) -> El (C (j A B y))) -> 
             El (C c) ;
def 
  D _ _ _ (i _ _ a) d _ = d a ;
  D _ _ _ (j _ _ b) _ e = e b ;

fun app :  ({A} : Set) -> ({B} : El A -> Set) -> El (Pi A B) -> (a : El A) -> El (B a) ;
def app _ _ (lambda _ _ f) a = f a ;

fun
  p : ({A} : Set) -> ({B} : El A -> Set) -> (_ : El (Sigma A B)) -> El A ;
  q : ({A} : Set) -> ({B} : El A -> Set) -> (c : El (Sigma A B)) -> El (B (p A B c)) ;
def
  p _ _ (pair _ _ a _) = a ;
----  q _ _ (pair _ _ _ b) = b ; ---- doesn't compile yet AR 13/9/2011
----  q A B c = E A B (\z -> B (p A B z)) c (\x,y -> y) ; ---- neither does this: {x <> p A B (pair A B x y)}

fun E : ({A} : Set) -> ({B} : El A -> Set) -> ({C} : El (Sigma A B) -> Set) -> 
           (c : El (Sigma A B)) -> 
           ((x : El A) -> (y : El (B x)) -> El (C (pair A B x y))) -> 
             El (C c) ;
def E _ _ _ (pair _ _ a b) d = d a b ;

fun
  R0 : ({C} : El Falsum -> Set) -> (c : El Falsum) -> El (C c) ;

fun
  Rec : ({C} : El Nat -> Set) -> 
          (c : El Nat) -> 
          (El (C Zero)) -> 
          ((x : El Nat) -> (El (C x)) -> El (C (Succ x))) -> 
            El (C c) ;
def
  Rec _ Zero d _ = d ;
  Rec C (Succ x) d e = e x (Rec C x d e) ;

fun J : (A : Set) -> (a,b : El A) -> (C : (x,y : El A) -> El (Id A x y) -> Set) -> 
          (c : El (Id A a b)) -> 
          (d : (x : El A) -> El (C x x (r A x))) ->
            El (C a b c) ;
def J _ _ _ _ (r _ a) d = d a ;

-- tests

fun one : El Nat ;
def one = Succ Zero ;

fun two : El Nat ;
def two = Succ one ;

fun plus : El Nat -> El Nat -> El Nat ;
def plus a b = Rec (\x -> Nat) b a (\x,y -> Succ y) ;

fun times : El Nat -> El Nat -> El Nat ;
def times a b = Rec (\x -> Nat) b Zero (\x,y -> plus y x) ;

fun exp2 : El Nat -> El Nat ;  -- 2^x
def exp2 a = Rec (\x -> Nat) a one (\x,y -> plus y y) ;

fun fast : El Nat -> El Nat ;  -- fast (Succ x) = exp2 (fast x)
def fast a = Rec (\x -> Nat) a one (\_ -> exp2) ;

fun test : El Nat ;
def test = fast (fast two) ;

}