--# -path=.:present

concrete QueryFre of Query = QueryI - 
  [namePrep, propCalled, SFun, SAll, IWhat] 
with 
  (Syntax = SyntaxFre),
  (Lang = LangFre),
  (LexQuery = LexQueryFre) **
open
  LexQueryFre,
  ParadigmsFre,
  IrregFre,
  SyntaxFre,
  ExtraFre,
  (L = LangFre),
  (M = MakeStructuralFre),
  Prelude
in {

-- deviations from functor
oper
-- prep not "av"
  namePrep = possess_Prep ;
-- verb "heta"
  propCalled : NP -> Prop = \i -> 
      propVP (mkVP (mkAdV "aussi") (mkVP (mkV2 (reflV (mkV "appeler"))) i)) ;

lin
  SAll k = mkNP all_Predet (mkNP thePl_Det k) | mkNP thePl_Det k ;
  SFun s r = mkNP (mkNP the_Quant plNum r.cn) (mkAdv r.prep s) ;
  IWhat = mkIP (mkIDet which_IQuant) | mkIP (mkIDet which_IQuant pluralNum) ;


-- lexicon

lin
  Located = relAP (mkAP located_A) in_Prep ;

  In = relVP useCopula in_Prep ;

  Employed = 
      relAP (mkAP (mkA "employé")) by8agent_Prep
    | relAP (mkAP (mkA "payé")) by8agent_Prep
    | relAP (mkAP (mkA "actif")) at_Prep
    | relAP (mkAP (mkA "professionnellement actif")) at_Prep
    | relVP (mkVP (mkV "travailler")) at_Prep
    ;

  HaveTitle = 
      relAP (mkAP (mkA "employé")) som_Prep
    | relVP useCopula noPrep
    | relVP (mkVP (mkV "travailler")) som_Prep
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "titre" masculine) noPrep)))) 
        possess_Prep
    ;

  EmployedAt s = 
      relAP (mkAP (mkA2 (mkA "employé") at_Prep) s) som_Prep
    | relAP (mkAP (mkA2 (mkA "employé") by8agent_Prep) s) som_Prep
    | relVP (mkVP (mkV2 (mkV "travailler") at_Prep) s) som_Prep 
    ;

  HaveTitleAt t = 
      relAP (mkAP (mkA2 (mkA "employé") som_Prep) (mkNP t)) at_Prep
    | relAP (mkAP (mkA2 (mkA "employé") som_Prep) (mkNP t)) by8agent_Prep
    | relVP (mkVP (mkNP a_Det t)) at_Prep
    | relVP (mkVP (mkV2 (mkV "travailler") som_Prep) (mkNP t)) at_Prep 
    | relVP (mkVP have_V2 (mkNP the_Det (mkCN (mkN2 (mkN "titre") noPrep) 
        (mkNP t)))) at_Prep 
    ;

  Named n = propAP  (mkAP (mkA2 called_A (mkPrep [])) n) ;
  Start n = propVP (mkVP (mkV2 (mkV "commencer") with_Prep) n) ;

  Organization = mkCN (mkN "organisation" feminine) ;
  Company = mkCN (mkN "entreprise") ;
  Place = mkCN (mkN "lieu") | mkCN (mkN "endroit") ;
  Person = 
      mkCN (mkN "personne")
    | mkCN (mkN "personne" "gens" feminine) ;

  Location = mkFunctionP (mkN "localité") possess_Prep ;
  Region = mkFunctionP (mkN "région" feminine) possess_Prep ;
  Subregion = mkFunctionP (mkN "sous-région" feminine) possess_Prep ;
  FName = mkFunctionP (mkN "nom") possess_Prep ;
  FNickname = mkFunctionP (mkN "surnom") possess_Prep ;
  FJobTitle = 
     mkFunctionP (mkN "titre" masculine) possess_Prep
   | mkFunctionP (mkN "position" feminine) possess_Prep ;

  SJobTitle t = mkNP a_Det t ;

oper
  mkCountry : Str -> Str -> {np : NP ; a : A} = 
    \n,a -> {np = mkNP (mkPN n) ; a = mkA a} ;

  mkName : Str -> NP = 
    \s -> mkNP (mkPN s) ;
  mkFunction : Str -> Fun =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;
  mkFunctionP : N -> Prep -> Fun =
    \n,p -> {cn = mkCN n ; prep = p} ;

  som_Prep = mkPrep "comme" ;

  noPrep = mkPrep [] ;

  useCopula = mkVP être_V ;

lin
-- JobTitles
  JobTitle1 = mkCN (mkN "'JobTitle1") ;
  JobTitle2 = mkCN (mkN "'JobTitle2") ;
  JobTitle3 = mkCN (mkN "'JobTitle3") ;
  JobTitle4 = mkCN (mkN "'JobTitle4") ;

-- Locations
  Location1 = mkName "'Location1" ;
  Location2 = mkName "'Location2" ;
  Location3 = mkName "'Location3" ;
  Location4 = mkName "'Location4" ;

-- Organizations
  Organization1 = mkName "'Organization1" ;
  Organization2 = mkName "'Organization2" ;
  Organization3 = mkName "'Organization3" ;
  Organization4 = mkName "'Organization4" ;

-- Persons
  Person1 = mkName "'Person1" ;
  Person2 = mkName "'Person2" ;
  Person3 = mkName "'Person3" ;
  Person4 = mkName "'Person4" ;

}
