--# -path=.:mathematical:present:resource-1.0/api:prelude

concrete ArithmEng of Arithm = LogicEng ** 
  open
    GrammarEng,
    ParadigmsEng,
    ProoftextEng,
    MathematicalEng,
    CombinatorsEng,
    ConstructorsEng
  in { 

lin
  Nat  = UseN  (regN "number") ;
  Zero = UsePN (regPN "zero") ;
  Succ = appN2 (regN2 "successor") ;

  EqNat x y = mkS (predA2 (mkA2 (regA "equal") (mkPrep "to")) x y) ;
  LtNat x y = mkS (predAComp (regA "equal") x y) ;
  Div   x y = mkS (predA2 (mkA2 (regA "divisible") (mkPrep "by")) x y) ;
  Even  x = mkS (predA (regA "even") x) ;
  Odd   x = mkS (predA (regA "odd") x) ;
  Prime x = mkS (predA (regA "prime") x) ;

  one = UsePN (regPN "one") ;
  two = UsePN (regPN "two") ;
  sum = appColl (regN2 "sum") ;
  prod = appColl (regN2 "product") ;

  evax1 = 
    proof (by (ref (mkLabel ["the first axiom of evenness ,"]))) 
      (mkS (pred (regA "even") (UsePN (regPN "zero")))) ;
  evax2 n c = 
    appendText c 
      (proof (by (ref (mkLabel ["the second axiom of evenness ,"]))) 
        (mkS (pred (regA "odd") (appN2 (regN2 "successor") n)))) ;
  evax3 n c = 
    appendText c 
      (proof (by (ref (mkLabel ["the third axiom of evenness ,"]))) 
        (mkS (pred (regA "even") (appN2 (regN2 "successor") n)))) ;


  eqax1 = 
    proof (by (ref (mkLabel ["the first axiom of equality ,"]))) 
      (mkS (predA2 (mkA2 (regA "equal") (mkPrep "to")) 
         (UsePN (regPN "zero")) 
         (UsePN (regPN "zero")))) ;

  eqax2 m n c = 
    appendText c 
      (proof (by (ref (mkLabel ["the second axiom of equality ,"]))) 
        (mkS (predA2 (mkA2 (regA "equal") (mkPrep "to")) 
          (appN2 (regN2 "successor") m) (appN2 (regN2 "successor") n)))) ;

  IndNat C d e = {s = 
    ["we proceed by induction . for the basis ,"] ++ d.s ++ 
    ["for the induction step, consider a number"] ++ C.$0 ++ 
    ["and assume"] ++ C.s ++ 
    --- "(" ++ e.$1 ++ ")" ++ 
    "." ++ e.s ++ 
    ["hence , for all numbers"] ++ C.$0 ++ "," ++ C.s ; lock_Text = <>} ;

  ex1 = proof ["the first theorem and its proof"] ;

} ;

