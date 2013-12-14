--# -path=.:../abstract:../common

-- documentation of French in French: the default introduced in LangFre

concrete DocumentationFre of Documentation = CatFre ** 
  DocumentationFreFunctor with (Terminology = TerminologyFre) ;
