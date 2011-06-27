concrete StructuralNep of Structural = CatNep ** 
  open MorphoNep, ParadigmsNep, Prelude, NounNep in {

  flags 
    optimize = all ;
    coding = utf8;

  lin

    above_Prep = mkPrep "माथि" ; -- माथि
    after_Prep = mkPrep "पछि" ; -- पछि
    all_Predet = ss "सबै" ; -- सबै (adj)
    almost_AdA = mkAdA "झण्डै" ;
    almost_AdN = mkAdN "झण्डै" ; -- JNx:xE (Adv) झण्डै
    although_Subj = ss "तैपनि" ; -- तैपनि (conj)
    always_AdV = mkAdV "सधैँ" ; -- सधैँ
    and_Conj = sd2 [] "र" ** {n = Pl} ;
    because_Subj = ss "किनभने" ; -- किनभने
    before_Prep = mkPrep "अघि" ; -- अघि 
    behind_Prep = mkPrep "पछि" ; -- पछि
    between_Prep = mkPrep "बिच" ; -- बिच
    both7and_DConj = sd2 "दुबै" "र" ** {n = Pl} ; -- दुबै र
    but_PConj = ss "तर" ; -- तर
    by8agent_Prep = mkPrep "लाइ" ; -- 
    by8means_Prep = mkPrep "ले" ; 
    can8know_VV,can_VV = mkV "सक्नु" ** { isAux = True} ;
    during_Prep = mkPrep "पर्यान्त" ; -- पर्यान्त
    either7or_DConj = sd2 "की" "अथवा" ** {n = Sg} ; -- की,  अथवा 
    everybody_NP =  MassNP (UseN (regN "सवौ जाना" Living)) ; -- not a good way coz need to include Noun (सवौ जाना)
    every_Det = mkDet "सबै" "हरेक" Sg ; -- सबै, हरेक
    everything_NP = MassNP (UseN (regN "हारेक कुरा" NonLiving)) ; -- हारेक कुरा
    everywhere_Adv = mkAdv "जाता ततै" ; -- जाता ततै
    few_Det = mkDet "थोरै" "अलिकती" Pl ; -- थोरै, अलिकती
--  d    first_Ord = {s = "पेहला" ; n = Sg} ; --DEPRECATED
    for_Prep = mkPrep "लागि" ; -- लागि
    from_Prep = mkPrep "बाट" ; -- बाट
    
    i_Pron = mkPron "म" "मेरो" Sg Masc Pers1 ; -- म, मेरो
    we_Pron = mkPron "हामीहरु" "हामीहरुको" Pl Masc Pers1 ; -- हामीहरु, हामीहरुको    
    he_Pron = mkPron "उ" "उस्लाई" "उस्ले" "उस्लाई" "उसबाट" "उस्मा" "उस्को" Sg  Masc Pers3_L; --उ, उस्लाई, उस्ले, उस्लाई, उसवाट, उस्मा, उस्को
    she_Pron = mkPron "उनी" "उन्लाई" "उन्ले" "उन्लाई" "उनबाट" "उन्मा" "उन्को" Sg Fem Pers3_M ; -- उनी , उन्को
    youSg_Pron = mkPron "तिमी" "तिम्रो" Sg Masc Pers2_M ; -- तिमी, तिम्रो
    youPl_Pron = mkPron "तिमीहरु" "तिमीहरुको" Pl Masc Pers2_M ; -- तिमीहरु, तिमीहरुको
    youPol_Pron = mkPron "तपाई" "तपाईहरुको" Sg Masc Pers2_H  ; -- तपाई, तपाईहरुको
    they_Pron = mkPron "उनीहरु" "उनिहरुको" Pl Masc Pers3_L ; -- उनिहरु, उनिहरुको
    it_Pron  = mkPron "यो" "यसलाई" "येसले" "यसलाई" "यसबाट" "यसमा" "ुस्को" Sg Masc Pers3_L; -- यो, यसलाई, यसले, यसलाई, यसबाट, यसमा, उस्को
    
    here_Adv = mkAdv "यहाँ" ; -- यहाँ
    here7to_Adv = mkAdv ["यहाँ सम्म"] ; -- यहाँ सम्म
    here7from_Adv = mkAdv ["यहाँ बाट"] ; -- यहाँ बाट
    how_IAdv = ss "कसरी" ; -- कसरी
    how8much_IAdv  = ss "कती" ; -- कती
    how8many_IDet = mkIDetn "कती वटा" "कती वटी" Pl ;  -- काती वटा, कती वटी (incase of humans it becomes, 'kati jana') NEEDS FIX
    if_Subj = ss "यदि" ; -- यदि
    in8front_Prep = mkPrep "सामु" ; -- सामु      
    in_Prep = mkPrep "मा" ; -- मा    
    less_CAdv = {s = "कम" ; p = "भन्दा"} ; -- भन्दा कम
    many_Det = mkDet "धेरै" "थुप्रै" Pl ; -- धेरै, थुप्रै
    more_CAdv = {s = "बढी" ; p = "भन्दा" } ;
    most_Predet = ss "ज्यादै" ; -- ज्यादै
    much_Det = mkDet "निक्कै" "बेसरी" Sg  ; -- 
    must_VV = mkV "अवश्य" ** { isAux = True} ; -- अवश्य
--  must_VV = {
--    s = table {
--      VVF VInf => ["हावे तो"] ;
--      VVF VPres => "मुसत" ;
--      VVF VPPart => ["हाद तो"] ;
--      VVF VPresPart => ["हाविनग तो"] ;
--      VVF VPast => ["हाद तो"] ;      --# notpresent
--      VVPastNeg => ["हादn'त तो"] ;      --# notpresent
--      VVPresNeg => "मुसतn'त"
--      } ;
--    isAux = True
--    } ;
  
--  d    no_Phr = ss "हुन्न" ; -- हुन्न
    no_Utt = ss "होईन" ; -- होईन
    on_Prep = mkPrep "मा" ; -- मा
--  d    one_Quant = mkQuant "एक" "एक" ; -- DEPRECATED
    only_Predet = ss "मात्र" ; -- मात्र
    or_Conj = sd2 [] "अथवा" ** {n = Sg} ; -- अथवा
    otherwise_PConj = ss "अन्यथा" ; -- अन्यथा
    part_Prep = mkPrep "भाग" ; -- भाग
    please_Voc = ss "कृपया" ; -- कृपया
    possess_Prep = mkPrep "धारणा गर्नु" ; -- धारणा गर्नु
    quite_Adv = ss "एकदम" ; -- एकदम    
    so_AdA = mkAdA "यस कारण" ; -- यस कारण ???? NEED TO CHECK
    somebody_NP = MassNP (UseN (regN "कोही" Living)); -- कोही
    someSg_Det = mkDet "कोही" "केही" Sg ;
    somePl_Det = mkDet "कोही" "केही" Pl ;
    something_NP = MassNP (UseN (regN "केही  कुरा" NonLiving)) ;
    somewhere_Adv = mkAdv "कहीं" ; -- कहीं
    that_Quant = mkQuant "त्ये" "यिनीहरु" ;
    that_Subj = ss "त्यो"; -- त्यो
    there_Adv = mkAdv "त्यहाँ" ; -- त्यहाँ
    there7to_Adv = mkAdv "त्यहाँ सम्म" ; -- त्यहाँ सम्म
    there7from_Adv = mkAdv "त्यहाँ बाट" ; -- त्यहाँ बाट
    therefore_PConj = ss "अतः" ; -- अतः    
    this_Quant = mkQuant "यो" "यी" ; -- यो,  यी
    through_Prep = mkPrep "मार्फत" ; -- मार्फत
    too_AdA = mkAdA "पनि" ; -- पनि
    to_Prep = ss "सम्म" ; -- सम्म
    under_Prep = mkPrep "अन्तर्गत" ; -- अन्तर्गत
    very_AdA = mkAdA "धेरै" ; -- धेरै
    want_VV = mkV "चाहनु" ** { isAux = False} ;    
    whatSg_IP = mkIP "के" "के" "के" "" Sg ;
    whatPl_IP = mkIP "के" "के" "के" "" Pl ;
    when_IAdv = ss "कहिले" ; -- कहिले
    when_Subj = ss "कहिले" ;
    where_IAdv = ss "कहाँ" ; -- कहाँ
    which_IQuant = {s = table {Sg => "कुन" ; Pl => "कुन" } }; -- कुन
--  d    whichPl_IDet = {s = "कुन" ; n = Sg} ;
--  d    whichSg_IDet = {s = "कुन" ; n = Pl} ;
    whoSg_IP = mkIP "को" "कासलाई" "कसको" "" Sg ; 
    whoPl_IP = mkIP "को" "कासलाई" "कसको" "" Pl ;
    why_IAdv = ss "किन" ; -- किन
    without_Prep = mkPrep "विना" ; -- विना
    with_Prep = mkPrep "सँग" ; -- सँग
--  d    yes_Phr = ss "हजुर" ; -- हजुर
    yes_Utt = ss "हजुर" ;  
    no_Quant =  mkQuant "हैन" "हैनै" ;
    not_Predet = {s="हैन"} ; -- हैन
    if_then_Conj = sd2 "यदि" "भने" ** {n = Sg} ; -- यदि भने
    at_least_AdN = mkAdN "कमसेकम" ; -- कमसेकम
    at_most_AdN = mkAdN "बढीमा" ; -- बढीमा
    nothing_NP = MassNP (UseN (regN "केही पनी")) ; -- केही पनी
    nobody_NP = MassNP (UseN (regN "केही पनी" living)) ; --कोही पनी
    except_Prep = mkPrep "बाहेक" ; -- बाहेक
    as_CAdv = {s = "जत्तीकै" ; p = ""} ;  -- जत्तीकै
    have_V2 = mkV2 (mkV "हुनु") "" ; -- हुनु
    language_title_Utt = ss "नेपाली" ; -- नेपाली
}
