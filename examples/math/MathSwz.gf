--# -path=.:prelude

concrete MathSwz of Math = open Prelude in {

flags lexer = textlit ; unlexer = textlit ;

-- lincat Section ; Label ; Context ; Typ ; Obj ; Prop ; Proof ; Var ;

lin
  SDefObj lab cont obj typ df = 
    ss ("Definition" ++ lab.s ++ "." ++ cont.s ++ 
        obj.s ++ "är" ++ "ett" ++ typ.s ++ "," ++ "definierat" ++ "som" ++ df.s ++ ".") ;  
  SDefProp lab cont prop df = 
    ss ("Definition" ++ lab.s ++ "." ++ cont.s ++ "vi" ++ "säger" ++ 
        "att" ++ prop.s ++ "vilket" ++ "menar" ++ "att" ++ df.s ++ ".") ;  
  SAxiom lab cont prop = 
    ss ("Axiom" ++ lab.s ++ "." ++ cont.s ++ prop.s ++ ".") ;
  STheorem lab cont prop proof = 
    ss ("Theorem" ++ lab.s ++ "." ++ cont.s ++ prop.s ++ "." ++ proof.s ++ ".") ;

  CEmpty = ss [] ;
  CObj vr typ co = ss ("låt" ++ vr.s ++ "vara" ++ "ett" ++ typ.s ++ "." ++ co.s) ;
  CProp prop co = ss ("anta" ++ "att" ++ prop.s ++ "." ++ co.s) ;

  OVar v = v ;
  LNone = ss [] ;
  LString s = s ;
  VString s = s ;

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
