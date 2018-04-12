--# -path=.:../abstract:../common

-- documentation of Portuguese in Portuguese: the default introduced in LangPor

concrete DocumentationPor of Documentation = CatPor **
  DocumentationPorFunctor with (Terminology = TerminologyPor) ;
