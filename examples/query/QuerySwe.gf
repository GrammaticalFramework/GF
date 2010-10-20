--# -path=.:present

concrete QuerySwe of Query = QueryI - [namePrep, propCalled] with 
  (Syntax = SyntaxSwe),
  (Lang = LangSwe),
  (LexQuery = LexQuerySwe) **
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

-- deviations from functor
oper
-- prep not "av"
  namePrep = on_Prep ;
-- verb "heta"
  propCalled : NP -> Prop = \i -> 
      propVP (mkVP (mkAdV "även") (mkVP (mkV2 (depV (mkV "kalla")) for_Prep) i))
    | propVP (mkVP (mkAdV "även") (mkVP (mkV2 "heter") i)) ;



-- lexicon

lin
  Located = relAP (mkAP located_A) in_Prep ;

  In = relVP UseCopula in_Prep ;

  Employed = 
      relAP (mkAP (mkA "anställd" "anställt")) by8agent_Prep
    | relAP (mkAP (mkA "betald" "betalt")) by8agent_Prep
    | relAP (mkAP (mkA "aktiv")) at_Prep
    | relAP (mkAP (mkA "professionellt aktiv")) at_Prep
    | relVP (mkVP (mkV "arbeta")) at_Prep
    | relVP (mkVP (mkV "jobba")) at_Prep
    | relVP (mkVP (mkV "medarbeta")) at_Prep
    ;

  HaveTitle = 
      relAP (mkAP (mkA "anställd" "anställt")) as_Prep
    | relVP UseCopula noPrep
    | relVP (mkVP (mkV "arbeta")) as_Prep
    | relVP (mkVP (mkV "jobba")) as_Prep
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "titel" "titlar") noPrep)))) 
        possess_Prep
    ;

  EmployedAt s = 
      relAP (mkAP (mkA2 (mkA "anställd" "anställt") at_Prep) s) as_Prep
    | relAP (mkAP (mkA2 (mkA "anställd" "anställt") by8agent_Prep) s) as_Prep
    | relVP (mkVP (mkV2 (mkV "arbeta") at_Prep) s) as_Prep 
    | relVP (mkVP (mkV2 (mkV "jobba") at_Prep) s) as_Prep 
    ;

  HaveTitleAt t = 
      relAP (mkAP (mkA2 (mkA "anställd" "anställt") as_Prep) (mkNP t)) at_Prep
    | relAP (mkAP (mkA2 (mkA "anställd" "anställt") as_Prep) (mkNP t)) by8agent_Prep
    | relVP (mkVP (mkNP a_Det t)) at_Prep
    | relVP (mkVP (mkV2 (mkV "arbeta") as_Prep) (mkNP t)) at_Prep 
    | relVP (mkVP (mkV2 (mkV "jobba") as_Prep) (mkNP t)) at_Prep 
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "titel" "titlar") noPrep) 
        (mkNP t)))) at_Prep 
    ;

  Named n = propAP  (mkAP (mkA2 called_A (mkPrep [])) n) ;
  Start n = propVP (mkVP (mkV2 "börja" with_Prep) n) ;

  Organization = mkCN (mkN "organisation" "organisationer") ;
  Company = mkCN (mkN "företag" "företag") ;
  Place = mkCN (mkN "plats" "platser") | mkCN (mkN "ställe" "ställen") ;
  Person = 
      mkCN (mkN "person" "personen" "folk" "folket")
    | mkCN (mkN "person" "personer") ;

  Location = mkFunctionP (mkN "läge" "lägen") possess_Prep ;
  Region = mkFunctionP (mkN "region" "regioner") possess_Prep ;
  Subregion = mkFunctionP (mkN "delregion" "delregioner") possess_Prep ;
  FName = mkFunctionP (mkN "namn" "namn") on_Prep ;
  FNickname = mkFunctionP (mkN "tilläggsnamn" "tilläggsnamn") on_Prep ;
  FJobTitle = 
     mkFunctionP (mkN "jobb" "jobb") possess_Prep
   | mkFunction "befattning" ;

  SJobTitle t = mkNP a_Det t ;

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

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} = 
    \n,a -> {np = mkNP (mkPN n) ; a = mkA a} ;

  mkName : Str -> NP = 
    \s -> mkNP (mkPN s) ;
  mkFunction : Str -> Fun =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;
  mkFunctionP : N -> Prep -> Fun =
    \n,p -> {cn = mkCN n ; prep = p} ;

}
