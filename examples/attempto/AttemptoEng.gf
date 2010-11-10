--# -path=.:present

concrete AttemptoEng of Attempto = SymbolsC,NumeralEng ** AttemptoI - [which_RP] with
  (Syntax = SyntaxEng),
  (Symbolic = SymbolicEng),
  (LexAttempto = LexAttemptoEng) ** open SyntaxEng, ExtraEng in {

lin which_RP = SyntaxEng.which_RP | that_RP ;

} ;

