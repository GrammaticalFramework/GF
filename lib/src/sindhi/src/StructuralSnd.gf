concrete StructuralSnd of Structural = CatSnd ** 
  open MorphoSnd, ParadigmsSnd, Prelude in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep "mT'y " ;
  after_Prep = mkPrep "k'an pWe' "  ;
  all_Predet = ss "sB' " ;
  almost_AdA, almost_AdN = mkAdN "gh't'W kry " ;
  although_Subj = ss "jytWt'yk " ;
  always_AdV = ss "h'myXh' " ;
  and_Conj = sd2 [] "A" ** {n = Pl} ;
  because_Subj = ss "c'akat' ty " ;
  before_Prep = mkPrep  "pyh'ryn" ;
  behind_Prep = mkPrep "pT!ty " ;
  between_Prep = mkPrep " jy Wc my "  ;
  both7and_DConj = sd2 "Be'y " "A" ** {n = Pl} ;
  but_PConj = ss "pr" ;
  by8agent_Prep = mkPrep  "h'T'an "   ;
  by8means_Prep = mkPrep "kan"  ;
  can8know_VV,can_VV = mkV "sgh't' " ** { isAux = True} ;
  during_Prep = mkPrep "Wc M" ;
  either7or_DConj = sd2 "kWe'y ByW " "ya" ** {n = Sg} ;
--everybody_NP =  MassNP (UseN (ParadigmsSnd.mkN "h'r kWe'y" "h'r kWe'y" "h'r kWe'y" "h'r kWe'y"  Masc )); -- not a good way coz need to include NounSnd
  every_Det = mkDet "h'r h'k " "h'r h'k  " "h'r h'k "  "h'r h'k "  Sg;
