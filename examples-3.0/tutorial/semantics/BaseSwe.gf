--# -path=.:prelude:present:api:mathematical

concrete BaseSwe of Base = BaseI with
  (Syntax = SyntaxSwe), 
  (Grammar = GrammarSwe), 
  (G = GrammarSwe), 
  (Symbolic = SymbolicSwe), 
  (LexBase = LexBaseSwe) ;
