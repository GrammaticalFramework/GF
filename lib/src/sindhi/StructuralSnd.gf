concrete StructuralSnd of Structural = CatSnd ** 
  open MorphoSnd, ParadigmsSnd, Prelude in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep "مٿی " ;
  after_Prep = mkPrep "کان پو۶ "  ;
  all_Predet = ss "سڀ " ;
  almost_AdA, almost_AdN = mkAdN "گھڻو ڪری " ;
  although_Subj = ss "جیتوڻیڪ " ;
  always_AdV = ss "ھمیشھ " ;
  and_Conj = sd2 [] "۽" ** {n = Pl} ;
  because_Subj = ss "ڇاڪاڻ تی " ;
  before_Prep = mkPrep  "پیھرین" ;
  behind_Prep = mkPrep "پٺتی " ;
  between_Prep = mkPrep " جی وچ می "  ;
  both7and_DConj = sd2 "ٻ۶ی " "۽" ** {n = Pl} ;
  but_PConj = ss "پر" ;
  by8agent_Prep = mkPrep  "ھٿان "   ;
  by8means_Prep = mkPrep "ڪان"  ;
  can8know_VV,can_VV = mkV "سگھڻ " ** { isAux = True} ;
  during_Prep = mkPrep "وچ ۾" ;
  either7or_DConj = sd2 "ڪو۶ی ٻیو " "یا" ** {n = Sg} ;
--everybody_NP =  MassNP (UseN (ParadigmsSnd.mkN "ھر ڪو۶ی" "ھر ڪو۶ی" "ھر ڪو۶ی" "ھر ڪو۶ی"  Masc )); -- not a good way coz need to include NounSnd
  every_Det = mkDet "ھر ھڪ " "ھر ھڪ  " "ھر ھڪ "  "ھر ھڪ "  Sg;
