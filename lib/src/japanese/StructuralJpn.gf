concrete StructuralJpn of Structural = CatJpn ** open (R = ResJpn), ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    above_Prep = R.mkPrep "の上に" ;  -- "noueni"
    after_Prep = R.mkPrep "の後に" ;  -- "noatoni"
    all_Predet = {s = "全部" ; not = False} ;
    almost_AdA = ss "殆ど" ;  -- "hotondo"
    almost_AdN = {s = "殆ど" ; postposition = False} ;
    although_Subj = R.mkSubj "のに" R.OtherSubj ; 
    always_AdV = ss "いつも" ;
    and_Conj = R.mkConj "そして" R.And ;
    because_Subj = R.mkSubj "から" R.OtherSubj ;
    before_Prep = R.mkPrep "の前に" ;  -- "nomaeni"
    behind_Prep = R.mkPrep "後ろに" ;  -- "ushironi"
    between_Prep = R.mkPrep "の間に" ;  -- "noaidani"
    both7and_DConj = R.mkConj "そして" R.Both ;
    by8agent_Prep = R.mkPrep "に" ;
    by8means_Prep = R.mkPrep "で" ;
    but_PConj = ss "けれども" ;
    can8know_VV = R.mkCan ;
    can_VV = can8know_VV ;
    during_Prep = R.mkPrep "の間に" ;  -- "noaidani"
    either7or_DConj = R.mkConj "それとも" R.Or ;
    every_Det = R.mkDet "全ての" "全て" R.Sg ;  -- "subeteno" 
    everybody_NP = R.mkNP "皆" True False R.Anim ;  -- "minna" 
    everything_NP = R.mkNP "全て" True False R.Inanim ;  -- "subete" 
    everywhere_Adv = R.mkAdv "どこでも" ;  -- "dokodemo"
--    first_Ord = R.mkFirst ; 
    few_Det = R.mkDet "少数の" "少数" R.Pl ;  -- "shoosuuno"
    for_Prep = R.mkPrep "用" ; -- "you"     "のために" 
    from_Prep = R.mkPrep "から" ;
    he_Pron = mkPron "彼" False R.Anim ;  -- "kare"
    here_Adv = R.mkAdv "ここで" ;
    here7to_Adv = R.mkAdv "ここに" ;
    here7from_Adv = R.mkAdv "ここから" ;
    how_IAdv = {s = \\st => "どのように" ; particle = "" ; wh8re = False} ;
    how8many_IDet = {s = "いくつ" ; n = R.Pl ; how8many = True ; inclCard = False} ;
    how8much_IAdv = {s = \\st => "いくら" ; particle = "" ; wh8re = False} ;
    i_Pron = mkPron "私" "私" True R.Anim ;  -- "watashi"
    if_Subj = R.mkSubj "" R.If ;
    in8front_Prep = R.mkPrep "の前に" ;  -- "nomaeni"
    in_Prep = R.mkPrep "に" ;
    it_Pron = mkPron "それ" False R.Inanim ;
    less_CAdv = {s = "より" ; less = True ; s_adn = "以下"} ;  -- "ika"
    many_Det = R.mkDet "多くの" "多く" R.Pl ;  -- "ookuno"
    more_CAdv = {s = "より" ; less = False ; s_adn = "以上"} ;  -- "ijou"
    most_Predet = {s = "ほとんどの" ; not = False} ;
    much_Det = R.mkDet "多くの" "多量" R.Sg ;  -- "ookuno" "taryou"
    must_VV = R.mkMust ;
