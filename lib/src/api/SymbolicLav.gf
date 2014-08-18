--# -path=.:../latvian:../common:../abstract:../prelude

resource SymbolicLav = Symbolic with
  (Symbol = SymbolLav),
  (Grammar = GrammarLav) ;
