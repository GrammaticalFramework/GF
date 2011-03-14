--# -path=.:present

concrete GrammarTermsEng of GrammarTerms = 
  open SyntaxEng, (S = SyntaxEng), ParadigmsEng, (P = ParadigmsEng) in {

lincat
  Rule = Utt ;
  Cat = CN ;
  ParamType = CN ;
  ParamValue = NP ;
  Language = {name : CN ; adj : AP} ;
  [Cat] = NP ;
  [ParamType] = {indef, bare : NP} ;

lin
  RuleFun c cs = 
    mkUtt (mkS (mkCl (mkNP a_Det c) (mkVP can_VV 
      (mkVP (passiveVP construct_V2) (S.mkAdv from_Prep cs))))) ;
  RuleInherent c ps = 
    mkUtt (mkS (mkCl (mkNP aPl_Det c) have_V2 ps.indef)) ;
  RuleVariable c ps = 
    mkUtt (mkS (mkCl (mkNP aPl_Det c)
      (mkVP (passiveVP inflect_V2) (S.mkAdv for_Prep ps.bare)))) ;

oper
  construct_V2 = mkV2 "construct" ;
  inflect_V2 = mkV2 "inflect" ;

lin
  BaseCat c = mkNP a_Det c ;
  ConsCat c cs = mkNP and_Conj (mkNP a_Det c) cs ;

  BaseParamType c = {
    indef = mkNP a_Det c ;
    bare = mkNP c
    } ;
  ConsParamType c cs = {
    indef = mkNP and_Conj (mkNP a_Det c) cs.indef ;
    bare = mkNP and_Conj (mkNP c) cs.bare
    } ;

lin 
  CatA = mkCN (mkN "adjective") ;
  CatA2 = mkCN (mkN "two-place adjective") ;
  CatAP = mkCN (mkA "adjectival") (mkN "phrase") ;
  CatAdA = mkCN (mkA "adjective-modifying") (mkN "adverb") ;
  CatAdN = mkCN (mkN "numeral-modifying adverb") ;
  CatAdV = mkCN (mkN "sentential adverb") ;
  CatAdv = mkCN (mkN "verb-phrase-modifying adverb") ;
  CatAnt = mkCN (mkN "anteriority") ;
  CatCAdv = mkCN (mkN "comparative adverb") ;
  CatCN = mkCN (mkN "common noun phrase") ;
  CatCard = mkCN (mkN "cardinal number") ;
  CatCl = mkCN (mkN "declarative clause") ;
  CatClSlash = slash (mkCN (mkN "clause")) ;
  CatComp = funOf (mkN "complement") (mkN "copula") ;
  CatConj = mkCN (mkN "conjunction") ;
  CatDet = mkCN (mkN "determiner phrase") ;
  CatDig = mkCN (mkN "digit") ;
  CatDigits = funOfPl (mkN "sequence") (mkN "digit") ;
  CatIAdv = mkCN (mkN "interrogative adverb") ;
  CatIComp = 
    mkCN (mkA "interrogative") (funOf (mkN "complement") (mkN "copula")) ;
  CatIDet = mkCN (mkN "interrogative determiner") ;
  CatIP = mkCN (mkN "interrogative pronoun") ;
  CatIQuant = mkCN (mkN "interrogative quantifier") ;
  CatImp = mkCN (mkN "imperative") ;
  CatImpForm = funOf (mkN "form") (mkN "imperative") ;
  CatInterj = mkCN (mkN "interjection") ;
  CatListAP = funOfPl (mkN "list") (mkN "adjectival phrase") ;
  CatListAdv = funOfPl (mkN "list") (mkN "adverb") ;
  CatListNP = funOfPl (mkN "list") (mkN "noun phrase") ;
  CatListRS = funOfPl (mkN "list") (mkN "relative clause") ;
  CatListS = funOfPl (mkN "list") (mkN "sentence") ;
  CatN = mkCN (mkN "noun") ;
  CatN2 = mkCN (mkN "two-place relational noun") ;
  CatN3 = mkCN (mkN "three-place relational noun") ;
  CatNP = mkCN (mkN "noun phrase") ;
  CatNum = mkCN (mkN "number-determining element") ;
  CatNumeral = mkCN (mkN "numeral expression") ;
  CatOrd = mkCN (mkN "ordinal") ;
  CatPConj = mkCN (mkN "phrase conjunction") ;
  CatPN = mkCN (mkN "proper name") ;
  CatPhr = mkCN (mkN "phrase") (S.mkAdv in_Prep (mkNP a_Det (mkN "text"))) ;
  CatPol = mkCN (mkN "polarity") ;
  CatPredet = mkCN (mkN "predeterminer") ;
  CatPrep = mkCN (mkN "preposition") ;
  CatPron = mkCN (mkN "personal pronoun") ;
  CatPunct = mkCN (mkN "punctuation mark") ;
  CatQCl = mkCN (mkN "question clause") ;
  CatQS = mkCN (mkN "question") ;
  CatQuant = mkCN (mkN "quantifier") ;
  CatRCl = mkCN (mkN "relative clause") ;
  CatRP = mkCN (mkN "relative pronoun") ;
  CatRS = mkCN (mkN "relative sentence") ;
  CatS = mkCN (mkN "declarative sentence") ;
  CatSC = mkCN (mkN "embedded clause") ;
  CatSSlash = slash (mkCN (mkN "sentence")) ;
  CatSub100 = mkCN (mkN "numeral") (S.mkAdv under_Prep (mkNP (mkPN "100"))) ;
  CatSub1000 = mkCN (mkN "numeral") (S.mkAdv under_Prep (mkNP (mkPN "1000"))) ;
  CatSubj = mkCN (mkN "subjunction") ;
  CatTemp = mkCN (mkN "temporal and aspectual feature") ;
  CatTense = mkCN (mkN "tense") ;
  CatText = mkCN (mkN "text") ;
  CatUnit = mkCN (mkN "numeral") (S.mkAdv under_Prep (mkNP (mkPN "10"))) ;
  CatUtt = mkCN (mkN "utterance") ;
  CatV = mkCN (mkN "intransitive verb") ;
  CatV2 = mkCN (mkN "two-place verb") ;
  CatV2A = 
    mkCN (mkN "verb") (P.mkAdv "with noun phrase and adjective complements") ;
  CatV2Q = 
    mkCN (mkN "verb") (P.mkAdv "with noun phrase and question complements") ;
  CatV2S = 
    mkCN (mkN "verb") (P.mkAdv "with noun phrase and sentence complements") ;
  CatV2V = 
    mkCN (mkN "verb") (P.mkAdv "with noun phrase and verb phrase complements") ;
  CatV3 = mkCN (mkN "three-place verb") ;
  CatVA = 
    mkCN (mkN "verb") (P.mkAdv "with an adjective complement") ;
  CatVP = mkCN (mkN "verb phrase") ;
  CatVPSlash = slash (mkCN (mkN "verb phrase")) ;
  CatVQ = 
    mkCN (mkN "verb") (P.mkAdv "with a question complement") ;
  CatVS = 
    mkCN (mkN "verb") (P.mkAdv "with a sentence complement") ;
  CatVV = 
    mkCN (mkN "verb") (P.mkAdv "with a verb-phrase complement") ;
  CatVoc = mkCN (mkN "vocative") ;

  PTGender = mkCN (mkN "gender") ;
  PTNumber = mkCN (mkN "number") ;
  PTCase   = mkCN (mkN "case") ;
  PTTense  = mkCN (mkN "tense") ;

oper 
  slash : CN -> CN = \cn ->
     mkCN (mkAP (mkA2 (mkA "missing") []) (mkNP a_Det (mkN "noun phrase"))) cn ;

  funOf : N -> N -> CN = \f,x ->
     mkCN (mkN2 f possess_Prep) (mkNP a_Det x) ;
  funOfPl : N -> N -> CN = \f,x ->
     mkCN (mkN2 f possess_Prep) (mkNP aPl_Det x) ;
}
