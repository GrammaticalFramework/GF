instance LexLogicGer of LexLogic = open SyntaxGer, ParadigmsGer, 
  (MS = MakeStructuralGer), Prelude in {

oper
  case_N = mkN "Fall" "Fälle" masculine ;
  such_A = invarA "derart" ; ----
  by_Prep = mkPrep "durch" accusative ;
  all_Det = aPl_Det ;
  axiom_N = mkN "Axiom" ;
  theorem_N = mkN "Theorem" ;
  definition_N = mkN "Definition" ;
  define_V3 = 
    mkV3 (mkV "definieren") (mkPrep [] accusative) (mkPrep "als" accusative) ;
  define_V2V = mkV2V (mkV "definieren") (mkPrep [] accusative) ;
  iff_Subj = MS.mkSubj "wenn und nur wenn" ;
}
