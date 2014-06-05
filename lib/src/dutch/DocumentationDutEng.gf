--# -path=.:../abstract:../common

-- documentation of Dutch in English

concrete DocumentationDutEng of Documentation = CatDut ** 
  DocumentationDutFunctor with (Terminology = TerminologyEng) ;
