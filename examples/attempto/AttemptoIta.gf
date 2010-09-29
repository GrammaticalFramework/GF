--# -path=.:present

concrete AttemptoIta of Attempto = NumeralIta, SymbolsC ** AttemptoI with
  (Syntax = SyntaxIta),
  (Symbolic = SymbolicIta),
  (LexAttempto = LexAttemptoIta) ;

