concrete StructuralUrd of Structural = CatUrd ** 
  open MorphoUrd, ParadigmsUrd, Prelude, NounUrd,ParamX,CommonHindustani in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep ["کے اوپر"] ["کے اوپر"] ;
  after_Prep = mkPrep ["کے بعد"] ["کے بعد"] ;
  all_Predet = ss "تمام" ;
  almost_AdA, almost_AdN = mkAdN "تقریبا" ;
  although_Subj = ss "اگرچہ" ;
  always_AdV = ss "ہمیشہ" ;
  and_Conj = sd2 [] "اور" ** {n = Pl} ;
  because_Subj = ss "کیونکہ" ;
  before_Prep = mkPrep ["سے پہلے"] ["سے پہلے"] ;
  behind_Prep = mkPrep ["کے پیچھے"] ["کے پیچھے"] ;
  between_Prep = mkPrep "درمیاں" "درمیاں" ;
  both7and_DConj = sd2 "دونوں" "اور" ** {n = Pl} ;
  but_PConj = ss "لیکن" ;
  by8agent_Prep = mkPrep "سے" "" ;
  by8means_Prep = mkPrep "پر" "" ;
  can8know_VV,can_VV = mkV "سکنا" ** { isAux = True} ;
  during_Prep = mkPrep ["کے درمیاں"] ["کے درمیاں"] ;
  either7or_DConj = sd2 "کوی ایک" "یا" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsUrd.mkN "ہر کوی" "ہر کوی" "ہر کوی" "ہر کوی" "ہر کوی" "ہر کوی" Masc )); -- not a good way coz need to include NounUrd
  every_Det = mkDet "ہر" "ہر" "ہر" "ہر" Sg;
  everything_NP = MassNP (UseN (ParadigmsUrd.mkN "ہر چیز" "ہر چیز" "ہر چیزو" "سب چیزیں" "سب چیزوں" "سب چیزو" Masc ));
  everywhere_Adv = mkAdv "ہر جگہ" ;
  few_Det = mkDet "چند" "چند" "چند" "چند" Pl ;
  first_Ord = {s = "پعہلا" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "کیلیے" "کیلیے" ;
  from_Prep = mkPrep "سے" "سے" ;
  he_Pron = personalPN "وہ" "اس" "" ["اس کا"] ["اس کی"] ["اس کے"] ["اس کی"] Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "یہاں" ;
  here7to_Adv = mkAdv ["یہاں پر"] ;
  here7from_Adv = mkAdv ["یہاں سے"] ;
  how_IAdv = ss "کیسے" ;
  how8many_IDet = makeIDet "کتنے" "کتنی" Pl ;
  how8much_IAdv  = ss "کتنا" ;
  if_Subj = ss "اگر" ;
  in8front_Prep = mkPrep ["کے سامنے"] ["کے سامنے"] ;
  i_Pron = personalPN "میں" "مجھ" "" "میرا" "میری" "میرے" "میری" Sg Masc Pers1;
  in_Prep = mkPrep "میں" "میں" ;
  it_Pron  = personalPN "یہ" "اس" "اس" ["اس کا"] ["اس کی"] ["اس کے"] ["اس کی"] Sg Masc Pers3_Near;
  less_CAdv = {s = "کم" ; p = ""} ;
  many_Det = mkDet "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" Pl ;
  more_CAdv = {s = "زیادہ" ; p = "سے" } ;
  most_Predet = ss "زیادہ تر" ;
  much_Det = mkDet "بہت" "بہت" "بہت" "بہت" Sg  ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["ہاvع تo"] ;
--      VVF VPres => "مuست" ;
--      VVF VPPart => ["ہاد تo"] ;
--      VVF VPresPart => ["ہاviنگ تo"] ;
--      VVF VPast => ["ہاد تo"] ;      --# notpresent
--      VVPastNeg => ["ہادn'ت تo"] ;      --# notpresent
--      VVPresNeg => "مuستn'ت"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "نo" ;
  no_Utt = ss "نہیں" ;
  on_Prep = mkPrep "پر" "پر" ;
--  one_Quant = demoPN "ایک" "ایک" "ایک" ; -- DEPRECATED
  only_Predet = ss "صرف" ;
  or_Conj = sd2 [] "یا" ** {n = Sg} ;
  otherwise_PConj = ss "یا پھر" ;
  part_Prep = mkPrep "" "" ;
  please_Voc = ss "مہربانی" ;
  possess_Prep = mkPrep "کا" "کی" ;
  quite_Adv = ss "خاموش" ;
  she_Pron = personalPN "وہ" "اس" "وہ" ["اس کی"] ["اس کی"] ["اس کے"] ["اس کی"] Sg Fem Pers3_Distant ;
  so_AdA = ss "اس لیے" ;
  somebody_NP = MassNP (UseN (ParadigmsUrd.mkN "کوی" "کوی" "کوی" "کوی" "کوی" "کوی" Masc ));
  someSg_Det = mkDet "کچھ" "کچھ" "کچھ" "کچھ" Sg ;
  somePl_Det = mkDet "کچھ" "کچھ" "کچھ" "کچھ" Pl ;
  something_NP = MassNP (UseN (ParadigmsUrd.mkN "کوی چیز" "کوی چیز" "کوی چیز" "کھ چیزیں" "کھ چیزوں" "کھ چیزو" Masc ));
  somewhere_Adv = mkAdv ["کہیں پر"] ;
  that_Quant = demoPN "وہ" "اس" "ان" ;
  that_Subj = ss "کہ";
  there_Adv = mkAdv "وہاں" ;
  there7to_Adv = mkAdv ["وہاں پر"] ;
  there7from_Adv = mkAdv ["وہاں سے"] ;
  therefore_PConj = ss "اس لیے" ;
  they_Pron = personalPN "وہ" "وہ" "وہ" ["ان کا"] ["ان کی"] ["ان کے"] ["ان کی"] Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "یہ" "اس" "ان";      
  through_Prep = mkPrep ["میں سے"] ["میں سے"] ;
  too_AdA = ss "بہت" ;
  to_Prep = mkPrep "کو" "کو" ; -- ** {lock_Prep = <>};
  under_Prep = mkPrep "کے نیچے" "کے نیچے" ; -- ** {lock_Prep = <>};
  very_AdA = ss "بہت" ;
  want_VV = mkV "چاہنا" ** { isAux = False} ;
  we_Pron = personalPN "ہم" "ہم" "ہم" "ہمارا" "ہماری" "ہمارے" "ہماری" Pl Masc Pers1 ;
  whatSg_IP = mkIP "کیا" "کس" "کس" Sg Masc ;
  whatPl_IP = mkIP "کیا" "کن" "کن" Pl Masc ;
  when_IAdv = ss "کب" ;
  when_Subj = ss "جب" ;
  where_IAdv = ss "کہاں" ;
--  which_IQuant = {s = \\_ => "کون سی"} ;
  which_IQuant = mkIQuant "کون" ;
--  whichPl_IDet = makeDet "کون سا" "کون سی" "کون سے" "کون سی" ;
--  whichSg_IDet = makeDet "کون سا" "کون سی" "کون سے" "کون سی" ;
  whoSg_IP = mkIP "کون" "کس" "کس" Sg Masc  ;
  whoPl_IP = mkIP "کون" "کن" "کنہوں" Pl Masc ;
  why_IAdv = ss "کیوں" ;
  without_Prep = mkPrep ["کے بغیر"] ["کے بغیر"] ;
  with_Prep = mkPrep ["کے ساتھ"] ["کے ساتھ"] ;
--  yes_Phr = ss "ہاں" ;
  yes_Utt = ss "ہاں" ;
  youSg_Pron = personalPN "تو" "تو" "تو" "تیرا" "تیری" "تیرے" "تیری" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "تم" "تم" "تم" "تمھارا" "تمھاری" "تمھارے" "تمھاری" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "آپ" "آپ" "آپ" ["آپ کا"] ["آپ کی"] ["آپ کے"] ["آپ کی"] Pl Masc Pers2_Respect  ;
  no_Quant =  demoPN " کوی نہیں" "کوی نہیں" "کوی نہیں" ; 
  not_Predet = {s="نہیں"} ;
  if_then_Conj = sd2 "اگر" "تو" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["کم از کم"] ;
  at_most_AdN = mkAdN ["زیادہ سے زیادہ"];
  nothing_NP = MassNP (UseN (ParadigmsUrd.mkN "کوی چیز نہیں" "کوی چیز نہیں" "کوی چیز نہیں" "کوی چیز نہیں" "کوی چیز نہیں" "کوی چیز نہیں" Masc )); 
  except_Prep = mkPrep "کے سواے" "کے سواے" ;
  nobody_NP = MassNP (UseN (ParadigmsUrd.mkN "کوی نہیں" "کوی نہیں" "کوی نہیں" "کوی نہیں" "کوی نہیں" "کوی نہیں" Masc ));  

  as_CAdv = {s = "اتنا" ; p = "جتنا"} ;

  have_V2 = mkV2 (mkV "رکھنا") "" ;

 language_title_Utt = ss "اردو" ;

}

