concrete SentencesDut of Sentences = NumeralDut ** SentencesI - 
  [SHaveNo,SHaveNoMass]
  with 
  (Syntax = SyntaxDut),
  (Symbolic = SymbolicDut),
  (Lexicon = LexiconDut) ** open Prelude, SyntaxDut in {

  lin 
    SHaveNo p k = mkS (mkCl p.name have_V2 (mkNP no_Quant plNum k)) ;
    SHaveNoMass p k = mkS (mkCl p.name have_V2 (mkNP no_Quant k)) ;

}

