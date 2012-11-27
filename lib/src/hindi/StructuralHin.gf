concrete StructuralHin of Structural = CatHin ** 
  open MorphoHin, ParadigmsHin, Prelude, NounHin,ParamX,CommonHindustani in {

  flags optimize=all ;
  coding = utf8;
  
  lin
  above_Prep = mkPrep ["के ऊपर"] ["के ऊपर"] ;
  after_Prep = mkPrep ["के बाद"]  ["के बाद"] ;
  all_Predet = ss "तमाम" ;
  almost_AdA, almost_AdN = mkAdN "तक़रीबन" ;
  although_Subj = ss "अगरचि" ;
  always_AdV = ss "हमेशा" ;
  and_Conj = sd2 [] "और" ** {n = Pl} ;
  because_Subj = ss "क्योंकि" ;
  before_Prep = mkPrep ["से पहले"] ["से पहले"] ; 
  behind_Prep = mkPrep ["के पीछे"] ["के पीछे"] ;
  between_Prep = mkPrep ["के दरमियान"] ["के दरमियान"] ;
  both7and_DConj = sd2 "दोनों" "और" ** {n = Pl} ;
  but_PConj = ss "लेकिन" ;
  by8agent_Prep = mkPrep "से" "से" ;
  by8means_Prep = mkPrep "पर" "पर" ;
  can8know_VV,can_VV = mkV "सकना" ** { isAux = True} ;
  during_Prep = mkPrep ["के दरमियान"] ["के दरमियान"] ;
  either7or_DConj = sd2 "कोई एक" "या" ** {n = Sg} ;
  everybody_NP =  MassNP (UseN (ParadigmsHin.mkN "हर कोई" "हर कोई" "हर कोई" "हर कोई" "हर कोई" "हर कोई" Masc )); 
  every_Det = mkDet "हर" "हर" "हर" "हर" Sg;
  everything_NP = MassNP (UseN (ParadigmsHin.mkN "हर चीज़" "हर चीज़" "हर चीज़ोँ" "सब चीज़ेँ" "सब चीज़ोँ" "सब चीज़ोँ" Masc ));
  everywhere_Adv = mkAdv "हर जगह" ;
  few_Det = mkDet "चंद" "चंद" "चंद" "चंद" Pl ;
  first_Ord = {s = "" ; n = Sg} ; --De:PRe:CATe:D
  for_Prep = mkPrep ["के लिये"] ["के लिये"]  ;
  from_Prep = mkPrep "से" "से" ;
  he_Pron = personalPN "वह" "उस" "" "उस का" "उस की" "उस के" "उस की" Sg Masc Pers3_Distant ;
  here_Adv = mkAdv "यहाँ" ;
  here7to_Adv = mkAdv ["यहाँ पर"] ;
  here7from_Adv = mkAdv ["यहाँ से"] ;
  how_IAdv = ss "कैसे" ;
  how8many_IDet = makeIDet "कितने" "कितनी" Pl ;
  how8much_IAdv  = ss "कितना" ;
  if_Subj = ss "अगर" ;
  in8front_Prep = mkPrep ["के सामने"] ["के सामने"] ;
  i_Pron = personalPN "मैं" "मुझ" "" "मेरा" "मेरी" "मेरे" "मेरी" Sg Masc Pers1;
  in_Prep = mkPrep "में" "में" ;
  it_Pron  = personalPN "यह" "इस" "यह" "इस का" "इस की" "उस के" "उस की" Sg Masc Pers3_Near;
  less_CAdv = {s = "कम" ; p = ""} ;
  many_Det = mkDet "बहुत" "बहुत" "बहुत" "बहुत" Pl ;
  more_CAdv = {s = "ज़्यादा" ; p = "से" } ;
  most_Predet = ss "सब से ज़्यादा" ;
  much_Det = mkDet "बहुत" "बहुत" "बहुत" "बहुत" Sg  ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["हवe तo"] ;
--      VVF VPres => "मुसत" ;
--      VVF VPPart => ["हद तo"] ;
--      VVF VPresPart => ["हविनग तo"] ;
--      VVF VPast => ["हद तo"] ;      --# notpresent
--      VVPastNeg => ["हदn'त तo"] ;      --# notpresent
--      VVPresNeg => "मुसतn'त"
--      } ;
--    isAux = True
--    } ;
  no_Utt = ss "नहीं" ;
  on_Prep = mkPrep "पर" "पर" ;
