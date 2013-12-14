--# -path=.:../abstract:../common

-- documentation of German in German: the default introduced in LangGer

concrete DocumentationGer of Documentation = CatGer ** 
  DocumentationGerFunctor with (Terminology = TerminologyGer) ;
