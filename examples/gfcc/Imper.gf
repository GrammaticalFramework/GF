abstract Imper = {

  cat
    Program ;
    Typ ;
    ListTyp ;
    Fun ListTyp Typ ;
    Body ListTyp ;
    Stm ;
    Exp Typ ;
    Var Typ ;
    ListExp ListTyp ;

  fun
    Empty : Program ;
    Funct : (AS : ListTyp) -> (V : Typ) -> 
              (Body AS) -> (Fun AS V -> Program) -> Program ;

    BodyNil  : Stm -> Body NilTyp ;
    BodyCons : (A : Typ) -> (AS : ListTyp) -> 
                  (Var A -> Body AS) -> Body (ConsTyp A AS) ;

    Decl   : (A : Typ) -> (Var A -> Stm) -> Stm ;
    Assign : (A : Typ) -> Var A -> Exp A -> Stm -> Stm ;
    Return : (A : Typ) -> Exp A -> Stm ;
    While  : Exp TInt -> Stm -> Stm -> Stm ;
    IfElse : Exp TInt -> Stm -> Stm -> Stm -> Stm ;
    Block  : Stm -> Stm -> Stm ;
    End    : Stm ;

    EVar   : (A : Typ) -> Var A -> Exp A ;
    EInt   : Int -> Exp TInt ;
    EFloat : Int -> Int -> Exp TFloat ;
    EAddI  : Exp TInt -> Exp TInt -> Exp TInt ;
    EAddF  : Exp TFloat -> Exp TFloat -> Exp TFloat ;
    ESubI  : Exp TInt -> Exp TInt -> Exp TInt ;
    ESubF  : Exp TFloat -> Exp TFloat -> Exp TFloat ;
    EMulI  : Exp TInt -> Exp TInt -> Exp TInt ;
    EMulF  : Exp TFloat -> Exp TFloat -> Exp TFloat ;
    ELtI   : Exp TInt -> Exp TInt -> Exp TInt ;
    ELtF   : Exp TFloat -> Exp TFloat -> Exp TInt ;
    EApp   : (AS : ListTyp) -> (V : Typ) -> Fun AS V -> ListExp AS -> Exp V ;

    TInt   : Typ ;
    TFloat : Typ ;

    NilTyp  : ListTyp ;
    ConsTyp : Typ -> ListTyp -> ListTyp ;

    NilExp  : ListExp NilTyp ;
    ConsExp : (A : Typ) -> (AS : ListTyp) -> 
                 Exp A -> ListExp AS -> ListExp (ConsExp A AS) ;

}
