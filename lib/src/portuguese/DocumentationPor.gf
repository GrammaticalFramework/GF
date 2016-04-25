--# -path=.:../abstract:../common

-- documentation of Pornish in Pornish: the default introduced in LangPor

concrete DocumentationPor of Documentation = CatPor ** 
  DocumentationPorFunctor with (Terminology = TerminologyPor) ;
