--# -path=.:../abstract

concrete ConstructionGrc of Construction = CatGrc ** 
  open SyntaxGrc, SymbolicGrc, ParadigmsGrc, 
       (L = LexiconGrc), (E = ExtraGrc), (G = GrammarGrc), (I = IrregGrc), (R = ResGrc), (N = NounGrc), Prelude in {
flags coding=utf8 ;

}
