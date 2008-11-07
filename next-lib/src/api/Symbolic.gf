--1 Symbolic: Noun Phrases with mathematical symbols

incomplete resource Symbolic = open Symbol, Grammar, PredefCnc in {

  oper
    symb : overload {
      symb : Str -> NP ;                       -- x
      symb : Int -> NP ;                       -- 23
      symb : Float -> NP ;                     -- 0.99
      symb : N  -> Digits -> NP ;              -- level 4
      symb : N  -> Card -> NP ;                -- level at least four
      symb : CN -> Card -> NP ;                -- advanced level at least four
      symb : Det -> N  -> Card -> NP ;         -- the number at least four
      symb : Det -> CN -> Card -> NP ;         -- the even number at least four
      symb : N  -> Numeral -> NP ;             -- level four
      symb : CN -> Numeral -> NP ;             -- advanced level four
      symb : Det -> N  -> Numeral -> NP ;      -- the number four
      symb : Det -> CN -> Numeral -> NP ;      -- the even number four
      symb : Det -> N  -> Str -> Str -> NP ;   -- the levels i and j
      symb : Det -> CN -> [Symb] -> NP ;       -- the basic levels i, j, and k
      symb : Symb -> S ;                       -- A
      symb : Symb -> Card ;                    -- n
      symb : Symb -> Ord                       -- n'th
      } ;

    mkSymb : Str -> Symb ;
    mkInteger : Predef.Int -> Integer ;
    mkFloating : Predef.Float -> Floating ;

--.

    symb = overload {
      symb : Str -> NP 
                          = \s -> UsePN (SymbPN (mkSymb s)) ;
      symb : Int -> NP 
                          = \i -> UsePN (IntPN i) ;
      symb : Float -> NP 
                          = \i -> UsePN (FloatPN i) ;
      symb : N -> Digits -> NP 
                          = \c,i -> CNNumNP (UseN c) (NumDigits i) ;
      symb : N -> Card -> NP 
                          = \c,n -> CNNumNP (UseN c) n ;
      symb : CN -> Card -> NP 
                          = \c,n -> CNNumNP c n ;
      symb : Det -> N  -> Card -> NP
                          = \d,n,x -> DetCN d (ApposCN (UseN n) (UsePN (NumPN x))) ;
      symb : Det -> CN -> Card -> NP
                          = \d,n,x -> DetCN d (ApposCN n (UsePN (NumPN x))) ;
      symb : N -> Numeral -> NP 
                          = \c,n -> CNNumNP (UseN c) (NumNumeral n) ;
      symb : CN -> Numeral -> NP 
                          = \c,n -> CNNumNP c (NumNumeral n) ;
      symb : Det -> N  -> Numeral -> NP
                          = \d,n,x -> DetCN d (ApposCN (UseN n) (UsePN (NumPN (NumNumeral x)))) ;
      symb : Det -> CN -> Numeral -> NP
                          = \d,n,x -> DetCN d (ApposCN n (UsePN (NumPN (NumNumeral x)))) ;
      symb : Det -> N  -> Str -> Str -> NP 
                          = \c,n,x,y -> CNSymbNP c (UseN n) (BaseSymb (mkSymb x) (mkSymb y)) ;
      symb : Det -> CN -> [Symb] -> NP 
                          = CNSymbNP ;
      symb : Symb -> S = SymbS ;
      symb : Symb -> Card = SymbNum ;
      symb : Symb -> Ord = SymbOrd
      } ;

    mkSymb : Str -> Symb = \s -> {s = s ; lock_Symb = <>} ;

    mkInteger i = {s = Predef.show Predef.Int i ; lock_Int = <>} ;
    mkFloating f = {s = Predef.show Predef.Float f ; lock_Float = <>} ;

    Integer : Type = {s : Str ; lock_Int : {}} ;
    Floating : Type = {s : Str ; lock_Float : {}} ;

}
