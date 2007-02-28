--# -path=.:api:present:prelude:mathematical

concrete MathEng of Math = MathI with
  (Grammar = GrammarEng), 
  (Combinators = CombinatorsEng), 
  (Predication = PredicationEng), 
  (Lex = LexEng) ;
