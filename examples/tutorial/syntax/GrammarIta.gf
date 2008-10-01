--# -path=.:prelude

concrete GrammarIta of Grammar = open Prelude, MorphoIta in {

  lincat
    Phr  = {s : Str} ;
    S    = {s : Str} ;
    QS   = {s : Str} ;
    Cl   = Clause ;
    QCl  = Clause ;
    NP   = NounPhrase ;
    IP   = NounPhrase ;
    CN   = Noun ;
    Det  = {s : Gender => Str ; n : Number} ;
    IDet = {s : Gender => Str ; n : Number} ;
    AP   = {s : Gender => Number => Str} ;
    AdA  = {s : Str} ;
    VP   = VerbPhrase ;
    N    = Noun ;
    A    = Adjective ;
    V    = Verb ;
    V2   = Verb2 ;
    Conj = {s : Str} ;
    Subj = {s : Str} ;
    Pol  = {s : Str ; p : Bool} ;

  oper
    Clause     : Type = {s : Bool => Str} ;
    NounPhrase : Type = {s : Str ; g : Gender ; n : Number} ;
    VerbPhrase : Type = {s : Bool => Gender => Number => Str} ; 
  lin
    PhrS = postfixSS "." ;
    PhrQS = postfixSS "?" ;

    UseCl  pol cl  = {s = pol.s ++ cl.s  ! pol.p} ;
    UseQCl pol qcl = {s = pol.s ++ qcl.s ! pol.p} ;

    QuestCl cl = cl ;

    SubjS subj s = {s = subj.s ++ s.s} ;

    PredVP  = predVP ;

    QuestVP = predVP ;

    QuestV2 ip np v2 = 
      {s = \\b => v2.c ++ ip.s ++ posneg b ++ v2.s ! np.n ++ np.s} ;
 
    ComplV2 v2 np = {s = \\b,_,n => posneg b ++ v2.s ! n ++ v2.c ++ np.s} ;
    ComplAP ap    = {s = \\b,g,n => posneg b ++ copula n ++ ap.s ! g ! n} ;

    DetCN  det cn = {s = det.s ! cn.g ++ cn.s ! det.n ; g = cn.g ; n = det.n} ;

    ModCN ap cn  = {s = \\n => cn.s ! n ++ ap.s ! cn.g ! n ; g = cn.g} ;

    AdVP adv vp  = {s = \\p,n,g => vp.s ! p ! n ! g ++ adv.s} ;
    AdAP ada ap  = {s = \\n,g => ada.s ++ ap.s ! n ! g} ;

    IDetCN det cn = {s = det.s ! cn.g ++ cn.s ! det.n ; g = cn.g ; n = det.n} ;

    ConjS c a b = {s = a.s ++ c.s ++ b.s} ;
    ConjNP c a b = {s = a.s ++ c.s ++ b.s ; n = Pl ; g = conjGender a.g b.g} ;

    UseN n = n ;
    UseA a = a ;
    UseV v = {s = \\b,_,n => posneg b ++ v.s ! n} ;

    this_Det = mkDet Sg (regAdjective "questo") ;
    that_Det = mkDet Sg quello ;
    these_Det = mkDet Pl (regAdjective "questo") ;
    those_Det = mkDet Pl quello ;
    every_Det = {s = \\_ => "ogni" ; n = Sg} ;
    theSg_Det = {s = artDef Sg ; n = Sg} ;
    thePl_Det = {s = artDef Pl ; n = Pl} ;
    indef_Det = {s = artIndef ; n = Sg} ;
    plur_Det = {s = \\_ => [] ; n = Pl} ;
    two_Det = {s = \\_ => "due" ; n = Pl} ;
    today_Adv = {s = "oggi"} ;
    very_AdA = {s = "molto"} ;
    which_IDet   = {s = \\_ => "quale" ; n = Sg} ;
    and_Conj = {s = "e"} ;
    because_Subj = {s = "perché"} ;

    PPos = {s = [] ; p = True} ;
    PNeg = {s = [] ; p = False} ;

  oper
    predVP : NounPhrase -> VerbPhrase -> Clause = \np,vp -> 
      {s = \\b => np.s ++ vp.s ! b ! np.g ! np.n} ;

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

    conjGender : Gender -> Gender -> Gender = \g,h -> case g of {
      Masc => Masc ;
      _ => h
    } ;

    quello : Adjective = 
      let 
        quel = pre {"quel"  ; "quello" / sImpuro ; "quell'" / vowel} ;
        quei = pre {"quei"  ; "quegli" / sImpuro ; "quegli" / vowel} ;
      in mkAdjective quel "quella" quei "quelle" ;

    sImpuro : Strs = strs {"sb" ; "sp" ; "sy" ; "z"} ;
    vowel   : Strs = strs {"a" ; "e" ; "i" ; "o" ; "u"} ;


}
