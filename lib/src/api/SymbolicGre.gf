--# -path=.:../greek:../common:../abstract:../prelude

resource SymbolicGre = Symbolic with 
  (Symbol = SymbolGre),
  (Grammar = GrammarGre) ;
