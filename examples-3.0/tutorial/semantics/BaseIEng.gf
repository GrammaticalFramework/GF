--# -path=.:prelude:present:api:mathematical

concrete BaseIEng of Base = BaseI with
  (Syntax = SyntaxEng), 
  (Grammar = GrammarEng), 
  (G = GrammarEng), 
  (Symbolic = SymbolicEng), 
  (LexBase = LexBaseEng) ;
