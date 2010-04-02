concrete StructuralUrd of Structural = CatUrd ** 
  open MorphoUrd, ParadigmsUrd, Prelude, NounUrd in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "awpr" ;
  after_Prep = ss "kE bed" ;
  all_Predet = ss "tmam" ;
  almost_AdA, almost_AdN = ss "tqryba" ;
  although_Subj = ss "agrch-" ;
  always_AdV = ss "hmyXh" ;
  and_Conj = sd2 [] "awr" ** {n = Pl} ;
  because_Subj = ss "kywnkh-" ;
  before_Prep = ss "phlE" ;
  behind_Prep = ss "pych-E" ;
  between_Prep = ss "drmyaN" ;
  both7and_DConj = sd2 "dwnwN" "awr" ** {n = Pl} ;
  but_PConj = ss "lykn" ;
  by8agent_Prep = ss "" ;
  by8means_Prep = ss "" ;
  can8know_VV,can_VV = mkV "skna" ** { isAux = True} ;
  during_Prep = ss ["kE drmyaN"] ;
  either7or_DConj = sd2 "kwy ayk" "ya" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsUrd.mkN "hr kwy" "hr kwy" "hr kwy" "hr kwy" "hr kwy" "hr kwy" Masc )); -- not a good way coz need to include NounUrd
  every_Det = mkDet "hr" "hr" "hr" "hr" Sg;
  everything_NP = MassNP (UseN (ParadigmsUrd.mkN "hr cyz" "hr cyz" "hr cyzw" "sb cyzyN" "sb cyzwN" "sb cyzw" Masc ));
  everywhere_Adv = ss "hr jgh" ;
  few_Det = mkDet "cnd" "cnd" "cnd" "cnd" Pl ;
  for_Prep = ss "kylyE" ;
  from_Prep = ss "sE" ;
  he_Pron = personalPN "wh" "as" "" "as ka"  Sg Masc Pers3_Distant ;
  here_Adv = ss "yhaN" ;
  here7to_Adv = ss ["yhaN pr"] ;
  here7from_Adv = ss ["yhaN sE"] ;
  how_IAdv = ss "how" ;
  how8many_IDet = makeIDet "ktnE" "ktny" Pl ;
  if_Subj = ss "agr" ;
  in8front_Prep = ss ["kE samnE"] ;
  i_Pron = personalPN "myN" "mjh-" "" "myra" Sg Masc Pers1;
  in_Prep = ss "meN" ;
  it_Pron  = personalPN "yh" "yh" "yh" "as ka" Sg Masc Pers3_Near;
  less_CAdv = {s = "km" ; p = ""} ;
  many_Det = mkDet "bht zyadh" "bht zyadh" "bht zyadh" "bht zyadh" Pl ;
  more_CAdv = {s = "zyadh-" ; p = "" } ;
  most_Predet = ss "zyadh tr" ;
  much_Det = mkDet "bht" "bht" "bht" "bht" Sg  ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["have to"] ;
--      VVF VPres => "must" ;
--      VVF VPPart => ["had to"] ;
--      VVF VPresPart => ["having to"] ;
--      VVF VPast => ["had to"] ;      --# notpresent
--      VVPastNeg => ["hadn't to"] ;      --# notpresent
--      VVPresNeg => "mustn't"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "no" ;
  no_Utt = ss "nhyN" ;
  on_Prep = ss "pr" ;
--  one_Quant = demoPN "ayk" "ayk" "ayk" ; -- DEPRECATED
  only_Predet = ss "srf" ;
  or_Conj = sd2 [] "ya" ** {n = Sg} ;
  otherwise_PConj = ss "ya ph-r" ;
  part_Prep = ss "" ;
  please_Voc = ss "mhrbani" ;
  possess_Prep = ss "ka" ;
  quite_Adv = ss "khamosh" ;
  she_Pron = personalPN "wh" "as" "wh" "as ky" Sg Fem Pers3_Distant ;
  so_AdA = ss "so" ;
  somebody_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy" "kwy" "kwy" "kwy" "kwy" "kwy" Masc ));
  someSg_Det = mkDet "kch-" "kch-" "kch-" "kch-" Sg ;
  somePl_Det = mkDet "kch-" "kch-" "kch-" "kch-" Pl ;
  something_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy cyz" "kwy cyz" "kwy cyz" "kh- cyzyN" "kh- cyzwN" "kh- cyzw" Masc ));
  somewhere_Adv = ss "khin pr" ;
  that_Quant = demoPN "wh" "as" "an" ;
  that_Subj = ss "kh";
  there_Adv = ss "whaN" ;
  there7to_Adv = ss "whaN pr" ;
  there7from_Adv = ss ["whaN sE"] ;
  therefore_PConj = ss "as lyE" ;
  they_Pron = personalPN "wh" "wh" "wh" "an ka" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "yh" "as" "an";      
  through_Prep = ss ["myN sE"] ;
  too_AdA = ss "bht" ;
  to_Prep = ss "kw" ;
  under_Prep = ss "nycE" ;
  very_AdA = ss "bht" ;
  want_VV = mkV "cahna" ** { isAux = False} ;
  we_Pron = personalPN "hm" "hm" "hm" "hmara" Pl Masc Pers1 ;
  whatSg_IP = mkIP "kya" "kis" "kis" Sg Masc ;
  whatPl_IP = mkIP "kya" "kin" "kin" Pl Masc ;
  when_IAdv = ss "kb" ;
  when_Subj = ss "kb" ;
  where_IAdv = ss "khaN" ;
  which_IQuant = {s = \\_ => "kwn sy"} ;
--  whichPl_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
--  whichSg_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
  whoSg_IP = mkIP "kwn" "kis" "kis" Sg Masc  ;
  whoPl_IP = mkIP "kwn" "kn" "knhwN" Pl Masc ;
  why_IAdv = ss "kywN" ;
  without_Prep = ss ["kE bGyr"] ;
  with_Prep = ss ["kE sath-"] ;
--  yes_Phr = ss "haN" ;
  yes_Utt = ss "haN" ;
  youSg_Pron = personalPN "tm" "tm" "tm" "tmh-ara" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "tm" "tm" "tm" "tmh-ara" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "Ap" "AP" "AP" "Ap ka" Sg Masc Pers2_Respect  ;
  no_Quant =  demoPN " kwy nhyN" "kwy nhyN" "kwy nhyN" ; 
  not_Predet = {s="nhyN"} ;
  if_then_Conj = sd2 "agr" "tw" ** {n = Sg} ; 
  at_least_AdN = ss ["km az km"] ;
  at_most_AdN = ss ["zyadh sE zyadh"];
  nothing_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" Masc )); 
  except_Prep = ss "swaE" ;
  nobody_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" Masc ));  

  as_CAdv = {s = "etna" ; p = "jtna"} ;

  have_V2 = mkV2 (mkV "rakh-na") "" ;

 language_title_Utt = ss "ardw" ;

}

