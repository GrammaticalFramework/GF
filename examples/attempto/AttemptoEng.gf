--# -path=.:present

concrete AttemptoEng of Attempto = SymbolsC,NumeralEng ** AttemptoI with
  (Syntax = SyntaxEng),
  (Symbolic = SymbolicEng),
  (LexAttempto = LexAttemptoEng) ;

