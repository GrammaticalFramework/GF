--# -path=.:prelude

concrete ProofEng of Proof = FormulaSymb ** open Prelude, Precedence in {

  flags startcat=Text ; unlexer=text ; lexer = text ;

  lincat
    Text, Proof = {s : Str} ; 
    [Formula] = {s : Str ; isnil : Bool} ;

  lin
    Start prems concl proof = {
      s = ifNotNil (\p -> "Suppose" ++ p ++ ".") prems ++
          ["We will show that"] ++ useTop concl ++ "." ++
          proof.s
      } ; 

    Hypo = {
      s = new ++ ["But this holds trivially ."]
      } ;

    Implic prems concl proof = {
      s = new ++ ["It is enough to"] ++
          ifNotNil (\p -> "assume" ++ p ++ "and") prems ++
          "show" ++ concl.s ++ 
          "." ++
          proof.s ;
      } ;

    RedAbs form proof = 
      let neg = useTop (prefixR 4 "~" form) in {
      s = new ++ ["To that end , we will assume"] ++ 
          neg ++
          ["and show"] ++ "_|_" ++ 
          "." ++
          new ++ ["So let us assume that"] ++
          neg ++ 
          "." ++
          proof.s
      } ;

    ExFalso form = {
      s = new ++ ["Hence we get"] ++ 
          useTop form ++ ["as desired"] ++ 
          "." 
      } ;

    ConjSplit a b c proof = {
      s = new ++ ["So by splitting we get"] ++ 
          useTop a ++ "," ++ useTop b ++
          toProve c ++
          "." ++ 
          proof.s
      } ;

    ModPon prems concl proof = {
      s = new ++ ["Then , by Modus ponens , we get"] ++ prems.s ++
          toProve concl ++
          "." ++ 
          proof.s
      } ;

    Forget prems concl proof = {
      s = new ++ ["In particular we get"] ++ prems.s ++
          toProve concl ++
          "." ++ 
          proof.s
      } ;

--

    DeMorgan1 = \form, concl, proof -> {
      s = new ++ ["Then , by the first de Morgan's law , we get"] ++ useTop form ++
          toProve concl ++
          "." ++ 
          proof.s
      } ;

    DeMorgan2 = \form, concl, proof -> {
      s = new ++ ["Then , by the second de Morgan's law , we get"] ++ useTop form ++
          toProve concl ++
          "." ++ 
          proof.s
      } ;

    ImplicNeg forms concl proof = {
      s = new ++ ["By implication negation , we get"] ++ forms.s ++
          toProve concl ++
          "." ++ 
          proof.s
      } ;

    NegRewrite form forms proof = 
      let 
        neg  = useTop (prefixR 4 "~" form) ;
        impl = useTop (infixR 1 "->" form (constant "_|_")) ;
      in {
      s = new ++ ["Thus , by rewriting"] ++ 
          neg ++
          ifNotNil (\p -> ["we may assume"] ++ p ++ "and") forms ++ 
          "show" ++ impl ++ 
          "." ++
          proof.s
      } ;

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

    new = variants {"&-" ; []} ; -- unlexing and parsing, respectively

    toProve : PrecExp -> Str = \c -> 
      variants {
        [] ;                      -- for generation
        ["to prove"] ++ useTop c  -- for parsing
        } ;

}
