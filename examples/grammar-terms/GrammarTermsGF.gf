concrete GrammarTermsGF of GrammarTerms = 
  open Prelude in {

lincat
  Rule = Str ;
  Cat = Str ;
  ParamType = Str ;
  ParamValue = Str ;
  Language = Str ;
  [Cat] = Str ;
  [ParamType] = Str ;

lin
  RuleFun c cs = cs ++ "->" ++ c ; 
  RuleInherent c ps = "lincat" ++ c ++ ":" ++ "{" ++ ps ++ "}" ; 
  RuleVariable c ps = "lincat" ++ c ++ ":" ++ ps ++ "=>" ++ "Str" ; 

lin
  BaseCat c = c ;
  ConsCat c cs = c ++ "->" ++ cs ;

  BaseParamType c = c ;
  ConsParamType c cs = c ++ "," ++ cs ;

lin 
  CatA = "A" ;
  CatA2 = "A2" ;
  CatAP = "AP" ;
  CatAdA = "AdA" ;
  CatAdN = "AdN" ;
  CatAdV = "AdV" ;
  CatAdv = "Adv" ;
  CatAnt = "Ant" ;
  CatCAdv = "CAdv" ;
  CatCN = "CN" ;
  CatCard = "Card" ;
  CatCl = "Cl" ;
  CatClSlash = "ClSlash" ;
  CatComp = "Comp" ;
  CatConj = "Conj" ;
  CatDet = "Det" ;
  CatDig = "Dig" ;
  CatDigits = "Digits" ;
  CatIAdv = "IAdv" ;
  CatIComp = "IComp" ;
  CatIDet = "IDet" ;
  CatIP = "IP" ;
  CatIQuant = "IQuant" ;
  CatImp = "Imp" ;
  CatImpForm = "ImpForm" ;
  CatInterj = "Interj" ;
  CatListAP = "ListAP" ;
  CatListAdv = "ListAdv" ;
  CatListNP = "ListNP" ;
  CatListRS = "ListRS" ;
  CatListS = "ListS" ;
  CatN = "N" ;
  CatN2 = "N2" ;
  CatN3 = "N3" ;
  CatNP = "NP" ;
  CatNum = "Num" ;
  CatNumeral = "Numeral" ;
  CatOrd = "Ord" ;
  CatPConj = "PConj" ;
  CatPN = "PN" ;
  CatPhr = "Phr" ;
  CatPol = "Pol" ;
  CatPredet = "Predet" ;
  CatPrep = "Prep" ;
  CatPron = "Pron" ;
  CatPunct = "Punct" ;
  CatQCl = "QCl" ;
  CatQS = "QS" ;
  CatQuant = "Quant" ;
  CatRCl = "RCl" ;
  CatRP = "RP" ;
  CatRS = "RS" ;
  CatS = "S" ;
  CatSC = "SC" ;
  CatSSlash = "SSlash" ;
  CatSub100 = "Sub100" ;
  CatSub1000 = "Sub1000" ;
  CatSubj = "Subj" ;
  CatTemp = "Temp" ;
  CatTense = "Tense" ;
  CatText = "Text" ;
  CatUnit = "Unit" ;
  CatUtt = "Utt" ;
  CatV = "V" ;
  CatV2 = "V2" ;
  CatV2A = "V2A" ;
  CatV2Q = "V2Q" ;
  CatV2S = "V2S" ;
  CatV2V = "V2V" ;
  CatV3 = "V3" ;
  CatVA = "VA" ;
  CatVP = "VP" ;
  CatVPSlash = "VPSlash" ;
  CatVQ = "VQ" ;
  CatVS = "VS" ;
  CatVV = "VV" ;
  CatVoc = "Voc" ;

  PTGender = "Gender" ;
  PTNumber = "Number" ;
  PTCase   = "Case" ;
  PTTense  = "Tense" ;

}
