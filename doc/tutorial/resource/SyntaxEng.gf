--# -path=.:prelude

concrete SyntaxEng of Syntax = open Prelude, MorphoEng in {

  lincat
    S    = {s : Str} ;
    NP   = {s : Str ; n : Number} ;
    CN   = {s : Number => Str} ;
    Det  = {s : Str ; n : Number} ;
    AP   = {s : Str} ;
    AdA  = {s : Str} ;
    VP   = {s : Bool => Number => Str} ;
    V    = {s : Number => Str} ;
    V2   = {s : Number => Str ; c : Str} ;

  lin
    PosVP  np vp = {s = np.s ++ vp.s ! True  ! np.n} ;
    NegVP  np vp = {s = np.s ++ vp.s ! False ! np.n} ;
 
    PredAP ap    = {s = \\b,n => copula b n ++ ap.s} ;
    PredV  v     = {s = \\b,n => predVerb b n v} ;
    PredV2 v2 np = {s = \\b,n => predVerb b n v2 ++ v2.c ++ np.s} ;

    DetCN det cn = {s = det.s ++ cn.s ! det.n ; n = det.n} ;

    ModCN ap cn  = {s = \\n => ap.s ++ cn.s ! n} ;

    AdAP ada ap  = {s = ada.s ++ ap.s} ;

    this_Det = {s = "this" ; n = Sg} ;
    that_Det = {s = "that" ; n = Sg} ;
    these_Det = {s = "these" ; n = Pl} ;
    those_Det = {s = "those" ; n = Pl} ;
    every_Det = {s = "every" ; n = Sg} ;
    theSg_Det = {s = "the" ; n = Sg} ;
    thePl_Det = {s = "the" ; n = Pl} ;
    a_Det = {s = artIndef ; n = Sg} ;
    plur_Det = {s = [] ; n = Pl} ;
    two_Det = {s = "two" ; n = Pl} ;

    very_AdA = {s = "very"} ;
    too_AdA = {s = "too"} ;


  oper
    copula : Bool -> Number -> Str = \b,n -> case n of {
      Sg => posneg b "is" ;
      Pl => posneg b "are"
      } ;

    predVerb : Bool -> Number -> Verb -> Str = \b,n,verb -> 
      let inf = verb.s ! Sg in
      case b of {
        True  => verb.s ! n ;
        False => posneg b ((regVerb "do").s ! n) ++ inf
        } ;

    posneg : Bool -> Str -> Str = \b,do -> case b of {
      True => do ;
      False => do + "n't"
      } ;

    artIndef : Str = 
      pre {"a" ; "an" / strs {"a" ; "e" ; "i" ; "o"}} ;


}
