
    mkAP = overload {
      mkAP : A -> AP           -- warm
                                         =    PositA   ;
      mkAP : A -> NP -> AP     -- warmer than Spain
                                         =    ComparA  ;
      mkAP : A2 -> NP -> AP    -- divisible by 2
                                         =    ComplA2  ;
      mkAP : A2 -> AP          -- divisible by itself
                                         =    ReflA2   ;
      mkAP : AP -> S -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedS s) ;
      mkAP : AP -> QS -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedQS s) ;
      mkAP : AP -> VP -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedVP s) ;
      mkAP : AdA -> A -> AP   -- very uncertain
                                         =   \x,y -> AdAP x (PositA y) ;
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
                                         =    \s,v -> PredVP s (UseV v) ;
      mkCl : NP -> V2 -> NP -> Cl    -- John uses it
                                         =    \s,v,o -> PredVP s (ComplV2 v o) ;
      mkCl : NP -> V3 -> NP -> NP -> Cl
                                         =    \s,v,o,i -> PredVP s (ComplV3 v o i) ;

      mkCl : NP  -> VV -> VP -> Cl = \s,v,vp -> PredVP s (ComplVV v vp) ;
      mkCl : NP  -> VS -> S  -> Cl = \s,v,p -> PredVP s (ComplVS v p) ;
      mkCl : NP  -> VQ -> QS -> Cl = \s,v,q -> PredVP s (ComplVQ v q) ;
      mkCl : NP  -> VA -> AP -> Cl = \s,v,q -> PredVP s (ComplVA v q) ;
      mkCl : NP  -> V2A ->NP -> AP -> Cl = \s,v,n,q -> PredVP s (ComplV2A v n q) ;



      mkCl : VP -> Cl          -- it rains
                                         =    ImpersCl   ;
      mkCl : NP  -> RS -> Cl   -- it is you who did it
                                         =    CleftNP    ;
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived
                                         =    CleftAdv   ;
      mkCl : N -> Cl          -- there is a house
                                         =    \y -> ExistNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)) ;
      mkCl : CN -> Cl          -- there is a house
                                         =    \y -> ExistNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y) ;
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
      mkCl : NP -> NP -> Cl    -- John is the man
	                                 =    \x,y -> PredVP x (UseComp (CompNP y)) ;
      mkCl : NP -> CN -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y))) ;
      mkCl : NP -> N -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)))) ;
      mkCl : NP -> Adv -> Cl   -- John is here
	                                 =    \x,y -> PredVP x (UseComp (CompAdv y)) ;
      mkCl : V -> Cl   -- it rains
	                                 =    \v -> ImpersCl (UseV v)
      } ;

    genericCl : VP -> Cl = GenericCl ;

    mkNP = overload {
      mkNP : Det -> CN -> NP      -- the old man
                                         =    DetCN    ;
      mkNP : Det -> N -> NP       -- the man
                                         =    \d,n -> DetCN d (UseN n)   ;
      mkNP : Num -> CN -> NP      -- forty-five old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) d NoOrd) n ;
      mkNP : Num -> N -> NP       -- forty-five men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) d NoOrd) (UseN n) ;

      mkNP : QuantSg -> CN -> NP = \q,n -> DetCN (DetSg q NoOrd) n ;
      mkNP : QuantSg -> N  -> NP = \q,n -> DetCN (DetSg q NoOrd) (UseN n) ;
      mkNP : QuantPl -> CN -> NP = \q,n -> DetCN (DetPl q NoNum NoOrd) n ;
      mkNP : QuantPl -> N  -> NP = \q,n -> DetCN (DetPl q NoNum NoOrd) (UseN n) ;

      mkNP : Pron    -> CN -> NP = \p,n -> DetCN (DetSg (SgQuant (PossPron p)) NoOrd) n ;
      mkNP : Pron    -> N  -> NP = \p,n -> DetCN (DetSg (SgQuant (PossPron p)) NoOrd) (UseN n) ;

      mkNP : Numeral -> CN -> NP      -- 51 old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd) n ;
      mkNP : Numeral -> N -> NP       -- 51 men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd) (UseN n) ;
      mkNP : Int -> CN -> NP      -- 51 old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) n ;
      mkNP : Int -> N -> NP       -- 51 men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) (UseN n) ;


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
      mkDet : QuantSg ->  Det       -- this man
                                         =    \q -> DetSg q NoOrd  ;
      mkDet : QuantPl -> Num -> Ord -> Det     -- these five best men
                                         =    DetPl     ;
      mkDet : QuantPl -> Det     -- these men
                                         =    \q -> DetPl q NoNum NoOrd   ;
      mkDet : Quant ->  Det       -- this man
                                         =    \q -> DetSg (SgQuant q) NoOrd  ;
      mkDet : Quant -> Num -> Det       -- these five man
                                         =    \q,nu -> DetPl (PlQuant q) nu NoOrd  ;
      mkDet : Num ->  Det       -- forty-five men
                                         =    \n -> DetPl (PlQuant IndefArt) n NoOrd  ;
      mkDet : Int -> Det          -- 51 (men)
                                         =    \n -> DetPl (PlQuant IndefArt) (NumInt n) NoOrd  ;
      mkDet : Numeral -> Det  --
	                                 =    \d -> DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd ;   

      mkDet : Pron -> Det      -- my (house)
                                         =    \p -> DetSg (SgQuant (PossPron p)) NoOrd
      } ;


      defSgDet   : Det  = DetSg (SgQuant DefArt) NoOrd ;   -- the (man)
      defPlDet   : Det  = DetPl (PlQuant DefArt) NoNum NoOrd ;   -- the (man)
      indefSgDet : Det  = DetSg (SgQuant IndefArt) NoOrd ;   -- the (man)
      indefPlDet : Det  = DetPl (PlQuant IndefArt) NoNum NoOrd ;   -- the (man)


    mkQuantSg : Quant -> QuantSg = SgQuant ;
    mkQuantPl : Quant -> QuantPl = PlQuant ;

    defQuant : Quant = DefArt ;
    indefQuant : Quant = IndefArt ;   

    massQuant : QuantSg = MassDet  ;



    mkNum = overload {
      mkNum : Numeral -> Num = NumNumeral ;
      mkNum : Int -> Num         -- 51
                                         =    NumInt      ;
      mkNum : Digit -> Num
                                         =    \d -> NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ;

      mkNum : AdN -> Num -> Num = AdNum
      } ;

      noNum : Num                -- [no num]
                                         =    NoNum       ;

    n1_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 pot01))) ;
    n2_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n2)))) ;
    n3_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n3)))) ;
    n4_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n4)))) ;
    n5_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n5)))) ;
    n6_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n6)))) ;
    n7_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n7)))) ;
    n8_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n8)))) ;
    n9_Numeral : Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n9)))) ;
    n10_Numeral : Numeral = num (pot2as3 (pot1as2 pot110)) ;
    n20_Numeral : Numeral = num (pot2as3 (pot1as2 (pot1 n2))) ;
    n100_Numeral : Numeral = num (pot2as3 (pot2 pot01)) ;
    n1000_Numeral : Numeral = num (pot3 (pot1as2 (pot0as1 pot01))) ;


    mkAdN : CAdv -> AdN = AdnCAdv ;                  -- more (than five)

    mkOrd = overload {
      mkOrd : Numeral -> Ord = OrdNumeral ;
      mkOrd : Int -> Ord         -- 51st
                                         =    OrdInt      ;
      mkOrd : Digit -> Ord       -- fifth
                                         =    \d -> OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ;
      mkOrd : A -> Ord           -- largest
                                         =    OrdSuperl
      } ;

      noOrd : Ord                -- [no ord]
                                         =    NoOrd       ;


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
	                                 =    \x,y -> AdjCN (PositA x) y ;
      mkCN :  A ->  N  -> CN     -- big house
	                                 =    \x,y -> AdjCN (PositA x) (UseN y) ;
      mkCN : CN -> RS  -> CN     -- house that John owns
                                         =    RelCN    ;
      mkCN :  N -> RS  -> CN     -- house that John owns
                                         =    \x,y -> RelCN (UseN x) y   ;
      mkCN : CN -> Adv -> CN     -- house on the hill
                                         =    AdvCN    ;
      mkCN :  N -> Adv -> CN     -- house on the hill
                                         =    \x,y -> AdvCN (UseN x) y  ;
      mkCN : CN -> S   -> CN     -- fact that John smokes
                                         =    \cn,s -> SentCN cn (EmbedS s) ;
      mkCN : CN -> QS  -> CN     -- question if John smokes
                                         =    \cn,s -> SentCN cn (EmbedQS s) ;
      mkCN : CN -> VP  -> CN     -- reason to smoke
                                         =    \cn,s -> SentCN cn (EmbedVP s) ;
      mkCN : CN -> NP  -> CN     -- number x, numbers x and y
                                         =    ApposCN ;
      mkCN :  N -> NP  -> CN     -- number x, numbers x and y
                                         =    \x,y -> ApposCN (UseN x) y
      } ;


    mkPhr = overload {
      mkPhr : PConj -> Utt -> Voc -> Phr   -- But go home my friend
                                         =    PhrUtt    ;
      mkPhr : Utt -> Voc -> Phr
                                         =    \u,v -> PhrUtt NoPConj u v ;
      mkPhr : PConj -> Utt -> Phr
                                         =    \u,v -> PhrUtt u v NoVoc ;
      mkPhr : Utt -> Phr   -- Go home
                                         =    \u -> PhrUtt NoPConj u NoVoc   ;
      mkPhr : S -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS s) NoVoc ; 
      mkPhr : Cl -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos s)) NoVoc ; 
      mkPhr : QS -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttQS s) NoVoc ;
      mkPhr : Imp -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttImpSg PPos s) NoVoc 

      } ;

    mkPConj : Conj -> PConj = PConjConj ;
    noPConj : PConj = NoPConj ;

    mkVoc   : NP -> Voc  = VocNP ;
    noVoc   : Voc  = NoVoc ;

    positivePol : Pol = PPos ; 
    negativePol : Pol = PNeg ;

    simultaneousAnt : Ant = ASimul ; 
    anteriorAnt : Ant = AAnter ; --# notpresent

    presentTense     : Tense = TPres ;
    pastTense        : Tense = TPast ; --# notpresent
    futureTense      : Tense = TFut ;  --# notpresent
    conditionalTense : Tense = TCond ; --# notpresent

