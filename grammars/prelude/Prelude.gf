-- language-independent prelude facilities

resource Prelude = open (Predef = Predef) in {

oper
-- to construct records and tables
  SS  : Type = {s : Str} ;
  ss  : Str -> SS = \s -> {s = s} ;
  ss2 : (_,_ : Str) -> SS = \x,y -> ss (x ++ y) ;
  ss3 : (_,_ ,_: Str) -> SS = \x,y,z -> ss (x ++ y ++ z) ;

  cc2 : (_,_ : SS) -> SS = \x,y -> ss (x.s ++ y.s) ;

  SS1 : Type -> Type = \P -> {s : P => Str} ;
  ss1 : (A : Type) -> Str -> SS1 A = \A,s -> {s = table {_ => s}} ;

  SP1 : Type -> Type = \P -> {s : Str ; p : P} ;
  sp1 : (A : Type) -> Str -> A -> SP1 A = \_,s,a -> {s = s ; p = a} ;

  nonExist : Str = variants {} ;

  optStr : Str -> Str = \s -> variants {s ; []} ;

  constTable : (A,B : Type) -> B -> A => B = \_,_,b -> \\_ => b ;
  constStr   : (A : Type) -> Str -> A => Str = \A -> constTable A Str ;

  infixSS   : Str  -> SS -> SS -> SS = \f,x,y -> ss (x.s ++ f ++ y.s) ;
  prefixSS  : Str        -> SS -> SS = \f,x   -> ss (f ++ x.s) ;
  postfixSS : Str        -> SS -> SS = \f,x   -> ss (x.s ++ f) ;
  embedSS   : Str -> Str -> SS -> SS = \f,g,x -> ss (f ++ x.s ++ g) ;

-- discontinuous
  SD2 = {s1,s2 : Str} ;
  sd2 : (_,_ : Str) -> SD2 = \x,y -> {s1 = x ; s2 = y} ;

-- parentheses
  paren : Str -> Str = \s -> "(" ++ s ++ ")" ;
  parenss : SS -> SS = \s -> ss (paren s.s) ;

-- free order between two strings
  bothWays : Str -> Str -> Str = \x,y -> variants {x ++ y ; y ++ x} ;

-- parametric order between two strings
  preOrPost : Bool -> Str -> Str -> Str = \pr,x,y -> 
    if_then_else Str pr (x ++ y) (y ++ x) ;

-- Booleans

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


-- zero, one, two, or more (elements in a list etc)

param
  ENumber = E0 | E1 | E2 | Emore ;

oper
  eNext : ENumber -> ENumber = \e -> case e of {
    E0 => E1 ; E1 => E2 ; _ => Emore} ;

  -- these were defined in Predef before
  oper isNil : Tok -> Bool = \b -> pbool2bool (Predef.eqStr [] b) ;

  oper ifTok : (A : Type) -> Tok -> Tok -> A -> A -> A = \A,t,u,a,b ->
      case Predef.eqStr t u of {Predef.PTrue => a ; Predef.PFalse => b} ;

  -- so we need an interface
  oper pbool2bool : Predef.PBool -> Bool = \b -> case b of {
    Predef.PFalse => False ; Predef.PTrue => True
    } ;

-- bind together two tokens in the lexer, either obligatorily or optionally

  oper 
    bind : Str -> Str -> Str = \x,y -> x ++ "&+" ++ y ;
    bindOpt : Str -> Str -> Str = \x,y -> variants {bind x y ; x ++ y} ;
} ;
