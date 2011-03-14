abstract GrammarTerms = {

flags startcat = Rule ;

cat
  Rule ;
  Cat ; 
  ParamType ;
  ParamValue ;
  Language ;
  [Cat] {1} ;
  [ParamType] {1} ;

fun
  RuleFun : Cat -> [Cat] -> Rule ;
  RuleInherent : Cat -> [ParamType] -> Rule ;
  RuleVariable : Cat -> [ParamType] -> Rule ;

fun 
  CatA : Cat ;
  CatA2 : Cat ;
  CatAP : Cat ;
  CatAdA : Cat ;
  CatAdN : Cat ;
  CatAdV : Cat ;
  CatAdv : Cat ;
  CatAnt : Cat ;
  CatCAdv : Cat ;
  CatCN : Cat ;
  CatCard : Cat ;
  CatCl : Cat ;
  CatClSlash : Cat ;
  CatComp : Cat ;
  CatConj : Cat ;
  CatDet : Cat ;
  CatDig : Cat ;
  CatDigits : Cat ;
  CatIAdv : Cat ;
  CatIComp : Cat ;
  CatIDet : Cat ;
  CatIP : Cat ;
  CatIQuant : Cat ;
  CatImp : Cat ;
  CatImpForm : Cat ;
  CatInterj : Cat ;
  CatListAP : Cat ;
  CatListAdv : Cat ;
  CatListNP : Cat ;
  CatListRS : Cat ;
  CatListS : Cat ;
  CatN : Cat ;
  CatN2 : Cat ;
  CatN3 : Cat ;
  CatNP : Cat ;
  CatNum : Cat ;
  CatNumeral : Cat ;
  CatOrd : Cat ;
  CatPConj : Cat ;
  CatPN : Cat ;
  CatPhr : Cat ;
  CatPol : Cat ;
  CatPredet : Cat ;
  CatPrep : Cat ;
  CatPron : Cat ;
  CatPunct : Cat ;
  CatQCl : Cat ;
  CatQS : Cat ;
  CatQuant : Cat ;
  CatRCl : Cat ;
  CatRP : Cat ;
  CatRS : Cat ;
  CatS : Cat ;
  CatSC : Cat ;
  CatSSlash : Cat ;
  CatSub100 : Cat ;
  CatSub1000 : Cat ;
  CatSubj : Cat ;
  CatTemp : Cat ;
  CatTense : Cat ;
  CatText : Cat ;
  CatUnit : Cat ;
  CatUtt : Cat ;
  CatV : Cat ;
  CatV2 : Cat ;
  CatV2A : Cat ;
  CatV2Q : Cat ;
  CatV2S : Cat ;
  CatV2V : Cat ;
  CatV3 : Cat ;
  CatVA : Cat ;
  CatVP : Cat ;
  CatVPSlash : Cat ;
  CatVQ : Cat ;
  CatVS : Cat ;
  CatVV : Cat ;
  CatVoc : Cat ;

  PTGender : ParamType ;
  PTNumber : ParamType ;
  PTCase   : ParamType ;
  PTTense  : ParamType ;

}
