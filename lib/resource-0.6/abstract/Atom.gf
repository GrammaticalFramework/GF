interface Atom = ResourceExt ** open Resource in {
  param
    Polarity = Pos | Neg ;

  oper
    AS : Type = {s : Polarity => SBranch} ;
    SBranch : Type ;

    mkPred : NP -> VG -> {s : Polarity => SBranch} = \x,F -> {s = 
      table {
        Pos => (PredVP x (PosVG F)).s ;
        Neg => (PredVP x (NegVG F)).s
        }
      } ;

    posAS, negAS : AS -> S ;
 
    posAS p = {s = p.s ! Pos ; lock_S =<>} ;
    negAS p = {s = p.s ! Neg ; lock_S =<>} ;
  } ;
