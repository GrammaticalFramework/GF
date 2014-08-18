--# -path=.:../polish:../common:../abstract:../prelude

resource SymbolicPol = Symbolic with 
  (Symbol = SymbolPol),
  (Grammar = GrammarPol) ;
