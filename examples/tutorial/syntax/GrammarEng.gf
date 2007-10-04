--# -path=.:prelude

concrete GrammarEng of Grammar = open Prelude, MorphoEng in {

  lincat
    Phr  = {s : Str} ;
    S    = {s : Str} ;
    QS   = {s : Str} ;
    NP   = NounPhrase ;
    IP   = NounPhrase ;
    CN   = Noun ;
    Det  = {s : Str ; n : Number} ;
    IDet = {s : Str ; n : Number} ;
    AP   = {s : Str} ;
    AdA  = {s : Str} ;
    VP   = VerbPhrase ;
    N    = Noun ;
    A    = {s : Str} ;
    V    = Verb ;
    V2   = Verb2 ;
    Pol  = {s : Str ; p : Bool} ;

  lin
    PhrS = postfixSS "." ;
    PhrQS = postfixSS "?" ;
 
    PredVP   = predVP True ;
    QuestVP  = predVP False ;
    IPPredVP = predVP True ;

    IPPredV2 p ip np v2 = {
      s = let 
            vp : VerbPhrase = {s = \\q,b,n => predVerb v2 q b n} ;
          in 
          bothWays (ip.s ++ (predVP False p np vp).s) v2.c
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

    IDetCN det cn = {s = det.s ++ cn.s ! det.n ; n = det.n} ;

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

    which_IDet = {s = "which" ; n = Sg} ;

    PPos = {s = [] ; p = True} ;
    PNeg = {s = [] ; p = False} ;

  oper
    NounPhrase = {s : Str ; n : Number} ;
    VerbPhrase = {s : Bool => Bool => Number => Str * Str} ; -- decl, pol

    predVP : Bool -> {s : Str ; p : Bool} -> NounPhrase -> VerbPhrase -> SS = 
      \q,p,np,vp -> {
      s = let vps = vp.s ! q ! p.p ! np.n 
          in case q of {
            True  => p.s ++ np.s ++ vps.p1 ++ vps.p2 ;
            False => p.s ++ vps.p1 ++ np.s ++ vps.p2
            }
    } ;

    copula : Bool -> Number -> Str = \b,n -> case n of {
      Sg => posneg b "is" ;
      Pl => posneg b "are"
      } ;

    do : Bool -> Number -> Str = \b,n -> 
      posneg b ((mkV "do").s ! n) ;

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
