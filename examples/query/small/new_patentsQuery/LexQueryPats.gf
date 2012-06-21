interface LexQueryPats = open Syntax, QueryPats, Query in 
{

oper

-------------------------------------------------------------- 
-- structural words and extra grammar constructs

   about_Prep : Prep ;

   all_NP : NP ;

   vpAP : VP -> AP ;
   
   what_IQuant : IQuant ;

   massInfoSg : CN -> NP ;
 
   massInfoPl : CN -> NP ;
 
   PatsAdvVPSlash : VPSlash -> Adv -> VPSlash ;  

   selectIP : NP -> IP ; -- selecting the right agreement : what are the ingredients ? / what is the expiration date ? (not obvious in English, but will make a difference in other languages) 


--------------------------------------------------------------
-- kinds 

   patent_number_CN : Kind ;

   claim_N : Kind ;


--------------------------------------------------------------
-- activities 

   expire_V : Adv -> Activity ;

   simp_expire_V : Activity ;

   apply_V : NP -> Activity ;

   compound_CN : Activity ;
  
   use_V2 : Set -> Activity ;

   approve_V2 : Adv -> Activity ;
 
   mention_V2 : NP -> Activity ;

   contain_V2 : NP -> Activity ;


--------------------------------------------------------------
-- properties 

   approve_prop_V2 : Adv -> Property ;

   use_prop_V2 : Set -> Property ;

--------------------------------------------------------------
-- relations  
 
   active_ingredient_CN : Relation ;

   dosage_form_CN : Relation ;

   route_of_administration_CN : Relation ;

   patent_number_Rel : Relation ;  

   patent_N : Relation ;
  
   patent_with_N : Relation ;

   expiration_date_CN : Relation ;

   use_code_CN : Relation ;

   application_number_CN : Relation ;

   application_number_no_CN : Relation ;
  
   applicant_CN : Relation ;

   applicant_no_CN : Relation ;

   approval_date_CN : Relation ;

   chemical_composition_CN : Relation ;
 
   chemical_substance_CN : Relation ;

   drug_N : Relation ;
 
   use_N : Relation ;  

   method_N : Relation ;

   drug_with_usage_form_CN : Relation ;

   drug_preparation_CN : Relation ;
  
   strength_N : Relation ;

   name_N : Relation ;   
  
   usage_form_CN : Relation ; 


}