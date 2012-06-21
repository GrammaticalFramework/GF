instance LexQueryPatsFre of LexQueryPats = open
  SyntaxFre,
  ParadigmsFre,
  ExtraFre,
  IrregFre, 
  DiffFre,
  StructuralFre,
  (CR=CommonRomance),
  ParamX,
  QueryFre,
  Prelude
   in 
{

oper 
-------------------------------------------------------------- 
-- structural words and extra grammar constructs

   about_Prep : Prep  = mkPreposition ["à propos de"] ;

   all_NP : NP = mkNP (mkPN "tout") ;

   vpAP : VP -> AP = variants {} ;
   
   what_IQuant : IQuant = which_IQuant ;

   massInfoSg : CN -> NP = \cn ->  
              let g = cn.g ;
                   n = Sg
              in  lin NP {
                   s = \\c => {comp,ton = cn.s ! n ; c1,c2 = []} ;
                   a = CR.agrP3 g n ;
                   hasClit = False ;
                  isPol = False
                 } ;
 
   massInfoPl : CN -> NP = \cn -> SyntaxFre.mkNP aPl_Det cn ;
 
   PatsAdvVPSlash : VPSlash -> Adv -> VPSlash = \vp, adv -> lin VPSlash 
    { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ adv.s ;
    ext   = vp.ext ;
    c2 = vp.c2 ;
    }  ; 

   selectIP : NP -> IP = \np -> case np.a.n of 
     {Sg       => whatSg_IP ;
      _        => whatPl_IP
     };


--------------------------------------------------------------
-- kinds 

   patent_number_CN : Kind = 
     let pn : CN = mkCN  (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "brevet")))
        in lin Kind  pn ;

   claim_N : Kind = lin Kind (mkCN (mkN "revendication")) ;

 
--------------------------------------------------------------
-- activities 

   expire_V : Adv -> Activity = \pdate -> 
        lin Activity (mkVP (mkVP (mkV "expire")) pdate) ;

   simp_expire_V : Activity =  
        lin Activity (mkVP (regV "expirer")) ;

   apply_V : NP -> Activity = \pat ->  lin Activity ( mkVP (mkVP (regV "appliquer")) (SyntaxFre.mkAdv for_Prep pat)) ;

   compound_CN : Activity = let vp : VP = mkVP (mkCN (mkN "composé"))
            in  lin Activity vp ;
  
   use_V2 : Set -> Activity = \s -> lin Activity (mkVP (passiveVP (dirV2 (regV "utiliser"))) (SyntaxFre.mkAdv in_Prep s));

   approve_V2 : Adv -> Activity = \pdate -> lin Activity (mkVP (passiveVP (dirV2 (regV "approuver"))) pdate) ;
 
   mention_V2 : NP -> Activity = \drug -> 
    lin Activity ( mkVP (mkVPSlash (dirV2 (regV "mentionner"))) drug) ;

   contain_V2 : NP -> Activity  = \chem ->
    lin Activity (mkVP (mkVPSlash IrregFre.contenir_V2) chem) ;


--------------------------------------------------------------
-- properties 

   approve_prop_V2 : Adv -> Property  = \pdate -> lin Property (vpAP (mkVP (passiveVP  (dirV2 (regV "approuver"))) pdate)) ;

   use_prop_V2 : Set -> Property = \s -> lin Property (vpAP (mkVP (passiveVP (dirV2 (regV "utiliser"))) (SyntaxFre.mkAdv in_Prep s))) ;
  
  

--------------------------------------------------------------
-- relations  
 
   active_ingredient_CN : Relation = makeRelation (mkCN (mkA "actif")  (mkN "ingrédient")) ;

   dosage_form_CN : Relation = makeRelation (mkCN (mkA "posologique") (mkN "forme")) ;

   route_of_administration_CN : Relation = makeRelation (mkCN (mkCN (mkN "voie")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "administration")))) ;

   patent_number_Rel : Relation  = makeRelation (mkCN  (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "brevet")))) ;

   patent_N : Relation = lin Relation {cn = mkCN (mkN "brevet") ; prep = for_Prep } ;
  
   patent_with_N : Relation = lin Relation {cn = mkCN (mkN "brevet"); prep = with_Prep} ;

   expiration_date_CN : Relation  = makeRelation (mkCN (mkCN (mkN "date")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "expiration")))) ;

   use_code_CN : Relation = makeRelation (mkCN (mkCN (mkN "code"))  (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "utilisation")))) ; 

   application_number_CN : Relation  = makeRelation (mkCN (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep  (mkNP (mkN "demande")))) ;


   application_number_no_CN : Relation  = lin Relation {cn = (mkCN (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep  (mkNP (mkN "demande")))); prep = mkPrep ""} ;
  
   applicant_CN : Relation = lin Relation { cn = mkCN (mkN "demandeur") ; prep = for_Prep } ;


   applicant_no_CN : Relation = lin Relation {cn = mkCN (mkN "demandeur"); prep = mkPrep ""} ;

   approval_date_CN : Relation = makeRelation (mkCN (mkCN (mkN "date")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "approbation")))) ;


   chemical_composition_CN : Relation = makeRelation (mkCN (mkA "chemique") (mkN "composition")) ;
 
   chemical_substance_CN : Relation = lin Relation {cn = (mkCN (mkA "chimique") (mkN "substance")) ; prep = from_Prep | part_Prep } ;

   drug_N : Relation = lin Relation {cn = mkCN (mkN "médicament") ; prep = with_Prep} ;
 
   use_N : Relation = makeRelation (mkCN (mkN "utilisation")) ;  

   method_N : Relation  = makeRelation (mkCN (mkN "méthode")) ;

   drug_with_usage_form_CN : Relation = lin Relation {cn = mkCN (mkN "médicament") ; prep = mkPrep "" } ;

   drug_preparation_CN : Relation = lin Relation {cn =  mkCN (mkN "préparation") ; prep = for_Prep} ; 
  
   strength_N : Relation  = makeRelation (mkCN (mkN "dosage")) ;

   name_N : Relation = makeRelation (mkCN (mkN "nom")) ;

   usage_form_CN = makeRelation ( mkCN (mkCN (mkN "formulaire")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "utilisation")))) ;

----------------------------------------------------------------------------
oper makeRelation : CN -> Relation =
    \s -> lin Relation {cn = s ; prep = possess_Prep} ;


}
