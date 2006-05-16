interface AuxDialogue = open Lang in {
  oper
    defN : N -> NP = \n -> 
      DetCN (DetSg (SgQuant DefArt) NoOrd) (UseN n) ;

    mkMove : Str -> Phr = \s -> {s = variants {
        s ;
        s ++ please_Voc.s
        } ;
        lock_Phr = <>
      } ;

}