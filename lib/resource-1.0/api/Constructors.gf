--1 Constructors: the High-Level Syntax API

-- This module gives access to (almost) all functions in the resource
-- syntax API defined in [Grammar Grammar.html]. It uses overloaded
-- function names to reduce the burden of remembering different names.
--
-- The principle is simply:
-- to construct an object of type $C$, use the function $mkC$.
--
-- For example, to the object
--
-- $PredVP (UsePron she_Pron) (ComplV2 love_V2 (UsePN paris_PN))$
--
-- can now also be written
--
-- $mkCl (mkNP she_Pron) (mkVP love_V2 (mkNP paris_PN))$
--
-- In addition to exact variants of the $Grammar$ functions, the module
-- gives some common special cases using deeper terms and default arguments.
-- An example of deeper terms is two-place coordination such as
--
-- $mkNP : Conj -> NP -> NP -> NP$. 
--
-- An example of default arguments is present-tense sentences,
--
-- $mkS : Cl -> S$.
--
-- The "old" API can of course be used simultaneously with this one.
-- Typically, $Grammar$ and $Paradigms$ are needed to be $open$ed in addition
-- to this. 


incomplete resource Constructors = open Grammar in {

  oper

--2 Texts, phrases, and utterances

    mkText : overload {
      mkText : Text               ;   -- [empty text]
      mkText : Phr -> Text        ;   -- John walks.
      mkText : Utt -> Text        ;   -- John walks.
      mkText : S -> Text          ;   -- John walks.
      mkText : Cl -> Text         ;   -- John walks.
      mkText : QS -> Text         ;   -- Does John walk?
      mkText : Imp -> Text        ;   -- Walk!
      mkText : Pol -> Imp -> Text ;   -- Don't walk!
      mkText : Phr -> Text -> Text    -- John walks. ...
      } ;

    mkPhr : overload {
      mkPhr : PConj -> Utt -> Voc -> Phr;   -- But go home my friend
      mkPhr : Utt -> Phr                ;   -- Go home
      mkPhr : S -> Phr                      -- I go home
      } ;

    mkUtt : overload {
      mkUtt : S -> Utt                  ;   -- John walks
      mkUtt : QS -> Utt                 ;   -- is it good
      mkUtt : Pol -> Imp -> Utt         ;   -- (don't) help yourself
      mkUtt : Imp -> Utt                ;   -- help yourself
      mkUtt : IP   -> Utt               ;   -- who
      mkUtt : IAdv -> Utt               ;   -- why
      mkUtt : NP   -> Utt               ;   -- this man
      mkUtt : Adv  -> Utt               ;   -- here
      mkUtt : VP   -> Utt                   -- to sleep
      } ;

--2 Sentences, and clauses

    mkS : overload {
      mkS : Cl -> S ;                        -- John walks
      mkS : Tense -> Cl -> S ;               -- John walked
      mkS : Ant -> Cl -> S ;                 -- John is walking
      mkS : Pol -> Cl -> S ;                 -- John doesn't walk
      mkS : Tense -> Ant -> Cl -> S ;        -- John was walking
      mkS : Tense -> Pol -> Cl -> S ;        -- John didn't walk
      mkS : Ant -> Pol -> Cl -> S ;          -- John isn't walking
      mkS : Tense -> Ant -> Pol -> Cl -> S ; -- John wouldn't have walked
      mkS : Conj -> S -> S -> S ;            -- John walks and Mary talks   
      mkS : DConj -> S -> S -> S ;           -- either I leave or you come
      mkS : Conj -> ListS -> S ;             -- John walks, Mary talks, and Bob runs
      mkS : DConj -> ListS -> S ;            -- either I leave, you come, or he runs
      mkS : Adv -> S -> S                    -- today, I will sleep
      } ;

    mkCl : overload {
      mkCl : NP -> VP -> Cl   ;   -- John wants to walk
      mkCl : NP -> V -> Cl    ;   -- John walks
      mkCl : NP -> V2 -> NP -> Cl ; -- John uses it
      mkCl : VP -> Cl         ;   -- it rains
      mkCl : NP  -> RS -> Cl  ;   -- it is you who did it
      mkCl : Adv -> S  -> Cl  ;   -- it is yesterday she arrived
      mkCl : NP -> Cl         ;   -- there is a house
      mkCl : NP -> AP -> Cl   ;   -- John is nice and warm
      mkCl : NP -> A  -> Cl   ;   -- John is warm
      mkCl : NP -> A -> NP -> Cl; -- John is warmer than Mary
      mkCl : NP -> A2 -> NP -> Cl; -- John is married to Mary
      mkCl : NP -> NP -> Cl   ;   -- John is a man
      mkCl : NP -> Adv -> Cl      -- John is here
      } ;

--2 Verb phrases and imperatives

    mkVP : overload {
      mkVP : V   -> VP            ;   -- sleep
      mkVP : V2  -> NP -> VP      ;   -- use it
      mkVP : V3  -> NP -> NP -> VP ;  -- send a message to her
      mkVP : VV  -> VP -> VP      ;   -- want to run
      mkVP : VS  -> S  -> VP      ;   -- know that she runs
      mkVP : VQ  -> QS -> VP      ;   -- ask if she runs
      mkVP : VA  -> AP -> VP      ;   -- look red
      mkVP : V2A -> NP -> AP -> VP ;  -- paint the house red
      mkVP : AP -> VP             ;   -- be warm
      mkVP : NP -> VP             ;   -- be a man
      mkVP : Adv -> VP            ;   -- be here
      mkVP : VP -> Adv -> VP      ;   -- sleep here
      mkVP : AdV -> VP -> VP          -- always sleep
      } ;

    mkImp : overload {
      mkImp : VP -> Imp              ;   -- go there now
      mkImp : V  -> Imp              ;   -- go
      mkImp : V2 -> NP -> Imp            -- take it
      } ;

--2 Noun phrases and determiners

    mkNP : overload {
      mkNP : Det -> CN -> NP  ;        -- the old man
      mkNP : Det -> N -> NP   ;        -- the man
      mkNP : PN -> NP         ;        -- John
      mkNP : Pron -> NP       ;        -- he
      mkNP : Predet -> NP -> NP ;      -- all the men
      mkNP : NP -> V2  -> NP  ;        -- the number squared
      mkNP : NP -> Adv -> NP  ;        -- Paris at midnight
      mkNP : Conj -> NP -> NP -> NP ;  -- John and Mary walk
      mkNP : DConj -> NP -> NP -> NP ; -- both John and Mary walk
      mkNP : Conj -> ListNP -> NP ;    -- John, Mary, and Bill walk
      mkNP : DConj -> ListNP -> NP     -- both John, Mary, and Bill walk

      } ;

    mkDet : overload {
      mkDet : QuantSg -> Ord -> Det        ;   -- this best (man)
      mkDet : Det                          ;   -- the (man)
      mkDet : QuantSg ->  Det              ;   -- this (man)
      mkDet : QuantPl -> Num -> Ord -> Det ;   -- these five best (men)
      mkDet : QuantPl -> Det               ;   -- these (men)
      mkDet : Quant ->  Det                ;   -- this (man)
      mkDet : Num -> Det                   ;   -- forty-five (men)
      mkDet : Digit -> Det                 ;   -- five (men)
      mkDet : Pron -> Det                      -- my (house)
      } ;

   def_Det : Det ;   -- the (man)
   indef_Det : Det ; -- a (man)
   mass_Det : Det ;  -- (water)

-- More determiners are available in the Structural module
   

--2 Numerals - cardinal and ordinal 

    mkNum : overload {
      mkNum : Num            ;   -- [no num]
      mkNum : Int -> Num     ;   -- 51
      mkNum : Digit -> Num
      } ;

    mkOrd : overload {
      mkOrd : Ord            ;   -- [no ord]
      mkOrd : Int -> Ord     ;   -- 51st
      mkOrd : Digit -> Ord   ;   -- fifth
      mkOrd : A -> Ord           -- largest
      } ;

--2 Common nouns

    mkCN : overload {
      mkCN : N  -> CN               ;   -- house
      mkCN : N2 -> NP -> CN         ;   -- son of the king
      mkCN : N3 -> NP -> NP -> CN   ;   -- flight from Moscow (to Paris)
      mkCN : N2 -> CN               ;   -- son
      mkCN : N3 -> CN               ;   -- flight
      mkCN : AP -> CN  -> CN        ;   -- nice and big blue house
      mkCN : AP ->  N  -> CN        ;   -- nice and big house
      mkCN : CN -> AP  -> CN        ;   -- nice and big blue house
      mkCN :  N -> AP  -> CN        ;   -- nice and big house
      mkCN :  A -> CN  -> CN        ;   -- big blue house
      mkCN :  A ->  N  -> CN        ;   -- big house
      mkCN : CN -> RS  -> CN        ;   -- house that John owns
      mkCN :  N -> RS  -> CN        ;   -- house that John owns
      mkCN : CN -> Adv -> CN        ;   -- house on the hill
      mkCN :  N -> Adv -> CN        ;   -- house on the hill
      mkCN : CN -> SC  -> CN        ;   -- fact that John smokes, question if he does
      mkCN :  N -> SC  -> CN        ;   -- fact that John smokes, question if he does
      mkCN : CN -> NP  -> CN        ;   -- number x, numbers x and y
      mkCN :  N -> NP  -> CN            -- number x, numbers x and y
      } ;

--2 Adjectival phrases

    mkAP : overload {
      mkAP : A -> AP        ;         -- warm
      mkAP : A -> NP -> AP  ;         -- warmer than Spain
      mkAP : A2 -> NP -> AP ;         -- divisible by 2
      mkAP : A2 -> AP       ;         -- divisible by itself
      mkAP : AP -> SC -> AP ;         -- great that she won; uncertain if she did
      mkAP : AdA -> AP -> AP ;        -- very uncertain
      mkAP : Conj -> AP -> AP -> AP ; -- warm and nice
      mkAP : DConj -> AP -> AP -> AP ;-- both warm and nice
      mkAP : Conj -> ListAP -> AP ;   -- warm, nice, and cheap
      mkAP : DConj -> ListAP -> AP    -- both warm, nice, and cheap

      } ;

--2 Adverbs

    mkAdv : overload {
      mkAdv : A -> Adv               ;    -- quickly
      mkAdv : Prep -> NP -> Adv      ;    -- in the house
      mkAdv : CAdv -> A -> NP -> Adv ;    -- more quickly than John
      mkAdv : CAdv -> A -> S -> Adv  ;    -- more quickly than he runs
      mkAdv : AdA -> Adv -> Adv      ;    -- very quickly
      mkAdv : Subj -> S -> Adv       ;    -- when he arrives
      mkAdv : Conj -> Adv -> Adv -> Adv;  -- here and now
      mkAdv : DConj -> Adv -> Adv -> Adv; -- both here and now
      mkAdv : Conj -> ListAdv -> Adv ;    -- here, now, and with you
      mkAdv : DConj -> ListAdv -> Adv     -- both here, now, and with you
      } ;

--2 Questions and interrogative pronouns

    mkQS : overload {
      mkQS : Tense -> Ant -> Pol -> QCl -> QS ; -- wouldn't John have walked
      mkQS : QCl  -> QS                       ; -- who walks
      mkQS : Cl   -> QS                         -- does John walk
      } ;

    mkQCl : overload {
      mkQCl : Cl -> QCl                ;   -- does John walk
      mkQCl : IP -> VP -> QCl          ;   -- who walks
      mkQCl : IP -> Slash -> QCl       ;   -- who does John love
      mkQCl : IP -> NP -> V2 -> QCl    ;   -- who does John love
      mkQCl : IAdv -> Cl -> QCl        ;   -- why does John walk
      mkQCl : Prep -> IP -> Cl -> QCl  ;   -- with whom does John walk
      mkQCl : IAdv -> NP -> QCl        ;   -- where is John
      mkQCl : IP -> QCl                    -- which houses are there
      } ;

    mkIP : overload {
      mkIP : IDet -> Num -> Ord -> CN -> IP ; -- which five best songs
      mkIP : IDet -> N -> IP              ;   -- which song
      mkIP : IP -> Adv -> IP                  -- who in Europe
      } ;

--2 Relative clauses and relative pronouns

    mkRS : overload {
      mkRS : Tense -> Ant -> Pol -> RCl -> RS ; -- who wouldn't have walked
      mkRS : RCl  -> RS                         -- who walks
      } ;

    mkRCl : overload {
      mkRCl : Cl -> RCl          ;   -- such that John loves her
      mkRCl : RP -> VP -> RCl    ;   -- who loves John
      mkRCl : RP -> Slash -> RCl     -- whom John loves
      } ;

    mkRP : overload {
      mkRP : RP                    ;   -- which
      mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
      } ;

--2 Objectless sentences and sentence complements

    mkSlash : overload {
      mkSlash : NP -> V2 -> Slash    ;    -- (whom) he sees
      mkSlash : NP -> VV -> V2 -> Slash ; -- (whom) he wants to see
      mkSlash : Slash -> Adv -> Slash ;   -- (whom) he sees tomorrow
      mkSlash : Cl -> Prep -> Slash       -- (with whom) he walks
      } ;

    mkSC : overload {
      mkSC : S  -> SC             ;   -- that you go
      mkSC : QS -> SC             ;   -- whether you go
      mkSC : VP -> SC                 -- to go
      } ;


--. 
-- Definitions

    mkAP = overload {
      mkAP : A -> AP           -- warm
                                         =    PositA   ;
      mkAP : A -> NP -> AP     -- warmer than Spain
                                         =    ComparA  ;
      mkAP : A2 -> NP -> AP    -- divisible by 2
                                         =    ComplA2  ;
      mkAP : A2 -> AP          -- divisible by itself
                                         =    ReflA2   ;
      mkAP : AP -> SC -> AP    -- great that she won, uncertain if she did
                                         =    SentAP   ;
      mkAP : AdA -> AP -> AP   -- very uncertain
                                         =    AdAP ;
      mkAP : Conj -> AP -> AP -> AP
                                        = \c,x,y -> ConjAP c (BaseAP x y) ;
      mkAP : DConj -> AP -> AP -> AP
                                        = \c,x,y -> DConjAP c (BaseAP x y) ;
      mkAP : Conj -> ListAP -> AP
                                        = \c,xy -> ConjAP c xy ;
      mkAP : DConj -> ListAP -> AP
                                        = \c,xy -> DConjAP c xy

      } ;

    mkAdv = overload {
      mkAdv : A -> Adv                   -- quickly
                                         =    PositAdvAdj  ;
      mkAdv : Prep -> NP -> Adv          -- in the house
                                         =    PrepNP       ;
      mkAdv : CAdv -> A -> NP -> Adv   -- more quickly than John
                                         =    ComparAdvAdj   ;
      mkAdv : CAdv -> A -> S -> Adv    -- more quickly than he runs
                                         =    ComparAdvAdjS  ;
      mkAdv : AdA -> Adv -> Adv               -- very quickly
                                         =    AdAdv   ;
      mkAdv : Subj -> S -> Adv                 -- when he arrives
                                         =    SubjS ;
      mkAdv : Conj -> Adv -> Adv -> Adv
                                        = \c,x,y -> ConjAdv c (BaseAdv x y) ;
      mkAdv : DConj -> Adv -> Adv -> Adv
                                        = \c,x,y -> DConjAdv c (BaseAdv x y) ;
      mkAdv : Conj -> ListAdv -> Adv
                                        = \c,xy -> ConjAdv c xy ;
      mkAdv : DConj -> ListAdv -> Adv
                                        = \c,xy -> DConjAdv c xy

      } ;

    mkCl = overload {
      mkCl : NP -> VP -> Cl           -- John wants to walk walks
                                         =    PredVP  ;
      mkCl : NP -> V -> Cl           -- John walks
                                         =    \s,v -> PredVP s (UseV v);
      mkCl : NP -> V2 -> NP -> Cl    -- John uses it
                                         =    \s,v,o -> PredVP s (ComplV2 v o);
      mkCl : VP -> Cl          -- it rains
                                         =    ImpersCl   ;
      mkCl : NP  -> RS -> Cl   -- it is you who did it
                                         =    CleftNP    ;
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived
                                         =    CleftAdv   ;
      mkCl : NP -> Cl          -- there is a house
                                         =    ExistNP    ;
      mkCl : NP -> AP -> Cl    -- John is nice and warm
	                                =     \x,y -> PredVP x (UseComp (CompAP y)) ;
      mkCl : NP -> A  -> Cl    -- John is warm
	                                =     \x,y -> PredVP x (UseComp (CompAP (PositA y))) ;
      mkCl : NP -> A -> NP -> Cl -- John is warmer than Mary
	                                =     \x,y,z -> PredVP x (UseComp (CompAP (ComparA y z))) ;
      mkCl : NP -> A2 -> NP -> Cl -- John is married to Mary
	                                =     \x,y,z -> PredVP x (UseComp (CompAP (ComplA2 y z))) ;
      mkCl : NP -> NP -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP y)) ;
      mkCl : NP -> Adv -> Cl   -- John is here
	                                 =    \x,y -> PredVP x (UseComp (CompAdv y))
      } ;

    mkNP = overload {
      mkNP : Det -> CN -> NP      -- the man
                                         =    DetCN    ;
      mkNP : Det -> N -> NP       -- the man
                                         =    \d,n -> DetCN d (UseN n)   ;
      mkNP : PN -> NP             -- John
                                         =    UsePN    ;
      mkNP : Pron -> NP           -- he
                                         =    UsePron  ;
      mkNP : Predet -> NP -> NP  -- only the man
                                         =    PredetNP  ;
      mkNP : NP -> V2  -> NP      -- the number squared
                                         =    PPartNP  ;
      mkNP : NP -> Adv -> NP      -- Paris at midnight
                                         =    AdvNP ;
      mkNP : Conj -> NP -> NP -> NP
                                        = \c,x,y -> ConjNP c (BaseNP x y) ;
      mkNP : DConj -> NP -> NP -> NP
                                        = \c,x,y -> DConjNP c (BaseNP x y) ;
      mkNP : Conj -> ListNP -> NP
                                        = \c,xy -> ConjNP c xy ;
      mkNP : DConj -> ListNP -> NP
                                        = \c,xy -> DConjNP c xy
      } ;

    mkDet = overload {
      mkDet : QuantSg ->        Ord -> Det     -- this best man
                                         =    DetSg     ;
      mkDet : Det   -- the man
                                         = DetSg (SgQuant DefArt) NoOrd ;
      mkDet : QuantSg ->  Det       -- this man
                                         =    \q -> DetSg q NoOrd  ;
      mkDet : QuantPl -> Num -> Ord -> Det     -- these five best men
                                         =    DetPl     ;
      mkDet : QuantPl -> Det     -- these men
                                         =    \q -> DetPl q NoNum NoOrd   ;
      mkDet : Quant ->  Det       -- this man
                                         =    \q -> DetSg (SgQuant q) NoOrd  ;
      mkDet : Num ->  Det       -- forty-five men
                                         =    \n -> DetPl (PlQuant IndefArt) n NoOrd  ;
      mkDet : Digit -> Det  -- five (men)
	                                 =    \d -> DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd ;   

      mkDet : Pron -> Det      -- my (house)
                                         =    \p -> DetSg (SgQuant (PossPron p)) NoOrd
      } ;


    def_Det : Det = DetSg (SgQuant DefArt) NoOrd ;   -- the (man)
    indef_Det : Det = DetSg (SgQuant IndefArt) NoOrd ; -- a (man)
    mass_Det : Det = DetSg MassDet NoOrd;  -- (water)


    mkNum = overload {
      mkNum : Num                -- [no num]
                                         =    NoNum       ;
      mkNum : Int -> Num         -- 51
                                         =    NumInt      ;
      mkNum : Digit -> Num
                                         =    \d -> NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))
      } ;

    mkOrd = overload {
      mkOrd : Ord                -- [no ord]
                                         =    NoOrd       ;
      mkOrd : Int -> Ord         -- 51st
                                         =    OrdInt      ;
      mkOrd : Digit -> Ord       -- fifth
                                         =    \d -> OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ;
      mkOrd : A -> Ord           -- largest
                                         =    OrdSuperl
      } ;

    mkCN = overload {
      mkCN : N  -> CN            -- house
                                         =    UseN     ;
      mkCN : N2 -> NP -> CN      -- son of the king
                                         =    ComplN2  ;
      mkCN : N3 -> NP -> NP -> CN      -- flight from Moscow (to Paris)
                                         =    \f,x -> ComplN2 (ComplN3 f x)  ;
      mkCN : N2 -> CN            -- son
                                         =    UseN2    ;
      mkCN : N3 -> CN            -- flight
                                         =    UseN3    ;
      mkCN : AP -> CN  -> CN     -- nice and big blue house
                                         =    AdjCN    ;
      mkCN : AP ->  N  -> CN     -- nice and big house
                                         =    \x,y -> AdjCN x (UseN y)   ;
      mkCN : CN -> AP  -> CN     -- nice and big blue house
                                         =    \x,y -> AdjCN y x    ;
      mkCN :  N -> AP  -> CN     -- nice and big house
                                         =    \x,y -> AdjCN y (UseN x)    ;
      mkCN :  A -> CN  -> CN     -- big blue house
	                                 =    \x,y -> AdjCN (PositA x) y;
      mkCN :  A ->  N  -> CN     -- big house
	                                 =    \x,y -> AdjCN (PositA x) (UseN y);
      mkCN : CN -> RS  -> CN     -- house that John owns
                                         =    RelCN    ;
      mkCN :  N -> RS  -> CN     -- house that John owns
                                         =    \x,y -> RelCN (UseN x) y   ;
      mkCN : CN -> Adv -> CN     -- house on the hill
                                         =    AdvCN    ;
      mkCN :  N -> Adv -> CN     -- house on the hill
                                         =    \x,y -> AdvCN (UseN x) y  ;
      mkCN : CN -> SC  -> CN     -- fact that John smokes, question if he does
                                         =    SentCN   ;
      mkCN :  N -> SC  -> CN     -- fact that John smokes, question if he does
                                         =    \x,y -> SentCN (UseN x) y  ;
      mkCN : CN -> NP  -> CN     -- number x, numbers x and y
                                         =    ApposCN ;
      mkCN :  N -> NP  -> CN     -- number x, numbers x and y
                                         =    \x,y -> ApposCN (UseN x) y
      } ;


    mkPhr = overload {
      mkPhr : PConj -> Utt -> Voc -> Phr   -- But go home my friend
                                         =    PhrUtt    ;
      mkPhr : Utt -> Phr   -- Go home
                                         =    \u -> PhrUtt NoPConj u NoVoc   ;
      mkPhr : S -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS s) NoVoc 
      } ;

    mkUtt = overload {
      mkUtt : S -> Utt                     -- John walks
                                         =    UttS      ;
      mkUtt : QS -> Utt                    -- is it good
                                         =    UttQS     ;
      mkUtt : Pol -> Imp -> Utt            -- (don't) help yourself
                                         =    UttImpSg  ;
      mkUtt : Imp -> Utt                    -- help yourself
                                         =    UttImpSg PPos  ;
      mkUtt : IP   -> Utt                   -- who
                                         =    UttIP    ;
      mkUtt : IAdv -> Utt                   -- why
                                         =    UttIAdv  ;
      mkUtt : NP   -> Utt                   -- this man
                                         =    UttNP    ;
      mkUtt : Adv  -> Utt                   -- here
                                         =    UttAdv   ;
      mkUtt : VP   -> Utt                   -- to sleep
                                         =    UttVP 
      } ;

    mkQCl = overload {

      mkQCl : Cl -> QCl                    -- does John walk
                                         =    QuestCl      ;
      mkQCl : IP -> VP -> QCl              -- who walks
                                         =    QuestVP      ;
      mkQCl : IP -> Slash -> QCl           -- who does John love
                                         =    QuestSlash   ;
      mkQCl : IP -> NP -> V2 -> QCl           -- who does John love
                                         =    \ip,np,v -> QuestSlash ip (SlashV2 np v)  ;
      mkQCl : IAdv -> Cl -> QCl            -- why does John walk
                                         =    QuestIAdv    ;
      mkQCl : Prep -> IP -> Cl -> QCl      -- with whom does John walk
                                         =    \p,ip -> QuestIAdv (PrepIP p ip)  ;
      mkQCl : IAdv -> NP -> QCl   -- where is John
                                         =    \a -> QuestIComp (CompIAdv a)   ;
      mkQCl : IP -> QCl         -- which houses are there
                                         =    ExistIP
      } ;

    mkIP = overload {
      mkIP : IDet -> Num -> Ord -> CN -> IP   -- which five best songs
                                         =    IDetCN   ;
      mkIP : IDet -> N -> IP      -- which song
                                         =    \i,n -> IDetCN i NoNum NoOrd (UseN n)  ;
      mkIP : IP -> Adv -> IP                  -- who in Europe
                                         =    AdvIP
      } ;

    mkRCl = overload {
      mkRCl : Cl -> RCl              -- such that John loves her
                                         =    RelCl     ;
      mkRCl : RP -> VP -> RCl        -- who loves John
                                         =    RelVP     ;
      mkRCl : RP -> Slash -> RCl     -- whom John loves
                                         =    RelSlash
      } ;

    mkRP = overload {
      mkRP : RP                        -- which
                                         =    IdRP   ;
      mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
                                         =    FunRP
      } ;

    mkSlash = overload {
      mkSlash : NP -> V2 -> Slash        -- (whom) he sees
                                         =    SlashV2    ;
      mkSlash : NP -> VV -> V2 -> Slash  -- (whom) he wants to see
                                         =    SlashVVV2  ;
      mkSlash : Slash -> Adv -> Slash    -- (whom) he sees tomorrow
                                         =    AdvSlash   ;
      mkSlash : Cl -> Prep -> Slash      -- (with whom) he walks
                                         =    SlashPrep
      } ;

    mkImp = overload {
      mkImp : VP -> Imp                -- go
                                         =    ImpVP      ;
      mkImp : V  -> Imp
                                         =    \v -> ImpVP (UseV v)  ;
      mkImp : V2 -> NP -> Imp
                                         =    \v,np -> ImpVP (ComplV2 v np)
      } ;

    mkSC = overload {
      mkSC : S  -> SC                 -- that you go
                                         =    EmbedS     ;
      mkSC : QS -> SC                 -- whether you go
                                         =    EmbedQS    ;
      mkSC : VP -> SC                 -- to go
                                         =    EmbedVP
      } ;

    mkS = overload {
      mkS : Cl  -> S
                                         =    UseCl TPres ASimul PPos ;
      mkS : Tense -> Cl -> S 
	                                 =    \t -> UseCl t ASimul PPos ;
      mkS : Ant -> Cl -> S
                                         =    \a -> UseCl TPres a PPos ;
      mkS : Pol -> Cl -> S
                                         =    \p -> UseCl TPres ASimul p ;
      mkS : Tense -> Ant -> Cl -> S
                                         =    \t,a -> UseCl t a PPos ;
      mkS : Tense -> Pol -> Cl -> S
                                         =    \t,p -> UseCl t ASimul p ;
      mkS : Ant -> Pol -> Cl -> S
                                         =    \a,p -> UseCl TPres a p ;
      mkS : Tense -> Ant -> Pol -> Cl  -> S
                                         =    UseCl   ;
      mkS : Conj -> S -> S -> S
                                        = \c,x,y -> ConjS c (BaseS x y) ;
      mkS : DConj -> S -> S -> S
                                        = \c,x,y -> DConjS c (BaseS x y) ;
      mkS : Conj -> ListS -> S
                                        = \c,xy -> ConjS c xy ;
      mkS : DConj -> ListS -> S
                                        = \c,xy -> DConjS c xy ;
      mkS : Adv -> S -> S 
                                        = AdvS

      } ;

    mkQS = overload {
      mkQS : Tense -> Ant -> Pol -> QCl -> QS
                                         =    UseQCl  ;
      mkQS : QCl  -> QS
                                         =    UseQCl TPres ASimul PPos ;
      mkQS : Cl   -> QS                  
	                                 =    \x -> UseQCl TPres ASimul PPos (QuestCl x)
      } ;

    mkRS = overload {
      mkRS : Tense -> Ant -> Pol -> RCl -> RS
                                         =    UseRCl  ;
      mkRS : RCl  -> RS
                                         =    UseRCl TPres ASimul PPos
      } ;

    mkText = overload {
      mkText : Text                   -- [empty text]
                                         =    TEmpty      ;
      mkText : Phr -> Text            -- John walks.
                                         =    \x -> TFullStop x TEmpty  ;
      mkText : Utt -> Text
	                                 =    \u -> TFullStop (PhrUtt NoPConj u NoVoc) TEmpty ;
      mkText : S -> Text
	                                 =    \s -> TFullStop (PhrUtt NoPConj (UttS s) NoVoc) TEmpty;
      mkText : Cl -> Text
	                                 =    \c -> TFullStop (PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos c)) NoVoc) TEmpty;
      mkText : QS -> Text
	                                 =    \q -> TQuestMark (PhrUtt NoPConj (UttQS q) NoVoc) TEmpty ;
      mkText : Imp -> Text
	                                 =    \i -> TExclMark (PhrUtt NoPConj (UttImpSg PPos i) NoVoc) TEmpty;
      mkText : Pol -> Imp -> Text 
	                                 =    \p,i -> TExclMark (PhrUtt NoPConj (UttImpSg p i) NoVoc) TEmpty;
      mkText : Phr -> Text -> Text    -- John walks. ...
                                         =    TFullStop
      } ;

    mkVP = overload {
      mkVP : V   -> VP                -- sleep
                                         =    UseV      ;
      mkVP : V2  -> NP -> VP          -- use it
                                         =    ComplV2   ;
      mkVP : V3  -> NP -> NP -> VP    -- send a message to her
                                         =    ComplV3   ;
      mkVP : VV  -> VP -> VP          -- want to run
                                         =    ComplVV   ;
      mkVP : VS  -> S  -> VP          -- know that she runs
                                         =    ComplVS   ;
      mkVP : VQ  -> QS -> VP          -- ask if she runs
                                         =    ComplVQ   ;
      mkVP : VA  -> AP -> VP          -- look red
                                         =    ComplVA   ;
      mkVP : V2A -> NP -> AP -> VP    -- paint the house red
                                         =    ComplV2A  ;
      mkVP : AP -> VP               -- be warm
                                         =    \a -> UseComp (CompAP a)   ;
      mkVP : NP -> VP               -- be a man
                                         =    \a -> UseComp (CompNP a)   ;
      mkVP : Adv -> VP               -- be here
                                         =    \a -> UseComp (CompAdv a)   ;
      mkVP : VP -> Adv -> VP          -- sleep here
                                         =    AdvVP     ;
      mkVP : AdV -> VP -> VP          -- always sleep
                                         =    AdVVP
      } ;
}
