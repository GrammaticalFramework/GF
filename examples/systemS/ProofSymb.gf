--# -path=.:prelude

concrete ProofSymb of Proof = FormulaSymb ** open Prelude, Precedence in {

  flags startcat=Text ; unlexer=text ; lexer = text ;

  lincat
    Text, Proof = {s : Str} ; 
    [Formula] = {s : Str ; isnil : Bool} ;

  lin
    Start prems concl = continue [] (task prems.s concl.s) ;

    Hypo = finish "Hypothesis" "Ø" ;

    Implic prems concl = continue ["Implication strategy"] (task prems.s concl.s) ;

    RedAbs form = continue ["Reductio ad absurdum"] (task neg abs)
      where { neg = useTop (prefixR 4 "~" form) } ;

    ExFalso form = finish (["Ex falso quodlibet"] ++ toProve form) "Ø" ; --- form

    ConjSplit a b c = 
      continue ["Conjunction split"] 
        (task (useTop a ++ "," ++ useTop b) (useTop c)) ;

    ModPon prems concl = continue ["Modus ponens"] (task prems.s concl.s) ;

    Forget prems concl = continue "Forgetting" (task prems.s concl.s) ;

--

    DeMorgan1 = \form, concl ->
      continue ["de Morgan 1"] (task form.s concl.s) ;
    DeMorgan2 = \form, concl ->
      continue ["de Morgan 2"] (task form.s concl.s) ;

    ImplicNeg forms concl = 
      continue ["Implication negation"] (task forms.s concl.s) ;

    NegRewrite form forms = 
      let 
        neg  = useTop (prefixR 4 "~" form) ;
        impl = useTop (infixR 1 "->" form (constant "_|_")) ;
      in 
      continue ["Negation rewrite"] (task forms.s impl) ;

--

    BaseFormula = {
      s = [] ; 
      isnil = True
      } ;

    ConsFormula f fs = {
      s = useTop f ++ ifNotNil (\p -> "," ++ p) fs ; 
      isnil = False
      } ;
    
  oper
    ifNotNil : (Str -> Str) -> {s : Str ; isnil : Bool} -> Str = \cons,prems ->
      case prems.isnil of {
         True  => prems.s ;
         False => cons prems.s
         } ;

    continue : Str -> Str -> {s : Str} -> {s : Str} = \label,task,proof -> {
      s = label ++ new ++ task ++ new ++ line ++ proof.s
      } ;

    finish : Str -> Str -> {s : Str} = \label,task -> {
      s = label ++ new ++ task 
      } ;

    task : Str -> Str -> Str = \prems,concl ->
      "[" ++ prems ++ "|-" ++ concl ++ "]" ;

    new = variants {"&-" ; []} ; -- unlexing and parsing, respectively

    line = "------------------------------" ;

    abs = "_|_" ;
 
    toProve : PrecExp -> Str = \c -> 
      variants {
        [] ;      -- for generation
        useTop c  -- for parsing
        } ;

}