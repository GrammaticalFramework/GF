--# -path=.:abstract:common:prelude

concrete NounLav of Noun = CatLav ** open ResLav, Prelude in {

flags

  coding = utf8 ;
  optimize = all_subs ;

lin

  -- Noun phrases

  -- Det -> CN -> NP
  -- e.g. 'the man'
  DetCN det cn = {
    s   = \\c => det.s ! cn.gend ! c ++ cn.s ! det.defin ! det.num ! c ;
    agr = AgrP3 det.num cn.gend ;
    pol = det.pol
  } ;

  -- PN -> NP
  -- e.g. 'John'
  UsePN pn = { s = pn.s ; agr = AgrP3 pn.num pn.gend ; pol = Pos } ;

  -- Pron -> NP
  -- e.g. 'he'
  UsePron pron = { s = pron.s ; agr = pron.agr ; pol = pron.pol } ;

  -- Predet -> NP -> NP
  -- e.g. 'only the man'
  PredetNP predet np = {
    s   = \\c => predet.s ! (fromAgr np.agr).gend ++ np.s ! c ;
    agr = np.agr ;
    pol = np.pol
  } ;

  -- NP -> V2 -> NP
  -- e.g. 'the man seen'
  PPartNP np v2 = {
    s   = \\c => v2.s ! Pos ! (VPart Pass (fromAgr np.agr).gend (fromAgr np.agr).num c) ++ np.s ! c ;
    agr = np.agr ;
    pol = np.pol
  } ;

  -- NP -> Adv -> NP
  -- e.g. 'Paris today'
  AdvNP np adv = {
    s = \\c => np.s ! c ++ adv.s ;
    agr = np.agr ;
    pol = np.pol
  } ;

  -- NP -> RS -> NP
  -- e.g. 'Paris, which is here'
  RelNP np rs = {
    s = \\c => np.s ! c ++ "," ++ rs.s ! np.agr ;
    agr = np.agr ;
    pol = np.pol
  } ;

  -- Det -> NP
  -- e.g. 'these five'
  DetNP det = {
    s = \\c => det.s ! Masc ! c ;
    agr = AgrP3 det.num Masc ;
    pol = det.pol
  } | {
    s = \\c => det.s ! Fem ! c ;
    agr = AgrP3 det.num Fem ;
    pol = det.pol
  } ;

  -- Determiners

  -- Quant -> Num -> Det
  -- e.g. 'these five'
  DetQuant quant num = {
    s     = \\gend,c => quant.s ! gend ! num.num ! c ++ num.s ! gend ! c ;
    num   = num.num ;
    defin = quant.defin ;  -- FIXME: ja ir kārtas skaitļa vārds, tad tikai noteiktās formas
    pol   = quant.pol
  } ;

  -- Quant -> Num -> Ord -> Det
  -- e.g. 'these five best'
  DetQuantOrd quant num ord = {
    s     = \\gend,c => quant.s ! gend ! num.num ! c ++ num.s ! gend ! c ++ ord.s ! gend ! c ;
    num   = num.num ;
    defin = quant.defin ; --FIXME: ja ir kārtas skaitļa vārds, tad tikai noteiktās formas
    pol   = quant.pol
  } ;

  -- Num
  NumSg = { s = \\_,_ => [] ; num = Sg ; hasCard = False } ;

  -- Num
  NumPl = { s = \\_,_ => [] ; num = Pl ; hasCard = False } ;

  -- Card -> Num
  NumCard card = card ** { hasCard = True } ;

  -- Digits -> Card
  -- e.g. '51'
  NumDigits digits = { s = \\_,_ => digits.s ! NCard ; num = digits.num } ;

  -- Numeral -> Card
  -- e.g. 'fifty-one'
  NumNumeral numeral = { s = numeral.s ! NCard ; num = numeral.num } ;

  -- AdN -> Card -> Card
  -- e.g. 'almost 51'
  AdNum adn card = {
    s   = \\gend,c => adn.s ++ card.s ! gend ! c ;
    num = card.num
  } ;

  -- Digits -> Ord
  -- e.g. '51st'
  OrdDigits digits = { s = \\_,_ => digits.s ! NOrd } ;

  -- Numeral -> Ord
  -- e.g. 'fifty-first'
  OrdNumeral numeral = { s = numeral.s ! NOrd } ;

  -- A -> Ord
  -- e.g. 'warmest'
  OrdSuperl a = { s = \\gend,c => a.s ! (AAdj Superl Def gend Sg c) } ;

  -- Quant
  IndefArt = { s = \\_,_,_ => [] ; defin = Indef ; pol = Pos } ;

  -- Quant
  DefArt = { s = \\_,_,_ => [] ; defin = Def ; pol = Pos } ;

  -- CN -> NP
  MassNP cn = {
    s   = cn.s ! Indef ! Sg ;  -- FIXME: bet 'šis alus'? un 'zaļš alus' vs. 'zaļais alus'?
    agr = AgrP3 Sg cn.gend ;
    pol = Pos
  } ;

  -- Pron -> Quant
  PossPron pron = { s = pron.poss ; defin = Def ; pol = Pos } ;

  -- Common nouns

  -- N -> CN
  -- e.g. 'house'
  UseN n = { s = \\_ => n.s ; gend = n.gend } ;

  -- N2 -> NP -> CN
  -- e.g. 'mother of the king'
  ComplN2 n2 np = {
    s    = \\_,num,c => preOrPost n2.isPre (n2.prep.s ++ np.s ! (n2.prep.c ! (fromAgr np.agr).num)) (n2.s ! num ! c) ;
    gend = n2.gend
  } ;

  -- N3 -> NP -> N2
  -- e.g. 'distance from this city (to Paris)'
  ComplN3 n3 np = {
    s     = \\num,c => preOrPost n3.isPre1 (n3.prep1.s ++ np.s ! (n3.prep1.c ! (fromAgr np.agr).num)) (n3.s ! num ! c) ;
    gend  = n3.gend ;
    prep  = n3.prep2 ;
    isPre = n3.isPre2
  } ;

  -- N2 -> CN
  -- e.g. 'mother'
  UseN2 n2 = { s = \\_ => n2.s ; gend = n2.gend } ;

  -- N3 -> N2
  -- e.g. 'distance (from this city)'
  Use2N3 n3 = { s = n3.s ; gend = n3.gend ; prep = n3.prep1 ; isPre = n3.isPre1 } ;

  -- N3 -> N2
  -- e.g. 'distance (to Paris)'
  Use3N3 n3 = { s = n3.s ; gend = n3.gend ; prep = n3.prep2 ; isPre = n3.isPre2 } ;

  -- AP -> CN -> CN
  -- e.g. 'big house'
  AdjCN ap cn = {
    s    = \\defin,num,c => ap.s ! defin ! cn.gend ! num ! c ++ cn.s ! defin ! num ! c ;
    gend = cn.gend
  } ;

  -- CN -> RS -> CN
  -- e.g. 'house that John bought'
  RelCN cn rs = {
    s    = \\defin,num,c => cn.s ! defin ! num ! c ++ "," ++ rs.s ! AgrP3 num cn.gend ;
    gend = cn.gend
  } ;

  -- CN -> Adv -> CN
  -- e.g. 'house on the hill'
  AdvCN cn adv = {
    s    = \\defin,num,c => cn.s ! defin ! num ! c ++ adv.s ;
    gend = cn.gend
  } ;

  -- CN -> SC -> CN
  -- e.g. 'question where she sleeps'
  SentCN cn sc = {
    s    = \\defin,num,c => cn.s ! defin ! num ! c ++ "," ++ sc.s ;
    gend = cn.gend
  } ;

  -- Apposition

  -- CN -> NP -> CN
  -- e.g. 'city Paris', 'numbers x and y'
  ApposCN cn np = 
    let num : Number = (fromAgr np.agr).num in {
      s    = \\defin,num,c => cn.s ! defin ! num ! c ++ np.s ! c ;
      gend = cn.gend
    } ;

  -- TODO: Possessive and partitive constructs

  -- PossNP : CN -> NP -> CN
  -- e.g. 'house of Paris', 'house of mine'

  -- PartNP : CN -> NP -> CN
  -- e.g. 'glass of wine'

  -- CountNP : Det -> NP -> NP
  -- e.g. 'three of them', 'some of the boys'

}
