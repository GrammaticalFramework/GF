concrete StructuralUrd of Structural = CatUrd ** 
  open MorphoUrd, ParadigmsUrd, Prelude, NounUrd in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "اوپر" ;
  after_Prep = ss "كے بعد" ;
  all_Predet = ss "تمام" ;
  almost_AdA, almost_AdN = ss "تقریبا" ;
  although_Subj = ss "اگرچھ" ;
  always_AdV = ss "ہمیشہ" ;
  and_Conj = sd2 [] "اور" ** {n = Pl} ;
  because_Subj = ss "كیونكھ" ;
  before_Prep = ss "پہلے" ;
  behind_Prep = ss "پیچھے" ;
  between_Prep = ss "درمیاں" ;
  both7and_DConj = sd2 "دونوں" "اور" ** {n = Pl} ;
  but_PConj = ss "لیكن" ;
  by8agent_Prep = ss "" ;
  by8means_Prep = ss "" ;
  can8know_VV,can_VV = mkV "سكنا" ** { isAux = True} ;
  during_Prep = ss ["كے درمیاں"] ;
  either7or_DConj = sd2 "كوی ایك" "یا" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsUrd.mkN "ہر كوی" "ہر كوی" "ہر كوی" "ہر كوی" "ہر كوی" "ہر كوی" Masc )); -- not a good way coz need to include NounUrd
  every_Det = mkDet "ہر" "ہر" "ہر" "ہر" Sg;
  everything_NP = MassNP (UseN (ParadigmsUrd.mkN "ہر چیز" "ہر چیز" "ہر چیزو" "سب چیزیں" "سب چیزوں" "سب چیزو" Masc ));
  everywhere_Adv = ss "ہر جگہ" ;
  few_Det = mkDet "چند" "چند" "چند" "چند" Pl ;
  for_Prep = ss "كیلیے" ;
  from_Prep = ss "سے" ;
  he_Pron = personalPN "وہ" "اس" "" "اس كا"  Sg Masc Pers3_Distant ;
  here_Adv = ss "یہاں" ;
  here7to_Adv = ss ["یہاں پر"] ;
  here7from_Adv = ss ["یہاں سے"] ;
  how_IAdv = ss "ہoو" ;
  how8many_IDet = makeIDet "كتنے" "كتنی" Pl ;
  if_Subj = ss "اگر" ;
  in8front_Prep = ss ["كے سامنے"] ;
  i_Pron = personalPN "میں" "مجھ" "" "میرا" Sg Masc Pers1;
  in_Prep = ss "معں" ;
  it_Pron  = personalPN "یہ" "یہ" "یہ" "اس كا" Sg Masc Pers3_Near;
  less_CAdv = {s = "كم" ; p = ""} ;
  many_Det = mkDet "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" Pl ;
  more_CAdv = {s = "زیادھ" ; p = "" } ;
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
  on_Prep = ss "پر" ;
--  one_Quant = demoPN "ایك" "ایك" "ایك" ; -- DEPRECATED
  only_Predet = ss "سرف" ;
  or_Conj = sd2 [] "یا" ** {n = Sg} ;
  otherwise_PConj = ss "یا پھر" ;
  part_Prep = ss "" ;
  please_Voc = ss "مہربانi" ;
  possess_Prep = ss "كا" ;
  quite_Adv = ss "كہامoسہ" ;
  she_Pron = personalPN "وہ" "اس" "وہ" "اس كی" Sg Fem Pers3_Distant ;
  so_AdA = ss "سo" ;
  somebody_NP = MassNP (UseN (ParadigmsUrd.mkN "كوی" "كوی" "كوی" "كوی" "كوی" "كوی" Masc ));
  someSg_Det = mkDet "كچھ" "كچھ" "كچھ" "كچھ" Sg ;
  somePl_Det = mkDet "كچھ" "كچھ" "كچھ" "كچھ" Pl ;
  something_NP = MassNP (UseN (ParadigmsUrd.mkN "كوی چیز" "كوی چیز" "كوی چیز" "كھ چیزیں" "كھ چیزوں" "كھ چیزو" Masc ));
  somewhere_Adv = ss "كہiن پر" ;
  that_Quant = demoPN "وہ" "اس" "ان" ;
  that_Subj = ss "كہ";
  there_Adv = ss "وہاں" ;
  there7to_Adv = ss "وہاں پر" ;
  there7from_Adv = ss ["وہاں سے"] ;
  therefore_PConj = ss "اس لیے" ;
  they_Pron = personalPN "وہ" "وہ" "وہ" "ان كا" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "یہ" "اس" "ان";      
  through_Prep = ss ["میں سے"] ;
  too_AdA = ss "بہت" ;
  to_Prep = ss "كو" ;
  under_Prep = ss "نیچے" ;
  very_AdA = ss "بہت" ;
  want_VV = mkV "چاہنا" ** { isAux = False} ;
  we_Pron = personalPN "ہم" "ہم" "ہم" "ہمارا" Pl Masc Pers1 ;
  whatSg_IP = mkIP "كیا" "كiس" "كiس" Sg Masc ;
  whatPl_IP = mkIP "كیا" "كiن" "كiن" Pl Masc ;
  when_IAdv = ss "كب" ;
  when_Subj = ss "كب" ;
  where_IAdv = ss "كہاں" ;
  which_IQuant = {s = \\_ => "كون سی"} ;
--  whichPl_IDet = makeDet "كون سا" "كون سی" "كون سے" "كون سی" ;
--  whichSg_IDet = makeDet "كون سا" "كون سی" "كون سے" "كون سی" ;
  whoSg_IP = mkIP "كون" "كiس" "كiس" Sg Masc  ;
  whoPl_IP = mkIP "كون" "كن" "كنہوں" Pl Masc ;
  why_IAdv = ss "كیوں" ;
  without_Prep = ss ["كے بغیر"] ;
  with_Prep = ss ["كے ساتھ"] ;
--  yes_Phr = ss "ہاں" ;
  yes_Utt = ss "ہاں" ;
  youSg_Pron = personalPN "تم" "تم" "تم" "تمھارا" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "تم" "تم" "تم" "تمھارا" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "آپ" "آP" "آP" "آپ كا" Sg Masc Pers2_Respect  ;
  no_Quant =  demoPN " كوی نہیں" "كوی نہیں" "كوی نہیں" ; 
  not_Predet = {s="نہیں"} ;
  if_then_Conj = sd2 "اگر" "تو" ** {n = Sg} ; 
  at_least_AdN = ss ["كم از كم"] ;
  at_most_AdN = ss ["زیادہ سے زیادہ"];
  nothing_NP = MassNP (UseN (ParadigmsUrd.mkN "كوی چیز نہیں" "كوی چیز نہیں" "كوی چیز نہیں" "كوی چیز نہیں" "كوی چیز نہیں" "كوی چیز نہیں" Masc )); 
  except_Prep = ss "سواے" ;
  nobody_NP = MassNP (UseN (ParadigmsUrd.mkN "كوی نہیں" "كوی نہیں" "كوی نہیں" "كوی نہیں" "كوی نہیں" "كوی نہیں" Masc ));  

  as_CAdv = {s = "عتنا" ; p = "جتنا"} ;

  have_V2 = mkV2 (mkV "راكھنا") "" ;

 language_title_Utt = ss "اردو" ;

}

