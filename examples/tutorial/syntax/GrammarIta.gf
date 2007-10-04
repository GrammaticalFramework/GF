--# -path=.:prelude

concrete GrammarIta of Grammar = open Prelude, MorphoIta in {

  lincat
    Phr  = {s : Str} ;
    S    = {s : Str} ;
    QS   = {s : Str} ;
    NP   = {s : Str ; g : Gender ; n : Number} ;
    IP   = {s : Str ; g : Gender ; n : Number} ;
    CN   = Noun ;
    Det  = {s : Gender => Str ; n : Number} ;
    IDet = {s : Gender => Str ; n : Number} ;
    AP   = {s : Gender => Number => Str} ;
    AdA  = {s : Str} ;
    VP   = {s : Bool => Gender => Number => Str} ;
    N    = Noun ;
    A    = Adjective ;
    V    = Verb ;
    V2   = Verb2 ;
    Pol  = {s : Str ; p : Bool} ;


  lin
    PhrS = postfixSS "." ;
    PhrQS = postfixSS "?" ;

    PredVP   p np vp = {s = np.s ++ p.s ++ vp.s ! p.p ! np.g ! np.n} ;
    QuestVP  p np vp = {s = np.s ++ p.s ++ vp.s ! p.p ! np.g ! np.n} ;
    IPPredVP p np vp = {s = np.s ++ p.s ++ vp.s ! p.p ! np.g ! np.n} ;

    IPPredV2 p ip np v2 = 
      {s = v2.c ++ ip.s ++ p.s ++ posneg p.p ++ v2.s ! np.n ++ np.s} ;
 
    ComplV2 v2 np = {s = \\b,_,n => posneg b ++ v2.s ! n ++ v2.c ++ np.s} ;
    ComplAP ap    = {s = \\b,g,n => posneg b ++ copula n ++ ap.s ! g ! n} ;

    DetCN  det cn = {s = det.s ! cn.g ++ cn.s ! det.n ; g = cn.g ; n = det.n} ;
    IDetCN det cn = {s = det.s ! cn.g ++ cn.s ! det.n ; g = cn.g ; n = det.n} ;

    ModCN ap cn  = {s = \\n => cn.s ! n ++ ap.s ! cn.g ! n ; g = cn.g} ;

    AdAP ada ap  = {s = \\n,g => ada.s ++ ap.s ! n ! g} ;

    UseN n = n ;
    UseA a = a ;
    UseV v = {s = \\b,_,n => posneg b ++ v.s ! n} ;

    this_Det = mkDet Sg (regAdjective "questo") ;
    that_Det = mkDet Sg (regAdjective "quello") ;
    these_Det = mkDet Pl (regAdjective "questo") ;
    those_Det = mkDet Pl (regAdjective "quello") ;
    every_Det = {s = \\_ => "ogni" ; n = Sg} ;
    theSg_Det = {s = artDef Sg ; n = Sg} ;
    thePl_Det = {s = artDef Pl ; n = Pl} ;
    indef_Det = {s = artIndef ; n = Sg} ;
    plur_Det = {s = \\_ => [] ; n = Pl} ;
    two_Det = {s = \\_ => "due" ; n = Pl} ;
    very_AdA = {s = "molto"} ;
    which_IDet   = {s = \\_ => "quale" ; n = Sg} ;

    PPos = {s = [] ; p = True} ;
    PNeg = {s = [] ; p = False} ;

  oper
    copula : Number -> Str = \n -> case n of {
      Sg => "è" ;
      Pl => "sono"
      } ;

    posneg : Bool -> Str = \b -> case b of {
      True => [] ;
      False => "non"
      } ;

    mkDet : Number -> Adjective -> Det = \n,adj -> {
      s = \\g => adj.s ! g ! n ;
      n = n ;
      lock_Det = <>
      } ;

    artDef : Number -> Gender => Str = \n -> case n of {
      Sg => table {
        Masc => pre {"il"  ; "lo" / sImpuro} ;
        Fem  => "la"
        } ;
      Pl => table {
        Masc => pre {"i"  ; "gli" / sImpuro ; "gli" / vowel} ;
        Fem  => "le"
        }
      } ;

    artIndef : Gender => Str = table {
      Masc => pre {"un"  ; "uno" / sImpuro} ;
      Fem  => pre {"una" ; "un'" / vowel}
      } ;

    sImpuro : Strs = strs {"sb" ; "sp" ; "sy" ; "z"} ;
    vowel   : Strs = strs {"a" ; "e" ; "i" ; "o" ; "u"} ;

}
