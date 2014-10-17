--# -path=.:../abstract:../common

-- documentation of Estonian in English

concrete DocumentationEstEng of Documentation = CatEst ** 
  DocumentationEstFunctor with (Terminology = TerminologyEng) ;
