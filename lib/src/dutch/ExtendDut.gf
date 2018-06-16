--# -path=alltenses:../common:../abstract

concrete ExtendDut of Extend =
  CatDut ** ExtendFunctor
   - [PastPartAP,ICompAP,IAdvAdv]
  with
    (Grammar = GrammarDut) **
  open
    GrammarDut,
    ResDut,
    Coordination,
    Prelude,
    ParadigmsDut in {

lin

  PastPartAP vp = { --# notpresent
    s = \\agr,af => let aForm = case vp.isHeavy of { --# notpresent
                          True  => APred ; --# notpresent
                          False => af } ; --# notpresent
                     in (infClause [] agr vp aForm).s ! Past ! Anter ! Pos ! Sub ; --# notpresent
    isPre = notB vp.isHeavy ; --# notpresent
   } ; --# notpresent
    
  ICompAP ap = {s = \\agr => "hoe" ++ ap.s ! agr ! APred} ; 

  IAdvAdv adv = {s = "hoe" ++ adv.s} ;
}