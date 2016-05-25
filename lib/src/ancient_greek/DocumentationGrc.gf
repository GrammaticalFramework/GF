--# -path=.:../abstract:../common

-- documentation of Greek in Ancient Greek: the default introduced in LangGrc

concrete DocumentationGrc of Documentation = CatGrc ** 
  DocumentationGrcFunctor with (Terminology = TerminologyGrc) ;
