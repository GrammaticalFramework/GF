abstract Imper = {

  cat
    Stm ;
    Typ ;
    Exp Typ ;
    Var Typ ;

  fun
    Decl   : (A : Typ) -> (Var A -> Stm) -> Stm ;
    Assign : (A : Typ) -> Var A -> Exp A -> Stm ;
    Return : (A : Typ) -> Exp A -> Stm ;
    While  : Exp TInt -> Stm -> Stm ;
    Block  : Stm -> Stm ;
    None   : Stm ;
    Next   : Stm -> Stm -> Stm ;

    EVar   : (A : Typ) -> Var A -> Exp A ;
    EInt   : Int -> Exp TInt ;
    EFloat : Int -> Int -> Exp TFloat ;
    EAddI  : Exp TInt -> Exp TInt -> Exp TInt ;
    EAddF  : Exp TFloat -> Exp TFloat -> Exp TFloat ;

    TInt   : Typ ;
    TFloat : Typ ;

  cat
    Program ;
    Typs ;
    Fun Typs Typ ;
    Body Typs ;
    Exps Typs ;

  fun
    Empty : Program ;
    Funct : (AS : Typs) -> (V : Typ) -> 
              (Body AS) -> (Fun V AS -> Program) -> Program ;

    NilTyp : Typs ;
    ConsTyp : Typ -> Typs -> Typs ;

    BodyNil  : Stm -> Body NilTyp ;
    BodyCons : (A : Typ) -> (AS : Typs) -> 
                  (Var A -> Body AS) -> Body (ConsTyp A AS) ;

    EApp  : (args : Typs) -> (val : Typ) -> Fun args val -> Exps args -> Exp val ;

    NilExp : Exps NilTyp ;
    ConsExp : (A : Typ) -> (AS : Typs) -> 
                 Exp A -> Exps AS -> Exps (ConsExp A AS) ;

}
