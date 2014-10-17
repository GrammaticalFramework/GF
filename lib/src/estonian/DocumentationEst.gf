--# -path=.:../abstract:../common

-- documentation of Estonian in Estonian: the default introduced in LangEst

concrete DocumentationEst of Documentation = CatEst ** 
  DocumentationEstFunctor with (Terminology = TerminologyEst) ;
