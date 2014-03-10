--# -path=.:../translator:../../../examples/phrasebook

abstract App =
    NDTrans
  , Phrasebook
              ** {
flags
  startcat=Phr;

fun
  PhrasePhr : Phrase -> Phr ;

}
