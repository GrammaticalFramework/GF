--# -path=.:../basque:../common:../abstract:../prelude

resource SymbolicEus = Symbolic with 
  (Symbol = SymbolEus),
  (Grammar = GrammarEus) ;