--everything_NP = MassNP (UseN (ParadigmsSnd.mkN "ھر شی " "ھر شی " "ھر شی " "سڀ ڪجھ "  Masc ));
  everywhere_Adv = mkAdv "ھر ھنڌ "  ;
  few_Det = mkDet "ڪجھ " "ڪجھ " "ڪجھ " "ڪجھ " Pl ;
  first_Ord = {s = "پھریون" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "لا۶ی ";
  from_Prep = mkPrep  "وٽان"  ;
  he_Pron = personalPN "ھو" "ھو" "" ["ھو "] ["ھو"] Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "ھتی"  ;
  here7to_Adv = mkAdv "اجھو" ;
  here7from_Adv = mkAdv ["ھیڏانھن"] ;
  how_IAdv = ss  "ڪ۶ین" ;
  how8many_IDet = makeIDet "ڪیترا" "ڪیترا" Pl ;
  how8much_IAdv  = ss  "ڪیترا";
  if_Subj = ss "جیڪڏھن" ;
  in8front_Prep = mkPrep ["جی سامھون"]  ;
  i_Pron = personalPN "مان" "مھنجا " "مھنجو " "مان" " " Sg Masc Pers1;
  in_Prep = mkPrep "۾"  ;
  it_Pron  = personalPN "اھا" "ھن" "اھو" "اھا" "" Sg Masc Pers3_Near;
  less_CAdv = {s = "گھٽ" ; p = ""} ;
  many_Det = mkDet "گھڻا" "گھڻی" "ڪافی" "ڪیترا" Pl ;
  more_CAdv = {s = "وڌیڪ"; p =  "گھڻا" } ;
  most_Predet = ss "سڀ کان گھڻو" ;
  much_Det = mkDet "گھڻو" "گھڻو" "گھڻو" "گھڻو" Sg  ;
--must_VV = {
--    s = table {
--      VVF VInf => ["hاvع تo"] ;
--      VVF VPres => "مuست" ;
--      VVF VPPart => ["hاد تo"] ;
--      VVF VPresPart => ["hاviنگ تo"] ;
--      VVF VPast => ["hاد تo"] ;      --# notpresent
--      VVPastNeg => ["hادn'ت تo"] ;      --# notpresent
--      VVPresNeg => "مuستn'ت"
--      } ;
--    isAux = True
--    } ;

-----b  
  no_Phr = ss "نo" ;
  no_Utt = ss  "نا" ;
  on_Prep = mkPrep "مٿان" ;
  one_Quant = demoPN "ھڪ" "ھڪ" "ھڪ" ; -- DEPRECATED
  only_Predet = ss "صرف" ;
  or_Conj = sd2 [] "یا" ** {n = Sg} ;
  otherwise_PConj = ss "ن ت  پو۶ی"  ;
  part_Prep = mkPrep "حسو"  ;
  possess_Prep = mkPrep[ "جو یا جی"] ;
  please_Voc = ss "مھربانی" ;
  quite_Adv = ss "ڇڏڻ " ;
  she_Pron = personalPN "ھو۶" "ھو" "ھو" ["ھو۶"] ["ھو۶"] Sg Fem Pers3_Distant ;
  so_AdA = ss "ان ڪری" ;
--somebody_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪو۶ی" "ڪو۶ی" "ڪو۶ی" "ڪو۶ی"  Masc ));
  someSg_Det = mkDet "ڪجھ " "ڪجھ " "ڪجھ " "ڪجھ " Sg ;
  somePl_Det = mkDet "ڪجھ " "ڪجھ " "ڪجھ " "ڪجھ " Pl ;
--something_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪو۶ی  شی" "ڪو۶ی  شی" "ڪو۶ی  شی" "ڪو۶ی  شیون" Masc ));
  somewhere_Adv = mkAdv "ڪٿی" ;
  that_Quant = demoPN "جیڪو" "" ""   ;
  that_Subj = ss "اھا" ;
  there_Adv = mkAdv "اتی" ;
  there7to_Adv = mkAdv ["ھتی"] ;
  there7from_Adv = mkAdv ["ھتان"] ;
  therefore_PConj = ss "ان ڪری" ;
  they_Pron = personalPN "اھی" "اھی" "اھی" ["اھی جو"] ["اھی جو"] Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "ھی" "ھن" "";     
  through_Prep = mkPrep "منجھان" ;
  under_Prep = mkPrep " ھیٺان"  ; -- ** {lock_Prep = <>};
  too_AdA = ss  "بیحد";
  to_Prep = mkPrep "ڏانھن"  ; -- ** {lock_Prep = <>};
  very_AdA = ss "تمام" ;
  want_VV = mkV "چاھڻ "  ** { isAux = False} ;
  we_Pron = personalPN "اسان" "اسان" "اسان" "اسانجo" "اسانجo" Pl Masc Pers1 ;
  whatSg_IP = mkIP "ڇا" "ڇو" "" "" Sg Masc ;
  whatPl_IP = mkIP "ڇا" "ڇو " " " "" Pl Masc ;
  when_IAdv = ss "ڪڏھن" ;
  when_Subj = ss "جڏھن" ;
  where_IAdv = ss "ڪٿی" ;
--which_IQuant = {s = \\_ => "ڪھڙو"} ;
  which_IQuant = mkIQuant "جیڪو" "جیڪی" "جیڪا" "جھڙو" ;
  whichPl_IDet = makeDet "جیڪY" "جنھن" ;
  whichSg_IDet = makeDet "جیڪو " "جیڪا"  ;
  whoSg_IP = mkIP "ڪیر" "ڪھنجی" "ڪھنجo" "" Sg Masc  ;
  whoPl_IP = mkIP "ڪیر" "ڪھنجا" "ڪھنجا" "" Pl Masc ;
  why_IAdv = ss "ڇو" ;
  without_Prep = mkPrep "کان سوا۶ " ;
  with_Prep = mkPrep "سان" ;
  yes_Phr = ss "ھا" ;
  yes_Utt = ss "ھا" ;
  youSg_Pron = personalPN "تون" "تون" "تون" "تھنجو" "تھنجی"  Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "توھان" "توھان" "توھان" "توھانجو" "توھانجی"  Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "توھان" "توھان" "توھان" "توھان جو" "توھان جی"  Pl Masc Pers2_Respect  ;
  no_Quant =  demoPN " ڇو ن" "ڇو ن" "ڇو ن " ; 
  not_Predet = {s="ن"} ;
  if_then_Conj = sd2 "جیڪڏھن" "ت" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["گھٽ می گھٽ"] ;
  at_most_AdN = mkAdN ["گھڻی کان گھڻو"];
  
--nothing_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪجھ شی ن" "ڪجھ شی ن" "ڪجھ شی ن" "ڪجھ شی ن" "ڪجھ شی ن" "ڪجھ شی ن" Masc )); 
  except_Prep = mkPrep "سوا۶ " ;
--nobody_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪو ب ن" "ڪو ب ن" "ڪو ب ن" "ڪو ب ن" "ڪو ب ن" "ڪو ب ن" Masc ));  

  as_CAdv = {s = "جی۶ن" ; p = "جھڙو"} ;
  have_V2 = mkV2 (mkV "رکڻ ") "" ;
  language_title_Utt = ss "ٻوlی" ;

}