--    no_Phr = {s = "いいえ"} ;
    no_Utt = {s = \\part,st => "いいえ" ; type = R.NoImp} ;
    on_Prep = R.mkPrep "の上に" ;  -- "noueni"
    only_Predet = {s = "ほんの" ; not = False} ;
    or_Conj = R.mkConj "それとも" R.Or ;
    otherwise_PConj = ss "そうしなければ" ;
    part_Prep = R.mkPrep "の" ;
    please_Voc = {s = \\st => "ください" ; type = R.Please ; null = ""} ; 
    possess_Prep = R.mkPrep "の" ;
    quite_Adv = ss "可成" ;  -- "kanari"
    she_Pron = mkPron "彼女" False R.Anim ;  -- "kanojo"
    so_AdA = ss "非常に" ;  -- "hijooni"
    someSg_Det = R.mkDet "多少の" "幾らか" R.Sg ;  -- "tashoono" "ikuraka"
    somePl_Det = R.mkDet "いくつかの" "幾らか" R.Pl ;  -- "ikuraka"
    somebody_NP = R.mkNP "誰か" False False R.Anim ;  -- "dareka" 
    something_NP = R.mkNP "何か" False False R.Inanim ;  -- "nanika"
    somewhere_Adv = R.mkAdv "どこかに" ;
    that_Quant = {s = \\st => "その" ; sp = \\st => "それ" ; no = False} ;
    that_Subj = R.mkSubj "ことを" R.That ;
    there_Adv = R.mkAdv "そこで" ;
    there7to_Adv = R.mkAdv "そこに" ;
    there7from_Adv = R.mkAdv "そこから" ;
    therefore_PConj = ss "それで" ;
    they_Pron = mkPron "彼ら" "あの人達" False R.Anim ;  -- "karera" "ano hito-tachi"
    this_Quant = {s = \\st => "この" ; sp = \\st => "これ" ; no = False} ;
    through_Prep = R.mkPrep "を通じて" ;  -- "otsuujite"
    to_Prep = R.mkPrep "に" ;
    too_AdA = ss "あまりにも" ;
    under_Prep = R.mkPrep "の下に" ;  -- "noshitani"
    very_AdA = ss "とても" ;
    want_VV  = R.mkWant ;
    we_Pron = mkPron "私達" False R.Anim ;  -- "watashitachi"
    whatPl_IP = {s_subj, s_obj = \\st => "何" ; anim = R.Inanim ; how8many = False} ;  -- "nani"
    whatSg_IP = {s_subj, s_obj = \\st => "何" ; anim = R.Inanim ; how8many = False} ;
    when_IAdv = {s = \\st => "いつ" ; particle = "" ; wh8re = False} ;
    when_Subj = R.mkSubj "と" R.OtherSubj ;
    where_IAdv = {s = \\st => "どこ" ; particle = "で" ; wh8re = True} ;
    which_IQuant = ss "どの" ;
    whoPl_IP = {s_subj, s_obj = \\st => "誰" ; anim = R.Anim ; how8many = False} ;  -- "dare"
    whoSg_IP = {s_subj, s_obj = \\st => "誰" ; anim = R.Anim ; how8many = False} ;
    why_IAdv = {s = \\st => "どうして" ; particle = "" ; wh8re = False} ;
    with_Prep = R.mkPrep "と" ;
    without_Prep = R.mkPrep "無しで" ;  -- "nashide"
--    yes_Phr = {s = "はい"} ;
    yes_Utt = {s = \\part,st => "はい" ; type = R.NoImp} ;
    youSg_Pron = mkPron "あなた" "あなた" False R.Anim ; 
    youPl_Pron = mkPron "あなた達" "あなた方" False R.Anim ;  -- "anatatachi" "anatagata"
    youPol_Pron = mkPron "あなた" False R.Anim ;
    
    no_Quant = {s = \\st => "" ; sp = \\st => "何も" ; no = True} ;  -- "nanimo"
    not_Predet = {s = "" ; not = True} ;
    if_then_Conj = R.mkConj "と" R.IfConj ;
    at_least_AdN = {s = "少なくとも" ; postposition = False} ;  -- "sukunakutomo"
    at_most_AdN = {s = "せいぜい" ; postposition = False} ;
    nobody_NP = R.mkNP "誰も" False True R.Anim ;  -- "daremo"
    nothing_NP = R.mkNP "何も" False True R.Inanim ;  -- "nanimo"
    except_Prep = R.mkPrep "を除いて" ;

    as_CAdv = {s = "と同じぐらい" ; less = False ; s_adn = "もの"} ;
    
    have_V2 = mkV2 "持っている" "を" R.Gr2 ;

    language_title_Utt = {s = \\part,st => "日本語" ; type = R.NoImp} ;  -- "nihongo"
}
