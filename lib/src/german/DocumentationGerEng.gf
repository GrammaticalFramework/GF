--# -path=.:../abstract:../common

-- documentation of German in English

concrete DocumentationGerEng of Documentation = CatGer ** 
  DocumentationGerFunctor with (Terminology = TerminologyEng) ;
