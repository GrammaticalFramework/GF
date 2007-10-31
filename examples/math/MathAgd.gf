--# -path=.:prelude

concrete MathAgd of Mathw = open Prelude in {

flags lexer = codelit ; unlexer = codelit ;

-- lincat Section ; Context ; Typ ; 
 lincat Obj, Prop = {s,name : Str} ;
-- Proof ; Var ;

lin
  SDefObj cont obj typ df = 
    ss (obj.name ++ "::" ++ cont.s ++ typ.s ++ 
        "=" ++ df.s ++ ";") ;  
  SDefProp cont prop df = 
    ss (prop.name ++ "::" ++ cont.s ++ "Prop" ++ 
        "=" ++ df.s ++ ";") ;  
  SAxiom cont prop = 
    ss ("ax" ++ "::" ++ cont.s ++ prop.s ++ ";") ;
  STheorem cont prop proof = 
    ss ("thm" ++ "::" ++ cont.s ++ prop.s ++ 
        "=" ++ proof.s ++ ";") ;  

  CEmpty = ss [] ;
  CObj vr typ co = ss ("(" ++ vr.s ++ "::" ++ typ.s ++ ")" ++ co.s) ;
  CProp prop co = ss ("(" ++ "_" ++ "::" ++ prop.s ++ ")" ++ co.s) ;

  OVar v = obj v.s [] ;

  V_x = ss "x" ;
  V_y = ss "y" ;
  V_z = ss "z" ;

oper
  obj : Str -> Str -> {s,name : Str} = \f,xs -> {
    s = f ++ xs ;
    name = f
  } ;

-- lexicon
lin
  Set  = ss "set" ;
  Nat  = ss ["Nat"] ;
  Zero = obj "Zero" [] ;
  Succ x = obj "Succ" x.s ;
  One  = obj "one" [] ;
  Two  = obj "two" [] ;
  Even x = obj "Even" x.s ;
  Odd x = obj "Odd" x.s ;
  Prime x = obj "Prime" x.s ;
  Divisible x y = obj "Div" (x.s ++ y.s) ;
  
}
