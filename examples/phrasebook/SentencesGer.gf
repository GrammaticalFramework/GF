concrete SentencesGer of Sentences = NumeralGer ** SentencesI - 
  [PYesToNo,SHaveNo,SHaveNoMass] with 
  (Syntax = SyntaxGer),
  (Symbolic = SymbolicGer),
  (Lexicon = LexiconGer) ** open Prelude, SyntaxGer in {

  lin 
    PYesToNo = mkPhrase (lin Utt (ss "doch")) ;
    SHaveNo p k = mkS (mkCl p.name have_V2 (mkNP no_Quant plNum k)) ;
    SHaveNoMass p k = mkS (mkCl p.name have_V2 (mkNP no_Quant k)) ;

}
