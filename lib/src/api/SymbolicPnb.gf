--# -path=.:present:mathematical:prelude

resource SymbolicPnb = Symbolic with 
  (Symbol = SymbolPnb),
  (Grammar = GrammarPnb) ;
