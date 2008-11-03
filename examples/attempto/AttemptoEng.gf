--# -path=.:present

concrete AttemptoEng of Attempto = SymbolsC ** AttemptoI with
  (Syntax = SyntaxEng),
  (Symbolic = SymbolicEng),
  (LexAttempto = LexAttemptoEng) ;

