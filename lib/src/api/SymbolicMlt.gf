--# -path=.:../maltese:../common:../abstract:../prelude

resource SymbolicMlt = Symbolic with
  (Symbol = SymbolMlt),
  (Grammar = GrammarMlt) ;
