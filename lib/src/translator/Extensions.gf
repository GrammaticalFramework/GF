abstract Extensions = 
  Cat,
  Extra [VPI]
  ** {

---- from ExtraEngAbs
cat

---- hard to merge VPI and VPS
  VPI ;
  [VPI] {2} ;

  VPS ;
  [VPS] {2} ;

fun
  MkVPI : VP -> VPI ;
  ConjVPI : Conj -> [VPI] -> VPI ;
  ComplVPIVV : VV -> VPI -> VP ;

  MkVPS : Temp -> Pol -> VP -> VPS ;
  ConjVPS : Conj -> [VPS] -> VPS ;
  PredVPS : NP -> VPS -> S ;

-- generalizing Grammar

  PassVPSlash        : VPSlash -> VP ;                        -- be forced to sleep
  PassAgentVPSlash   : VPSlash -> NP -> VP ;                  -- be begged by her to go

  ComplVV : VV -> Ant -> Pol -> VP -> VP ;                    -- want not to have slept

---- merge?
  SlashV2V      : V2V -> Ant -> Pol -> VP -> VPSlash ;   -- force (her) not to have slept
  SlashVPIV2V   : V2V -> Pol -> VPI -> VPSlash ;         -- force (her) not to sleep and dream


-- new structures

  GenNP       : NP -> Quant ;       -- this man's
  GenIP       : IP -> IQuant ;      -- whose
  GenRP       : Num -> CN -> RP ;   -- whose car(s)
 
---- should be covered by variants
----    ComplBareVS   : VS -> S -> VP ;         -- know you go
----    SlashBareV2S  : V2S -> S  -> VPSlash ;  -- answer (to him) it is good
----    ComplSlashPartLast : VPSlash -> NP -> VP ;

---- merge VPS and VPI
----            MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
----            VPIForm, VPIInf, VPIPresPart, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,


---- merge these two?
    CompoundCN : Num -> N -> CN -> CN ;
    DashCN : N -> N -> N ;

---- merge ?
----  NominalizeVPSlashNP : VPSlash -> NP -> NP ; -- publishing of the document
----  EmbedPresPart : VP -> SC ;                  -- looking at Mary (is fun)
    GerundN : V -> N ;                            -- sleeping

---- merge ?
----  PartVP : VP -> AP ;                         -- (man) looking at Mary
    GerundAP : V -> AP ;                          -- sleeping (man)

    PastPartAP : V2 -> AP ;                       -- lost (opportunity)

---- why is this needed?
    OrdCompar : A -> Ord ;                                     -- (my) better (side)

    UseQuantPN : Quant -> PN -> NP;                            -- this John

    SlashSlashV2V : V2V -> Ant -> Pol -> VPSlash -> VPSlash ;  ---- what is this?

---- eliminate as topicalizations
    PredVPosv,PredVPovs : NP -> VP -> Cl ;         
    
---- merge with IdRP?
    that_RP : RP ;
    who_RP : RP ;
    EmptyRelSlash : ClSlash -> RCl ;            -- (the city) he lives in

---- overgenerating?
    VPSlashVS  : VS -> VP -> VPSlash ;          -- to believe her to sleep

    PastPartRS : Ant -> Pol -> VPSlash -> RS ;  -- (man) not seen by her 
    PresPartRS : Ant -> Pol -> VP -> RS ;       -- (man) not having seen her

    ApposNP : NP -> NP -> NP ;                  -- Mr Hollande, the president of France,
	
---- move to standard RGL?
    AdAdV       : AdA -> AdV -> AdV ;           -- almost always
    UttAdV      : AdV -> Utt;                   -- always!
    PositAdVAdj : A -> AdV ;                    -- (that she) positively (sleeps)

    CompS       : S -> Comp ;                   -- (the fact is) that she sleeps
    CompQS      : QS -> Comp ;                  -- (the question is) who sleeps
    CompVP      : Ant -> Pol -> VP -> Comp ;    -- (she is) to go

}
