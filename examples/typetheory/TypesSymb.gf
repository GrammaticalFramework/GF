concrete TypesSymb of Types = open Prelude in {

-- Martin-Löf's set theory 1984, the polymorphic notation used in the book

lincat 
  Judgement = SS ;
  Set = SS ; 
  El = SS ;

-- Greek letters; latter alternative for easy input

flags coding = utf8 ;

oper
  capPi = "Π" | "Pi" ;
  capSigma = "Σ" | "Sigma" ;
  smallLambda = "λ" | "lambda" ;

lin
  JSet A = ss (A.s ++ ":" ++ "set") ;
  JElSet A a = ss (a.s ++ ":" ++ A.s) ;

  Plus A B = parenss (infixSS "+" A B) ;
  Pi A B = ss (paren (capPi ++ B.$0 ++ ":" ++ A.s) ++ B.s) ;
  Sigma A B = ss (paren (capSigma ++ B.$0 ++ ":" ++ A.s) ++ B.s) ;
  Falsum = ss "Ø" ;
  Nat = ss "N" ; 
  Id A a b = apply "I" A a b ;


oper
  apply = overload {
    apply : Str -> Str -> Str = \f,x -> f ++ paren x ;
    apply : Str -> SS -> SS = \f,x -> prefixSS f (parenss x) ;
    apply : Str -> SS -> SS -> SS = \f,x,y -> 
      prefixSS f (parenss (ss (x.s ++ "," ++ y.s))) ;
    apply : Str -> SS -> SS -> SS -> SS = \f,x,y,z -> 
      prefixSS f (parenss (ss (x.s ++ "," ++ y.s ++ "," ++ z.s))) ;
    apply : Str -> SS -> SS -> SS -> SS -> SS = \f,x,y,z,u -> 
      prefixSS f (parenss (ss (x.s ++ "," ++ y.s ++ "," ++ z.s ++ "," ++ u.s))) ;
    } ;

  binder = overload {
    binder : Str -> Str -> SS = \x,b ->
      ss (paren x ++ b) ;
    binder : Str -> Str -> Str -> SS = \x,y,b ->
      ss (paren x ++ paren y ++ b) ;
    } ;

lin 
  Funct A B = parenss (infixSS "->" A B) ;
  Prod A B = parenss (infixSS "x" A B) ;
  Neg A    = parenss (prefixSS "~" A) ;

  i _ _ a = apply "i" a ;
  j _ _ b = apply "j" b ;

  lambda _ _ b = ss (paren (smallLambda ++ b.$0) ++ b.s) ;

  pair _ _ a b = apply [] a b ;

  Zero = ss "0" ;
  Succ x = apply "s" x ;

  r _ = apply "r" ;

  D _ _ _ c d e = apply "D" c (binder d.$0 d.s) (binder e.$0 e.s) ;
  app _ _ = apply "app" ;
  p _ _ = apply "p" ;
  q _ _ = apply "q" ;

  E _ _ _ c d = apply "E" c (binder d.$0 d.$1 d.s) ;

  R0 _ = apply "R_0" ;

  Rec _ c d e = apply "R" c c (binder e.$0 e.$1 e.s) ;

  J _ _ a b c d = apply "J" a b c (binder d.$0 d.s) ;

}

