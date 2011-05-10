concrete StructuralPnb of Structural = CatPnb ** 
  open MorphoPnb, ParadigmsPnb, Prelude, NounPnb in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = ss "اتے" ;
  after_Prep = ss "توں بعد" ;
  all_Predet = ss "سارے" ;
  almost_AdA, almost_AdN = ss "تقریبا" ;
  although_Subj = ss "پاویں" ;
  always_AdV = ss "ہمیشہ" ;
  and_Conj = sd2 [] "تے" ** {n = Pl} ;
  because_Subj = ss "كیونكھ" ;
  before_Prep = ss "پلے" ;
  behind_Prep = ss "پیچھے" ;
  between_Prep = ss "وچكار" ;
  both7and_DConj = sd2 "دوویں" "تے" ** {n = Pl} ;
  but_PConj = ss "مگر" ;
  by8agent_Prep = ss "" ;
  by8means_Prep = ss "" ;
  can8know_VV,can_VV = mkV "سكنا" ** { isAux = True} ;
  during_Prep = ss ["دے وچ"] ;
  either7or_DConj = sd2 "كوی اك" "یا" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (MorphoPnb.mkN11 "ہر كوی")); -- not a good way coz need to include NounPnb
  every_Det = mkDet "ہر" "ہر" "ہر" "ہر" Sg;
  everything_NP = MassNP (UseN (MorphoPnb.mkN11 "ہر شے"));
  everywhere_Adv = mkAdv "ہر تھاں" ;
  few_Det = mkDet "كچھ" "كچھ" "كچھ" "كچھ" Pl ;
  first_Ord = {s = "پعہلا" ; n = Sg} ; --DEPRECATED
  for_Prep = ss "[دے واسطE]" ;
  from_Prep = ss "توں" ;
  he_Pron = personalPN "او" "اونوں" "او" "اورے" "اورا"  Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "ایتھے" ;
  here7to_Adv = mkAdv "ایتھے" ;
  here7from_Adv = mkAdv "ایتھوں" ;
  how_IAdv = ss "كسراں" ;
  how8many_IDet = makeIDet "كینے" "كینی" Pl ;
  how8much_IAdv  = ss "كینا" ;
  if_Subj = ss "اگر" ;
  in8front_Prep = ss ["دے سامنے"] ;
  i_Pron = personalPN "میں" "مینوں" "مینوں" "میتوں" "میرا" Sg Masc Pers1;
  in_Prep = ss "وچ" ;
  it_Pron  = personalPN "اے" "اینوں" "اینوں" "" "ایرا" Sg Masc Pers3_Near;
  less_CAdv = {s = "كٹ" ; p = ""} ;
  many_Det = mkDet "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" "بہت زیادہ" Pl ;
  more_CAdv = {s = "ہور" ; p = "" } ;
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
  no_Utt = ss "نیں" ;
  on_Prep = ss "اتے" ;
  one_Quant = demoPN "اك" "اك" "اك"  ; -- DEPRECATED
  only_Predet = ss "صرف" ;
  or_Conj = sd2 [] "یا" ** {n = Sg} ;
  otherwise_PConj = ss "یا فیر" ;
  part_Prep = ss "ہصہ" ;
  please_Voc = ss "مہربانi" ;
  possess_Prep = ss "دا" ;
  quite_Adv = ss "كہامoسہ" ;
  she_Pron = personalPN "او" "اونوں" "اونو" "اورے" "اورا" Sg Fem Pers3_Distant ;
  so_AdA = ss "سo" ;
  somebody_NP = MassNP (UseN (MorphoPnb.mkN11 "كوی" ));
  someSg_Det = mkDet "كچھ" "كچھ" "كچھ" "كچھ" Sg ;
  somePl_Det = mkDet "كچھ" "كچھ" "كچھ" "كچھ" Pl ;
  something_NP = MassNP (UseN (MorphoPnb.mkN11 "كوی شے"));
  somewhere_Adv = mkAdv "كتلے" ;
  that_Quant = demoPN "وہ" "اس" "ان" ;
  that_Subj = ss "كہ";
  there_Adv = mkAdv "اوتھے" ;
  there7to_Adv = mkAdv "اوتھے" ;
  there7from_Adv = mkAdv "اوتھوں" ;
  therefore_PConj = ss "اس لی" ;
  they_Pron = personalPN "او" "[اوناں نوN]" "او" "اوناں" "اوناں دا" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "اے" "ایرا" "ایناں";      
  through_Prep = ss "وچوں" ;
  too_AdA = ss "بہت" ;
--  to_Prep = ss "اونوں" ** {lock_Prep = <>};
  to_Prep = ss "نوں" ** {lock_Prep = <>};
  under_Prep = ss "تھلے" ** {lock_Prep = <>};
  very_AdA = ss "بہت" ;
  want_VV = mkV "چانا" ** { isAux = False} ;
  we_Pron = personalPN "اسی" "سانوں" "سانوں" "ساتوں" "ساڈا" Pl Masc Pers1 ;
  whatSg_IP = mkIP "كیا" "كرا" "كرا" "كرا" Sg Masc ; -- check it
--  whatPl_IP = mkIP "كیا" "كiن" "كiن" Pl Masc ;
  when_IAdv = ss "كدوں" ;
  when_Subj = ss "كدوں" ;
  where_IAdv = ss "كتھے" ;
  which_IQuant = mkIQuant "كیڑا" "كیڑی" "كیڑے" "كیڑی" ;
--  whichPl_IDet = makeDet "كون سا" "كون سی" "كون سے" "كون سی" ;
--  whichSg_IDet = makeDet "كون سا" "كون سی" "كون سے" "كون سی" ;
  whoSg_IP = mkIP "كون" "كرا" "كرا" "كرا" Sg Masc  ;
--  whoPl_IP = mkIP "كون" "كن" "كنہوں" Pl Masc ;
  why_IAdv = ss "كیوں" ;
  without_Prep = ss ["توں بغیر"] ;
  with_Prep = ss ["دے نال"] ;
--  yes_Phr = ss "ہاں" ;
  yes_Utt = ss "ہاں" ;
  youSg_Pron = personalPN "توں" "تینوں" "تینوں" "تیرے" "توواڈا" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "تسی" "توانوں" "توانوں" "تواڈے" "توواڈا" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "تسی" "توانوں" "توانوں" "تواڈے" "توواڈا" Sg Masc Pers2_Respect  ;
  no_Quant =  demoPN " كوی نہیں" "كوی نہیں" "كوی نہیں" ; 
  not_Predet = {s="نہیں"} ;
  if_then_Conj = sd2 "اگر" "تے" ** {n = Sg} ; 
  at_least_AdN = ss ["كم توں كم"] ;
  at_most_AdN = ss ["زیادہ توں زیادہ"];
  nothing_NP = MassNP (UseN (MorphoPnb.mkN11 "كچھ نیں" )); 
  except_Prep = ss "سواے" ;
  nobody_NP = MassNP (UseN (MorphoPnb.mkN11 "كوی نہیں"));  

  as_CAdv = {s = "ایناں" ; p = "جناں"} ;

  have_V2 = mkV2 (mkV "راكھنا") "" ;

 language_title_Utt = ss "پنجابی" ;

}

