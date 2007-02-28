--# -path=.:api:present:prelude:mathematical

concrete MathFre of Math = MathI with
  (Grammar = GrammarFre), 
  (Combinators = CombinatorsFre), 
  (Predication = PredicationFre), 
  (Lex = LexFre) ;
