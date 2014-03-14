--# -path=.:../translator:../../../examples/phrasebook

abstract App =
    SmallPred
  , Extensions [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]
  , Documentation - [Pol,Tense]
  , Dictionary - [Pol,Tense]

  , Phrasebook
              ** {
flags
  startcat=Phr ;

fun
  PhrasePhr : Phrase -> Phr ;

}
