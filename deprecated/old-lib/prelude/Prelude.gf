--1 The GF Prelude

-- This file defines some prelude facilities usable in all grammars.

resource Prelude = open (Predef=Predef) in {

oper

--2 Strings, records, and tables

  SS  : Type = {s : Str} ;
  ss  : Str -> SS = \s -> {s = s} ;
  ss2 : (_,_ : Str) -> SS = \x,y -> ss (x ++ y) ;
  ss3 : (_,_ ,_: Str) -> SS = \x,y,z -> ss (x ++ y ++ z) ;

  cc2 : (_,_ : SS) -> SS = \x,y -> ss (x.s ++ y.s) ;
  cc3 : (_,_,_ : SS) -> SS = \x,y,z -> ss (x.s ++ y.s ++ z.s) ;

  SS1 : Type -> Type = \P -> {s : P => Str} ;
  ss1 : (A : Type) -> Str -> SS1 A = \A,s -> {s = table {_ => s}} ;

  SP1 : Type -> Type = \P -> {s : Str ; p : P} ;
  sp1 : (A : Type) -> Str -> A -> SP1 A = \_,s,a -> {s = s ; p = a} ;

  constTable : (A,B : Type) -> B -> A => B = \_,_,b -> \\_ => b ;
  constStr   : (A : Type) -> Str -> A => Str = \A -> constTable A Str ;

-- Discontinuous constituents.

  SD2 : Type = {s1,s2 : Str} ;
  sd2 : (_,_ : Str) -> SD2 = \x,y -> {s1 = x ; s2 = y} ;


--2 Optional elements

-- Missing form.

  nonExist : Str = variants {} ;

-- Optional string with preference on the string vs. empty.
 
  optStr : Str -> Str = \s -> variants {s ; []} ;
  strOpt : Str -> Str = \s -> variants {[] ; s} ;

-- Free order between two strings.

  bothWays : Str -> Str -> Str = \x,y -> variants {x ++ y ; y ++ x} ;

-- Parametric order between two strings.

  preOrPost : Bool -> Str -> Str -> Str = \pr,x,y -> 
    if_then_Str pr (x ++ y) (y ++ x) ;

--2 Infixes. prefixes, and postfixes

-- Fixes with precedences are defined in [Precedence Precedence.html].

  infixSS   : Str  -> SS -> SS -> SS = \f,x,y -> ss (x.s ++ f ++ y.s) ;
  prefixSS  : Str        -> SS -> SS = \f,x   -> ss (f ++ x.s) ;
  postfixSS : Str        -> SS -> SS = \f,x   -> ss (x.s ++ f) ;
  embedSS   : Str -> Str -> SS -> SS = \f,g,x -> ss (f ++ x.s ++ g) ;


--2 Booleans

 param Bool = True | False ;

oper
  if_then_else : (A : Type) -> Bool -> A -> A -> A = \_,c,d,e -> 
    case c of {
      True => d ;  ---- should not need to qualify
      False => e
     } ;

  andB : (_,_ : Bool) -> Bool = \a,b -> if_then_else Bool a b False ;
  orB  : (_,_ : Bool) -> Bool = \a,b -> if_then_else Bool a True b ;
  notB : Bool         -> Bool = \a   -> if_then_else Bool a False True ;

  if_then_Str : Bool -> Str -> Str -> Str = if_then_else Str ;

  onlyIf : Bool -> Str -> Str = \b,s -> case b of {
    True => s ;
    _ => nonExist
    } ;

-- Interface to internal booleans

  pbool2bool : Predef.PBool -> Bool = \b -> case b of {
    Predef.PFalse => False ; Predef.PTrue => True
    } ;

  init : Tok -> Tok = Predef.tk 1 ;
  last : Tok -> Tok = Predef.dp 1 ;

--2 High-level acces to Predef operations

  isNil : Tok -> Bool = \b -> pbool2bool (Predef.eqStr [] b) ;

  ifTok : (A : Type) -> Tok -> Tok -> A -> A -> A = \A,t,u,a,b -> 
    case Predef.eqStr t u of {Predef.PTrue => a ; Predef.PFalse => b} ;

--2 Lexer-related operations

-- Bind together two tokens in some lexers, either obligatorily or optionally

  oper 
    glue : Str -> Str -> Str = \x,y -> x ++ BIND ++ y ;
    glueOpt : Str -> Str -> Str = \x,y -> variants {glue x y ; x ++ y} ;
    noglueOpt : Str -> Str -> Str = \x,y -> variants {x ++ y ; glue x y} ;

-- Force capitalization of next word in some unlexers

    capitalize : Str -> Str = \s -> CAPIT ++ s ;

-- These should be hidden, and never changed since they are hardcoded in (un)lexers

    BIND : Str = "&+" ;
    PARA : Str = "&-" ;
    CAPIT : Str = "&|" ;

--2 Miscellaneous

-- Identity function

  id : (A : Type) -> A -> A = \_,a -> a ;

-- Parentheses

  paren : Str -> Str = \s -> "(" ++ s ++ ")" ;
  parenss : SS -> SS = \s -> ss (paren s.s) ;

-- Zero, one, two, or more (elements in a list etc)

param
  ENumber = E0 | E1 | E2 | Emore ;

oper
  eNext : ENumber -> ENumber = \e -> case e of {
    E0 => E1 ; E1 => E2 ; _ => Emore} ;


}