--    singularImpForm  : ImpForm = ss [] ;
--    pluralImpForm  : ImpForm = ss [] ;
--    politeImpForm : ImpForm = ss [] ;

--    mkUttImp : ImpForm -> Pol -> Imp -> Utt = \f,p,i -> case f of {
      IFSg  => UttImpSg p i ;
      IFPl  => UttImpPl p i ;
      IFPol => UttImpPol p i
      } ;

    mkUtt = overload {
      mkUtt : S -> Utt                     -- John walked
                                         =    UttS      ;
      mkUtt : Cl -> Utt                     -- John walks
	                                 =    \c -> UttS (UseCl TPres ASimul PPos c) ;
      mkUtt : QS -> Utt                    -- is it good
                                         =    UttQS     ;
--      mkUtt : ImpForm -> Pol -> Imp -> Utt -- don't help yourselves
--                                         =    mkUttImp  ;
--      mkUtt : ImpForm ->        Imp -> Utt -- help yourselves
--                                        =  \f -> mkUttImp f PPos ;
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

    lets_Utt : VP -> Utt = ImpPl1 ;

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
      mkIP : IDet -> Ord -> CN -> IP   -- which five best songs
                                         = \i ->   IDetCN i NoNum  ;
      mkIP : IDet -> Num -> CN -> IP   -- which five best songs
                                         = \i,n ->   IDetCN i n NoOrd  ;
      mkIP : IDet -> N -> IP      -- which song
                                         =    \i,n -> IDetCN i NoNum NoOrd (UseN n)  ;
      mkIP : IP -> Adv -> IP                  -- who in Europe
                                         =    AdvIP
      } ;

    mkIAdv : Prep -> IP -> IAdv = PrepIP ;

    mkRCl = overload {
      mkRCl : Cl -> RCl              -- such that John loves her
                                         =    RelCl     ;
      mkRCl : RP -> VP -> RCl        -- who loves John
                                         =    RelVP     ;
      mkRCl : RP -> Slash -> RCl     -- whom John loves
                                         =    RelSlash ;
      mkRCl : RP -> NP -> V2 -> RCl     -- whom John loves
                                         =  \rp,np,v2 -> RelSlash rp (SlashV2 np v2)
      } ;

    which_RP : RP                        -- which
                                         =    IdRP   ;
    mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
                                         =    FunRP
      ;

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

      mkQS : QCl  -> QS
                                         =    UseQCl TPres ASimul PPos ;
      mkQS : Tense -> QCl -> QS 
	                                 =    \t -> UseQCl t ASimul PPos ;
      mkQS : Ant -> QCl -> QS
                                         =    \a -> UseQCl TPres a PPos ;
      mkQS : Pol -> QCl -> QS
                                         =    \p -> UseQCl TPres ASimul p ;
      mkQS : Tense -> Ant -> QCl -> QS
                                         =    \t,a -> UseQCl t a PPos ;
      mkQS : Tense -> Pol -> QCl -> QS
                                         =    \t,p -> UseQCl t ASimul p ;
      mkQS : Ant -> Pol -> QCl -> QS
                                         =    \a,p -> UseQCl TPres a p ;
      mkQS : Tense -> Ant -> Pol -> QCl -> QS
                                         =    UseQCl  ;
      mkQS : Cl   -> QS                  
	                                 =    \x -> UseQCl TPres ASimul PPos (QuestCl x)
      } ;


    mkRS = overload {

      mkRS : RCl  -> RS
                                         =    UseRCl TPres ASimul PPos ;
      mkRS : Tense -> RCl -> RS 
	                                 =    \t,c -> UseRCl t ASimul PPos c ;
      mkRS : Ant -> RCl -> RS
                                         =    \a,c -> UseRCl TPres a PPos c ;
      mkRS : Pol -> RCl -> RS
                                         =    \p,c -> UseRCl TPres ASimul p c ;
      mkRS : Tense -> Ant -> RCl -> RS
                                         =    \t,a,c -> UseRCl t a PPos c ;
      mkRS : Tense -> Pol -> RCl -> RS
                                         =    \t,p,c -> UseRCl t ASimul p c ;
      mkRS : Ant -> Pol -> RCl -> RS
                                         =    \a,p,c -> UseRCl TPres a p c ;
      mkRS : Tense -> Ant -> Pol -> RCl -> RS
                                         =    UseRCl  
      } ;



  oper
    emptyText : Text = TEmpty ;       -- [empty text]

