concrete ArithmEng of Arithm = LogicEng ** open LogicResEng in {

lin
  Nat = {s = nomReg "number"} ;
  zero = ss "zero" ;
  succ = fun1 "successor" ;

  EqNat = adj2 ["equal to"] ;
  LtNat = adj2 ["smaller than"] ;
  Div   = adj2 ["divisible by"] ;
  Even  = adj1 "even" ;
  Odd   = adj1 "odd" ;
  Prime = adj1 "prime" ;

  one = ss "one" ;
  two = ss "two" ;
  sum = fun2 "sum" ;
  prod = fun2 "product" ;

  evax1 = ss ["by the first axiom of evenness , zero is even"] ;
  evax2 n c = {s = 
    c.s ++ [". By the second axiom of evenness , the successor of"] ++ 
    n.s ++ ["is odd"]} ;
  evax3 n c = {s = 
    c.s ++ [". By the third axiom of evenness , the successor of"] ++ 
    n.s ++ ["is even"]} ;
  eqax1 = ss ["by the first axiom of equality , zero is equal to zero"] ;
  eqax2 m n c = {s = 
    c.s ++ [". By the second axiom of equality , the successor of"] ++ m.s ++ 
    ["is equal to the successor of"] ++ n.s} ;
  IndNat C d e = {s = 
    ["we proceed by induction . For the basis ,"] ++ d.s ++ 
    [". For the induction step, consider a number"] ++ C.$0 ++ 
    ["and assume"] ++ C.s ++ "(" ++ e.$1 ++ ")" ++ "." ++ e.s ++ 
    ["Hence, for all numbers"] ++ C.$0 ++ "," ++ C.s} ;

  ex1 = ss ["The first theorem and its proof ."] ;

} ;

