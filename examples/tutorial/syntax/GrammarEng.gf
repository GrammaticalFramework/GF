--# -path=.:prelude

concrete GrammarEng of Grammar = open Prelude, MorphoEng in {

  lincat
    Phr  = {s : Str} ;
    S    = {s : Str} ;
    QS   = {s : Str} ;
    Cl   = {s : Order => Bool => Str} ;
    QCl  = {s : Order => Bool => Str} ;
    NP   = NounPhrase ;
    IP   = NounPhrase ;
    CN   = Noun ;
    Det  = {s : Str ; n : Number} ;
    IDet = {s : Str ; n : Number} ;
    AP   = {s : Str} ;
    Adv  = {s : Str} ;
    AdA  = {s : Str} ;
    VP   = VerbPhrase ;
    N    = Noun ;
    A    = {s : Str} ;
    V    = Verb ;
    V2   = Verb2 ;
    Conj = {s : Str} ;
    Subj = {s : Str} ;
    Pol  = {s : Str ; p : Bool} ;

  lin
    PhrS  = postfixSS "." ;
    PhrQS = postfixSS "?" ;

    UseCl  pol cl  = {s = pol.s ++ cl.s  ! Dir ! pol.p} ;
    UseQCl pol qcl = {s = pol.s ++ qcl.s ! Inv ! pol.p} ;

    QuestCl cl = cl ;
 
    SubjS subj s = {s = subj.s ++ s.s} ;

    PredVP = predVP ;

    QuestVP ip vp = let cl = predVP ip vp in  {s = \\_ => cl.s ! Dir};

    QuestV2 ip np v2 = {
      s = \\ord,pol => 
          let 
            vp : VerbPhrase = predVerb v2
          in 
          bothWays (ip.s ++ (predVP np vp).s ! ord ! pol) v2.c
    } ;

    ComplV2 v np = insertObject (v.c ++ np.s) (predVerb v) ;

    ComplAP ap = {
      s = \\_,b,n => {
        fin = copula b n ; 
        inf = ap.s 
      }
    } ;

    DetCN det cn = {s = det.s ++ cn.s ! det.n ; n = det.n} ;

    ModCN ap cn  = {s = \\n => ap.s ++ cn.s ! n} ;

    AdVP adv vp  = {
      s = \\o,b,n => 
        let vps = vp.s ! o ! b ! n in {
          fin = vps.fin ;
          inf =  vps.inf ++ adv.s
        }
    } ;

    AdAP ada ap  = {s = ada.s ++ ap.s} ;

    IDetCN det cn = {s = det.s ++ cn.s ! det.n ; n = det.n} ;

    ConjS c a b = {s = a.s ++ c.s ++ b.s} ;
    ConjNP c a b = {s = a.s ++ c.s ++ b.s ; n = Pl} ;

    UseN n = n ;
    UseA a = a ;
    UseV = predVerb ;

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
    today_Adv = {s = "today"} ;
    very_AdA = {s = "very"} ;
    which_IDet = {s = "which" ; n = Sg} ;

    and_Conj = {s = "and"} ;
    because_Subj = {s = "because"} ;

    PPos = {s = [] ; p = True} ;
    PNeg = {s = [] ; p = False} ;

  param
    Order = Dir | Inv ;

  oper
    NounPhrase = {s : Str ; n : Number} ;
    VerbPhrase = {s : Order => Bool => Number => {fin,inf : Str}} ;

    predVP : NounPhrase -> VerbPhrase -> {s : Order => Bool => Str} = 
      \np,vp -> {
      s = \\q,p => 
          let vps = vp.s ! q ! p ! np.n 
          in case q of {
            Dir => np.s ++ vps.fin ++ vps.inf ;
            Inv => vps.fin ++ np.s ++ vps.inf
            }
    } ;

    copula : Bool -> Number -> Str = \b,n -> case n of {
      Sg => posneg b "is" ;
      Pl => posneg b "are"
      } ;

    do : Bool -> Number -> Str = \b,n -> 
      posneg b ((mkV "do").s ! n) ;

    predVerb : Verb -> VerbPhrase = \verb -> {
      s = \\q,b,n => 
      let 
        inf = verb.s ! Pl ;
        fin = verb.s ! n ;
        aux = do b n
      in
      case <q,b> of {
        <Dir,True> => {fin = []  ; inf = fin} ;
        _          => {fin = aux ; inf = inf}
        }
      } ;

    insertObject : Str -> VerbPhrase -> VerbPhrase = 
      \obj,vp -> {
      s = \\q,b,n => let vps = vp.s ! q ! b! n in {
        fin = vps.fin ;
        inf = vps.inf ++ obj
      }
    } ;

    posneg : Bool -> Str -> Str = \b,do -> case b of {
      True => do ;
      False => do + "n't"
      } ;

    artIndef : Str = 
      pre {"a" ; "an" / strs {"a" ; "e" ; "i" ; "o"}} ;
        
}
