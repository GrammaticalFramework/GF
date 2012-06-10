concrete StructuralJpn of Structural = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    above_Prep = mkPrep "の上に" ;  -- "noueni"
    after_Prep = mkPrep "の後に" ;  -- "noatoni"
    all_Predet = {s = "全部" ; not = False} ;
    almost_AdA = ss "殆ど" ;  -- "hotondo"
    almost_AdN = {s = "殆ど" ; postposition = False} ;
    although_Subj = mkSubj "のに" OtherSubj ; 
    always_AdV = ss "いつも" ;
    and_Conj = mkConj "そして" And ;
    because_Subj = mkSubj "から" OtherSubj ;
    before_Prep = mkPrep "の前に" ;  -- "nomaeni"
    behind_Prep = mkPrep "後ろに" ;  -- "ushironi"
    between_Prep = mkPrep "の間に" ;  -- "noaidani"
    both7and_DConj = mkConj "そして" Both ;
    by8agent_Prep = mkPrep "に" ;
    by8means_Prep = mkPrep "によって" ;
    but_PConj = ss "けれども" ;
    can8know_VV = mkCan ;
    can_VV = can8know_VV ;
    during_Prep = mkPrep "の間に" ;  -- "noaidani"
    either7or_DConj = mkConj "それとも" Or ;
    every_Det = mkDet "全ての" "全て" Sg ;  -- "subeteno" 
    everybody_NP = mkNP "皆" True False Anim ;  -- "minna" 
    everything_NP = mkNP "全て" True False Inanim ;  -- "subete" 
    everywhere_Adv = mkAdv "どこでも" ;  -- "dokodemo"
    first_Ord = mkFirst ; 
    few_Det = mkDet "少数の" "少数" Pl ;  -- "shoosuuno"
    for_Prep = mkPrep "のために" ;
    from_Prep = mkPrep "から" ;
    he_Pron = mkPron "彼" False Anim ;  -- "kare"
    here_Adv = mkAdv "ここで" ;
    here7to_Adv = mkAdv "ここに" ;
    here7from_Adv = mkAdv "ここから" ;
    how_IAdv = {s = \\st => "どのように" ; particle = "" ; wh8re = False} ;
    how8many_IDet = {s = "いくつ" ; n = Pl ; how8many = True ; inclCard = False} ;
    how8much_IAdv = {s = \\st => "いくら" ; particle = "" ; wh8re = False} ;
    i_Pron = mkPron "私" "私" True Anim ;  -- "watashi"
    if_Subj = mkSubj "" If ;
    in8front_Prep = mkPrep "の前に" ;  -- "nomaeni"
    in_Prep = mkPrep "に" ;
    it_Pron = mkPron "それ" False Inanim ;
    less_CAdv = {s = "より" ; less = True ; s_adn = "以下"} ;  -- "ika"
    many_Det = mkDet "多くの" "多く" Pl ;  -- "ookuno"
    more_CAdv = {s = "より" ; less = False ; s_adn = "以上"} ;  -- "ijou"
    most_Predet = {s = "ほとんどの" ; not = False} ;
    much_Det = mkDet "多くの" "多量" Sg ;  -- "ookuno" "taryou"
    must_VV = mkMust ;
    no_Phr = {s = "いいえ"} ;
    no_Utt = {s = \\part,st => "いいえ" ; type = NoImp} ;
    on_Prep = mkPrep "の上に" ;  -- "noueni"
    only_Predet = {s = "ほんの" ; not = False} ;
    or_Conj = mkConj "それとも" Or ;
    otherwise_PConj = ss "そうしなければ" ;
    part_Prep = mkPrep "の" ;
    please_Voc = {s = \\st => "ください" ; type = Please ; null = ""} ; 
    possess_Prep = mkPrep "の" ;
    quite_Adv = ss "可成" ;  -- "kanari"
    she_Pron = mkPron "彼女" False Anim ;  -- "kanojo"
    so_AdA = ss "非常に" ;  -- "hijooni"
    someSg_Det = mkDet "多少の" "幾らか" Sg ;  -- "tashoono" "ikuraka"
    somePl_Det = mkDet "いくつかの" "幾らか" Pl ;  -- "ikuraka"
    somebody_NP = mkNP "誰か" False False Anim ;  -- "dareka" 
    something_NP = mkNP "何か" False False Inanim ;  -- "nanika"
    somewhere_Adv = mkAdv "どこかに" ;
    that_Quant = {s = \\st => "その" ; sp = \\st => "それ" ; no = False} ;
    that_Subj = mkSubj "ことを" That ;
    there_Adv = mkAdv "そこで" ;
    there7to_Adv = mkAdv "そこに" ;
    there7from_Adv = mkAdv "そこから" ;
    therefore_PConj = ss "それで" ;
    they_Pron = mkPron "彼ら" "あの人達" False Anim ;  -- "karera" "ano hito-tachi"
    this_Quant = {s = \\st => "この" ; sp = \\st => "これ" ; no = False} ;
    through_Prep = mkPrep "を通じて" ;  -- "otsuujite"
    to_Prep = mkPrep "に" ;
    too_AdA = ss "あまりにも" ;
    under_Prep = mkPrep "の下に" ;  -- "noshitani"
    very_AdA = ss "とても" ;
    want_VV  = mkWant ;
    we_Pron = mkPron "私達" False Anim ;  -- "watashitachi"
    whatPl_IP = {s_subj, s_obj = \\st => "何" ; anim = Inanim ; how8many = False} ;  -- "nani"
    whatSg_IP = {s_subj, s_obj = \\st => "何" ; anim = Inanim ; how8many = False} ;
    when_IAdv = {s = \\st => "いつ" ; particle = "" ; wh8re = False} ;
    when_Subj = mkSubj "と" OtherSubj ;
    where_IAdv = {s = \\st => "どこ" ; particle = "で" ; wh8re = True} ;
    which_IQuant = ss "どの" ;
    whoPl_IP = {s_subj, s_obj = \\st => "誰" ; anim = Anim ; how8many = False} ;  -- "dare"
    whoSg_IP = {s_subj, s_obj = \\st => "誰" ; anim = Anim ; how8many = False} ;
    why_IAdv = {s = \\st => "どうして" ; particle = "" ; wh8re = False} ;
    with_Prep = mkPrep "と" ;
    without_Prep = mkPrep "無しで" ;  -- "nashide"
    yes_Phr = {s = "はい"} ;
    yes_Utt = {s = \\part,st => "はい" ; type = NoImp} ;
    youSg_Pron = mkPron "あなた" "あなた" False Anim ; 
    youPl_Pron = mkPron "あなた達" "あなた方" False Anim ;  -- "anatatachi" "anatagata"
    youPol_Pron = mkPron "あなた" False Anim ;
    
    no_Quant = {s = \\st => "" ; sp = \\st => "何も" ; no = True} ;  -- "nanimo"
    not_Predet = {s = "" ; not = True} ;
    at_least_AdN = {s = "少なくとも" ; postposition = False} ;  -- "sukunakutomo"
    at_most_AdN = {s = "せいぜい" ; postposition = False} ;
    nobody_NP = mkNP "誰も" False True Anim ;  -- "daremo"
    nothing_NP = mkNP "何も" False True Inanim ;  -- "nanimo"
    except_Prep = mkPrep "を除いて" ;

    as_CAdv = {s = "と同じぐらい" ; less = False ; s_adn = "もの"} ;
    
    have_V2 = mkV2 "持っている" "を" Gr2 ;

    language_title_Utt = {s = \\part,st => "日本語" ; type = NoImp} ;  -- "nihongo"
}
