--# -path=.:../arabic:../common:../abstract:../prelude

resource TryAra = SyntaxAra, LexiconAra, ParadigmsAra - [mkAdN, mkAdv,mkOrd,mkQuant] ** 
  open (P = ParadigmsAra) in {

}
