abstract Imper = PredefAbs ** {

  cat
    Program ;
    Rec ListTyp ;
    Typ ;
    NumTyp ;
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
    EInt   : Int -> Exp (TNum TInt) ;
    EFloat : Int -> Int -> Exp (TNum TFloat) ;
    ELt    : (n : NumTyp) -> let Ex = Exp (TNum n) in Ex -> Ex -> Exp (TNum TInt) ;
    EApp   : (AS : ListTyp) -> (V : Typ) -> Fun AS V -> ListExp AS -> Exp V ;
    EAdd, EMul, ESub : (n : NumTyp) -> let Ex = Exp (TNum n) in Ex -> Ex -> Ex ;

    TNum   : NumTyp -> Typ ;  
    TInt, TFloat : NumTyp ;

    NilTyp  : ListTyp ;
    ConsTyp : Typ -> ListTyp -> ListTyp ;

    NilExp  : ListExp NilTyp ;
    OneExp  : (A : Typ) -> Exp A -> ListExp (ConsTyp A NilTyp) ;
    ConsExp : (A : Typ) -> (AS : ListTyp) -> 
                 Exp A -> ListExp AS -> ListExp (ConsTyp A AS) ;
}
