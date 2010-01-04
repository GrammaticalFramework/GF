--# -path=alltenses
concrete EditorEng of Editor = open GrammarEng, ParadigmsEng in {

lincat Adjective = A ;
       Noun = N ;
       Verb = V ;
       Determiner = Det ;
       Sentence = Utt ;

lin Available = mkA "available" ;
    Next      = mkA "next" ;
    Previous  = mkA "previous" ;

lin Bulgarian = mkN "Bulgarian" ;
    Danish    = mkN "Danish" ;
    English   = mkN "English" ;
    Finnish   = mkN "Finnish" ;
    French    = mkN "French" ;
    German    = mkN "German" ;
    Italian   = mkN "Italian" ;
    Norwegian = mkN "Norwegian" ;
    Russian   = mkN "Russian" ;
    Spanish   = mkN "Spanish" ;
    Swedish   = mkN "Swedish" ;

lin Float_N    = mkN "float" ;
    Integer_N  = mkN "integer" ;
    String_N   = mkN "string" ;
    
    Language   = mkN "language" ;
    Node       = mkN "node" ;
    Page       = mkN "page" ;
    Refinement = mkN "refinement" ;
    Tree       = mkN "tree" ;
    Wrapper    = mkN "wrapper" ;

lin Copy    = mkV "copy" ;
    Cut     = mkV "cut" ;
    Delete  = mkV "delete" ;
    Enter   = mkV "enter" ;
    Parse   = mkV "parse" ;
    Paste   = mkV "paste" ;
    Redo    = mkV "redo" ;
    Refine  = mkV "refine" ;
    Replace = mkV "replace" ;
    Select  = mkV "select" ;
    Show    = mkV "show" ;
    Undo    = mkV "undo" ;
    Wrap    = mkV "wrap" ;

lin DefPlDet   = DetQuant DefArt   NumPl ;
    DefSgDet   = DetQuant DefArt   NumSg ;
    IndefPlDet = DetQuant IndefArt NumPl ;
    IndefSgDet = DetQuant IndefArt NumSg ;

lin Command v d n = UttImpSg PPos (ImpVP (ComplSlash (SlashV2a (mkV2 v)) (DetCN d (UseN n)))) ;
    CommandAdj v d a n = UttImpSg PPos (ImpVP (ComplSlash (SlashV2a (mkV2 v)) (DetCN d (AdjCN (PositA a) (UseN n))))) ;
    ErrorMessage a n = UttNP (DetCN (DetQuant no_Quant NumPl) (AdjCN (PositA a) (UseN n))) ;
    Label n = UttNP (MassNP (UseN n)) ;
    RandomlyCommand v d n = UttImpSg PPos (ImpVP (AdvVP (ComplSlash (SlashV2a (mkV2 v)) (DetCN d (UseN n))) (PrepNP (mkPrep "at") (MassNP (UseN (mkN "random")))))) ;
    SingleWordCommand v = UttImpSg PPos (ImpVP (UseV v)) ;

}