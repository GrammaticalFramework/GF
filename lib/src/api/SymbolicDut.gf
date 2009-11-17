--# -path=.:present:mathematical:prelude

resource SymbolicDut = Symbolic with 
  (Symbol = SymbolDut),
  (Grammar = GrammarDut) ;
