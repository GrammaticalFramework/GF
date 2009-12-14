abstract Editor = {

cat Adjective ;
    Noun ;
    Verb ;
    Determiner ;
    Sentence ;

fun Available : Adjective ;
    Next      : Adjective ;
    Previous  : Adjective ;
 
fun Bulgarian : Noun ;
    Danish    : Noun ;
    English   : Noun ;
    Finnish   : Noun ;
    French    : Noun ;
    German    : Noun ;
    Italian   : Noun ;
    Norwegian : Noun ;
    Russian   : Noun ;
    Spanish   : Noun ;
    Swedish   : Noun ;

fun Float_N    : Noun ;
    Integer_N  : Noun ;
    String_N   : Noun ;
    
    Language   : Noun ;
    Node       : Noun ;
    Page       : Noun ;
    Refinement : Noun ;
    Tree       : Noun ;
    Wrapper    : Noun ;

fun Copy    : Verb ;
    Cut     : Verb ;
    Delete  : Verb ;
    Enter   : Verb ;
    Parse   : Verb ;
    Paste   : Verb ;
    Redo    : Verb ;
    Refine  : Verb ;
    Replace : Verb ;
    Select  : Verb ;
    Show    : Verb ;
    Undo    : Verb ;
    Wrap    : Verb ;

fun DefPlDet   : Determiner ;
    DefSgDet   : Determiner ;
    IndefPlDet : Determiner ;
    IndefSgDet : Determiner ;

fun Command           : Verb -> Determiner -> Noun -> Sentence ;
    CommandAdj        : Verb -> Determiner -> Adjective -> Noun -> Sentence ;
    ErrorMessage      : Adjective -> Noun -> Sentence ;   
    Label             : Noun -> Sentence ;
    RandomlyCommand   : Verb -> Determiner -> Noun -> Sentence ;
    SingleWordCommand : Verb -> Sentence ;

}