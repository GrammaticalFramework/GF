-- NounMlt.gf: noun phrases and nouns
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

concrete NounMlt of Noun = CatMlt ** open ResMlt, Prelude in {

  flags
    optimize=noexpand ;
    coding=utf8 ;

  oper
    -- Used in DetCN below
    chooseNounNumForm : Det -> CN -> Str = \det,n ->
      let
        sing = n.s ! Singulative ;
        coll = if_then_Str n.hasColl
          (n.s ! Collective) -- baqar
          (n.s ! Plural)  -- snien
          ;
        dual = n.s ! Dual ;
        plur = n.s ! Plural ;
        -- pind = n.s ! Plural Indeterminate ;
      in case det.n of {
        NumX Sg  => sing ; -- baqra
        NumX Pl  => coll ; -- baqar (coll) / ħafna snien (pdet)
        Num0     => sing ; -- l-ebda baqra
        Num1     => sing ; -- baqra
        Num2     => if_then_Str n.hasDual dual plur ; -- sentejn / baqar
        Num3_10  => coll ; -- tlett baqar
        Num11_19 => sing ; -- ħdax-il baqra
        Num20_99 => sing   -- għoxrin baqra
      } ;

  lin
    -- Det -> CN -> NP
    -- the man
    DetCN det cn =
      let
        -- To stop complaining about lock fields
        det = lin Det det ;
        cn  = lin CN cn ;
        noun = chooseNounNumForm det cn ;
      in {
        s = table {
          NPCPrep => noun ;
          _       => case <det.isPron, cn.takesPron> of {
            <True,True>  => glue noun det.clitic ;
            <True,_>     => artDef ++ noun ++ det.s ! cn.g ;
            _            => case <det.n,cn.hasDual> of {
              <Num2, True>  => noun ; -- sentejn
              _             => det.s ! cn.g ++ noun -- tlett baqar
              }
            }
          } ;
        a = case (numform2nounnum det.n) of {
          Singulative => mkAgr Sg P3 cn.g ; --- collective?
          _           => mkAgr Pl P3 cn.g
          } ;
        isPron = False ;
        isDefn = det.isDefn ;
      } ;

    -- Quant -> Num -> Det
    -- these five
    DetQuant quant num = {
      s = \\gen =>
        let gennum = case num.n of { NumX Sg => GSg gen ; _ => GPl }
        in case <quant.isDemo,num.n> of {
            <True,_>  => quant.s ! gennum ++ artDef ++ num.s ! NumAdj ;
            -- <True ,NumX Sg> => ...
            <False,NumX Sg> => quant.s ! gennum ;
            <False,_> => quant.s ! gennum ++ num.s ! NumAdj
        } ;
      n = num.n ;
      clitic = quant.clitic ;
      hasNum = True ; -- num.hasCard ?
      isPron = quant.isPron ;
      isDefn = quant.isDefn ;
    } ;

    -- Quant -> Num -> Ord -> Det
    -- these five best
    --- Almost an exact copy of DetQuant, consider factoring together
    DetQuantOrd quant num ord = {
      s = \\gen =>
        let gennum = case num.n of { NumX Sg => GSg gen ; _ => GPl }
        in case quant.isDemo of {
          True  => quant.s ! gennum ++ artDef ++ num.s ! NumAdj ++ ord.s ! NumAdj ;
          False => quant.s ! gennum ++ num.s ! NumAdj ++ ord.s ! NumAdj
        } ;
      n = num.n ;
      clitic = quant.clitic ;
      hasNum = True ;
      isPron = quant.isPron ;
      isDefn = quant.isDefn ;
      } ;

    -- Det -> NP
    -- these five
    DetNP det = {
      s = \\c => det.s ! Masc ;
      a = agrP3 (numform2num det.n) Masc ;
      isPron = False ;
      isDefn = True ;
      } ;

    -- Quant
    DefArt = {
      s  = \\_ => artDef ;
      clitic = [] ;
      isPron = False ;
      isDemo = False ;
      isDefn = True ;
    } ;
    IndefArt = {
      s  = \\_ => artIndef ;
      clitic = [] ;
      isPron = False ;
      isDemo = False ;
      isDefn = False ;
    } ;

    -- PN -> NP
    -- John
    UsePN pn = {
      s = \\c => pn.s ;
      a = pn.a ;
      isPron = False ;
      isDefn = False ;
      } ;

    -- Pron -> NP
    -- he
    UsePron p = {
      s = table {
        NPNom   => p.s ! Personal ;
        NPAcc   => p.s ! Personal ;
        NPCPrep => p.s ! Suffixed
        } ;
      a = p.a ;
      isPron = True ;
      isDefn = False ;
      } ;

    -- Pron -> Quant
    -- my (house)
    PossPron p = {
      s = \\_ => p.s ! Possessive ;
      clitic = p.s ! Suffixed ;
      isPron = True ;
      isDemo = False ;
      isDefn = True ;
      } ;

    -- Predet -> NP -> NP
    -- only the man
    PredetNP pred np = overwriteNPs np (\\c => pred.s ++ np.s ! c) ;

    -- NP -> V2 -> NP
    -- the man seen
    PPartNP np v2 = case v2.hasPastPart of {
      True  => overwriteNPs np (\\c => np.s ! c ++ (v2.s ! VPastPart (toGenNum np.a)).s1) ; -- raġel rieqed
      False => overwriteNPs np (\\c => np.s ! c ++ (v2.s ! VImpf (toVAgr np.a)).s1)         -- mara tisma'
      } ;

    -- NP -> RS -> NP
    -- Paris, which is here
    RelNP np rs = overwriteNPs np (\\c => np.s ! c ++ "," ++ rs.s ! np.a ) ;

    -- NP -> Adv -> NP
    -- Paris today
    AdvNP np adv = overwriteNPs np (\\c => np.s ! c ++ adv.s) ;

    -- Num
    NumSg = {s = \\c => []; n = NumX Sg ; hasCard = False} ;
    NumPl = {s = \\c => []; n = NumX Pl ; hasCard = False} ;

    -- Card -> Num
    NumCard n = n ** {hasCard = True} ;

    -- Digits -> Card
    -- 51
    NumDigits d = {s = d.s ; n = d.n} ;

    -- Digits -> Ord
    -- 51st
    OrdDigits d = {s = d.s} ;

    -- Numeral -> Card
    -- fifty-one
    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;

    -- Numeral -> Ord
    -- fifty-first
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    -- AdN -> Card -> Card
    -- almost 51
    AdNum adn card = card ** {
      s = \\c => adn.s ++ card.s ! c ;
      } ;

    -- A -> Ord
    -- warmest
    OrdSuperl a = {
      s = \\c => case a.hasComp of {
        True => a.s ! ASuperl ;
        False => "l-iktar" ++ a.s ! APosit (GSg Masc) --- should agree
        }
      } ;

    -- CN -> NP
    -- (beer)
    MassNP cn = {
      s = \\c => cn.s ! Collective ;
      a = agrP3 Sg cn.g ;
      isPron = False ;
      isDefn = True ;
      } ;

    -- N -> CN
    -- house
    UseN n = n ;

    -- N2 -> CN
    -- mother
    UseN2 n2 = n2 ; -- just ignore the c2

    -- N3 -> N2
    -- distance (from this city)
    Use2N3 n3 = n3 ** { c2 = n3.c2 } ;

    -- N3 -> N2
    -- distance (to Paris)
    Use3N3 n3 = n3 ** { c2 = n3.c3 } ;

    -- N2 -> NP -> CN
    -- mother of the king
    ComplN2 n2 np = {
        s = \\num => n2.s ! num ++ prepNP n2.c2 np ;
        g = n2.g ;
        hasColl = False ;
        hasDual = False ;
        takesPron = False ;
      } ;

    -- N3 -> NP -> N2
    -- distance from this city (to Paris)
    ComplN3 n3 np = {
        s = \\num => n3.s ! num ++ prepNP n3.c3 np ;
        g = n3.g ;
        hasColl = False ;
        hasDual = False ;
        takesPron = False ;
        c2 = n3.c3
      } ;

    -- AP -> CN -> CN
    -- big house
    AdjCN ap cn = overwriteCNs cn (\\num => preOrPost ap.isPre (ap.s ! mkGenNum num cn.g) (cn.s ! num)) ;

    -- CN -> RS -> CN
    -- house that John bought
    RelCN cn rs = overwriteCNs cn (\\num => cn.s ! num ++ rs.s ! agrP3 (nounnum2num num) cn.g) ;

    -- CN -> Adv -> CN
    -- house on the hill
    AdvCN cn adv = overwriteCNs cn (\\num => cn.s ! num ++ adv.s) ;

    -- CN -> SC -> CN
    -- question where she sleeps
    SentCN cn sc = overwriteCNs cn (\\num => cn.s ! num ++ sc.s) ;

    -- CN -> NP -> CN
    -- Appossition: city Paris
    ApposCN cn np = overwriteCNs cn (\\num => cn.s ! num ++ np.s ! NPNom) ; -- known to be overgenerating

    -- CN -> NP -> CN
    -- Possessive: house of mine
    PossNP  cn np = overwriteCNs cn (\\num => cn.s ! num ++ prepNP prep_ta np) ;

    -- CN -> NP -> CN
    -- Partitive: glass of wine
    PartNP  cn np = overwriteCNs cn (\\num => cn.s ! num ++ prepNP prep_ta np) ;

    -- Det -> NP -> NP
    -- three of them, some of the boys
    CountNP det np =
      let
        dets = case det.n of {
          NumX Sg => wiehed ! np.a.g ;
          _       => det.s ! np.a.g
        } ;
      in {
      s = \\c => case np.isPron of {
        True  => dets ++ prep_minn.enclitic ! np.a;
        False => dets ++ prep_minn.s ! (bool2definiteness np.isDefn) ++ np.s ! c
        } ;
      a = agrP3 (numform2num det.n) np.a.g ;
      isPron = False ;
      isDefn = np.isDefn ;
      } ;

  oper
    -- Overwrite the s field in an NP
    overwriteNPs : NounPhrase -> (NPCase => Str) -> NounPhrase = \np,tbl -> {
      s = tbl ;
      a = np.a ;
      isPron = np.isPron ;
      isDefn = np.isDefn ;
      } ;

    -- Overwrite the s field in a Noun
    overwriteCNs : Noun -> (Noun_Number => Str) -> Noun = \n,tbl -> {
      s = tbl ;
      g = n.g ;
      hasColl = n.hasColl ;
      hasDual = n.hasDual ;
      takesPron = n.takesPron ;
      } ;

}
