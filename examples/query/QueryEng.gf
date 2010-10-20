--# -path=.:present

concrete QueryEng of Query = QueryI with 
  (Syntax = SyntaxEng),
  (Lang = LangEng),
  (LexQuery = LexQueryEng) **
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

-- lexicon

lin
  Located = relAP (mkAP located_A) in_Prep ;

  In = relVP UseCopula in_Prep ;

  Employed = 
      relAP (mkAP (mkA "employed")) by8agent_Prep
    | relAP (mkAP (mkA "paid")) by8agent_Prep
    | relAP (mkAP (mkA "active")) at_Prep
    | relAP (mkAP (mkA "professionally active")) at_Prep
    | relVP (mkVP (mkV "work")) at_Prep
    | relVP (mkVP (mkV "collaborate")) in_Prep
    ;

  HaveTitle = 
      relAP (mkAP (mkA "employed")) as_Prep
    | relVP UseCopula noPrep
    | relVP (mkVP (mkV "work")) as_Prep
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "title"))))) possess_Prep
    ;

  EmployedAt s = 
      relAP (mkAP (mkA2 (mkA "employed") at_Prep) s) as_Prep
    | relAP (mkAP (mkA2 (mkA "employed") by8agent_Prep) s) as_Prep
    | relVP (mkVP (mkV2 (mkV "work") at_Prep) s) as_Prep 
    ;

  HaveTitleAt t = 
      relAP (mkAP (mkA2 (mkA "employed") as_Prep) (mkNP t)) at_Prep
    | relAP (mkAP (mkA2 (mkA "employed") as_Prep) (mkNP t)) by8agent_Prep
    | relVP (mkVP (mkNP a_Det t)) at_Prep
    | relVP (mkVP (mkV2 (mkV "work") as_Prep) (mkNP t)) at_Prep 
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "title")) (mkNP t)))) at_Prep 
    ;

  Named n = propAP  (mkAP (mkA2 (mkA "named") []) n) ;
  Start n = propVP (mkVP (mkV2 "start" with_Prep) n) ;

  Organization = mkCN (mkN "organization") ;
  Company = mkCN (mkN "company") ;
  Place = mkCN (mkN "place") ;
  Person = 
      mkCN (mkN "person" "people")
    | mkCN (mkN "person") ;

  Location = mkFunction "location" ;
  Region = mkFunction "region" ;
  Subregion = mkFunction "subregion" | mkFunction "sub-region" ;
  FName = mkFunction "name" ;
  FNickname = mkFunction "nickname" ;
  FJobTitle = mkFunction "job title" | mkFunction "job" | mkFunction "position" |
    mkFunction "appointment" | mkFunction "job position" | mkFunction "mandate" |
    mkFunction "title" | mkFunction "capacity" ;

  SJobTitle t = mkNP a_Det t ;

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

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} = 
    \n,a -> {np = mkNP (mkPN n) ; a = mkA a} ;

  mkName : Str -> NP = 
    \s -> mkNP (mkPN s) ;
  mkFunction : Str -> Fun =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;


}
