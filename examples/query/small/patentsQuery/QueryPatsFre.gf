--# -path=.:..:alltenses

concrete QueryPatsFre of QueryPats = QueryFre ** open
    LexQueryPatsFre,
    ParadigmsFre,
    IrregFre,
    SyntaxFre,
    ExtraFre,
    (L=LangFre),
    Prelude
in {


--------------------------------------------------------
-- additions to the original query grammar 

lin

 SThe k = SyntaxFre.mkNP the_Det k ; 

 SMassSg k = SyntaxFre.mkNP k ;  

 QWho a = mkUtt (mkQCl whoSg_IP a) ; 
 
-- QWhen : Set -> Activity -> Query ;  

 QMass s = mkUtt s ; 

 QExist s =  mkUtt (L.ExistIP (L.IdetCN (L.IdetQuant what_IQuant L.NumPl) s))
              | mkUtt (mkNP all_NP (SyntaxFre.mkAdv about_Prep (mkNP s))) ;


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
  SimpDate = Adv ; 


lin
PQInfo drug = QInfo (DrugToSet drug) ;  
     
PQActive drug = 
      let ai : Kind = KRelSet active_ingredient_CN (DrugToSet drug) 
   in 
    basicPlur ai  ;
 

PQDosage drug = 
       let df : Kind = KRelSet dosage_form_CN (DrugToSet drug)          
   in 
    basicBoth df | QExist df ;
   

PQRoute drug = 
      let df : Kind = KRelSet route_of_administration_CN (DrugToSet drug)  
   in 
    basicBoth df | QExist df ;


PQPatentNo =  
      let bu : Query = basicPlur patent_number_CN 
        in 
  bu | QExist patent_number_CN ;
    

PQPatentDrug drug = 
        let df : Kind = KRelSet patent_number_Rel (DrugToSet drug)  
  in 
    basicSing df ;



PQPatentPat  patent = 
       let ai : Kind = KRelSet patent_number_Rel (PatentToSet patent) 
   in 
    basicSing ai ;


PQExpPat patent = 
       let 
          ai : Kind = KRelSet expiration_date_CN (PatentToSet patent) ;
          bu : Query = basicSing ai 
   in 
    bu ; 
  -- KAct when_IAdv (mkCl patent (mkVP expire_V))) ;


PQExpDrug drug = 
      let 
          ai : Kind = KRelSet expiration_date_CN (SThe (KRelSet patent_N (DrugToSet drug))) 
   in 
  basicSing ai ;
--   | mkUtt (mkQCl when_IAdv (mkCl (mkNP the_Art ai) (mkVP expire_V)));


PQUseCode patent = 
       let df : Kind = KRelSet use_code_CN (PatentToSet patent) 
  in 
   basicBoth df  ;


PQAppNumber patent = 
     let df : Kind = KRelSet application_number_CN (PatentToSet patent) 
  in 
  basicSing df  ;


PQApplicant patent = 
    let df : Kind = KRelSet applicant_CN (PatentToSet patent) ;
         bu : Query = basicSing df 
   in 
   bu ;
--   | mkUtt (mkQS (mkQCl whoSg_IP (mkVP (mkVP apply_V) (SyntaxFre.mkAdv for_Prep patent)))) 
--   | mkUtt (mkQS pastTense (mkQCl whoSg_IP (mkVP (mkVP apply_V) (SyntaxFre.mkAdv for_Prep patent))));


PQAppDayDrug drug =
    let df : Kind = KRelSet approval_date_CN (SThe (KRelSet patent_N (DrugToSet drug)))
    in 
     basicSing df  ; 

 
PQAppDayPat patent =
    let df : Kind = KRelSet approval_date_CN (PatentToSet patent) 
    in
     basicSing df  ;
 

PQAppDayPatApp patent applicant =
       let df : Kind = KRelSet approval_date_CN (SThe (KRelSet patent_with_N (SThe (KRelSet applicant_CN (AppToSet applicant))))) 
        in 
        basicSing df  ;


PQAppDayNo appno = 
     let df : Kind = KRelSet approval_date_CN (SThe (KRelSet  patent_with_N (SThe (KRelSet application_number_CN (AppNumToSet appno))))) 
   in 
     basicSing df ;

 
