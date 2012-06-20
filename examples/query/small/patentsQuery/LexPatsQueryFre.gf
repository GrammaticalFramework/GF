instance LexPatsQueryFre of LexPatsQuery = 
  open SyntaxFre, ParadigmsFre, ExtraFre, IrregFre, StructuralFre, DiffFre, (CR=CommonRomance), ParamX, Prelude in {

flags 
  coding = utf8 ;

oper

  giveMe : NP -> VP = \np -> mkVP (mkV2 (mkV "montrer")) np  ; 
  get_V2 = IrregFre.obtenir_V2 ;
  want_V2 =IrregFre.vouloir_V2 ;

-- structural words
  about_Prep : Prep = mkPreposition ["à propos de"] ;
  all_NP : NP = mkNP (mkPN "tout") ; 
  

  
  vpAP vp = variants {} ;


  active_ingredient_CN : CN = mkCN (mkA "actif")  (mkN "ingrédient") ;
  dosage_form_CN : CN = mkCN (mkA "posologique") (mkN "forme") ;
  route_of_administration_CN : CN = mkCN (mkCN (mkN "voie")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "administration"))) ;
  patent_number_CN : CN = mkCN  (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "brevet"))) ;
  patent_N : N = mkN "brevet" ;
  expiration_date_CN : CN = mkCN (mkCN (mkN "date")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "expiration")));
  expire_V : V = regV "expirer" ;
  use_code_CN : CN = mkCN (mkCN (mkN "code"))  (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "utilisation"))) ; 
  application_number_CN : CN = mkCN (mkCN (mkN "numéro")) (SyntaxFre.mkAdv possess_Prep  (mkNP (mkN "demande"))) ;
   apply_V : V = regV "appliquer" ;
   applicant_CN : CN = mkCN (mkN "demandeur") ; 
   approval_date_CN : CN = mkCN (mkCN (mkN "date")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "approbation"))) ;
   chemical_composition_CN : CN = mkCN (mkA "chemique") (mkN "composition") ;
   chemical_substance_CN : CN = mkCN (mkA "chimique") (mkN "substance") ;
   drug_N : N = mkN "médicament" ;
   use_N : N = mkN "utilisation" ;
   compound_CN : CN = mkCN (mkN "composé") ;
   method_N : N = mkN "méthode" ;
   strength_N : N = mkN "dosage" ;
   drug_preparation_CN : CN = mkCN (mkN "préparation") ; 
   claim_N : N = mkN "revendication" ;
   mention_V2 : V2 = dirV2 (regV "mentionner") ;
   use_V2 : V2 = dirV2 (regV "utiliser") ;
   approve_V2 : V2 = dirV2 (regV "approuver") ;
   contain_V2 : V2 = IrregFre.contenir_V2 ;
   usage_form_CN : CN = mkCN (mkCN (mkN "formulaire")) (SyntaxFre.mkAdv possess_Prep (mkNP (mkN "utilisation")));

  information_N : N = mkN "information" ;


  what_IQuant : IQuant = which_IQuant ;
  
  massInfoSg : CN -> NP  = \cn -> 
              let g = cn.g ;
                   n = Sg
              in  lin NP {
                   s = \\c => {comp,ton = cn.s ! n ; c1,c2 = []} ;
                   a = CR.agrP3 g n ;
                   hasClit = False ;
                  isPol = False
                 } ;

  massInfoPl : CN -> NP = \cn -> mkNP aPl_Det cn ;

  that_RP : RP = which_RP ;

 PatsAdvVPSlash vp adv =  lin VPSlash 
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

}
