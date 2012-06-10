concrete ExtraJpn of ExtraJpnAbs = CatJpn ** open ResJpn, Prelude, ParadigmsJpn in {

  lincat
    Level = {s : Str ; l : Style} ;
    Part = {s : Str ; p : Particle} ;
    
  lin
    Honorific = {s = [] ; l = Resp} ;
    Informal  = {s = [] ; l = Plain} ;
    
    PartWA = {s = [] ; p = Wa} ;
    PartGA = {s = [] ; p = Ga} ;
    
    StylePartPhr level part pconj utt voc = {
      s = case voc.type of {
        Please => case utt.type of {
          ImpPolite => level.s ++ part.s ++ pconj.s ++ utt.s ! part.p ! Resp ++ voc.null ;
          (Imper|NoImp) => level.s ++ part.s ++ pconj.s ++ utt.s ! part.p ! Resp ++ voc.s ! Resp
          } ;
        VocPres => case utt.type of {
          (Imper|ImpPolite) => level.s ++ part.s ++ voc.s ! Plain ++ "," ++ pconj.s ++ 
                               utt.s ! part.p ! Plain ;
          NoImp => level.s ++ part.s ++ voc.s ! level.l ++ "," ++ pconj.s ++ 
                   utt.s ! part.p ! level.l
          } ;
        VocAbs => case utt.type of {
          (Imper|ImpPolite) => level.s ++ part.s ++ voc.s ! Plain ++ pconj.s ++ 
                               utt.s ! part.p ! Plain ;
          NoImp => level.s ++ part.s ++ voc.s ! level.l ++ pconj.s ++ utt.s ! part.p ! level.l
          }
        } 
      } ;
  } ;