--    fullStopPunct  : Punct = {p = PFullStop ; s = []} ; -- .
--    questMarkPunct : Punct = {p = PQuestMark ; s = []} ; -- .
--    exclMarkPunct  : Punct = {p = PExclMark ; s = []} ; -- .

-- lincat Impform = {p : PImpForm ; s : Str} ;
-- lincat Punct = {p : PPunct ; s : Str} ;
-- param PImpForm = IFSg | IFPl | IFPol ;
-- param PPunct = PFullStop | PExclMark | PQuestMark ;

    mkText = overload {
--      mkText : Phr -> Punct -> Text -> Text =
--        \phr,punct,text -> case punct of {
--          PFullStop => TFullStop phr text ; 
--          PExclMark => TExclMark phr text ;
--          PQuestMark => TQuestMark phr text
--          } ;
--      mkText : Phr -> Punct -> Text =
--        \phr,punct -> case punct of {
--          PFullStop => TFullStop phr TEmpty ; 
--          PExclMark => TExclMark phr TEmpty ;
--          PQuestMark => TQuestMark phr TEmpty
--          } ;
      mkText : Phr -> Text            -- John walks.
                                         =    \x -> TFullStop x TEmpty  ;
      mkText : Utt -> Text
	                                 =    \u -> TFullStop (PhrUtt NoPConj u NoVoc) TEmpty ;
      mkText : S -> Text
	                                 =    \s -> TFullStop (PhrUtt NoPConj (UttS s) NoVoc) TEmpty ;
      mkText : Cl -> Text
	                                 =    \c -> TFullStop (PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos c)) NoVoc) TEmpty ;
      mkText : QS -> Text
	                                 =    \q -> TQuestMark (PhrUtt NoPConj (UttQS q) NoVoc) TEmpty ;
      mkText : Imp -> Text
	                                 =    \i -> TExclMark (PhrUtt NoPConj (UttImpSg PPos i) NoVoc) TEmpty ;
      mkText : Pol -> Imp -> Text 
	                                 =    \p,i -> TExclMark (PhrUtt NoPConj (UttImpSg p i) NoVoc) TEmpty ;
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
---      mkVP : VS  -> NP -> VP = \v -> ComplV2 (UseVS v) ;
---      mkVP : VQ  -> NP -> VP = \v -> ComplV2 (UseVQ v) ;
      mkVP : VA  -> AP -> VP          -- look red
                                         =    ComplVA   ;
      mkVP : V2A -> NP -> AP -> VP    -- paint the house red
                                         =    ComplV2A  ;
      mkVP : A -> VP               -- be warm
                                         =    \a -> UseComp (CompAP (PositA a)) ;
      mkVP : A -> NP -> VP -- John is warmer than Mary
	                                =     \y,z -> (UseComp (CompAP (ComparA y z))) ;
      mkVP : A2 -> NP -> VP -- John is married to Mary
	                                =     \y,z -> (UseComp (CompAP (ComplA2 y z))) ;
      mkVP : AP -> VP               -- be warm
                                         =    \a -> UseComp (CompAP a)   ;
      mkVP : NP -> VP               -- be a man
                                         =    \a -> UseComp (CompNP a)   ;
      mkVP : CN -> VP               -- be a man
                             = \y -> (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y))) ;
      mkVP : N -> VP               -- be a man
                             = \y -> (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)))) ;
      mkVP : Adv -> VP               -- be here
                                         =    \a -> UseComp (CompAdv a)   ;
      mkVP : VP -> Adv -> VP          -- sleep here
                                         =    AdvVP     ;
      mkVP : AdV -> VP -> VP          -- always sleep
                                         =    AdVVP
      } ;

  reflexiveVP   : V2 -> VP = ReflV2 ;
  passiveVP = overload {
      passiveVP : V2 ->       VP = PassV2 ;
      passiveVP : V2 -> NP -> VP = \v,np -> (AdvVP (PassV2 v) (PrepNP by8agent_Prep np))
      } ;
  progressiveVP : VP -> VP = ProgrVP ;


  mkListS = overload {
   mkListS : S -> S -> ListS = BaseS ;
   mkListS : S -> ListS -> ListS = ConsS
   } ;

  mkListAP = overload {
   mkListAP : AP -> AP -> ListAP = BaseAP ;
   mkListAP : AP -> ListAP -> ListAP = ConsAP
   } ;

  mkListAdv = overload {
   mkListAdv : Adv -> Adv -> ListAdv = BaseAdv ;
   mkListAdv : Adv -> ListAdv -> ListAdv = ConsAdv
   } ;

  mkListNP = overload {
   mkListNP : NP -> NP -> ListNP = BaseNP ;
   mkListNP : NP -> ListNP -> ListNP = ConsNP
   } ;

