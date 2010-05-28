concrete SentencesSwe of Sentences = NumeralSwe ** SentencesI - [PYesToNo,NameNN] with 
  (Syntax = SyntaxSwe),
  (Symbolic = SymbolicSwe),
  (Lexicon = LexiconSwe) ** open Prelude, SyntaxSwe, (P = ParadigmsSwe) in {

  lin PYesToNo = mkPhrase (lin Utt (ss "jo")) ;
  lin NameNN = mkNP (P.mkPN "NN") ;

}
