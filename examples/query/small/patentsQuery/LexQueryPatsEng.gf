instance LexQueryPatsEng of LexQueryPats = open
  SyntaxEng,
  (M=MakeStructuralEng),
  ParadigmsEng,
  ExtraEng,
  IrregEng, 
  LangEng,
  ResEng,
  QueryEng
   in 
{

oper 
-------------------------------------------------------------- 
-- structural words and extra grammar constructs

   about_Prep : Prep  = mkPrep "about" ;

   all_NP : NP = SyntaxEng.mkNP (mkPN "all") ;

   vpAP : VP -> AP = PartVP ;
   
   what_IQuant : IQuant = M.mkIQuant "what" "what" ;

   massInfoSg : CN -> NP = \cn -> SyntaxEng.mkNP cn ;
 
   massInfoPl : CN -> NP = \cn -> SyntaxEng.mkNP aPl_Det cn ;
 
   PatsAdvVPSlash : VPSlash -> Adv -> VPSlash = LangEng.AdvVPSlash ;  

   selectIP : NP -> IP = \np -> case np.a of 
     {AgP3Sg _ => whatSg_IP ;
      _        => whatPl_IP
     };


--------------------------------------------------------------
-- kinds 

   patent_number_CN : Kind = lin Kind  (mkCN (mkN "patent" (mkN "number"))) ;

   claim_N : Kind = lin Kind (mkCN (mkN "claim")) ;

 
--------------------------------------------------------------
-- activities 

   expire_V : Adv -> Activity = \pdate -> 
        lin Activity (mkVP (mkVP (mkV "expire")) pdate) ;

   simp_expire_V : Activity =  
        lin Activity (mkVP (mkV "expire")) ;

   apply_V : NP -> Activity = \pat ->  lin Activity ( mkVP (mkVP (mkV "apply" "applies" "applied" "applied" "applying")) (SyntaxEng.mkAdv for_Prep pat)) ;

   compound_CN : Activity = let vp : VP = mkVP (mkCN (mkN "compound"))
            in  lin Activity vp ;
  
   use_V2 : Set -> Activity = \s -> lin Activity (mkVP (passiveVP (mkV2 (mkV "use" "uses" "used" "used" "using"))) (SyntaxEng.mkAdv in_Prep s));

   approve_V2 : Adv -> Activity = \pdate -> lin Activity (mkVP (passiveVP (mkV2 (mkV "approve" "approves" "approved" "approved" "approving"))) pdate) ;
 
   mention_V2 : NP -> Activity = \drug -> 
    lin Activity ( mkVP (mkVPSlash (mkV2 (mkV "mention" "mentions" "mentioned" "mentioned" "mentioning"))) drug) ;

   contain_V2 : NP -> Activity  = \chem ->
    lin Activity (mkVP (mkVPSlash (mkV2 (mkV "contain" "contains" "contained" "contained" "containing"))) chem) ;


--------------------------------------------------------------
-- properties 

   approve_prop_V2 : Adv -> Property  = \pdate -> lin Property (vpAP (mkVP (passiveVP (mkV2 (mkV "approve" "approves" "approved" "approved" "approving"))) pdate)) ;

   use_prop_V2 : Set -> Property = \s -> lin Property (vpAP (mkVP (passiveVP (mkV2 (mkV "use" "uses" "used" "used" "using"))) (SyntaxEng.mkAdv in_Prep s))) ;
  
  

--------------------------------------------------------------
-- relations  
 
   active_ingredient_CN : Relation = makeRelation (mkCN (mkA "active")  (mkN "ingredient")) ;

   dosage_form_CN : Relation = makeRelation (mkCN (mkN "dosage" (mkN "form"))) ;

   route_of_administration_CN : Relation = makeRelation (mkCN (mkN "route") (SyntaxEng.mkAdv (mkPrep "of") (SyntaxEng.mkNP (mkN "administration")))) ;

   patent_number_Rel : Relation  = makeRelation (mkCN (mkN "patent" (mkN "number"))) ;

   patent_N : Relation = lin Relation {cn = mkCN (mkN "patent") ; prep = for_Prep } ;
  
   patent_with_N : Relation = lin Relation {cn = mkCN (mkN "patent"); prep = with_Prep} ;

   expiration_date_CN : Relation  = makeRelation (mkCN (mkN "expiration" (mkN "date"))) ;

   use_code_CN : Relation = makeRelation (SyntaxEng.mkCN (mkN "use" (mkN "code"))) ; 

   application_number_CN : Relation  = makeRelation ((mkCN (mkN "application" (mkN  "number"))) | (mkCN (mkN ["patent application"] (mkN  "number")))) ;


   application_number_no_CN : Relation  = lin Relation {cn = ((mkCN (mkN "application" (mkN  "number"))) | (mkCN (mkN ["patent application"] (mkN  "number")))); prep = noPrep} ;
  
   applicant_CN : Relation = lin Relation { cn = mkCN (mkN "applicant") ; prep = for_Prep } ;


   applicant_no_CN : Relation = lin Relation {cn = mkCN (mkN "applicant"); prep = noPrep} ;

   approval_date_CN : Relation = makeRelation (mkCN (mkN "approval" (mkN "date"))) ;


   chemical_composition_CN : Relation = makeRelation (mkCN (mkA "chemical") (mkN "composition")) ;
 
   chemical_substance_CN : Relation = lin Relation {cn = (mkCN (mkA "chemical") (mkN "substance")) ; prep = from_Prep | part_Prep } ;

   drug_N : Relation = lin Relation {cn = mkCN (mkN "drug") ; prep = with_Prep} ;
 
   use_N : Relation = makeRelation (mkCN (mkN "use")) ;  

   method_N : Relation  = makeRelation (mkCN (mkN "method")) ;

   drug_with_usage_form_CN : Relation = lin Relation {cn = mkCN (mkN "drug") ; prep = noPrep } ;

   drug_preparation_CN : Relation = lin Relation {cn = mkCN (mkN "drug" (mkN "preparation")) ; prep = for_Prep} ; 
  
   strength_N : Relation  = makeRelation (mkCN (mkN "strength")) ;

   name_N : Relation = makeRelation (mkCN (mkN "name")) ;

   usage_form_CN = makeRelation (mkCN (mkN "usage" (mkN "form"))) ;

----------------------------------------------------------------------------
oper makeRelation : CN -> Relation =
    \s -> lin Relation {cn = s ; prep = possess_Prep} ;


}