--# -path=.:../abstract:../common

-- documentation of English in English: the default introduced in LangEng

concrete DocumentationEng of Documentation = CatEng ** 
  DocumentationEngFunctor with (Terminology = TerminologyEng) ;

