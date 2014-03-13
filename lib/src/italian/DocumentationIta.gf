--# -path=.:../abstract:../common

-- documentation of Italian in Italian: the default introduced in LangIta

concrete DocumentationIta of Documentation = CatIta ** 
  DocumentationItaFunctor with (Terminology = TerminologyIta) ;
