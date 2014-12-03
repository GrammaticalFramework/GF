--# -path=.:../abstract:../common

-- documentation of Catalan in Catalan: the default introduced in LangCat

concrete DocumentationCat of Documentation = CatCat ** 
  DocumentationCatFunctor with (Terminology = TerminologyCat) ;
