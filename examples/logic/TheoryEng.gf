--# -path=.:mathematical:present:resource-1.0/api:prelude

concrete TheoryEng of Theory = TheoryI with
  (LexTheory = LexTheoryEng), 
  (Grammar = GrammarEng), 
  (Symbolic = SymbolicEng), 
  (Symbol = SymbolEng), 
  (Combinators = CombinatorsEng), 
  (Constructors = ConstructorsEng), 
  ;