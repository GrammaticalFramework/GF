--# -path=.:alltenses

concrete QueryPatEng of QueryPat = QueryEng ** open
  SyntaxEng,
  LexPatsQueryEng,
  LangEng,
  ParadigmsEng
in {


--------------------------------------------------------
-- additions to the original query grammar 

lin

 SThe k = SyntaxEng.mkNP the_Det k ; 

 SMassSg k = SyntaxEng.mkNP k ;  

 QWho a = mkUtt (mkQCl whoSg_IP a) ; 
 
-- QWhen : Set -> Activity -> Query ;  

 QMass s = mkUtt s ; 


---------------------------------------------------------
-- from the patent query grammar 

lincat 
  Drug = NP ;
  Patent = NP ; 
  ChemicalSubstance = NP ;
  DrugUsageForm = NP ;
  PatentNumber = NP ;
  Applicant = NP ;
  ApplicationNumber = NP ;
  PatsDate = Adv ;  


lin
PQInfo drug = QInfo (DrugToSet drug) ;  
     
PQActive drug = 
      let 
          ai : Kind = KRelSet active_ingredient_CN (DrugToSet drug) 
   in 
    basicPlur ai  ;
 

PQDosage drug = 
       let 
         df : Kind = KRelSet dosage_form_CN (DrugToSet drug) 
         
   in 
   basicBoth df ;
 --  | mkUtt (ExistIP (IdetCN (IdetQuant what_IQuant NumPl) df)) ;
   

PQRoute drug = 
      let 
          df : Kind = KRelSet route_of_administration_CN (DrugToSet drug)  
   in 
   basicBoth df ;
--   | mkUtt (ExistIP (IdetCN (IdetQuant what_IQuant NumPl) df)) ;


PQPatentNo =  
      let bu : Query = basicPlur patent_number_CN 
        in 
  bu ;
--  | mkUtt (ExistIP (IdetCN (IdetQuant what_IQuant NumPl) patent_number_CN)) ;
    


PQPatentDrug drug = 
        let 
         df : Kind = KRelSet patent_number_Rel (DrugToSet drug)  
  in 
    basicSing df ;



PQPatentPat  patent = 
       let 
          ai : Kind = KRelSet patent_number_Rel (PatentToSet patent) 
   in 
    basicSing ai ;


PQExpPat patent = 
       let 
          ai : Kind = KRelSet expiration_date_CN (PatentToSet patent) ;
          bu : Query = basicSing ai 
   in 
    bu ;
--   | mkUtt (mkQCl when_IAdv (mkCl patent (mkVP expire_V))) ;


PQExpDrug drug = 
      let 
          ai : Kind = KRelSet expiration_date_CN (SThe (KRelSet patent_N (DrugToSet drug))) ;
          bu : Query = basicSing ai 
   in 
  bu ;
--   | mkUtt (mkQCl when_IAdv (mkCl (mkNP the_Art ai) (mkVP expire_V)));


PQUseCode patent = 
       let 
         df : Kind = KRelSet use_code_CN (PatentToSet patent) 
  in 
  basicBoth df  ;

PQAppNumber patent = 
     let 
         df : Kind = KRelSet application_number_CN (PatentToSet patent) 
  in 
  basicSing df  ;

PQApplicant patent = 
    let df : Kind = KRelSet applicant_CN (PatentToSet patent) ;
         bu : Query = basicSing df 
   in 
   bu ;
--   | mkUtt (mkQS (mkQCl whoSg_IP (mkVP (mkVP apply_V) (SyntaxEng.mkAdv for_Prep patent)))) 
--   | mkUtt (mkQS pastTense (mkQCl whoSg_IP (mkVP (mkVP apply_V) (SyntaxEng.mkAdv for_Prep patent))));

PQAppDayDrug drug =
    let 
         df : Kind = KRelSet approval_date_CN (SThe (KRelSet patent_N (DrugToSet drug)))
    in 
     basicSing df  ; 

 
PQAppDayPat patent =
    let 
         df : Kind = KRelSet approval_date_CN (PatentToSet patent) 
    in
     basicSing df  ;
 

--------------------------------------------------------------------------------
 oper basicSing : CN -> Utt =
    \df -> 
       let  sg_df : NP = SThe df ;
            massdf : NP = SMassSg df 
     in 
      QSet sg_df
   | QMass massdf
   | QMass sg_df ;
   

oper basicPlur : CN -> Utt = 
    \df -> 
       let  sg_df : NP = SAll df ;
            massdf : NP = SPlural df
     in 
      QInfo sg_df
   | QMass massdf
   | QMass sg_df ;
   
oper basicBoth : CN -> Utt = 
  \df ->
     let sg_df : NP = SThe df ;
          the_df : NP = SAll df ; 
          mass_sg_df : NP = SMassSg df ;
          mass_pl_df : NP = SPlural df
   in
     QInfo the_df 
   | QInfo sg_df
   | QMass mass_sg_df
   | QMass sg_df
   | QMass mass_pl_df
   | QMass the_df ;
 

{- use later as more options for QInfo

 | mkUtt (mkQCl (mkIP (mkIDet what_IQuant) information_N) (mkClSlash (mkNP youPl_Pron) (PatsAdvVPSlash (mkVPSlash have_V2) (SyntaxEng.mkAdv about_Prep drug))))    
  | mkUtt (mkQCl (mkIP (mkIDet what_IQuant) information_N) (mkClSlash (mkNP i_Pron) (SlashVV can_VV (PatsAdvVPSlash (mkVPSlash get_V2) (SyntaxEng.mkAdv about_Prep drug))))) 
  | mkUtt (mkNP all_Predet (massInfoSg (mkCN (mkCN information_N) (SyntaxEng.mkAdv about_Prep drug)))) 
  | mkUtt (mkNP all_NP (SyntaxEng.mkAdv about_Prep drug))       
  |  mkUtt  drug ;
-} 

--------------------------------------------------------------------------
-- coercions

lin DrugToSet d = d ; 
lin PatentToSet d = d ;
lin ChemToSet d = d ;
lin UsageToSet d = d ;
lin PatNumToSet d = d ; 
lin AppToSet d = d ;
lin AppNumToSet d = d ;
--lin DateToSet : PatsDate -> Set ;



--------------------------------------------------------------------------
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

oper mkPatsDate : Prep -> Adv = \prep -> SyntaxEng.mkAdv prep (mkNP (mkPN "DATE")) ;



}

