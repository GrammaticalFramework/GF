--# -path=.:..:alltenses

abstract QueryPats = Query ** open Syntax in {
-------------------------------------------------------------------------------------
-- additions to the general Query grammar


fun 
 
 SThe : Kind -> Set ; -- the route of administration

 SMassSg : Kind -> Set ; -- route of administration 

 QWho : Activity -> Query ; -- who applied for the patent ? 
 
-- QWhen : Set -> Activity -> Query ; -- when was the patent approved ? 

 QMass : Set -> Query ; -- expiration date of the patent
 
 QExist : Kind -> Query ; -- what dosage forms of DRUG are there ? 
  -- maybe merge with QSet

 


-------------------------------------------------------------------------------------
-- categories and example functions for the Patent Query grammar

cat 
  Drug ; 
  Patent ; 
  ChemicalSubstance ;
  DrugUsageForm ;
  PatentNumber ;
  Applicant ;
  ApplicationNumber ;
  PatsDate ;
  SimpDate ;

--------------------------------------------------------------------------------
-- simple coercions

fun DrugToSet : Drug -> Set ; 
fun PatentToSet : Patent -> Set ;
fun ChemToSet : ChemicalSubstance -> Set ;
fun UsageToSet : DrugUsageForm -> Set ;
fun PatNumToSet : PatentNumber -> Set ; 
fun AppToSet : Applicant -> Set ;
fun AppNumToSet : ApplicationNumber -> Set ;
--fun DateToSet : PatsDate -> Set ;


fun 
  OnDate : SimpDate ->  PatsDate ;
  BeforeDate : SimpDate -> PatsDate ;
  AfterDate : SimpDate ->  PatsDate ;
  FromSimpDate : SimpDate -> PatsDate ; 


-------------------------------------------------------------------------------------
-- main functions for the Patents Query grammar 

fun 

  PQInfo : Drug -> Query ; -- what information do you have about DRUG | give me all information about DRUG ...

  PQActive : Drug -> Query ; -- what active ingredients are in DRUG

  PQDosage : Drug -> Query ; -- what are the dosage forms of DRUG

  PQRoute : Drug -> Query ; -- what is the route of administration of DRUG

  PQPatentNo : Query ; -- give me all the patent numbers
  
  PQPatentDrug : Drug -> Query ; -- give me the patent number of DRUG
  
  PQPatentPat : Patent -> Query ; -- give me the patent number for PATENT

  PQExpPat : Patent -> Query ; -- when does PATENT expire
   
  PQExpDrug : Drug -> Query ;  -- when does the patent for DRUG expire
   
  PQUseCode : Patent -> Query ; -- what is the use code of PATENT
   
  PQAppNumber : Patent -> Query ; -- what is the application number for PATENT
  
  PQApplicant : Patent -> Query ; -- who applied for PATENT

  PQAppDayDrug : Drug -> Query ; -- what is the approval date of the patent for DRUG
  
  PQAppDayPat : Patent -> Query ; -- what is the approval date of PATENT
   
  PQAppDayPatApp : Patent -> Applicant -> Query ; -- what is the approval date of PATENT with APPLICANT

  PQAppDayNo : ApplicationNumber -> Query ; -- what is the approval date for the patent with APPLICATION_NUMBER
 
  PQChemComp : Drug -> Query ;  -- what is the chemical composition of DRUG

  PQCompounds : Query ; -- what are the drugs that are compounds

  PQPrep : Query ; -- what drug preparations are there  

  PQDrugPrep : Drug -> Query ; -- the drug preparation for DRUG

  PQPrepDate : Drug -> PatsDate -> Query ; -- the drug preparation for DRUG with a patent that expires after DATE

  PQName : Drug -> Query ; -- the name of DRUG
 
  PQNameDate : Drug -> PatsDate -> Query ;  -- the name of drug with approval date DATE

  PQNameApp : Applicant -> Query ; -- the name of drug with a patent from applicant APPLICANT

  PQMethods : Patent -> Query ; -- what methods are used for PATENT

  PQDateMeth : PatsDate -> Query ;  -- what methods are used in patents with approval date before DATE 

  PQMethNo : PatentNumber -> Query ; -- what methods are used in the patent with patent number PATENT_NUMBER

  PQUse : Patent -> Query ; -- what is the use of PATENT

  PQUseDate : PatsDate -> Query ; -- what is the use of PATENT approved before DATE

  PQUseExp : Patent -> PatsDate -> Query ; -- what is the use of PATENT that expires on DATE 
  
  PQDateUse : PatsDate -> Query ; -- give me all patents approved on DATE

  PQUseDrug : Drug -> Query ; -- what is the use of DRUG

  PQUseChem : ChemicalSubstance -> Query ; -- what is the use of drugs that contain CHEMICAL_SUBSTANCE 

  PQUseForm : DrugUsageForm -> Query ; -- what is the use of drugs with usage form DRUG_USAGE_FORM   

  PQStrength : Drug -> Query ; -- what is the strength of DRUG

  PQStrengthChem : ChemicalSubstance -> Query ; -- what is the strenght of drugs that contain CHEMICAL_SUBSTANCE

  PQClaims  : Drug -> Query ; -- what are the claims that mention DRUG 



fun 
---------------------
  Aspirin : Drug ;
---------------------
-- put all other drug names here !


---------------------
  Pats1230 : Patent ; 
---------------------
-- put all other patent names here !


---------------------
  Hydrogen : ChemicalSubstance ;
---------------------
-- put all chemical substances here !


--------------------
  Inhalation : DrugUsageForm ;
--------------------
-- put all drug usage forms here !



-------------------
  P123 : PatentNumber ;
-------------------
-- put all patent numbers here !



-------------------
  JohnDoe : Applicant ;
-------------------
-- put all applicants here !



-------------------
   A123 : ApplicationNumber ;
------------------
-- put all application numbers here


-------------------
   Today : PatsDate ;
   A20June : SimpDate ; 
-------------------
-- put all dates here (maybe use Date grammar instead)


}