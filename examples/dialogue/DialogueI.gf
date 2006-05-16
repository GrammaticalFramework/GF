incomplete concrete DialogueI of Dialogue = open Lang, Prelude in {

  lincat
    Move   = Phr ;
    Action = {s : ActType => Str} ;
    Kind   = CN ;
    Object = NP ;
    Oper0  = V ;
    Oper1  = V2 ;
    Oper2  = V3 ;

  lin
    MRequest a = ss (a.s ! ARequest) ;
    MAnswer  a = ss (a.s ! AAnswer) ;

    MQuery k = 
      PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos 
        (ExistIP (IDetCN whichPl_IDet NoNum NoOrd k)))) NoVoc ;

    AOper0 op         = mkAction (UseV op) ;
    AOper1 _   op x   = mkAction (ComplV2 op x) ;
    AOper2 _ _ op x y = mkAction (ComplV3 op x y) ;

    OAll k = PredetNP all_Predet (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) k) ;
    OIndef k = DetCN (DetSg (SgQuant IndefArt) NoOrd) k ;
    ODef k = DetCN (DetSg (SgQuant DefArt) NoOrd) k ;

  param
    ActType = ARequest | AAnswer ; -- and some others

  oper

  -- this should perhaps be language dependent - but at least these
  -- variants seem to make sense in all languages

    mkAction : VP -> {s : ActType => Str} = \vp -> {
      s = table {
        ARequest => variants {
          aImp vp ;
          aImpPlease vp ;
          aWant vp ;
          aCanYou vp
          } ;
        AAnswer => variants {
          aInf vp
          }
        }
      } ;

   aImp : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttImpSg PPos (ImpVP vp)) NoVoc).s ;

   aImpPlease : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttImpSg PPos (ImpVP vp)) please_Voc).s ;

   aWant : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos (PredVP (UsePron i_Pron) 
        (ComplVV want_VV vp)))) NoVoc).s ;

   aCanYou : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos (QuestCl (PredVP 
        (UsePron youSg_Pron) (ComplVV can_VV vp))))) NoVoc).s ;

   aInf : VP -> Str = \vp ->
     (PhrUtt NoPConj (UttVP vp) NoVoc).s ;

}

