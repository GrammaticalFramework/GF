incomplete concrete DialogueI of Dialogue = open Lang, Prelude in {

  lincat
    Move   = Phr ;
    Action = {s : ActType => Str} ;
    Proposition = Phr ; ----
    Question = Phr ;
    Kind   = CN ;
    Object = NP ;
    Oper0  = V ;
    Oper1  = V2 ;
    Oper2  = V3 ;

  lin
    MRequest a = ss (a.s ! ARequest) ;
    MConfirm a = ss (a.s ! AConfirm) ;
    MAnswer  a = a ;
    MIssue   a = a ;

    MYes = yes_Phr ;
    MNo  = no_Phr ;
    MObject _ ob = PhrUtt NoPConj (UttNP ob) optPlease ;

    PAction a  = ss (a.s ! AConfirm) ;

    QKind k = 
      PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos 
        (ExistIP (IDetCN whichPl_IDet NoNum NoOrd k)))) NoVoc ;

    AOper0 op         = mkAction (UseV op) ;
    AOper1 _   op x   = mkAction (ComplV2 op x) ;
    AOper2 _ _ op x y = mkAction (ComplV3 op x y) ;

    OAll k   = PredetNP all_Predet (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) k) ;
    OIndef k = DetCN (DetSg (SgQuant IndefArt) NoOrd) k ;
    ODef k   = DetCN (DetSg (SgQuant DefArt) NoOrd) k ;

  param
    ActType  = ARequest | AConfirm ; -- and some others

  oper

  -- this should perhaps be language dependent - but at least these
  -- variants seem to make sense in all languages

    mkAction : VP -> {s : ActType => Str} = \vp -> {
      s = table {
        ARequest => variants {
          aImp vp ;
          aWant vp ;
          aCanYou vp
          } ;
        AConfirm => variants {
          aInf vp
          }
        }
      } ;

   optPlease : Voc = variants {NoVoc ; please_Voc} ;

   aImp : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttImpSg PPos (ImpVP vp)) optPlease).s ;

   aWant : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos (PredVP (UsePron i_Pron) 
        (ComplVV want_VV vp)))) optPlease).s ;

   aCanYou : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos (QuestCl (PredVP 
        (UsePron youSg_Pron) (ComplVV can_VV vp))))) optPlease).s ;

   aInf : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttVP vp) NoVoc).s ;

}

