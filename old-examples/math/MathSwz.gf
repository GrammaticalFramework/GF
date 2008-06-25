--# -path=.:prelude

concrete MathSwz of Mathw = open Prelude in {

flags lexer = textlit ; unlexer = textlit ;

-- lincat Section ; Context ; Typ ; Obj ; Prop ; Proof ; Var ;

lin
  SDefObj cont obj typ df = 
    ss ("Definition" ++ "." ++ cont.s ++ 
        obj.s ++ "är" ++ "ett" ++ typ.s ++ "," ++ "definierat" ++ "som" ++ df.s ++ ".") ;  
  SDefProp cont prop df = 
    ss ("Definition" ++ "." ++ cont.s ++ "vi" ++ "säger" ++ 
        "att" ++ prop.s ++ "om" ++ df.s ++ ".") ;  
  SAxiom cont prop = 
    ss ("Axiom" ++ "." ++ cont.s ++ prop.s ++ ".") ;
  STheorem cont prop proof = 
    ss ("Theorem" ++ "." ++ cont.s ++ prop.s ++ "." ++ proof.s ++ ".") ;

  CEmpty = ss [] ;
  CObj vr typ co = ss ("låt" ++ vr.s ++ "vara" ++ "ett" ++ typ.s ++ "." ++ co.s) ;
  CProp prop co = ss ("anta" ++ "att" ++ prop.s ++ "." ++ co.s) ;

  OVar v = v ;

  V_x = ss "x" ;
  V_y = ss "y" ;
  V_z = ss "z" ;

-- lexicon

  Set  = ss "mängd" ;
  Nat  = ss ["naturligt tal"] ;
  Zero = ss "noll" ;
  Succ = prefixSS ["efterföljaren till"] ;
  One  = ss "ett" ;
  Two  = ss "två" ;
  Even = postfixSS ["är jämnt"] ;
  Odd  = postfixSS ["är udda"] ;
  Prime = postfixSS ["är ett primtal"] ;
  Divisible = infixSS ["är delbart med"] ;

}
