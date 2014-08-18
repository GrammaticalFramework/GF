--# -path=.:../finnish:../common:../abstract:../prelude

resource SymbolicFin = Symbolic with 
  (Symbol = SymbolFin),
  (Grammar = GrammarFin) ;
