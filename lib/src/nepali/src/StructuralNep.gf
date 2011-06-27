concrete StructuralNep of Structural = CatNep ** 
  open MorphoNep, ParadigmsNep, Prelude, NounNep in {

  flags 
    optimize = all ;
    coding = utf8;

  lin

    above_Prep = mkPrep "maTi" ; -- माथि
    after_Prep = mkPrep "pci" ; -- पछि
    all_Predet = ss "sbE" ; -- सबै (adj)
    almost_AdA = mkAdA "JNx:xE" ;
    almost_AdN = mkAdN "JNx:xE" ; -- JNx:xE (Adv) झण्डै
    although_Subj = ss "tEpni" ; -- तैपनि (conj)
    always_AdV = mkAdV "sDEV" ; -- सधैँ
    and_Conj = sd2 [] "r" ** {n = Pl} ;
    because_Subj = ss "kinBne" ; -- किनभने
    before_Prep = mkPrep "HGi" ; -- अघि 
    behind_Prep = mkPrep "pci" ; -- पछि
    between_Prep = mkPrep "biC" ; -- बिच
    both7and_DConj = sd2 "dubE" "r" ** {n = Pl} ; -- दुबै र
    but_PConj = ss "tr" ; -- तर
    by8agent_Prep = mkPrep "lai:" ; -- 
    by8means_Prep = mkPrep "le" ; 
    can8know_VV,can_VV = mkV "skx:nu" ** { isAux = True} ;
    during_Prep = mkPrep "prx:yanx:t" ; -- पर्यान्त
    either7or_DConj = sd2 "kI" "HTva" ** {n = Sg} ; -- की,  अथवा 
    everybody_NP =  MassNP (UseN (regN "svw jana" Living)) ; -- not a good way coz need to include Noun (सवौ जाना)
    every_Det = mkDet "sbE" "hrek" Sg ; -- सबै, हरेक
    everything_NP = MassNP (UseN (regN "harek kura" NonLiving)) ; -- हारेक कुरा
    everywhere_Adv = mkAdv "jata ttE" ; -- जाता ततै
    few_Det = mkDet "TorE" "HliktI" Pl ; -- थोरै, अलिकती
--  d    first_Ord = {s = "pehla" ; n = Sg} ; --DEPRECATED
    for_Prep = mkPrep "lagi" ; -- लागि
    from_Prep = mkPrep "baq" ; -- बाट
    
    i_Pron = mkPron "m" "mero" Sg Masc Pers1 ; -- म, मेरो
    we_Pron = mkPron "hamIhru" "hamIhruko" Pl Masc Pers1 ; -- हामीहरु, हामीहरुको    
    he_Pron = mkPron "f" "fsx:laI:" "fsx:le" "fsx:laI:" "fsbaq" "fsx:ma" "fsx:ko" Sg  Masc Pers3_L; --उ, उस्लाई, उस्ले, उस्लाई, उसवाट, उस्मा, उस्को
    she_Pron = mkPron "fnI" "fnx:laI:" "fnx:le" "fnx:laI:" "fnbaq" "fnx:ma" "fnx:ko" Sg Fem Pers3_M ; -- उनी , उन्को
    youSg_Pron = mkPron "timI" "timx:ro" Sg Masc Pers2_M ; -- तिमी, तिम्रो
    youPl_Pron = mkPron "timIhru" "timIhruko" Pl Masc Pers2_M ; -- तिमीहरु, तिमीहरुको
    youPol_Pron = mkPron "tpaI:" "tpaI:hruko" Sg Masc Pers2_H  ; -- तपाई, तपाईहरुको
    they_Pron = mkPron "fnIhru" "fnihruko" Pl Masc Pers3_L ; -- उनिहरु, उनिहरुको
    it_Pron  = mkPron "yo" "yslaI:" "yesle" "yslaI:" "ysbaq" "ysma" "usx:ko" Sg Masc Pers3_L; -- यो, यसलाई, यसले, यसलाई, यसबाट, यसमा, उस्को
    
    here_Adv = mkAdv "yhaV" ; -- यहाँ
    here7to_Adv = mkAdv ["yhaV smx:m"] ; -- यहाँ सम्म
    here7from_Adv = mkAdv ["yhaV baq"] ; -- यहाँ बाट
    how_IAdv = ss "ksrI" ; -- कसरी
    how8much_IAdv  = ss "ktI" ; -- कती
    how8many_IDet = mkIDetn "ktI vqa" "ktI vqI" Pl ;  -- काती वटा, कती वटी (incase of humans it becomes, 'kati jana') NEEDS FIX
    if_Subj = ss "ydi" ; -- यदि
    in8front_Prep = mkPrep "samu" ; -- सामु      
    in_Prep = mkPrep "ma" ; -- मा    
    less_CAdv = {s = "km" ; p = "Bnx:da"} ; -- भन्दा कम
    many_Det = mkDet "DerE" "Tupx:rE" Pl ; -- धेरै, थुप्रै
    more_CAdv = {s = "bXI" ; p = "Bnx:da" } ;
    most_Predet = ss "jx:yadE" ; -- ज्यादै
    much_Det = mkDet "nikx:kE" "besrI" Sg  ; -- 
    must_VV = mkV "HvSx:y" ** { isAux = True} ; -- अवश्य
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
  
--  d    no_Phr = ss "hunx:n" ; -- हुन्न
    no_Utt = ss "hoI:n" ; -- होईन
    on_Prep = mkPrep "ma" ; -- मा
--  d    one_Quant = mkQuant "e:k" "e:k" ; -- DEPRECATED
    only_Predet = ss "matx:r" ; -- मात्र
    or_Conj = sd2 [] "HTva" ** {n = Sg} ; -- अथवा
    otherwise_PConj = ss "Hnx:yTa" ; -- अन्यथा
    part_Prep = mkPrep "Bag" ; -- भाग
    please_Voc = ss "kRpya" ; -- कृपया
    possess_Prep = mkPrep "DarNa grx:nu" ; -- धारणा गर्नु
    quite_Adv = ss "e:kdm" ; -- एकदम    
    so_AdA = mkAdA "ys karN" ; -- यस कारण ???? NEED TO CHECK
    somebody_NP = MassNP (UseN (regN "kohI" Living)); -- कोही
    someSg_Det = mkDet "kohI" "kehI" Sg ;
    somePl_Det = mkDet "kohI" "kehI" Pl ;
    something_NP = MassNP (UseN (regN "kehI  kura" NonLiving)) ;
    somewhere_Adv = mkAdv "khIM" ; -- कहीं
    that_Quant = mkQuant "tx:ye" "yinIhru" ;
    that_Subj = ss "tx:yo"; -- त्यो
    there_Adv = mkAdv "tx:yhaV" ; -- त्यहाँ
    there7to_Adv = mkAdv "tx:yhaV smx:m" ; -- त्यहाँ सम्म
    there7from_Adv = mkAdv "tx:yhaV baq" ; -- त्यहाँ बाट
    therefore_PConj = ss "Hth:" ; -- अतः    
    this_Quant = mkQuant "yo" "yI" ; -- यो,  यी
    through_Prep = mkPrep "marx:Pt" ; -- मार्फत
    too_AdA = mkAdA "pni" ; -- पनि
    to_Prep = ss "smx:m" ; -- सम्म
    under_Prep = mkPrep "Hnx:trx:gt" ; -- अन्तर्गत
    very_AdA = mkAdA "DerE" ; -- धेरै
    want_VV = mkV "Cahnu" ** { isAux = False} ;    
    whatSg_IP = mkIP "ke" "ke" "ke" "" Sg ;
    whatPl_IP = mkIP "ke" "ke" "ke" "" Pl ;
    when_IAdv = ss "khile" ; -- कहिले
    when_Subj = ss "khile" ;
    where_IAdv = ss "khaV" ; -- कहाँ
    which_IQuant = {s = table {Sg => "kun" ; Pl => "kun" } }; -- कुन
--  d    whichPl_IDet = {s = "kun" ; n = Sg} ;
--  d    whichSg_IDet = {s = "kun" ; n = Pl} ;
    whoSg_IP = mkIP "ko" "kaslaI:" "ksko" "" Sg ; 
    whoPl_IP = mkIP "ko" "kaslaI:" "ksko" "" Pl ;
    why_IAdv = ss "kin" ; -- किन
    without_Prep = mkPrep "vina" ; -- विना
    with_Prep = mkPrep "sVg" ; -- सँग
--  d    yes_Phr = ss "hjur" ; -- हजुर
    yes_Utt = ss "hjur" ;  
    no_Quant =  mkQuant "hEn" "hEnE" ;
    not_Predet = {s="hEn"} ; -- हैन
    if_then_Conj = sd2 "ydi" "Bne" ** {n = Sg} ; -- यदि भने
    at_least_AdN = mkAdN "kmsekm" ; -- कमसेकम
    at_most_AdN = mkAdN "bXIma" ; -- बढीमा
    nothing_NP = MassNP (UseN (regN "kehI pnI")) ; -- केही पनी
    nobody_NP = MassNP (UseN (regN "kehI pnI" living)) ; --कोही पनी
    except_Prep = mkPrep "bahek" ; -- बाहेक
    as_CAdv = {s = "jtx:tIkE" ; p = ""} ;  -- जत्तीकै
    have_V2 = mkV2 (mkV "hunu") "" ; -- हुनु
    language_title_Utt = ss "nepalI" ; -- नेपाली
}
