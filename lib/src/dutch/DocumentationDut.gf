--# -path=.:../abstract:../common

-- documentation of Dutch in Dutch: the default introduced in LangDut

concrete DocumentationDut of Documentation = CatDut ** 
  DocumentationDutFunctor with (Terminology = TerminologyDut) ;