--  one_Quant = demoPN "" ; -- De:PRe:CATe:D
  only_Predet = ss "सिर्फ़" ;
  or_Conj = sd2 [] "या" ** {n = Sg} ;
  otherwise_PConj = ss "नहीं तो" ;
  part_Prep = mkPrep "" "" ;
  please_Voc = ss "कृपया" ;
  possess_Prep = mkPrep "का" "की" ;
  quite_Adv = ss "काफ़ी" ;
  she_Pron = personalPN "वह" "उस" "उस" "उस का" "उस की" "उस के" "उस की"  Sg Fem Pers3_Distant ; -- chek with prasad about 'Us'
  so_AdA = ss "तो" ;
  somebody_NP = MassNP (UseN (ParadigmsHin.mkN "कोई" "कोई" "कोई" "कोई" "कोई" "कोई" Masc ));
  someSg_Det = mkDet "कुछ" "कुछ" "कुछ" "कुछ" Sg ;
  somePl_Det = mkDet "कुछ" "कुछ" "कुछ" "कुछ" Pl ;
  something_NP = MassNP (UseN (ParadigmsHin.mkN ["कोई चीज़"] ["कोई चीज़"] ["कोई चीज़"] ["कोई चीज़"] ["कोई चीज़"] ["कोई चीज़"] Masc ));
  somewhere_Adv = mkAdv ["कहीं"] ;
  that_Quant = demoPN "वह" "वे" "उस" "उन" ;
  that_Subj = ss "कि";
  there_Adv = mkAdv "वहाँ" ;
  there7to_Adv = mkAdv ["वहाँ पर"] ;
  there7from_Adv = mkAdv ["वहाँ से"] ;
  therefore_PConj = ss "इस लिये" ;
  they_Pron = personalPN "वे" "वे" "वे" "उन का" "उन की" "उन के" "उन की" Pl Masc Pers3_Distant ; ---- 
  this_Quant = demoPN "यह" "ये" "इस" "इन";      
  through_Prep = mkPrep ["में से"] ["में से"] ;
  too_AdA = ss "बहुत" ;
  to_Prep = mkPrep "को" "को" ; -- ** {lock_Prep = <>};
  under_Prep = mkPrep ["के नीचे"] ["के नीचे"] ; -- ** {lock_Prep = <>};
  very_AdA = ss "बहुत" ;
  want_VV = mkV "चाहना" ** { isAux = False} ;
  we_Pron = personalPN "हम" "हम" "हम" "हमारा" "हमारी" "हमारे" "हमारी" Pl Masc Pers1 ;
  whatSg_IP = mkIP "क्या" "क्या" "क्या" Sg Masc ; -- confirm
  whatPl_IP = mkIP "क्या" "क्या" "क्या" Pl Masc ;
  when_IAdv = ss "कब" ;
  when_Subj = ss "कब" ;
  where_IAdv = ss "कहाँ" ;
  which_IQuant = mkIQuant ["कौन सा"] ["कौन से"] "" ["कौन सी"] ["कौन सी"] ""
                          ["कौन से"] ["कौन से"] "" ["कौन सी"] ["कौन सी"] "" ; -- need to put right forms Prasad
--  whichPl_IDet = makeDet "" ;
--  whichSg_IDet = makeDet "";
  whoSg_IP = mkIP "कौन" "किस" "किस" Sg Masc  ;
  whoPl_IP = mkIP "कौन" "किन" "किनहों" Pl Masc ;
  why_IAdv = ss "क्यों" ;
--  without_Prep = mkPrep ;
  with_Prep = mkPrep ["के साथ"] ["के साथ"] ;
--  yes_Phr = ss "???" ;
  yes_Utt = ss "हाँ" ;
  youSg_Pron = personalPN "तू" "तुम" "तुम" "तुम्हारा" "तुम्हारी" "तुम्हारे" "तुम्हारी" Sg Masc Pers2_Casual ;
  youPl_Pron = personalPN "तुम" "तुम" "तुम" "तुम्हारा" "तुम्हारी" "तुम्हारे" "तुम्हारी" Pl Masc Pers2_Casual ;
  youPol_Pron = personalPN "आप" "आप" "आप" "आप का" "आप की" "आप के" "आप की" Sg Masc Pers2_Respect  ;
--  no_Quant =  demoPN "कोई नहीं" ; 
  not_Predet = {s="नहीं"} ;
--  if_then_Conj = sd2  "अगर तो" ** {n = Sg} ; 
  at_least_AdN = mkAdN ["कम से कम"] ;
  at_most_AdN = mkAdN ["ज़्यादा से ज़्यादा"];
--  nothing_NP = MassNP (UseN (ParadigmsHin.mkN "कुछ नहीं" Masc )); 
  except_Prep = mkPrep "के सिवाय" "के सिवाय";
--  nobody_NP = MassNP (UseN (ParadigmsHin.mkN "कोई नहीं" Masc ));  

  as_CAdv = {s = "इतना" ; p = "जितना"} ;

  have_V2 = mkV2 "रखना";

 language_title_Utt = ss "हिन्दी" ;

}

