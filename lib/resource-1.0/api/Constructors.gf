incomplete resource Constructors = open Grammar in {

  oper

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
                                         =    AdAP
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
                                         =    SubjS
      } ;

    mkCl = overload {
      mkCl : NP -> VP -> Cl           -- John walks
                                         =    PredVP  ;
      mkCl : VP -> Cl          -- it rains
                                         =    ImpersCl   ;
      mkCl : NP  -> RS -> Cl   -- it is you who did it
                                         =    CleftNP    ;
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived
                                         =    CleftAdv   ;
      mkCl : NP -> Cl          -- there is a house
                                         =    ExistNP
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
                                         =    AdvNP
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
      mkDet : Num ->  Det       -- five men
                                         =    \n -> DetPl (PlQuant IndefArt) n NoOrd  ;
      mkDet : Pron -> Det      -- my (house)
                                         =    \p -> DetSg (SgQuant (PossPron p)) NoOrd
      } ;

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
      mkCN : AP -> CN  -> CN     -- big house
                                         =    AdjCN    ;
      mkCN : CN -> AP  -> CN     -- big house
                                         =    \x,y -> AdjCN y x    ;
      mkCN : CN -> RS  -> CN     -- house that John owns
                                         =    RelCN    ;
      mkCN : CN -> Adv -> CN     -- house on the hill
                                         =    AdvCN    ;
      mkCN : CN -> SC  -> CN     -- fact that John smokes, question if he does
                                         =    SentCN   ;
      mkCN : CN -> NP  -> CN     -- number x, numbers x and y
                                         =    ApposCN
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
      mkS : Tense -> Ant -> Pol -> Cl  -> S
                                         =    UseCl   ;
      mkS : Cl  -> S
                                         =    UseCl TPres ASimul PPos
      } ;

    mkQS = overload {
      mkQS : Tense -> Ant -> Pol -> QCl -> QS
                                         =    UseQCl  ;
      mkQS : QCl  -> QS
                                         =    UseQCl TPres ASimul PPos
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
