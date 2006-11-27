--# -path=.:mathematical:present:resource-1.0/api:prelude

instance ProoftextEng of Prooftext = 
  open 
    LexTheoryEng, 
    GrammarEng, 
    SymbolicEng, 
    SymbolEng, 
    (C=ConstructX),
    CombinatorsEng, 
    ConstructorsEng,
    (P=ParadigmsEng)
  in {

oper
  mkLabel : Str -> Label = \s -> UsePN (P.regPN s) ;


}
