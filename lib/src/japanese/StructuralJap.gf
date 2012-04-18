concrete StructuralJap of Structural = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    above_Prep = mkPrep "の上に" "上に" ;  -- "noueni" "ueni" 
    after_Prep = mkPrep "の後に" "後" ;  -- "noatoni" "ato"
    all_Predet = ss "全部" ;  -- "zembu"
    almost_AdA = ss "殆ど" ;  -- "hotondo" ;
    although_Subj = {s = "のに" ; when = False} ; 
    almost_AdN = {s = "殆ど" ; postposition = False} ;
    always_AdV = ss "いつも" ;
    and_Conj = mkConj "と" "そして" False ;
    because_Subj = {s = "から" ; when = False} ;
    before_Prep = mkPrep "の前に" "前に" ;  -- "nomaeni" "maeni"
    behind_Prep = mkPrep "後ろに" "後ろに" ;  -- "ushironi" "ushironi"
    between_Prep = mkPrep "の間に" "間に" ;  -- "noaidani" "aidani"
    by8agent_Prep = mkPrep "に" "" ;  
    by8means_Prep = mkPrep "によって" "" ;
    but_PConj = ss "けれども" ;
    can8know_VV = mkVerb "でき" "でき" "できる" "できた" ** {sense = Abil} ;
    can_VV = can8know_VV ;
    during_Prep = mkPrep "の間に" "" ;  -- "noaidani"
    every_Det = mkDet "各自の" Sg ;  -- "kakujino" 
    everybody_NP = mkNP "皆" True False Anim ;  -- "minna" 
    everything_NP = mkNP "全て" True False Inanim ;  -- "subete" 
    everywhere_Adv = mkAdv "どこでも" ;  -- "dokodemo" ;
    first_Ord = {pred = \\st,t,p => "一番目" ++ mkCopula.s ! st ! t ! p ;
                 attr = "一番目の" ; te = "一番目" ++ mkCopula.te ;
                 tara = "一番目" ++ mkCopula.tara ; adv = "一番目"} ; -- "ichibanme"
    few_Det = mkDet "少数" Pl ;  -- "shoosuuno"
    for_Prep = mkPrep "のために" "" ;
    from_Prep = mkPrep "から" "から" ;
    he_Pron = mkPron "彼" False Anim ;  -- "kare"
    here_Adv = mkAdv "ここで" ;
    here7to_Adv = mkAdv "ここに" ;
    here7from_Adv = mkAdv "ここから" ;
    how_IAdv = {s = \\st => "どのように" ; particle = ""} ;
    how8many_IDet = {s = "いくつ" ; n = Pl ; how8many = True ; inclCard = False} ;
    how8much_IAdv = {s = \\st => "いくら" ; particle = ""} ;
    i_Pron = mkPron ("僕"|"私") "私" True Anim ;  -- "boku"|"watashi"
    in8front_Prep = mkPrep "の前に" "前に" ;  -- "nomaeni" "maeni"
    in_Prep = mkPrep "に" "" ;
    it_Pron = mkPron "それ" False Inanim ;
    less_CAdv = {s = "のほうが" ; compar = Less} ;
    many_Det = mkDet "多くの" Pl ;  -- "ookuno"
    more_CAdv = {s = "より" ; compar = More} ;  -- "yori"
    most_Predet = ss "ほとんどの" ;
    much_Det = mkDet "多くの" Sg ;  -- "ookuno"
    must_VV = {s = (mkVerb "なら" "なり" "なる" "なった").s ; te = "なって" ;
               tara = "なったら" ; a_stem = "なら" ; i_stem = "なり" ; sense = Oblig} ;
    no_Phr = ss "いいえ" ;
    no_Utt = {s = \\st => "いいえ"} ;
    on_Prep = mkPrep "の上に" "" ;
    only_Predet = ss "ほんの" ;
    or_Conj = mkConj "か" "それとも" True ;
    otherwise_PConj = ss "そうしなければ" ;
    please_Voc = {s = table {Resp => "ください" ; Plain => "" } ; please = True} ; 
    possess_Prep = mkPrep "の" "" ;
    quite_Adv = ss "可成" ;
    she_Pron = mkPron "彼女" False Anim ;  -- "kanojo"
    so_AdA = ss "非常に" ;  -- "hijooni"
    someSg_Det = mkDet "多少の" Sg ;  -- "tashoono"
    somePl_Det = mkDet "いくつかの" Pl ;
    somebody_NP = mkNP "誰か" False False Anim ;  -- "dareka" 
    something_NP = mkNP "何か" False False Inanim ;  -- "nanika"
    somewhere_Adv = mkAdv "どこかに" ;
    that_Quant = {s = \\st => "その"} ;
    there_Adv = mkAdv "そこに" ;
    there7to_Adv = mkAdv "そこに" ;
    there7from_Adv = mkAdv "そこから" ;
    therefore_PConj = ss "それで" ;
    they_Pron = mkPron "彼ら" "あの人達" False Anim ;  -- "karera" "ano hito-tachi"
    this_Quant = {s = \\st => "この"} ;
    through_Prep = mkPrep "を通じて" "通じて" ;  -- "otsuujite"
    to_Prep = mkPrep "に" "" ;
    too_AdA = ss "あまりにも" ;
    under_Prep = mkPrep "の下に" "下に" ;  -- "noshitani"
    very_AdA = ss "とても" ;
    want_VV  = {s = (mkVerb "い" "い" "いる" "いった").s ; te = "いって" ; 
                tara = "いったら" ; a_stem = "い" ; i_stem = "い" ; sense = Wish} ;
    we_Pron = mkPron "私達" False Anim ;  -- "watashitachi"
    whatPl_IP = {s = \\st => "何" ; anim = Inanim ; how8many = False} ;  -- "nani"
    whatSg_IP = {s = \\st => "何" ; anim = Inanim ; how8many = False} ;
    when_IAdv = {s = \\st => "いつ" ; particle = ""} ;
    when_Subj = {s = [] ; when = True} ;
    where_IAdv = {s = \\st => "どこ" ; particle = "で"} ;
    which_IQuant = ss "どの" ;
    whoPl_IP = {s = \\st => "誰" ; anim = Anim ; how8many = False} ;
    whoSg_IP = {s = \\st => "誰" ; anim = Anim ; how8many = False} ;
    why_IAdv = {s = \\st => "どうして" ; particle = ""} ;
    with_Prep = mkPrep "と" "" ;
    without_Prep = mkPrep "無しで" "無しで" ;  -- "nashide"
    yes_Phr = ss "はい" ;
    yes_Utt = {s = \\st => "はい"} ;
    youSg_Pron = mkPron ("あなた"|"君") "あなた" False Anim ;  -- ("anata"|"kimi") 
    youPl_Pron = mkPron "あなた達" "あなた方" False Anim ;  -- "anatatachi" "anatagata"
    youPol_Pron = mkPron "あなた" False Anim ;
    
    at_least_AdN = {s = "少なくとも" ; postposition = False} ;  -- "sukunakutomo"
    at_most_AdN = {s = "せいぜい" ; postposition = False} ;
    nobody_NP = mkNP "誰も" False True Anim ;
    nothing_NP = mkNP "何も" False True Inanim ;
    except_Prep = mkPrep "を除いて" "を除いて" ;  -- "onozoite"
    
    as_CAdv = {s = "と同じぐらい" ; compar = NoCompar} ;  -- "toonajigurai"
}
