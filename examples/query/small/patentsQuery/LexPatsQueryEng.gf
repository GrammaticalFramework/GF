instance LexPatsQueryEng of LexPatsQuery = QueryEng ** 
  open SyntaxEng, (M = MakeStructuralEng), ParadigmsEng, (Lang=LangEng), ExtraEng, IrregEng, ResEng in {

oper

  giveMe : NP -> VP = \np -> mkVP (mkV3 give_V) (SyntaxEng.mkNP i_Pron) np ; 
  get_V2 = mkV2 IrregEng.get_V ;
  want_V2 = mkV2 (mkV "want" "wants" "wanted" "wanted" "wanting") ;

-- structural words
  about_Prep : Prep = mkPrep "about" ;
  all_NP : NP = SyntaxEng.mkNP (mkPN "all") ; 
--  at_Prep : Prep = mkPrep "at" ;


  vpAP = PartVP ;

  active_ingredient_CN : Relation = makeRelation (mkCN (mkA "active")  (mkN "ingredient")) ;
  dosage_form_CN : Relation = makeRelation (mkCN (mkN "dosage" (mkN "form"))) ;
  route_of_administration_CN : Relation = makeRelation (mkCN (mkN "route") (SyntaxEng.mkAdv (mkPrep "of") (SyntaxEng.mkNP (mkN "administration")))) ;
  patent_number_CN : Kind = lin Kind  (mkCN (mkN "patent" (mkN "number"))) ;
  patent_number_Rel : Relation = makeRelation (mkCN (mkN "patent" (mkN "number"))) ;
  patent_N : Relation = lin Relation {cn = mkCN (mkN "patent") ; prep = for_Prep } ;
  expiration_date_CN : Relation = makeRelation (mkCN (mkN "expiration" (mkN "date"))) ;
  expire_V : V = mkV "expire" ;
  use_code_CN : Relation = makeRelation (SyntaxEng.mkCN (mkN "use" (mkN "code"))) ; 
  application_number_CN : Relation = makeRelation ((mkCN (mkN "application" (mkN  "number"))) | (mkCN (mkN ["patent application"] (mkN  "number")))) ;
   apply_V : V = mkV "apply" "applies" "applied" "applied" "applying" ;
   applicant_CN : Relation = lin Relation {cn = mkCN (mkN "applicant") ; prep = for_Prep } ; 
   approval_date_CN : Relation = makeRelation (mkCN (mkN "approval" (mkN "date"))) ;
   chemical_composition_CN : Relation = makeRelation (mkCN (mkA "chemical") (mkN "composition")) ;
   chemical_substance_CN : Relation = makeRelation (mkCN (mkA "chemical") (mkN "substance")) ;
   drug_N : N = mkN "drug" ;
   use_N : Relation = makeRelation (mkCN (mkN "use")) ;
   compound_CN : Relation = makeRelation (mkCN (mkN "compound")) ;
   --name_N : N = mkN "name" ;
   method_N : N = mkN "method" ;
   strength_N : Relation = makeRelation (mkCN (mkN "strength")) ;
   drug_preparation_CN : Relation = makeRelation (mkCN (mkN "drug" (mkN "preparation"))) ; 
   claim_N : N = mkN "claim" ;
   mention_V2 : V2 = mkV2 (mkV "mention" "mentions" "mentioned" "mentioned" "mentioning") ;
   use_V2 : V2 = mkV2 (mkV "use" "uses" "used" "used" "using") ;
   approve_V2 : V2 = mkV2 (mkV "approve" "approves" "approved" "approved" "approving") ;
   contain_V2 : V2 = mkV2 (mkV "contain" "contains" "contained" "contained" "containing") ;
   usage_form_CN : Relation = makeRelation (mkCN (mkN "usage" (mkN "form"))) ;

  information_N : N = mkN "information" ;

  what_IQuant : IQuant = M.mkIQuant "what" "what" ;
  
  massInfoSg : CN -> NP  = \cn -> SyntaxEng.mkNP cn ;
 
  massInfoPl : CN -> NP = \cn -> SyntaxEng.mkNP aPl_Det cn ;

  that_RP : RP = ExtraEng.that_RP ;

  PatsAdvVPSlash = Lang.AdvVPSlash ;

  selectIP np = case np.a of 
     {AgP3Sg _ => whatSg_IP ;
      _        => whatPl_IP
     };

oper makeRelation : CN -> Relation =
    \s -> lin Relation {cn = s ; prep = possess_Prep} ;


}
