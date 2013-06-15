concrete StructuralSnd of Structural = CatSnd ** 
  open MorphoSnd, ParadigmsSnd, Prelude in {

  flags optimize=all ;
  coding = utf8;

  lin
  above_Prep = mkPrep "مٿي" ;
  after_Prep = mkPrep "کان پوء"  ;
  all_Predet = ss "سڀ" ;
  almost_AdA, almost_AdN = mkAdN "گھڻو ڪري" ;
  although_Subj = ss "جيتوڻيڪ " ;
  always_AdV = ss "ھميشه" ;
  and_Conj = sd2 [] "۽" ** {n = Pl} ;
  because_Subj = ss "ڇاڪاڻ ته" ;
  before_Prep = mkPrep  "پھرين" ;
  behind_Prep = mkPrep "پٺتي" ;
  between_Prep = mkPrep "جي وچ ۾"  ;
  both7and_DConj = sd2 "ٻئي" "۽" ** {n = Pl} ;
  but_PConj = ss "پر" ;
  by8agent_Prep = mkPrep  "ھٿان"   ;
  by8means_Prep = mkPrep "ڪان"  ;
  can8know_VV,can_VV = mkV "سگھڻ" ** { isAux = True} ;
  during_Prep = mkPrep "وچ ۾" ;
  either7or_DConj = sd2 "ڪو ٻيو" "يا" ** {n = Sg} ;
--everybody_NP =  MassNP (UseN (ParadigmsSnd.mkN "ھر ڪوئي" "ھر ڪوئي" "ھر ڪوئي" "ھر ڪوئي"  Masc )); -- not a good way coz need to include NounSnd
  every_Det = mkDet "ھر ھڪ" "ھر ھڪ" "ھر ھڪ"  "ھر ھڪ"  Sg;
--everything_NP = MassNP (UseN (ParadigmsSnd.mkN "ھر شيء" "ھر شيء" "ھر شيء" "سڀ ڪجھ"  Masc ));
  everywhere_Adv = mkAdv "ھر ھنڌ"  ;
  few_Det = mkDet "ڪجھ" "ڪجھ" "ڪجھ" "ڪجھ" Pl ;
  first_Ord = {s = "پھريون" ; n = Sg} ; --DEPRECATED
  for_Prep = mkPrep "لاءِ";
  from_Prep = mkPrep  "وٽان"  ;
  he_Pron = personalPN "ھو" "ھو" "" ["ھو "] ["ھو"] Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "ھتي"  ;
  here7to_Adv = mkAdv "اجھو" ;
  here7from_Adv = mkAdv ["ھيڏانھن"] ;
  how_IAdv = ss  "ڪيئن" ;
  how8many_IDet = makeIDet "ڪيترا" "ڪيترا" Pl ;
  how8much_IAdv  = ss  "ڪيترا";
  if_Subj = ss "جيڪڏھن" ;
  in8front_Prep = mkPrep ["جي سامھون"]  ;
  i_Pron = personalPN "مان" "مھنجا" "منھنجو" "مان" " " Sg Masc Pers1;
  in_Prep = mkPrep "۾"  ;
  it_Pron  = personalPN "اھا" "ھن" "اھو" "اھا" "" Sg Masc Pers3_Near;
  less_CAdv = {s = "گھٽ" ; p = ""} ;
  many_Det = mkDet "گھڻا" "گھڻي" "ڪافي" "ڪيترا" Pl ;
  more_CAdv = {s = "وڌيڪ"; p =  "گھڻا" } ;
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
  no_Phr = ss "نه" ;
  no_Utt = ss  "نا" ;
  on_Prep = mkPrep "مٿان" ;
  one_Quant = demoPN "ھڪ" "ھڪ" "ھڪ" ; -- DEPRECATED
  only_Predet = ss "صرف" ;
  or_Conj = sd2 [] "يا" ** {n = Sg} ;
  otherwise_PConj = ss "نه ته پوءِ"  ;
  part_Prep = mkPrep "حصو"  ;
  possess_Prep = mkPrep[ "جو يا جي"] ;
  please_Voc = ss "مھرباني" ;
  quite_Adv = ss "ڇڏڻ" ;
  she_Pron = personalPN "ھوء" "ھو" "ھو" ["ھوء"] ["ھوء"] Sg Fem Pers3_Distant ;
  so_AdA = ss "ان ڪري" ;
--somebody_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪوئي" "ڪوئي" "ڪوئي" "ڪوئي"  Masc ));
  someSg_Det = mkDet "ڪجھ " "ڪجھ " "ڪجھ " "ڪجھ " Sg ;
  somePl_Det = mkDet "ڪجھ " "ڪجھ " "ڪجھ " "ڪجھ " Pl ;
--something_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪا شي" "ڪا شي" "ڪا شي" "ڪا شيون" Masc ));
  somewhere_Adv = mkAdv "ڪٿي" ;
  that_Quant = demoPN "جيڪو" "" ""   ;
  that_Subj = ss "اھا" ;
  there_Adv = mkAdv "اتي" ;
  there7to_Adv = mkAdv ["ھتي"] ;
  there7from_Adv = mkAdv ["ھتان"] ;
  therefore_PConj = ss "ان ڪري" ;
  they_Pron = personalPN "اھي" "اھي" "اھي" ["انهن جو"] ["انهن جو"] Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "ھي" "ھن" "";     
  through_Prep = mkPrep "منجھان" ;
  under_Prep = mkPrep " ھيٺان"  ; -- ** {lock_Prep = <>};
  too_AdA = ss  "بيحد";
  to_Prep = mkPrep "ڏانھن"  ; -- ** {lock_Prep = <>};
  very_AdA = ss "تمام" ;
  want_VV = mkV "چاھڻ "  ** { isAux = False} ;
  we_Pron = personalPN "اسان" "اسان" "اسان" "اسانجو" "اسانجو" Pl Masc Pers1 ;
  whatSg_IP = mkIP "ڇا" "ڇو" "" "" Sg Masc ;
  whatPl_IP = mkIP "ڇا" "ڇو " " " "" Pl Masc ;
  when_IAdv = ss "ڪڏھن" ;
  when_Subj = ss "جڏھن" ;
  where_IAdv = ss "ڪٿي" ;
--which_IQuant = {s = \\_ => "ڪھڙو"} ;
  which_IQuant = mkIQuant "جيڪو" "جيڪي" "جيڪا" "جھڙو" ;
  whichPl_IDet = makeDet "جيڪي" "جنھن" ;
  whichSg_IDet = makeDet "جيڪو " "جيڪا"  ;
  whoSg_IP = mkIP "ڪير" "ڪنھنجي" "ڪنھنجو" "" Sg Masc  ;
  whoPl_IP = mkIP "ڪير" "ڪنھنجا" "ڪنھنجا" "" Pl Masc ;
  why_IAdv = ss "ڇو" ;
  without_Prep = mkPrep "کان سواءِ" ;
  with_Prep = mkPrep "سان" ;
  yes_Phr = ss "ھا" ;
  yes_Utt = ss "ھا" ;
  youSg_Pron = personalPN "تون" "تون" "تون" "تنھنجو" "تنھنجي"  Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "توھان" "توھان" "توھان" "توھانجو" "توھانجي"  Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "توھان" "توھان" "توھان" "توھان جو" "توھان جي"  Pl Masc Pers2_Respect  ;
  no_Quant =  demoPN " ڇو نه" "ڇو نه" "ڇو نه " ; 
  not_Predet = {s="ن"} ;
  if_then_Conj = sd2 "جيڪڏھن" "ته" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["گھٽ ۾ گھٽ"] ;
  at_most_AdN = mkAdN ["گھڻي کان گھڻو"];
  
--nothing_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪجھ شي ن" "ڪجھ شي ن" "ڪجھ شي ن" "ڪجھ شي ن" "ڪجھ شي ن" "ڪجھ شي ن" Masc )); 
  except_Prep = mkPrep "سواءِ" ;
--nobody_NP = MassNP (UseN (ParadigmsSnd.mkN "ڪو به نه" "ڪو به نه" "ڪو به نه" "ڪو به نه" "ڪو به نه" "ڪو به نه" Masc ));  

  as_CAdv = {s = "جيئن" ; p = "جھڙو"} ;
  have_V2 = mkV2 (mkV "رکڻ ") "" ;
  language_title_Utt = ss "ٻولي" ;

}

