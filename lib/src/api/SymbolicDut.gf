--# -path=.:../dutch:../common:../abstract:../prelude

resource SymbolicDut = Symbolic with 
  (Symbol = SymbolDut),
  (Grammar = GrammarDut) ;
