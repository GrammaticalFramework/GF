concrete StructuralHin of Structural = CatHin ** 
  open MorphoHin, ParadigmsHin, Prelude, NounHin,ParamX,CommonHindustani in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep "wपर" "wपर" ;
  after_Prep = mkPrep ["कै बेद"]  ["कै बेद"] ;
  all_Predet = ss "तमम" ;
  almost_AdA, almost_AdN = mkAdN "तqरयब" ;
  although_Subj = ss "गरचh-" ;
  always_AdV = ss "हमयXह" ;
  and_Conj = sd2 [] "wर" ** {n = Pl} ;
  because_Subj = ss "कयwनकh-" ;
  before_Prep = mkPrep "पहलै" "पहलै" ;
  behind_Prep = mkPrep "पयचh-ै" "पयचh-ै" ;
  between_Prep = mkPrep "दरमयं" "दरमयं" ;
  both7and_DConj = sd2 "दwनwं" "wर" ** {n = Pl} ;
  but_PConj = ss "लयकन" ;
  by8agent_Prep = mkPrep "" "" ;
  by8means_Prep = mkPrep "" "" ;
--  can8know_VV,can_VV = mkV "सकन" ** { isAux = True} ;
  during_Prep = mkPrep ["कै दरमयं"] ["कै दरमयं"] ;
  either7or_DConj = sd2 "कwय यक" "य" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsHin.mkN "हर कwय" "हर कwय" "हर कwय" "हर कwय" "हर कwय" "हर कwय" Masc )); -- not a good way coz need to include NounHin
--  every_Det = mkDet "हर" Sg;
  everything_NP = MassNP (UseN (ParadigmsHin.mkN "हर चयज़" "हर चयज़" "हर चयज़w" "सब चयज़यं" "सब चयज़wं" "सब चयज़w" Masc ));
  everywhere_Adv = mkAdv "हर जगह" ;
