concrete StructuralUrd of Structural = CatUrd ** 
  open MorphoUrd, ParadigmsUrd, Prelude, NounUrd,ParamX,CommonHindustani in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep ["kE awpr"] ["kE awpr"] ;
  after_Prep = mkPrep ["kE bed"] ["kE bed"] ;
  all_Predet = ss "tmam" ;
  almost_AdA, almost_AdN = mkAdN "tqryba" ;
  although_Subj = ss "agrch" ;
  always_AdV = ss "hmyXh" ;
  and_Conj = sd2 [] "awr" ** {n = Pl} ;
  because_Subj = ss "kywnkh" ;
  before_Prep = mkPrep ["sE phlE"] ["sE phlE"] ;
  behind_Prep = mkPrep ["kE pych'E"] ["kE pych'E"] ;
  between_Prep = mkPrep "drmyaN" "drmyaN" ;
  both7and_DConj = sd2 "dwnwN" "awr" ** {n = Pl} ;
  but_PConj = ss "lykn" ;
  by8agent_Prep = mkPrep "sE" "" ;
  by8means_Prep = mkPrep "pr" "" ;
  can8know_VV,can_VV = mkV "skna" ** { isAux = True} ;
  during_Prep = mkPrep ["kE drmyaN"] ["kE drmyaN"] ;
  either7or_DConj = sd2 "kwy ayk" "ya" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsUrd.mkN "hr kwy" "hr kwy" "hr kwy" "hr kwy" "hr kwy" "hr kwy" Masc )); -- not a good way coz need to include NounUrd
  every_Det = mkDet "hr" "hr" "hr" "hr" Sg;
  everything_NP = MassNP (UseN (ParadigmsUrd.mkN "hr cyz" "hr cyz" "hr cyzw" "sb cyzyN" "sb cyzwN" "sb cyzw" Masc ));
  everywhere_Adv = mkAdv "hr jgh" ;
  few_Det = mkDet "cnd" "cnd" "cnd" "cnd" Pl ;
  first_Ord = {s = "pehla" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "kylyE" "kylyE" ;
  from_Prep = mkPrep "sE" "sE" ;
  he_Pron = personalPN "wh" "as" "" ["as ka"] ["as ky"] ["as kE"] ["as ky"] Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "yhaN" ;
  here7to_Adv = mkAdv ["yhaN pr"] ;
  here7from_Adv = mkAdv ["yhaN sE"] ;
  how_IAdv = ss "kysE" ;
  how8many_IDet = makeIDet "ktnE" "ktny" Pl ;
  how8much_IAdv  = ss "ktna" ;
  if_Subj = ss "agr" ;
  in8front_Prep = mkPrep ["kE samnE"] ["kE samnE"] ;
  i_Pron = personalPN "myN" "mjh'" "" "myra" "myry" "myrE" "myry" Sg Masc Pers1;
  in_Prep = mkPrep "myN" "myN" ;
  it_Pron  = personalPN "yh" "as" "as" ["as ka"] ["as ky"] ["as kE"] ["as ky"] Sg Masc Pers3_Near;
  less_CAdv = {s = "km" ; p = ""} ;
  many_Det = mkDet "bht zyadh" "bht zyadh" "bht zyadh" "bht zyadh" Pl ;
  more_CAdv = {s = "zyadh" ; p = "sE" } ;
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
  on_Prep = mkPrep "pr" "pr" ;
--  one_Quant = demoPN "ayk" "ayk" "ayk" ; -- DEPRECATED
  only_Predet = ss "Srf" ;
  or_Conj = sd2 [] "ya" ** {n = Sg} ;
  otherwise_PConj = ss "ya ph'r" ;
  part_Prep = mkPrep "" "" ;
  please_Voc = ss "mhrbany" ;
  possess_Prep = mkPrep "ka" "ky" ;
  quite_Adv = ss "KamwX" ;
  she_Pron = personalPN "wh" "as" "wh" ["as ky"] ["as ky"] ["as kE"] ["as ky"] Sg Fem Pers3_Distant ;
  so_AdA = ss "as lyE" ;
  somebody_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy" "kwy" "kwy" "kwy" "kwy" "kwy" Masc ));
  someSg_Det = mkDet "kch'" "kch'" "kch'" "kch'" Sg ;
  somePl_Det = mkDet "kch'" "kch'" "kch'" "kch'" Pl ;
  something_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy cyz" "kwy cyz" "kwy cyz" "kh' cyzyN" "kh' cyzwN" "kh' cyzw" Masc ));
  somewhere_Adv = mkAdv ["khyN pr"] ;
  that_Quant = demoPN "wh" "as" "an" ;
  that_Subj = ss "kh";
  there_Adv = mkAdv "whaN" ;
  there7to_Adv = mkAdv ["whaN pr"] ;
  there7from_Adv = mkAdv ["whaN sE"] ;
  therefore_PConj = ss "as lyE" ;
  they_Pron = personalPN "wh" "wh" "wh" ["an ka"] ["an ky"] ["an kE"] ["an ky"] Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "yh" "as" "an";      
  through_Prep = mkPrep ["myN sE"] ["myN sE"] ;
  too_AdA = ss "bht" ;
  to_Prep = mkPrep "kw" "kw" ; -- ** {lock_Prep = <>};
  under_Prep = mkPrep "kE nycE" "kE nycE" ; -- ** {lock_Prep = <>};
  very_AdA = ss "bht" ;
  want_VV = mkV "cahna" ** { isAux = False} ;
  we_Pron = personalPN "hm" "hm" "hm" "hmara" "hmary" "hmarE" "hmary" Pl Masc Pers1 ;
  whatSg_IP = mkIP "kya" "ks" "ks" Sg Masc ;
  whatPl_IP = mkIP "kya" "kn" "kn" Pl Masc ;
  when_IAdv = ss "kb" ;
  when_Subj = ss "jb" ;
  where_IAdv = ss "khaN" ;
--  which_IQuant = {s = \\_ => "kwn sy"} ;
  which_IQuant = mkIQuant "kwn" ;
--  whichPl_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
--  whichSg_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
  whoSg_IP = mkIP "kwn" "ks" "ks" Sg Masc  ;
  whoPl_IP = mkIP "kwn" "kn" "knhwN" Pl Masc ;
  why_IAdv = ss "kywN" ;
  without_Prep = mkPrep ["kE bGyr"] ["kE bGyr"] ;
  with_Prep = mkPrep ["kE sath'"] ["kE sath'"] ;
--  yes_Phr = ss "haN" ;
  yes_Utt = ss "haN" ;
  youSg_Pron = personalPN "tw" "tw" "tw" "tyra" "tyry" "tyrE" "tyry" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "tm" "tm" "tm" "tmh'ara" "tmh'ary" "tmh'arE" "tmh'ary" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "Ap" "Ap" "Ap" ["Ap ka"] ["Ap ky"] ["Ap kE"] ["Ap ky"] Pl Masc Pers2_Respect  ;
  no_Quant =  demoPN " kwy nhyN" "kwy nhyN" "kwy nhyN" ; 
  not_Predet = {s="nhyN"} ;
  if_then_Conj = sd2 "agr" "tw" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["km az km"] ;
  at_most_AdN = mkAdN ["zyadh sE zyadh"];
  nothing_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" "kwy cyz nhyN" Masc )); 
  except_Prep = mkPrep "kE swaE" "kE swaE" ;
  nobody_NP = MassNP (UseN (ParadigmsUrd.mkN "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" "kwy nhyN" Masc ));  

  as_CAdv = {s = "atna" ; p = "jtna"} ;

  have_V2 = mkV2 (mkV "rkh'na") "" ;

 language_title_Utt = ss "ardw" ;

}

