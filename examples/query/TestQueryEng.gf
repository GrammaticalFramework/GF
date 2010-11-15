--# -path=.:present

concrete TestQueryEng of TestQuery = QueryEng **
open
  LexQueryEng,
  ParadigmsEng,
  IrregEng,
  SyntaxEng,
  ExtraEng,
  (L = LangEng),
  (M = MakeStructuralEng),
  Prelude
in {

-- test lexicon

lin
  USA = mkCountry "USA" "American" ;
  Bulgaria = mkCountry "Bulgaria" "Bulgarian" ;
  California = mkCountry "California" "Californian" ;
  OblastSofiya = mkName "Oblast Sofiya" ;

  CEO = mkCN (mkN "CEO") ;
  ChiefInformationOfficer = mkCN (mkN "Chief Information Officer") ;

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
