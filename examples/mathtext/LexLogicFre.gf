instance LexLogicFre of LexLogic = open SyntaxFre, ParadigmsFre, 
  (MS = MakeStructuralFre), Prelude in {

oper
  case_N = mkN "cas" ;
  such_A = mkA "tel" "telle" ;
  by_Prep = mkPrep "par" ;
  all_Det = thePl_Det ;
  axiom_N = mkN "axiome" masculine ;
  theorem_N = mkN "théorème" masculine ;
  definition_N = mkN "définition" feminine ;
  define_V3 = mkV3 (mkV "définir") (mkPrep []) (mkPrep "comme") ;
  define_V2V = mkV2V (mkV "définir") (mkPrep []) genitive ;
  iff_Subj = MS.mkSubj ("si et seulement" ++ if_Subj.s) ; --- .s

}
