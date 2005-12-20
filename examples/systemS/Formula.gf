-- 20 Dec 2005, 9.45

abstract Formula = {

  cat 
    Formula ;
    Term ;

  fun
    And, Or, If : (_,_ : Formula) -> Formula ;
    Not : Formula -> Formula ;
    Abs : Formula ;

----    All, Exist : (Term -> Formula) -> Formula ;

  -- to test

    A, B, C : Formula ;

}