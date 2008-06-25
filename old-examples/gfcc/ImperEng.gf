-- # -path=.:prelude
--# -path=.:../../lib/prelude

-- Toy English phrasing of C programs. Intended use is with 
-- speech synthesis. Printed code should use HTML formatting.
-- AR 5/10/2005.

concrete ImperEng of Imper = open Prelude, ResImperEng in {
  flags lexer=textvars ; unlexer=text ; startcat=Program ;

  lincat
    Rec = {s,s2,s3 : Str} ;

  lin
    Empty = ss [] ;
    FunctNil val stm cont = ss (
      ["The function"] ++ cont.$0 ++ 
      "returns" ++ indef ++ val.s ++ "." ++
      ["It is defined as follows :"] ++
      stm.s ++
      PARA ++ 
      cont.s) ;
    Funct args val rec = ss (
      ["The function"] ++ rec.$0 ++ 
      "takes" ++ rec.s2 ++ 
      "and" ++ "returns" ++ indef ++ val.s ++ "." ++
      ["It is defined as follows:"] ++
      rec.s ++ 
      PARA ++
      rec.s3) ;

    RecOne typ stm prg = stm ** {
      s2 = indef ++ typ.s ++ stm.$0 ;
      s3 = prg.s
      } ;
    RecCons typ _ body prg = {
      s  = body.s ; 
      s2 = indef ++ typ.s ++ body.$0 ++ "and" ++ body.s2 ;
      s3 = prg.s
      } ;

    Decl  typ cont = continues ("let" ++ cont.$0 ++ "be" ++ indef ++ typ.s) cont ;
    Assign _ x exp = continues ("set" ++ x.s ++ "to" ++ exp.s) ;
    While exp loop = continues (["if"] ++ exp.s ++ 
                                [", do the following :"] ++ loop.s ++ 
       ["test the condition and repeat the loop if the condition holds"]) ;
    IfElse exp t f = continue  ("if" ++ exp.s ++ [", then"] ++ t.s ++ "Else" ++ f.s) ;
    Block stm      = continue  (stm.s) ;
    Printf t e     = continues ("print" ++ e.s) ;
    Return _ exp   = statement ("return" ++ exp.s) ;
    Returnv        = statement ["return from the function"] ;
    End            = ss [] ;
 
    EVar  _ x  = constant x.s ;
    EInt    n  = constant n.s ;
    EFloat a b = constant (a.s ++ "." ++ b.s) ;
    EMul _ _   = prefix "product" ;
    EAdd _ _   = prefix "sum" ;
    ESub _ _ x y = ss (["the subtraction of"] ++ y.s ++ "from" ++  x.s) ;
    ELt _ _    = comparison "smaller" ;

    EAppNil val f = constant f.s ;
    EApp args val f exps = constant (f.s ++ ["applied to"] ++ exps.s) ;

    TInt    = {s = "integer"} ; 
    TFloat  = {s = "float"} ;
    NilTyp  = ss [] ;
    ConsTyp = cc2 ;
    OneExp _ e = e ;
    ConsExp _ _ e es = ss (e.s ++ "and" ++ es.s) ;
}
