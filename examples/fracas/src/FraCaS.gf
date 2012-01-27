--# -path=.:alltenses

abstract FraCaS = Grammar, Additions, FraCaSLex ** {

flags
  startcat = Phr ;

-- language independent functions

fun
  ComparAsAs : A -> NP -> AP;

fun
  Adverbial : Adv -> Phr;
  PAdverbial : PConj -> Adv -> Phr;
  Nounphrase : NP -> Phr;
  PNounphrase : PConj -> NP -> Phr;
  Question : QS -> Phr;
  PQuestion : PConj -> QS -> Phr;
  Sentence : S -> Phr;
  PSentence : PConj -> S -> Phr;

fun
  Past : Temp;
  PastPerfect : Temp;
  Present : Temp;
  PresentPerfect : Temp;
  Future : Temp;
  FuturePerfect : Temp;
  Conditional : Temp;

fun
  ConjCN2 : Conj -> CN -> CN -> CN;
  ConjNP2 : Conj -> NP -> NP -> NP;
  ConjNP3 : Conj -> NP -> NP -> NP -> NP;
  ConjQS2 : Conj -> QS -> QS -> QS;
  ConjS2 : Conj -> S -> S -> S;
  ConjVPI2 : Conj -> VP -> VP -> VPI;
  ConjVPS2 : Conj -> Temp -> Pol -> VP -> Temp -> Pol -> VP -> VPS;

-- language dependent functions

fun
  UncNeg : Pol ;

fun
  ComplVSa : VS -> S -> VP ;
  ProgrVPa : VP -> VP ;

fun
  elliptic_V : V ;
  elliptic_NP_Sg, elliptic_NP_Pl : NP ; 
  elliptic_CN : CN ; 
  elliptic_VP : VP ;
  elliptic_Cl : Cl ; 
  elliptic_VPSlash : VPSlash ;
  elliptic_V2V : V2V ;

}
