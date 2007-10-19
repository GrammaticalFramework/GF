--1 Symbolic: Noun Phrases with mathematical symbols

incomplete resource Symbolic = open Symbol, Grammar in {

  oper
    symb : overload {
      symb : Str -> NP ;                       -- x
      symb : Int -> NP ;                       -- 23
      symb : Float -> NP ;                     -- 0.99
      symb : N -> Int -> NP ;                  -- level 4
      symb : N -> Num -> NP ;                  -- level four
      symb : CN -> Num -> NP ;                 -- difficult level four
      symb : Det -> N  -> Num -> NP ;          -- the number four
      symb : Det -> CN -> Num -> NP ;          -- the even number four
      symb : Det -> N  -> Str -> Str -> NP ;   -- the levels i and j
      symb : Det -> CN -> [Symb] -> NP         -- the basic levels i, j, and k
      } ;

    mkSymb : Str -> Symb ;

--.

    symb = overload {
      symb : Str -> NP 
                          = \s -> UsePN (SymbPN (mkSymb s)) ;
      symb : Int -> NP 
                          = \i -> UsePN (IntPN i) ;
      symb : Float -> NP 
                          = \i -> UsePN (FloatPN i) ;
      symb : N -> Int -> NP 
                          = \c,i -> CNNumNP (UseN c) (NumInt i) ;
      symb : N -> Num -> NP 
                          = \c,n -> CNNumNP (UseN c) n ;
      symb : CN -> Num -> NP 
                          = \c,n -> CNNumNP c n ;
      symb : Det -> N  -> Num -> NP
                          = \d,n,x -> DetCN d (ApposCN (UseN n) (UsePN (NumPN x))) ;
      symb : Det -> CN -> Num -> NP
                          = \d,n,x -> DetCN d (ApposCN n (UsePN (NumPN x))) ;
      symb : Det -> N  -> Str -> Str -> NP 
                          = \c,n,x,y -> CNSymbNP c (UseN n) (BaseSymb (mkSymb x) (mkSymb y)) ;
      symb : Det -> CN -> [Symb] -> NP 
                          = CNSymbNP
      } ;

    mkSymb : Str -> Symb = \s -> {s = s ; lock_Symb = <>} ;

}
