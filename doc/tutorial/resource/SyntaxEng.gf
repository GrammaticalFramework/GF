--# -path=.:prelude

concrete SyntaxEng of Syntax = open Prelude, MorphoEng in {

  lincat
    Phr  = {s : Str} ;
    S    = {s : Str} ;
    QS   = {s : Str} ;
    NP   = MorphoEng.NP ;
    IP   = MorphoEng.NP ;
    CN   = Noun ;
    Det  = {s : Str ; n : Number} ;
    AP   = {s : Str} ;
    AdA  = {s : Str} ;
    VP   = MorphoEng.VP ;
    N    = Noun ;
    A    = {s : Str} ;
    V    = Verb ;
    V2   = Verb ** {c : Str} ;

  lin
    PhrS = postfixSS "." ;
    PhrQS = postfixSS "?" ;
 
    PosVP   = predVP True True ;
    NegVP   = predVP True False ;
    QPosVP  = predVP False True ;
    QNegVP  = predVP False False ;
    IPPosVP = predVP True True ;
    IPNegVP = predVP True False ;

    IPPosV2 ip np v2 = {
      s = let 
            vp : MorphoEng.VP = {s = \\q,b,n => predVerb v2 q b n} ;
          in 
          bothWays (ip.s ++ (predVP False True np vp).s) v2.c
    } ;
    IPNegV2 ip np v2 = {
      s = let 
            vp : MorphoEng.VP = {s = \\q,b,n => predVerb v2 q b n} ;
          in 
          bothWays (ip.s ++ (predVP False False np vp).s) v2.c
    } ;
    
        
    ComplV2 v2 np = {
      s = \\q,b,n => 
        let vp = predVerb v2 q b n in
        <vp.p1, vp.p2 ++ v2.c ++ np.s>
    } ;

    ComplAP ap = {s = \\_,b,n => <copula b n, ap.s>} ;

    DetCN det cn = {s = det.s ++ cn.s ! det.n ; n = det.n} ;

    ModCN ap cn  = {s = \\n => ap.s ++ cn.s ! n} ;

    AdAP ada ap  = {s = ada.s ++ ap.s} ;

    WhichCN cn = {s = "which" ++ cn.s ! Sg ; n = Sg} ;

    UseN n = n ;
    UseA a = a ;
    UseV v = {s = \\q,b,n => predVerb v q b n} ;

    this_Det = {s = "this" ; n = Sg} ;
    that_Det = {s = "that" ; n = Sg} ;
    these_Det = {s = "these" ; n = Pl} ;
    those_Det = {s = "those" ; n = Pl} ;
    every_Det = {s = "every" ; n = Sg} ;
    theSg_Det = {s = "the" ; n = Sg} ;
    thePl_Det = {s = "the" ; n = Pl} ;
    indef_Det = {s = artIndef ; n = Sg} ;
    plur_Det = {s = [] ; n = Pl} ;
    two_Det = {s = "two" ; n = Pl} ;

    very_AdA = {s = "very"} ;

  oper
    predVP : Bool -> Bool -> MorphoEng.NP -> MorphoEng.VP -> SS = 
      \q,b,np,vp -> {
      s = let vps = vp.s ! q ! b ! np.n 
          in case q of {
            True  => np.s ++ vps.p1 ++ vps.p2 ;
            False => vps.p1 ++ np.s ++ vps.p2
            }
    } ;

    copula : Bool -> Number -> Str = \b,n -> case n of {
      Sg => posneg b "is" ;
      Pl => posneg b "are"
      } ;

    do : Bool -> Number -> Str = \b,n -> 
      posneg b ((regVerb "do").s ! n) ;

    predVerb : Verb -> Bool -> Bool -> Number -> Str * Str = \verb,q,b,n -> 
      let 
        inf = verb.s ! Pl ;
        fin = verb.s ! n ;
        aux = do b n
      in
      case <q,b> of {
        <True,True> => <[],fin> ;
        _ => <aux,inf>
        } ;

    posneg : Bool -> Str -> Str = \b,do -> case b of {
      True => do ;
      False => do + "n't"
      } ;

    artIndef : Str = 
      pre {"a" ; "an" / strs {"a" ; "e" ; "i" ; "o"}} ;
}
