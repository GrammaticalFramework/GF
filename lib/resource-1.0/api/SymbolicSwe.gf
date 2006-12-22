--# -path=.:present:mathematical:prelude

resource SymbolicSwe = Symbolic with 
  (Symbol = SymbolSwe),
  (Grammar = GrammarSwe) ;
