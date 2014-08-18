--# -path=.:../russian:../common:../abstract:../prelude

resource SymbolicRus = Symbolic with 
  (Symbol = SymbolRus),
  (Grammar = GrammarRus) ;