PQChemComp drug = 
     let 
         df : Kind = KRelSet chemical_substance_CN (DrugToSet drug) ;
         cc : Kind = KRelSet chemical_composition_CN (DrugToSet drug)         
   in 
    basicPlur df | basicSing cc ; 


PQCompounds  =
       let cc : Kind = KAct compound_CN (KRel drug_N)          
        in 
          basicPlur cc  ;


PQPrep = 
     basicPlur (KRel drug_preparation_CN)
   | QExist (KRel drug_preparation_CN) ;


PQDrugPrep drug = 
        let df : Kind = KRelSet drug_preparation_CN (DrugToSet drug) 
  in 
      basicSing df ;

-----

PQName drug = 
    let 
         df : CN = KRelSet name_N (DrugToSet drug) 
   in 
     basicSing df ;


PQNameApp applicant = 
        let   pt2 : Set = SIndef (KRelSet  patent_with_N (SThe (KRelSet applicant_CN applicant))) ;
              df : Kind = KRelSet drug_N pt2 
   in 
     basicSing df ; 

----
 
PQMethods patent = 
        let  pt1 : Kind = KProp (use_prop_V2 (PatentToSet patent)) (KRel method_N) ;
             pt2 : Kind = KRelSet method_N (PatentToSet patent) ;
             pt : Kind = pt1 | pt2               
   in 
    basicPlur pt ; 


PQDateMeth date  =  
       let pdate : Set = SAll (KAct (expire_V date) (KRel patent_N)) ;
            pt1 : Kind = KAct  (use_V2 pdate) (KRel method_N) ;
            pt2 : Kind = KProp (use_prop_V2 pdate) (KRel method_N) ;
            pt3 : Kind = KRelSet method_N pdate ;
             pt : Kind = pt1 | pt2 | pt3              
   in 
    basicPlur pt ;

 
PQMethNo appno = 
        let pdate : Set = SThe (KRelSet patent_with_N (SThe (KRelSet application_number_no_CN appno))) ;
           pt1 : Kind = KProp (use_prop_V2 (SThe (KRel patent_N))) (KRel method_N) ;
           pt2 : Kind = KRelSet method_N (SThe (KRel patent_N)) ;
           pt : Kind = pt1 | pt2               
   in 
     basicPlur pt ;

----

PQUse patent =   
   let df : Kind = KRelSet use_N (PatentToSet patent) 
  in 
    basicSing df ;   


PQUseDate date = 
       let pdate : Set =  SThe (KAct (approve_V2 date) (KRel patent_N))  ;
           pt : Kind = KRelSet use_N pdate              
   in 
     basicSing pt ;

PQDateUse date =
      let  patent : Kind = KRel patent_N ;
           pdate : Set = SAll (KProp (approve_prop_V2 date) patent) ;
           pt : Kind = KRelSet use_N pdate 
              
   in 
     basicPlur pt ;


PQUseDrug drug = 
    let df : Kind = KRelSet use_N (DrugToSet drug) 
   in 
      basicSing df  ;


PQUseChem chem = 
   let  drug : Kind = KAct (contain_V2 chem) (KRel drug_N) ;
        drugs : Set = SAll drug ;
        df : Kind = KRelSet use_N drugs         
   in 
     basicSing df  ;    


PQUseForm uform = 
   let  drug : Kind = KRelSet usage_form_CN (UsageToSet uform) ;
        drugs : Set = SAll drug ;
        df : Kind = KRelSet use_N drugs 
   in 
      basicSing df  ;

---

PQStrength drug =
    let df : Kind = KRelSet strength_N (DrugToSet drug) 
   in 
      basicSing df  ;
      

PQStrengthChem chem = 
   let  drug : Kind = KAct (contain_V2 chem) (KRel drug_N) ;
        drugs : Set = SAll drug ;
        df : Kind = KRelSet strength_N (DrugToSet drugs) 
  in 
     basicSing df  ; 

---

PQClaims  drug = 
       let cc : Kind =  KAct (mention_V2 drug) (mkCN claim_N) 
            in 
       basicPlur cc ;



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



 OnDate d = mkPatsDate on_Prep ;
 BeforeDate d = mkPatsDate before_Prep ;
 AfterDate d = mkPatsDate after_Prep ;

 oper mkPatsDate : Prep -> Adv = \prep -> SyntaxFre.mkAdv prep (mkNP (mkPN "DATE")) ;




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


}