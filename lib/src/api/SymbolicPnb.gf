--# -path=.:../punjabi:../common:../abstract:../prelude

resource SymbolicPnb = Symbolic with 
  (Symbol = SymbolPnb),
  (Grammar = GrammarPnb) ;
