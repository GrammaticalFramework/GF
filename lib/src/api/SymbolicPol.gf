--# -path=.:present

resource SymbolicPol = Symbolic with 
  (Symbol = SymbolPol),
  (Grammar = GrammarPol) ;
