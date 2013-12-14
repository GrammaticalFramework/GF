--# -path=.:../abstract:../common

-- documentation of Swedish in Swedish: the default introduced in LangSwe

concrete DocumentationSwe of Documentation = CatSwe ** 
  DocumentationSweFunctor with (Terminology = TerminologySwe) ;
