--# -path=.:present:mathematical:prelude

resource SymbolicPes = Symbolic with 
  (Symbol = SymbolPes),
  (Grammar = GrammarPes) ;
