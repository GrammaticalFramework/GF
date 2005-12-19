--# -path=.:prelude

concrete SyntaxIta of Syntax = open Prelude, MorphoIta in {

  lincat
    S    = {s : Str} ;
    NP   = {s : Str ; g : Gender ; n : Number} ;
    CN   = {s : Number => Str ; g : Gender} ;
    Det  = {s : Gender => Str ; n : Number} ;
    AP   = {s : Gender => Number => Str} ;
    AdA  = {s : Str} ;
    VP   = {s : Bool => Gender => Number => Str} ;
    V    = {s : Number => Str} ;
    V2   = {s : Number => Str ; c : Str} ;

  lin
    PosVP  np vp = {s = np.s ++ vp.s ! True  ! np.g ! np.n} ;
    NegVP  np vp = {s = np.s ++ vp.s ! False ! np.g ! np.n} ;
 
    PredAP ap    = {s = \\b,g,n => posneg b ++ copula n ++ ap.s ! g ! n} ;
    PredV  v     = {s = \\b,_,n => posneg b ++ v.s ! n} ;
    PredV2 v2 np = {s = \\b,_,n => posneg b ++ v2.s ! n ++ v2.c ++ np.s} ;

    DetCN det cn = {s = det.s ! cn.g ++ cn.s ! det.n ; g = cn.g ; n = det.n} ;

    ModCN ap cn  = {s = \\n => cn.s ! n ++ ap.s ! cn.g ! n ; g = cn.g} ;

    AdAP ada ap  = {s = \\n,g => ada.s ++ ap.s ! n ! g} ;

    this_Det = mkDet Sg (regAdjective "questo") ;
    that_Det = mkDet Sg (regAdjective "quello") ;
    these_Det = mkDet Pl (regAdjective "questo") ;
    those_Det = mkDet Pl (regAdjective "quello") ;
    every_Det = {s = \\_ => "ogni" ; n = Sg} ;
    theSg_Det = {s = artDef Sg ; n = Sg} ;
    thePl_Det = {s = artDef Pl ; n = Pl} ;
    a_Det = {s = artIndef ; n = Pl} ;
    plur_Det = {s = \\_ => [] ; n = Pl} ;
    two_Det = {s = \\_ => "due" ; n = Pl} ;

    very_AdA = {s = "molto"} ;
    too_AdA = {s = "troppo"} ;


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
