--# -path=.:present

concrete TestQuerySwe of TestQuery = QuerySwe **
open
  LexQuerySwe,
  ParadigmsSwe,
  IrregSwe,
  SyntaxSwe,
  ExtraSwe,
  (L = LangSwe),
  (M = MakeStructuralSwe),
  Prelude
in {

-- test lexicon

lin
  USA = mkCountry "USA" "amerikansk" ;
  Bulgaria = mkCountry "Bulgarien" "bulgarisk" ;
  California = mkCountry "Kalifornien" "Kalifornisk" ;
  OblastSofiya = mkName "Oblast Sofiya" ;

  CEO = mkCN (mkN "VD" "VD:ar") ;
  ChiefInformationOfficer = mkCN (mkN "chefsinformatör" "chefsinformatörer") ;

  Microsoft = mkName "Microsoft" ;
  Google = mkName "Google" ;

  SergeyBrin = mkName "Sergey Brin" ;
  LarryPage = mkName "Larry Page" ;
  EricSchmidt = mkName "Eric Schmidt" ;
  MarissaMayer = mkName "Marissa Mayer" ;
  UdiManber = mkName "Udi Manber" ;
  CarlGustavJung = mkName "Carl Gustav Jung" ;
  Jung = mkName "Jung" ;
  BenFried = mkName "Ben Fried" ;

}
