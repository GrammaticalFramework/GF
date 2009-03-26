-- operations for precedence-dependent strings.
-- five levels: 
-- p4 (constants), p3 (applications), p2 (products), p1 (sums), p0 (arrows)

resource Precedence = open Prelude in {

param 
Prec = p4 | p3 | p2 | p1 | p0 ;

oper 
PrecTerm : Type = Prec => Str ;

oper 
pss : PrecTerm -> {s : PrecTerm} = \s -> {s = s} ;


-- change this if you want some other type of parentheses
mkParenth : Str -> Str = \str -> "(" ++ str ++ ")" ;

-- define ordering of precedences
nextPrec : Prec => Prec =
  table {p0 => p1 ; p1 => p2 ; p2 => p3 ; _ => p4} ;
prevPrec : Prec => Prec =
  table {p4 => p3 ; p3 => p2 ; p2 => p1 ; _ => p0} ;

mkPrec : Str -> Prec => Prec => Str = \str ->
  table {
    p4 => table {                -- use the term of precedence p4...
      _   => str} ;              -- ...always without parentheses
    p3 => table {                -- use the term of precedence p3...
      p4  => mkParenth str ;     -- ...in parentheses if p4 is required...
      _   => str} ;              -- ...otherwise without parentheses
    p2 => table {
      p4  => mkParenth str ;
      p3  => mkParenth str ;
      _   => str} ;              
    p1 => table {
      p1  => str ;
      p0  => str ;
      _   => mkParenth str} ;
    p0 => table {
      p0  => str ;
      _   => mkParenth str}
        } ;

-- make a string into a constant, of precedence p4
mkConst : Str -> PrecTerm = 
  \f -> 
  mkPrec f ! p4 ;

-- make a string into a 1/2/3 -place prefix operator, of precedence p3
mkFun1 : Str -> PrecTerm -> PrecTerm = 
  \f -> \x ->
  table {k => mkPrec (f ++ x ! p4) ! p3 ! k} ;
mkFun2 : Str -> PrecTerm -> PrecTerm -> PrecTerm = 
  \f -> \x -> \y ->
  table {k => mkPrec (f ++ x ! p4 ++ y ! p4) ! p3 ! k} ;
mkFun3 : Str -> PrecTerm -> PrecTerm -> PrecTerm -> PrecTerm = 
  \f -> \x -> \y -> \z ->
  table {k => mkPrec (f ++ x ! p4 ++ y ! p4 ++ z ! p4) ! p3 ! k} ;

-- make a string into a non/left/right -associative infix operator, of precedence p
mkInfix : Str -> Prec -> PrecTerm -> PrecTerm -> PrecTerm = 
  \f -> \p -> \x -> \y ->
  table {k => mkPrec (x ! (nextPrec ! p) ++ f ++ y ! (nextPrec ! p)) ! p ! k} ;
mkInfixL : Str -> Prec -> PrecTerm -> PrecTerm -> PrecTerm = 
  \f -> \p -> \x -> \y ->
  table {k => mkPrec (x ! p ++ f ++ y ! (nextPrec ! p)) ! p ! k} ;
mkInfixR : Str -> Prec -> PrecTerm -> PrecTerm -> PrecTerm = 
  \f -> \p -> \x -> \y ->
  table {k => mkPrec (x ! (nextPrec ! p) ++ f ++ y ! p) ! p ! k} ;

-----------------------------------------------------------

-- alternative:
-- precedence as inherent feature

oper TermWithPrec : Type = {s : Str ; p : Prec} ;

oper 
mkpPrec : Str -> Prec -> TermWithPrec =
  \f -> \p ->
  {s = f ; p = p} ;

usePrec : TermWithPrec -> Prec -> Str =
  \x -> \p ->
  mkPrec x.s ! x.p ! p ;

-- make a string into a constant, of precedence p4
mkpConst : Str -> TermWithPrec = 
  \f -> 
  mkpPrec f p4 ;

-- make a string into a 1/2/3 -place prefix operator, of precedence p3
mkpFun1 : Str -> TermWithPrec -> TermWithPrec = 
  \f -> \x ->
  mkpPrec (f ++ usePrec x p4) p3 ;

mkpFun2 : Str -> TermWithPrec -> TermWithPrec -> TermWithPrec = 
  \f -> \x -> \y ->
  mkpPrec (f ++ usePrec x p4 ++ usePrec y p4) p3 ;

mkpFun3 : Str -> TermWithPrec -> TermWithPrec -> TermWithPrec -> TermWithPrec = 
  \f -> \x -> \y -> \z ->
  mkpPrec (f ++ usePrec x p4 ++ usePrec y p4 ++ usePrec z p4) p3 ;

-- make a string a into non/left/right -associative infix operator, of precedence p
mkpInfix : Str -> Prec -> TermWithPrec -> TermWithPrec -> TermWithPrec = 
  \f -> \p -> \x -> \y ->
  mkpPrec (usePrec x (nextPrec ! p) ++ f ++ usePrec y (nextPrec ! p)) p ;
mkpInfixL : Str -> Prec -> TermWithPrec -> TermWithPrec -> TermWithPrec = 
  \f -> \p -> \x -> \y ->
  mkpPrec (usePrec x p ++ f ++ usePrec y (nextPrec ! p)) p ;
mkpInfixR : Str -> Prec -> TermWithPrec -> TermWithPrec -> TermWithPrec = 
  \f -> \p -> \x -> \y ->
  mkpPrec (usePrec x (nextPrec ! p) ++ f ++ usePrec y p) p ;
} ;
