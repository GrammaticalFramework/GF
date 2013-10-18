--# -path=.:present:mathematical:prelude

resource SymbolicEst = Symbolic with 
  (Symbol = SymbolEst),
  (Grammar = GrammarEst) ;
