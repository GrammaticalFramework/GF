abstract ExtraJpnAbs = Cat ** {
  cat
    Level ;  -- style of speech
    Part ;   -- particles wa/ga

  fun
    Honorific : Level ;
    Informal  : Level ;
    
    PartWA : Part ;
    PartGA : Part ;

    StylePartPhr : Level -> Part -> PConj -> Utt -> Voc -> Phr ;
  } ;
