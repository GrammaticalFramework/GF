--# -path=.:..:alltenses

concrete QueryPatEng of QueryPat = QueryPatI with 
  (Syntax = SyntaxEng),
  (Lang = LangEng),
  (LexPatsQuery = LexPatsQueryEng) **

open
  LexPatsQueryEng,
  ParadigmsEng,
  IrregEng,
  SyntaxEng,
  ExtraEng,
  (L = LangEng),
  (M = MakeStructuralEng),
  Prelude,
  QueryEng
in {

-- lexicon

oper mkDrug : Str -> NP = 
    \p -> mkNP  (mkPN p) ;

oper mkPatents : Str -> NP = 
   \p -> mkNP (mkPN p) ;

oper mkChemicalSubstance : Str -> NP = 
   \p -> mkNP (mkPN p) ;

oper mkDrugUsageForm : Str -> NP =
   \p -> mkNP (mkPN p) ;

oper  mkPatentNumber : Str -> NP = 
   \p -> mkNP (mkPN p) ;

oper  mkApplicant : Str -> NP = 
   \p -> mkNP (mkPN p) ;

oper  mkApplicationNumber : Str -> NP = 
   \p -> mkNP (mkPN p);




lin

Aspirin = mkDrug "DRUG" ;

Pats1230 = mkPatents "PATENT" ;

Hydrogen = mkChemicalSubstance "CHEMICAL_SUBSTANCE" ;

Inhalation = mkDrugUsageForm "DRUG_USAGE_FORM" ;

P123 = mkPatentNumber "PATENT_NUMBER" ;

JohnDoe = mkApplicant "APPLICANT" ;

A123 = mkApplicationNumber "APPLICATION_NUMBER" ;


 OnDate = mkPatsDate on_Prep ;
 BeforeDate  = mkPatsDate before_Prep ;
 AfterDate = mkPatsDate after_Prep ;

oper mkPatsDate : Prep -> Adv = \prep -> Syntax.mkAdv prep (mkNP (mkPN "DATE")) ;

}
