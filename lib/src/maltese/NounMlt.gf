-- NounMlt.gf: noun phrases and nouns
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

concrete NounMlt of Noun = CatMlt ** open ResMlt, Prelude in {

  flags
    optimize=noexpand ;

  oper
    -- Used in DetCN below
    chooseNounNumForm : Det -> CN -> Str = \det,n ->
      let
        det' = det.s ! n.g ;
        sing = n.s ! Singulative ;
        coll = if_then_Str n.hasColl
          (n.s ! Collective) -- BAQAR
          (n.s ! Plural)  -- SNIEN
          ;
        dual = n.s ! Dual ;
        plur = n.s ! Plural ;
        -- pind = n.s ! Plural Indeterminate ;
      in case det.n of {
        NumX Sg   => det' ++ sing ; -- BAQRA
        NumX Pl   => det' ++ coll ; -- BAQAR (coll) / ħafna SNIEN (pdet)
        Num0     => det' ++ sing ; -- L-EBDA BAQRA
        Num1     => det' ++ sing ; -- BAQRA
        Num2     => if_then_Str n.hasDual 
          dual -- BAQARTEJN
          (det' ++ plur) -- ŻEWĠ IRĠIEL
          ;
        Num3_10  => det' ++ coll ; -- TLETT BAQAR
        Num11_19 => det' ++ sing ; -- ĦDAX-IL BAQRA
        Num20_99 => det' ++ sing -- GĦOXRIN BAQRA
      } ;

  lin
    -- Det -> CN -> NP
    DetCN det cn = {
      s = table {
        Nom => case <det.isPron, cn.takesPron> of {
          <True,True>  => glue (cn.s ! numform2nounnum det.n) det.clitic ;
          <True,_>     => artDef ++ cn.s ! numform2nounnum det.n ++ det.s ! cn.g ;
          _            => chooseNounNumForm det cn
          } ;
        CPrep => cn.s ! numform2nounnum det.n
        } ;
      a = case (numform2nounnum det.n) of {
	Singulative => mkAgr cn.g Sg P3 ; --- collective?
	_           => mkAgr cn.g Pl P3
      } ;
      isPron = False ;
      isDefn = det.isDefn ;
    } ;

    -- Quant -> Num -> Det
    DetQuant quant num = {
      s = \\gen =>
        let gennum = case num.n of { NumX Sg => GSg gen ; _ => GPl }
        in case quant.isDemo of {
          True  => quant.s ! gennum ++ artDef ++ num.s ! NumAdj ;
          False => quant.s ! gennum ++ num.s ! NumAdj
        } ;
      n = num.n ;
      clitic = quant.clitic ;
      hasNum = num.hasCard ;
      isPron = quant.isPron ;
      isDefn = quant.isDefn ;
    } ;

    -- Quant -> Num -> Ord -> Det
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
    UsePN pn = {
      s = \\c => pn.s ;
      a = pn.a ;
      isPron = False ;
      isDefn = False ;
      } ;

    -- Pron -> NP
    UsePron p = {
      s = table {
        Nom => p.s ! Personal ;
        CPrep => p.s ! Suffixed Acc
        } ;
      a = p.a ;
      isPron = True ;
      isDefn = False ;
      } ;

    -- Pron -> Quant
    PossPron p = {
      s = \\_ => p.s ! Possessive ;
      clitic = p.s ! Suffixed Gen ;
      isPron = True ;
      isDemo = False ;
      isDefn = True ;
      } ;

    -- Num
    NumSg = {s = \\c => []; n = NumX Sg ; hasCard = False} ;
    NumPl = {s = \\c => []; n = NumX Pl ; hasCard = False} ;

    -- Card -> Num
    NumCard n = n ** {hasCard = True} ;
 
    -- Digits -> Card
    NumDigits d = {s = d.s ; n = d.n} ;

    -- Digits -> Ord
    OrdDigits d = {s = d.s} ;

    -- Numeral -> Card
    NumNumeral numeral = {s = numeral.s ! NCard; n = numeral.n} ;

    -- Numeral -> Ord
    OrdNumeral numeral = {s = numeral.s ! NOrd} ;

    -- N -> CN
    UseN n = n ;

    -- N2 -> CN
    UseN2 n = n ;

-- Card
-- CN
-- Det
-- NP
-- Num
-- Ord

}
