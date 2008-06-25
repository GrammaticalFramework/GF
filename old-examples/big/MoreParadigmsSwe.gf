resource MoreParadigmsSwe = ParadigmsSwe ** open Prelude, CatSwe in {

oper
  s2 : Str -> N = decl2Noun ;
  s3 : Str -> N = decl3Noun ;
  s4 : Str -> N = decl4Noun ;
  s5 : Str -> N = decl5Noun ;

  v2 : Str -> V = conj2 ;
  v3 : Str -> V = conj3 ;

  aAbstract : Str -> A = \a -> mk2A a a ;
  aFager : Str -> A = \a -> mk3A a (a + "t") (Predef.tk 2 a + "a") ;
  aGrund : Str -> A = regA ; -- yes
  aKorkad : Str -> A = \a -> mk3A a (init a + "t") (a + "e") ;
  aVaken : Str -> A = \a -> mk3A a (init a + "t") (Predef.tk 2 a + "a") ;
  aVid : Str -> A = regA ; -- yes

---- to do
  sParti : Str -> N = regN ;
  sPapper : Str -> N = regN ;
  sKikare : Str -> N = regN ;
  sProgram : Str -> N = regN ;
  sNyckel : Str -> N = regN ;
  sMuseum : Str -> N = regN ;
  sKam : Str -> N = regN ;


}
