--# -path=.:../maltese:../common:../abstract:../prelude

resource TryMlt = SyntaxMlt, LexiconMlt, ParadigmsMlt - [mkAdN, mkAdv,mkOrd,mkQuant] ** 
  open (P = ParadigmsMlt) in {

}
