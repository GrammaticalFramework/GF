resource ConstructX = open CommonX in {

  oper
    mkText : Str -> Text = \s -> {s = s ; lock_Text = <>} ; 
    mkPhr  : Str -> Phr  = \s -> {s = s ; lock_Phr = <>} ; 
    Utt = {s : Str} ;
    Voc = {s : Str} ;
    SC  = {s : Str} ;
    Adv = {s : Str} ; 
    AdV = {s : Str} ; 
    AdA = {s : Str} ; 
    AdS = {s : Str} ; 
    AdN = {s : Str} ;
    IAdv = {s : Str} ;
    CAdv = {s : Str} ;
    PConj = {s : Str} ;

}