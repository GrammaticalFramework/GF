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
      s = \\agr,af => (infClause [] agr vp).s ! Past ! Anter ! Pos ! Sub ;
      isPre = notB vp.inf.p2
      } ;
    
    }