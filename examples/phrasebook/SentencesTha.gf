concrete SentencesTha of Sentences = NumeralTha ** SentencesI - [ACitizen] with 
  (Syntax = SyntaxTha),
  (Symbolic = SymbolicTha),
  (Lexicon = LexiconTha) ** open SyntaxTha, (P = ParadigmsTha), (R = ResTha) in {

lin
  ACitizen p n = mkCl p.name (mkVP (mkCN n (P.personN R.khon_s))) ;

}
