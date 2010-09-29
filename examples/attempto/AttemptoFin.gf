--# -path=.:present

concrete AttemptoFin of Attempto = NumeralFin, SymbolsC ** AttemptoI with
  (Syntax = SyntaxFin),
  (Symbolic = SymbolicFin),
  (LexAttempto = LexAttemptoFin) ;

