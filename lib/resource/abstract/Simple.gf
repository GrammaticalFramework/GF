abstract Simple = Categories ** {

cat

  Sentence ;

fun

  PAffirm    : Sentence -> Phr ;
  PNegate    : Sentence -> Phr ;
  PQuestion  : Sentence -> Phr ;
  PCommand   : Imp      -> Phr ;

  SVerb      : NP -> V         -> Sentence ;
  STransVerb : NP -> V2 -> NP  -> Sentence ;
  SAdjective : NP -> AP        -> Sentence ;
  SAdverb    : NP -> Adv       -> Sentence ;

  SModified  : Sentence -> Adv -> Sentence ;

  PIntV      : IP -> V        -> Phr ;
  PIntSubjV2 : IP -> V2 -> NP -> Phr ;
  PIntObjV2  : IP -> NP -> V2 -> Phr ;
  PIntAP     : IP -> AP ->       Phr ;
  PIntAdv    : IP -> Adv ->      Phr ;

  NPDef   : CN -> NP ;
  NPIndef : CN -> NP ;
  NPGroup : CN -> NP ;
  NPMass  : CN -> NP ;
  NPName  : PN -> NP ;

  NSimple   : N -> CN ;
  NModified : AP -> CN -> CN ;

  ASimple : ADeg -> AP ;
  AVery   : ADeg -> AP ;

  AdvPrep : Prep -> NP -> Adv ;

}
