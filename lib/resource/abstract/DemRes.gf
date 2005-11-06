interface DemRes = open Prelude, Resource in {

  oper
    Pointing = {s5 : Str} ;

    noPointing : Pointing = {s5 = []} ;

    mkDemS  : Cl -> DemAdverb -> Pointing -> MultiSentence = \cl,adv,p ->
    {s = table {
       MInd   => msS  (UseCl  (PosTP TPresent ASimul) (AdvCl cl adv)) ;
       MQuest => msQS (UseQCl (PosTP TPresent ASimul) (QuestCl (AdvCl cl adv)))
       } ;
     s5 = p.s5 ++ adv.s5
    } ;
    mkDemQ  : QCl -> DemAdverb -> Pointing -> MultiQuestion = \cl,adv,p ->
    {s = msQS (UseQCl (PosTP TPresent ASimul) cl) ++ adv.s ; --- (AdvQCl cl adv)) ;
     s5 = p.s5 ++ adv.s5
    } ;

    msS   : S  -> Str ;
    msQS  : QS -> Str ;
    msImp : Imp -> Str ;

    concatDem : (x,y : Pointing) -> Pointing = \x,y -> {
      s5 = x.s5 ++ y.s5
      } ;

    mkDemType : Type -> Type = \t -> t ** Pointing ;

    Demonstrative : Type = mkDemType NP ;
    MultiSentence : Type = mkDemType {s : MSForm => Str} ;
    MultiQuestion : Type = mkDemType SS ;
    DemAdverb     : Type = mkDemType Adv ;

    addDAdv : Adv -> Pointing -> DemAdverb -> DemAdverb = \a,p,d ->
      {s = a.s ++ d.s ; s5 = p.s5 ++ d.s5 ; lock_Adv = a.lock_Adv} ;

  param
    MSForm = MInd | MQuest ;

}
