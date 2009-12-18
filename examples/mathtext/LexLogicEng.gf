instance LexLogicEng of LexLogic = open SyntaxEng, ParadigmsEng, 
  (MS = MakeStructuralEng), Prelude in {

oper
  case_N = mkN "case" ;
  such_A = mkA "such" ;
  by_Prep = mkPrep "by" ;
  all_Det = aPl_Det ;
  axiom_N = mkN "axiom" ;
  theorem_N = mkN "theorem" ;
  definition_N = mkN "definition" ;
  define_V3 = mkV3 (mkV "define") (mkPrep [] ) (mkPrep "as") ;
  define_V2V = mkV2V (mkV "define") (mkPrep [] ) (mkPrep []) ;
  iff_Subj = MS.mkSubj "if and only if" ;
}
