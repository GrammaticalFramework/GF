--# -path=.:../abstract:../common

-- documentation of Finnish in Finnish: the default introduced in LangFin

concrete DocumentationFin of Documentation = CatFin ** 
  DocumentationFinFunctor with (Terminology = TerminologyFin) ;
