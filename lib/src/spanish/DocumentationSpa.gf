--# -path=.:../abstract:../common

-- documentation of Spanish in Spanish: the default introduced in LangSpa

concrete DocumentationSpa of Documentation = CatSpa ** 
  DocumentationSpaFunctor with (Terminology = TerminologySpa) ;
