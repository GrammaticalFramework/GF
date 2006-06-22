interface DemRes = open Prelude, Resource in {

  oper
    Pointing = {s5 : Str} ;

    noPointing : Pointing = {s5 = []} ;

    mkDemS  : Cl -> DemAdverb -> Pointing -> MultiSentence = \cl,adv,p ->
    {s = table {
       MInd   b => msS  (UseCl  (polar b) (AdvCl cl adv)) ;
       MQuest b => msQS (UseQCl (polar b) (QuestCl (AdvCl cl adv)))
       } ;
     s5 = p.s5 ++ adv.s5
    } ;

    polar : Bool -> TP = \b -> case b of {
      True  => PosTP TPresent ASimul ;
      False => NegTP TPresent ASimul
      } ;

    mkDemQ  : QCl -> DemAdverb -> Pointing -> MultiQuestion = \cl,adv,p ->
    {s = \\b => msQS (UseQCl (polar b) cl) ++ adv.s ; --- (AdvQCl cl adv)) ;
     s5 = p.s5 ++ adv.s5
    } ;
    mkDemImp : VCl -> DemAdverb -> Pointing -> MultiImperative = \cl,adv,p ->
    {s = table { 
           True  => msImp (PosImpVP cl) ++ adv.s ;
           False => msImp (NegImpVP cl) ++ adv.s
           } ;
     s5 = p.s5 ++ adv.s5
    } ;

    msS   : S  -> Str ;
    msQS  : QS -> Str ;
    msImp : Imp -> Str ;

    concatDem : (x,y : Pointing) -> Pointing = \x,y -> {
      s5 = x.s5 ++ y.s5
      } ;

    mkDemType : Type -> Type = \t -> t ** Pointing ;

    MultiSentence   : Type = mkDemType {s : MSForm => Str} ;
    MultiQuestion   : Type = mkDemType {s : Bool   => Str} ;
    MultiImperative : Type = mkDemType {s : Bool   => Str} ;

    Demonstrative   : Type = mkDemType NP ;
    DemAdverb       : Type = mkDemType Adv ;

    mkDAdv : Adv -> Pointing -> DemAdverb = \a,p ->
      a ** p ** {lock_Adv = a.lock_Adv} ;

  param
    MSForm = MInd Bool | MQuest Bool ;

}
