resource DemRes = open Prelude in {

  oper

    Point : Type = 
      {point : Str} ;

    point : Point -> Str = \p ->
      p.point ;
 
    mkPoint : Str -> Point = \s -> 
      {point = s} ;

    noPoint : Point = 
      mkPoint [] ;

    concatPoint : (x,y : Point) -> Point = \x,y -> 
      mkPoint (point x ++ point y) ;

-- A type is made demonstrative by adding $Point$.

    Dem : Type -> Type = \t -> t ** Point ;

    mkDem : (t : Type) -> t -> Point -> Dem t = \_,x,s ->
      x ** s ;

    nonDem : (t : Type) -> t -> Dem t = \t,x ->
      mkDem t x noPoint ;


{-
    mkDemS  : Cl -> DemAdverb -> Pointing -> MultiSentence = \cl,adv,p ->
    {s = table {
       MInd   b => msS  (UseCl  (polar b) (AdvCl cl adv)) ;
       MQuest b => msQS (UseQCl (polar b) (QuestCl (AdvCl cl adv)))
       } ;
     point = p.point ++ adv.point
    } ;

    polar : Bool -> TP = \b -> case b of {
      True  => PosTP TPresent ASimul ;
      False => NegTP TPresent ASimul
      } ;

    mkDemQ  : QCl -> DemAdverb -> Pointing -> MultiQuestion = \cl,adv,p ->
    {s = \\b => msQS (UseQCl (polar b) cl) ++ adv.s ; --- (AdvQCl cl adv)) ;
     point = p.s5 ++ adv.s5
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

    MultiSentence   : Type = mkDemType {s : MSForm => Str} ;
    MultiQuestion   : Type = mkDemType {s : Bool   => Str} ;
    MultiImperative : Type = mkDemType {s : Bool   => Str} ;

    Demonstrative   : Type = mkDemType NP ;
    DemAdverb       : Type = mkDemType Adv ;

    mkDAdv : Adv -> Pointing -> DemAdverb = \a,p ->
      a ** p ** {lock_Adv = a.lock_Adv} ;

  param
    MSForm = MInd Bool | MQuest Bool ;

-}

}
