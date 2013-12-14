--# -path=.:../abstract:../common

-- documentation of Finnish in English

concrete DocumentationFinEng of Documentation = CatFin ** 
  DocumentationFinFunctor with (Terminology = TerminologyEng) ;
