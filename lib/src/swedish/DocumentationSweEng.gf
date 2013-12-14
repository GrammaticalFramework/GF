--# -path=.:../abstract:../common

-- documentation of Swedish in English

concrete DocumentationSweEng of Documentation = CatSwe ** 
  DocumentationSweFunctor with (Terminology = TerminologyEng) ;
