--# -path=alltenses:../common:../abstract

concrete ExtendDut of Extend =
  CatDut ** ExtendFunctor
   - [PastPartAP]
  with
    (Grammar = GrammarDut) **
  open
    GrammarDut,
    ResDut,
    Coordination,
    Prelude,
    ParadigmsDut in {
  lin

  PastPartAP vp = {
    s = \\agr,af => let aForm = case vp.isHeavy of {
                          True  => APred ;
                          False => af } ;
                     in (infClause [] agr vp aForm).s ! Past ! Anter ! Pos ! Sub ;
    isPre = notB vp.isHeavy ;
   } ;
    
 }