concrete SentencesSwe of Sentences = NumeralSwe ** SentencesI - [
    PYesToNo,NameNN
    ---- , KindDrink  -- should be utrum gender when countable
 ] with 
  (Syntax = SyntaxSwe),
  (Symbolic = SymbolicSwe),
  (Lexicon = LexiconSwe) ** open Prelude, SyntaxSwe, (P = ParadigmsSwe) in {

  lin 
    PYesToNo = mkPhrase (lin Utt (ss "jo")) ;
    NameNN = mkNP (P.mkPN "NN") ;
----    KindDrink d = mkCN (P.mkN [] [] [] [] P.utrum) (lin Adv (mkUtt d)) ; --- an awful hack...
  
}
