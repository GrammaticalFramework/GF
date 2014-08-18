--# -path=.:../estonian:../common:../abstract:../prelude

resource SymbolicEst = Symbolic with 
  (Symbol = SymbolEst),
  (Grammar = GrammarEst) ;
