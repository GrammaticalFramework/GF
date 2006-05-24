incomplete concrete DialogueI of Dialogue = open Multi, Prelude in {

  lincat
    Move   = Phr ;
    Action = {s : ActType => Str ; point : Str} ;
    Proposition = Utt ; ----
    Question = Utt ;
    Kind   = CN ;
    Object = NP ;
    Oper0  = V ;
    Oper1  = V2 ;
    Oper2  = V3 ;

  lin
    IRequest a = {s = a.s ! ARequest ; point = a.point} ;
    IConfirm a = {s = a.s ! AConfirm ; point = a.point} ;
    IAnswer  a = a ;
    IIssue   a = a ;

    IYes = yes_Phr ** noPoint ;
    INo  = no_Phr ** noPoint ;
    IObject _ ob = UttNP ob ;

    PAction a  = {s = a.s ! AConfirm ; point = a.point} ;

    QKind k = 
      UttQS (UseQCl TPres ASimul PPos 
        (ExistIP (IDetCN whichPl_IDet NoNum NoOrd k))) ;

    AOper0 op         = mkAction (UseV op) ;
    AOper1 _   op x   = mkAction (ComplV2 op x) ;
    AOper2 _ _ op x y = mkAction (ComplV3 op x y) ;

    OAll k = PredetNP all_Predet (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) k) ;
    OIndef k = DetCN (DetSg (SgQuant IndefArt) NoOrd) k ;
    ODef k   = DetCN (DetSg (SgQuant DefArt) NoOrd) k ;

  param
    ActType  = ARequest | AConfirm ; -- and some others

  oper

  -- this should perhaps be language dependent - but at least these
  -- variants seem to make sense in all languages

    mkAction : VP -> {s : ActType => Str ; point : Str} = \vp -> {
      s = table {
        ARequest => (variants {
          aImp vp ;
          aWant vp ;
          aCanYou vp
          }).s ;
        AConfirm => (variants {
          aInf vp
          }).s
        } ;
      point = vp.point
      } ;

    optPlease : Voc = variants {NoVoc ; please_Voc} ;
 
    aImp : VP -> Utt = \vp ->
      UttImpSg PPos (ImpVP vp) ;

    aWant : VP -> Utt = \vp ->
      UttS (UseCl TPres ASimul PPos 
        (PredVP (UsePron i_Pron) (ComplVV want_VV vp))) ;

    aCanYou : VP -> Utt = \vp ->
      UttQS (UseQCl TPres ASimul PPos (QuestCl 
        (PredVP (UsePron youSg_Pron) (ComplVV can_VV vp)))) ;

    aInf : VP -> Utt = \vp ->
      UttVP vp ;

-- multimodality

  lincat
    Click  = Point ;
    Input  = Utt ;
    Speech = Multi.Speech ;

  lin
    OThis     k c = this8point_NP c ;
    OThisKind k c = DetCN (DetSg (SgQuant (this8point_Quant c)) NoOrd) k ;

    MInput i = PhrUtt NoPConj i optPlease ;
    SInput i = SpeechUtt NoPConj i optPlease ;

    MkClick = MkPoint ;

  oper
    noPoint = {point = []} ;

}

