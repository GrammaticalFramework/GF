--# -path=.:../abstract:prelude

resource ConstructX = open CommonX in {

  oper
    mkText : Str -> Text = \s -> {s = s ; lock_Text = <>} ; 
    mkPhr  : Str -> Phr  = \s -> {s = s ; lock_Phr = <>} ; 
    mkUtt : Str -> Utt  = \s -> {s = s ; lock_Utt = <>} ;
    mkVoc : Str -> Voc  = \s -> {s = s ; lock_Voc = <>} ;
    mkSC : Str -> SC  = \s -> {s = s ; lock_SC = <>} ;
    mkAdv : Str -> Adv  = \s -> {s = s ; lock_Adv = <>} ;
    mkAdV : Str -> AdV  = \s -> {s = s ; lock_AdV = <>} ;
    mkAdA : Str -> AdA  = \s -> {s = s ; lock_AdA = <>} ;
    mkAdN : Str -> AdN  = \s -> {s = s ; lock_AdN = <>} ;
    mkIAdv : Str -> IAdv  = \s -> {s = s ; lock_IAdv = <>} ;
    mkCAdv : Str -> CAdv  = \s -> {s = s ; lock_CAdv = <>} ;
    mkPConj : Str -> PConj  = \s -> {s = s ; lock_PConj = <>} ;

}
