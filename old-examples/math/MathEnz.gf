--# -path=.:prelude

concrete MathEnz of Mathw = open Prelude in {

flags lexer = textlit ; unlexer = textlit ;

-- lincat Section ; Context ; Typ ; Obj ; Prop ; Proof ; Var ;

lin
  SDefObj cont obj typ df = 
    ss ("Definition" ++ "." ++ cont.s ++ 
        obj.s ++ "is" ++ "a" ++ typ.s ++ "," ++ "defined" ++ "as" ++ df.s ++ ".") ;  
  SDefProp cont prop df = 
    ss ("Definition" ++ "." ++ cont.s ++ "we" ++ "say" ++ 
        "that" ++ prop.s ++ "if" ++ df.s ++ ".") ;  
  SAxiom cont prop = 
    ss ("Axiom" ++ "." ++ cont.s ++ prop.s ++ ".") ;
  STheorem cont prop proof = 
    ss ("Theorem" ++ "." ++ cont.s ++ prop.s ++ "." ++ proof.s ++ ".") ;

  CEmpty = ss [] ;
  CObj vr typ co = ss ("let" ++ vr.s ++ "be" ++ "a" ++ typ.s ++ "." ++ co.s) ;
  CProp prop co = ss ("assume" ++ prop.s ++ "." ++ co.s) ;

  OVar v = v ;

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
