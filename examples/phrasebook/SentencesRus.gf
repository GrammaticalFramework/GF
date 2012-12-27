concrete SentencesRus of Sentences = NumeralRus ** SentencesI - [
  NameNN, SHave, SHaveNo, SHaveNoMass, QDoHave, AHaveCurr,
    IMale, IFemale, YouFamMale, YouFamFemale, YouPolMale, YouPolFemale
 ]  with 
  (Syntax = SyntaxRus),
  (Symbolic = SymbolicRus),
  (Lexicon = LexiconRus), (Grammar = GrammarRus) ** open Prelude, SyntaxRus, ExtraRus, (P = ParadigmsRus), (R = ResRus), (M = MorphoRus) in {
    lin
      SHave p obj = mkS (mkCl (mkVP have_V3 obj p.name)) ;
      SHaveNo p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      SHaveNoMass p obj = mkS (mkCl (mkVP have_not_V3 (mkNP obj) p.name)) ;
      QDoHave p obj = mkQS (mkQCl (mkCl (mkVP have_V3 obj p.name))) ;

      AHaveCurr p curr = mkCl (mkVP have_V3 (mkNP aPl_Det curr) p.name) ;

    lin
      NameNN = mkNP (P.mkN "NN") ;
      IMale = mkPerson (M.pronYa R.Masc) ;
      IFemale = mkPerson (M.pronYa R.Fem) ;
      YouFamMale = mkPerson (M.pronTu R.Masc) ;
      YouFamFemale = mkPerson (M.pronTu R.Fem) ;
      YouPolMale = mkPerson (M.pronVu R.Masc) ;
      YouPolFemale = mkPerson (M.pronVu R.Fem) ;

}