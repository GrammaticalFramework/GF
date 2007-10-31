--# -path=.:prelude

concrete MathEnz of Mathw = open Prelude in {

flags lexer = textlit ; unlexer = textlit ;

-- lincat Section ; Label ; Context ; Typ ; Obj ; Prop ; Proof ; Var ;

lin
  SDefObj lab cont obj typ df = 
    ss ("Definition" ++ lab.s ++ "." ++ cont.s ++ 
        obj.s ++ "is" ++ "a" ++ typ.s ++ "," ++ "defined" ++ "as" ++ df.s ++ ".") ;  
  SDefProp lab cont prop df = 
    ss ("Definition" ++ lab.s ++ "." ++ cont.s ++ "we" ++ "say" ++ 
        "that" ++ prop.s ++ "to" ++ "mean" ++ "that" ++ df.s ++ ".") ;  
  SAxiom lab cont prop = 
    ss ("Axiom" ++ lab.s ++ "." ++ cont.s ++ prop.s ++ ".") ;
  STheorem lab cont prop proof = 
    ss ("Theorem" ++ lab.s ++ "." ++ cont.s ++ prop.s ++ "." ++ proof.s ++ ".") ;

  CEmpty = ss [] ;
  CObj vr typ co = ss ("let" ++ vr.s ++ "be" ++ "a" ++ typ.s ++ "." ++ co.s) ;
  CProp prop co = ss ("assume" ++ prop.s ++ "." ++ co.s) ;

  OVar v = v ;
  LNone = ss [] ;
  LString s = s ;
  VString s = s ;

  V_x = ss "x" ;
  V_y = ss "y" ;
  V_z = ss "z" ;

-- lexicon

  Set  = ss "set" ;
  Nat  = ss ["natural number"] ;
  Zero = ss "zero" ;
  Succ = prefixSS ["the successor of"] ;
  One  = ss "one" ;
  Two  = ss "two" ;
  Even = postfixSS ["is even"] ;
  Odd  = postfixSS ["is odd"] ;
  Prime = postfixSS ["is prime"] ;
  Divisible = infixSS ["is divisible by"] ;
  
}
