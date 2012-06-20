interface LexPatsQuery = Query ** open Syntax in {

oper
  giveMe : NP -> VP ;
  get_V2 : V2 ;
  want_V2 : V2 ;

-- structural words

   about_Prep : Prep ;

   all_NP : NP ;

-- basic common nouns 
 
  active_ingredient_CN : Relation ;

  dosage_form_CN : Relation ;

  route_of_administration_CN : Relation ;

  patent_number_CN : Kind ;
 
  patent_number_Rel : Relation ;

  patent_N : Relation ;
  
  expiration_date_CN : Relation ;

  expire_V : V ;

  use_code_CN : Relation ;

  application_number_CN : Relation ;

  apply_V : V ;
  
  applicant_CN : Relation ;

  approval_date_CN : Relation ;

  chemical_composition_CN : Relation ;
 
  chemical_substance_CN : Relation ;

  drug_N : N ;
 
  use_N : Relation ;  

  compound_CN : Relation ;
  
  use_V2 : V2 ;

  approve_V2 : V2 ;

  method_N : N ;

  usage_form_CN : Relation ;

  drug_preparation_CN : Relation ;

  vpAP : VP -> AP ;

  information_N : N ;
  
  strength_N : Relation ;

  claim_N : N ;
 
  mention_V2 : V2 ;

  what_IQuant : IQuant ;

  contain_V2 : V2 ;

  massInfoSg : CN -> NP ;
 
  massInfoPl : CN -> NP ;
  
  that_RP : RP ;

  PatsAdvVPSlash : VPSlash -> Adv -> VPSlash ;  

  selectIP : NP -> IP ; -- selecting the right agreement : what are the ingredients ? / what is the expiration date ? (not obvious in English, but will make a difference in other languages) 

}
