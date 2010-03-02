abstract Imper = {

  flags startcat = Program ;

  cat
    Program ;
    Rec ListTyp ;
    Typ ;
    IsNum Typ ;
    ListTyp ;
    Fun ListTyp Typ ;
    Stm ;
    Exp Typ ;
    Var Typ ;
    ListExp ListTyp ;

  fun
    Empty : Program ;
    Funct : (AS : ListTyp) -> (V : Typ) -> 
              (Fun AS V -> Rec AS) -> Program ;
    FunctNil : (V : Typ) -> 
                 Stm -> (Fun NilTyp V -> Program) -> Program ;
    RecOne  : (A : Typ) -> (Var A -> Stm) -> Program -> Rec (ConsTyp A NilTyp) ;
    RecCons : (A : Typ) -> (AS : ListTyp) -> 
                  (Var A -> Rec AS) -> Program -> Rec (ConsTyp A AS) ;

    Decl    : (A : Typ) -> (Var A -> Stm) -> Stm ;
    Assign  : (A : Typ) -> Var A -> Exp A -> Stm -> Stm ;
    While   : Exp TInt -> Stm -> Stm -> Stm ;
    IfElse  : Exp TInt -> Stm -> Stm -> Stm -> Stm ;
    Block   : Stm -> Stm -> Stm ;
    Printf  : (A : Typ) -> Exp A -> Stm -> Stm ;
    Return  : (A : Typ) -> Exp A -> Stm ;
    Returnv : Stm ;
    End     : Stm ;

    EVar   : (A : Typ) -> Var A -> Exp A ;
    EInt   : Int -> Exp TInt ;
    EFloat : Int -> Int -> Exp TFloat ;
    ELt    : (n : Typ) -> IsNum n -> Exp n -> Exp n -> Exp TInt ;
    EAdd, EMul, ESub : (n : Typ) -> IsNum n -> Exp n -> Exp n -> Exp n ;
    EAppNil : (V : Typ) -> Fun NilTyp V -> Exp V ;
    EApp    : (AS : ListTyp) -> (V : Typ) -> Fun AS V -> ListExp AS -> Exp V ;

    TInt, TFloat : Typ ;
    isNumInt : IsNum TInt ; isNumFloat : IsNum TFloat ; 
    NilTyp  : ListTyp ;
    ConsTyp : Typ -> ListTyp -> ListTyp ;

    OneExp  : (A : Typ) -> Exp A -> ListExp (ConsTyp A NilTyp) ;
    ConsExp : (A : Typ) -> (AS : ListTyp) -> 
                 Exp A -> ListExp AS -> ListExp (ConsTyp A AS) ;
}