--  few_Det = mkDet "चनद" Pl ;
  first_Ord = {s = "पेहल" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "कयलयै" "कयलयै" ;
  from_Prep = mkPrep "सै" "सै" ;
  he_Pron = personalPN "wह" "स" "" "स क"  Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "यहं" ;
  here7to_Adv = mkAdv "यहं पर" ;
  here7from_Adv = mkAdv "यहं सै" ;
  how_IAdv = ss "कयसै" ;
  how8many_IDet = makeIDet "कतनै" "कतनय" Pl ;
  if_Subj = ss "गर" ;
  in8front_Prep = mkPrep ["कै समनै"] ["कै समनै"] ;
  i_Pron = personalPN "मयं" "मजh-" "" "मयर" Sg Masc Pers1;
  in_Prep = mkPrep "में" "में" ;
  it_Pron  = personalPN "यह" "यह" "यह" "स क" Sg Masc Pers3_Near;
  less_CAdv = {s = "कम" ; p = ""} ;
--  many_Det = mkDet "बहत ज़यदह" Pl ;
  more_CAdv = {s = "ज़यदh-" ; p = "" } ;
  most_Predet = ss "ज़यदह तर" ;
  --much_Det = mkDet "बहत" Pl  ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["हवे तॉ"] ;
--      VVF VPres => "मुसत" ;
--      VVF VPPart => ["हद तॉ"] ;
--      VVF VPresPart => ["हविनग तॉ"] ;
--      VVF VPast => ["हद तॉ"] ;      --# notpresent
--      VVPastNeg => ["हदn'त तॉ"] ;      --# notpresent
--      VVPresNeg => "मुसतn'त"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "नॉ" ;
  no_Utt = ss "नहयं" ;
  on_Prep = mkPrep "पर" "पर" ;
--  one_Quant = demoPN "यक" "यक" "यक" ; -- DEPRECATED
  only_Predet = ss "सरf" ;
  or_Conj = sd2 [] "य" ** {n = Sg} ;
  otherwise_PConj = ss "य पh-र" ;
  part_Prep = mkPrep "" "" ;
  please_Voc = ss "महरबनि" ;
  possess_Prep = mkPrep "क" "कय" ;
  quite_Adv = ss "कहमॉसह" ;
  she_Pron = personalPN "wह" "स" "wह" "स कय" Sg Fem Pers3_Distant ;
  so_AdA = ss "सॉ" ;
  somebody_NP = MassNP (UseN (ParadigmsHin.mkN "कwय" "कwय" "कwय" "कwय" "कwय" "कwय" Masc ));
  --someSg_Det = mkDet "कचh-" Sg ;
  --somePl_Det = mkDet "कचh-" Pl ;
  something_NP = MassNP (UseN (ParadigmsHin.mkN "कwय चयज़" "कwय चयज़" "कwय चयज़" "कh- चयज़यं" "कh- चयज़wं" "कh- चयज़w" Masc ));
  somewhere_Adv = mkAdv "कहिन पर" ;
  that_Quant = demoPN "wह" "स" "न" ;
  that_Subj = ss "कह";
  there_Adv = mkAdv "wहं" ;
  there7to_Adv = mkAdv "wहं पर" ;
  there7from_Adv = mkAdv ["wहं सै"] ;
  therefore_PConj = ss "स लयै" ;
  they_Pron = personalPN "wह" "wह" "wह" "न क" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "यह" "स" "न";      
  through_Prep = mkPrep ["मयं सै"] ["मयं सै"] ;
  too_AdA = ss "बहत" ;
  to_Prep = mkPrep "कw" "कw" ;
  under_Prep = mkPrep "नयचै" "नयचै" ;
  very_AdA = ss "बहत" ;
--  want_VV = mkV "चहन" ** { isAux = False} ;
  we_Pron = personalPN "हम" "हम" "हम" "हमर" Pl Masc Pers1 ;
  whatSg_IP = mkIP "कय" "किस" "किस" Sg Masc ;
  whatPl_IP = mkIP "कय" "किन" "किन" Pl Masc ;
  when_IAdv = ss "कब" ;
  when_Subj = ss "कब" ;
  where_IAdv = ss "कहं" ;
  which_IQuant = {s = \\_ => "कwन सय"} ;
--  whichPl_IDet = makeDet "कwन स" "कwन सय" "कwन सै" "कwन सय" ;
--  whichSg_IDet = makeDet "कwन स" "कwन सय" "कwन सै" "कwन सय" ;
  whoSg_IP = mkIP "कwन" "किस" "किस" Sg Masc  ;
  whoPl_IP = mkIP "कwन" "कन" "कनहwं" Pl Masc ;
  why_IAdv = ss "कयwं" ;
  without_Prep = mkPrep ["कै बघयर"] ["कै बघयर"] ;
  with_Prep = mkPrep ["कै सतh-"] ["कै सतh-"] ;
--  yes_Phr = ss "हं" ;
  yes_Utt = ss "हं" ;
  youSg_Pron = personalPN "तम" "तम" "तम" "तमh-र" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "तम" "तम" "तम" "तमh-र" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "ाप" "ाफ" "ाफ" "ाप क" Sg Masc Pers2_Respect  ;
  no_Quant =  demoPN " कwय नहयं" "कwय नहयं" "कwय नहयं" ; 
  not_Predet = {s="नहयं"} ;
  if_then_Conj = sd2 "गर" "तw" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["कम ज़ कम"] ;
  at_most_AdN = mkAdN ["ज़यदह सै ज़यदह"];
  nothing_NP = MassNP (UseN (ParadigmsHin.mkN "कwय चयज़ नहयं" "कwय चयज़ नहयं" "कwय चयज़ नहयं" "कwय चयज़ नहयं" "कwय चयज़ नहयं" "कwय चयज़ नहयं" Masc )); 
  except_Prep = mkPrep "सwै" "सwै" ;
  nobody_NP = MassNP (UseN (ParadigmsHin.mkN "कwय नहयं" "कwय नहयं" "कwय नहयं" "कwय नहयं" "कwय नहयं" "कwय नहयं" Masc ));  

  as_CAdv = {s = "ेतन" ; p = "जतन"} ;

  have_V2 = mkV2 (mkV "रकh-न") "" ;

 language_title_Utt = ss "रदw" ;

}

