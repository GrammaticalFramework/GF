--1 Obsolete constructs included for backward-compatibility

abstract Backward = Cat ** {


-- from Cat 

cat 
    Slash ;
   
fun

-- from Verb 19/4/2008

    ComplV2  : V2  -> NP -> VP ;        -- use it
    ComplV3  : V3  -> NP -> NP -> VP ;  -- send a message to her
    ComplV2V : V2V -> NP -> VP -> VP ;  -- cause it to burn
    ComplV2S : V2S -> NP -> S  -> VP ;  -- tell me that it rains
    ComplV2Q : V2Q -> NP -> QS -> VP ;  -- ask me who came
    ComplV2A : V2A -> NP -> AP -> VP ;  -- paint it red

    ReflV2   : V2 -> VP ;         -- use itself

-- from Sentence 19/4/2008

    SlashV2   : NP -> V2 -> Slash ;         -- (whom) he sees
    SlashVVV2 : NP -> VV -> V2 -> Slash;    -- (whom) he wants to see 

-- from Noun 19/4/2008

    NumInt     : Int -> Num ;     -- 51
    OrdInt     : Int -> Ord ;     -- 51st (DEPRECATED)
    NoOrd : Ord ;

    -- 20/4
    DetSg : Quant ->        Ord -> Det ;  -- the best man
    DetPl : Quant -> Num -> Ord -> Det ;  -- the five best men
    NoNum : Num ;

    -- 22/4
    DefArt   : Quant ;       -- the (house), the (houses)
    IndefArt : Quant ;       -- a (house), (houses)
    MassDet  : Quant ;       -- (beer)

-- from Structural 19/4/2008

    that_NP : NP ;
    these_NP : NP ;
    this_NP : NP ;
    those_NP : NP ;

}
