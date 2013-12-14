--# -path=.:../abstract:../common

-- documentation of French in English

concrete DocumentationFreEng of Documentation = CatFre ** 
  DocumentationFreFunctor with (Terminology = TerminologyEng) ;