--everything_NP = MassNP (UseN (ParadigmsSnd.mkN "h'r Xy " "h'r Xy " "h'r Xy " "sB' kjh' "  Masc ));
  everywhere_Adv = mkAdv "h'r h'nd' "  ;
  few_Det = mkDet "kjh' " "kjh' " "kjh' " "kjh' " Pl ;
  first_Ord = {s = "ph'ryWn" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "Lae'y ";
  from_Prep = mkPrep  "WTan"  ;
  he_Pron = personalPN "h'W" "h'W" "" ["h'W "] ["h'W"] Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "h'ty"  ;
  here7to_Adv = mkAdv "ajh'W" ;
  here7from_Adv = mkAdv ["h'yD'anh'n"] ;
  how_IAdv = ss  "ke'yn" ;
  how8many_IDet = makeIDet "kytra" "kytra" Pl ;
  how8much_IAdv  = ss  "kytra";
  if_Subj = ss "jykD'h'n" ;
  in8front_Prep = mkPrep ["jy samh'Wn"]  ;
  i_Pron = personalPN "man" "mh'nja " "mh'njW " "man" " " Sg Masc Pers1;
  in_Prep = mkPrep "M"  ;
  it_Pron  = personalPN "ah'a" "h'n" "ah'W" "ah'a" "" Sg Masc Pers3_Near;
  less_CAdv = {s = "gh'T" ; p = ""} ;
  many_Det = mkDet "gh't'a" "gh't'y" "kafy" "kytra" Pl ;
  more_CAdv = {s = "Wd'yk"; p =  "gh't'a" } ;
  most_Predet = ss "sB' k'an gh't'W" ;
  much_Det = mkDet "gh't'W" "gh't'W" "gh't'W" "gh't'W" Sg  ;
--must_VV = {
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

-----b  
  no_Phr = ss "no" ;
  no_Utt = ss  "na" ;
  on_Prep = mkPrep "mT'an" ;
  one_Quant = demoPN "h'k" "h'k" "h'k" ; -- DEPRECATED
  only_Predet = ss "Srf" ;
  or_Conj = sd2 [] "ya" ** {n = Sg} ;
  otherwise_PConj = ss "n t  pWe'y"  ;
  part_Prep = mkPrep "HsW"  ;
  possess_Prep = mkPrep[ "jW ya jy"] ;
  please_Voc = ss "mh'rbany" ;
  quite_Adv = ss "c'D't' " ;
  she_Pron = personalPN "h'We'" "h'W" "h'W" ["h'We'"] ["h'We'"] Sg Fem Pers3_Distant ;
  so_AdA = ss "an kry" ;
--somebody_NP = MassNP (UseN (ParadigmsSnd.mkN "kWe'y" "kWe'y" "kWe'y" "kWe'y"  Masc ));
  someSg_Det = mkDet "kjh' " "kjh' " "kjh' " "kjh' " Sg ;
  somePl_Det = mkDet "kjh' " "kjh' " "kjh' " "kjh' " Pl ;
--something_NP = MassNP (UseN (ParadigmsSnd.mkN "kWe'y  Xy" "kWe'y  Xy" "kWe'y  Xy" "kWe'y  XyWn" Masc ));
  somewhere_Adv = mkAdv "kT'y" ;
  that_Quant = demoPN "jykW" "" ""   ;
  that_Subj = ss "ah'a" ;
  there_Adv = mkAdv "aty" ;
  there7to_Adv = mkAdv ["h'ty"] ;
  there7from_Adv = mkAdv ["h'tan"] ;
  therefore_PConj = ss "an kry" ;
  they_Pron = personalPN "ah'y" "ah'y" "ah'y" ["ah'y jW"] ["ah'y jW"] Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "h'y" "h'n" "";     
  through_Prep = mkPrep "mnjh'an" ;
  under_Prep = mkPrep " h'yT!an"  ; -- ** {lock_Prep = <>};
  too_AdA = ss  "byHd";
  to_Prep = mkPrep "D'anh'n"  ; -- ** {lock_Prep = <>};
  very_AdA = ss "tmam" ;
  want_VV = mkV "cah't' "  ** { isAux = False} ;
  we_Pron = personalPN "asan" "asan" "asan" "asanjo" "asanjo" Pl Masc Pers1 ;
  whatSg_IP = mkIP "c'a" "c'W" "" "" Sg Masc ;
  whatPl_IP = mkIP "c'a" "c'W " " " "" Pl Masc ;
  when_IAdv = ss "kD'h'n" ;
  when_Subj = ss "jD'h'n" ;
  where_IAdv = ss "kT'y" ;
--which_IQuant = {s = \\_ => "kh'RW"} ;
  which_IQuant = mkIQuant "jykW" "jyky" "jyka" "jh'RW" ;
  whichPl_IDet = makeDet "jykY" "jnh'n" ;
  whichSg_IDet = makeDet "jykW " "jyka"  ;
  whoSg_IP = mkIP "kyr" "kh'njy" "kh'njo" "" Sg Masc  ;
  whoPl_IP = mkIP "kyr" "kh'nja" "kh'nja" "" Pl Masc ;
  why_IAdv = ss "c'W" ;
  without_Prep = mkPrep "k'an sWae' " ;
  with_Prep = mkPrep "san" ;
  yes_Phr = ss "h'a" ;
  yes_Utt = ss "h'a" ;
  youSg_Pron = personalPN "tWn" "tWn" "tWn" "th'njW" "th'njy"  Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "tWh'an" "tWh'an" "tWh'an" "tWh'anjW" "tWh'anjy"  Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "tWh'an" "tWh'an" "tWh'an" "tWh'an jW" "tWh'an jy"  Pl Masc Pers2_Respect  ;
  no_Quant =  demoPN " c'W n" "c'W n" "c'W n " ; 
  not_Predet = {s="n"} ;
  if_then_Conj = sd2 "jykD'h'n" "t" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["gh'T my gh'T"] ;
  at_most_AdN = mkAdN ["gh't'y k'an gh't'W"];
  
--nothing_NP = MassNP (UseN (ParadigmsSnd.mkN "kjh' Xy n" "kjh' Xy n" "kjh' Xy n" "kjh' Xy n" "kjh' Xy n" "kjh' Xy n" Masc )); 
  except_Prep = mkPrep "sWae' " ;
--nobody_NP = MassNP (UseN (ParadigmsSnd.mkN "kW b n" "kW b n" "kW b n" "kW b n" "kW b n" "kW b n" Masc ));  

  as_CAdv = {s = "jye'n" ; p = "jh'RW"} ;
  have_V2 = mkV2 (mkV "rk't' ") "" ;
  language_title_Utt = ss "BWly" ;

}

