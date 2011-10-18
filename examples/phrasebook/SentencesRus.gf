concrete SentencesRus of Sentences = NumeralRus ** SentencesI - [
  NameNN, SHave, SHaveNo, SHaveNoMass, QDoHave, AHaveCurr
 ]  with 
  (Syntax = SyntaxRus),
--  (Symbolic = SymbolicRus),
  (Lexicon = LexiconRus), (Grammar = GrammarRus) ** open Prelude, SyntaxRus in {
    lin
      SHave p obj = mkS (mkCl (mkVP have_V3 obj p.name)) ;
      SHaveNo p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      SHaveNoMass p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      QDoHave p obj = mkQS (mkQCl (mkCl (mkVP have_V3 obj p.name))) ;

      AHaveCurr p curr = mkCl (mkVP have_V3 (mkNP aPl_Det curr) p.name) ;

}