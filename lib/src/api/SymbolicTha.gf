--# -path=.:../thai:../common:../abstract:../prelude

resource SymbolicTha = Symbolic with 
  (Symbol = SymbolTha),
  (Grammar = GrammarTha) ;
