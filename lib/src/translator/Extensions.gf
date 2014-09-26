abstract Extensions = 
  Cat
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

---- merge VPS and VPI
----            MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
----            VPIForm, VPIInf, VPIPresPart, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,


-- generalizing Grammar

  PassVPSlash        : VPSlash -> VP ;                        -- be forced to sleep
  PassAgentVPSlash   : VPSlash -> NP -> VP ;                  -- be begged by her to go

  ComplVV : VV -> Ant -> Pol -> VP -> VP ;                    -- want not to have slept

  PredFrontVS : Temp -> NP -> VS -> S  -> S ;                 -- I am here, she said     -- no negation
  PredFrontVQ : Temp -> NP -> VQ -> QS -> S ;                 -- are you here, she asked -- no negation; direct order

---- merge?
  SlashV2V      : V2V -> Ant -> Pol -> VP -> VPSlash ;   -- force (her) not to have slept
  SlashVPIV2V   : V2V -> Pol -> VPI -> VPSlash ;         -- force (her) not to sleep and dream


-- new structures

  GenNP       : NP -> Quant ;       -- this man's
  GenIP       : IP -> IQuant ;      -- whose
  GenRP       : Num -> CN -> RP ;   -- whose car(s)
 
  CompoundN   : N -> N  -> N ;      -- control system / controls system / control-system
  CompoundAP  : N -> A  -> AP ;     -- language independent / language-independent

  GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
  GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
  GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)

  WithoutVP   : VP -> Adv ;         -- without publishing the document  
  ByVP        : VP -> Adv ;         -- by publishing the document  
  InOrderToVP : VP -> Adv ;         -- (in order) to publish the document

  PresPartAP  : VP -> AP ;          -- sleeping (man), (man) sleeping in the car

  PastPartAP      : VPSlash -> AP ;         -- lost (opportunity) ; (opportunity) lost in space
  PastPartAgentAP : VPSlash -> NP -> AP ;   -- (opportunity) lost by the company

  UseQuantPN : Quant -> PN -> NP;  -- this John
    
---- merge with IdRP?
    that_RP : RP ;
    who_RP : RP ;
    EmptyRelSlash : ClSlash -> RCl ;            -- (the city) he lives in

---- overgenerating?
    VPSlashVS  : VS -> VP -> VPSlash ;          -- to believe (her) to sleep --- she was believed to sleep

    PastPartRS : Ant -> Pol -> VPSlash -> RS ;  -- (man) not seen by her --- maybe no Anter
    PresPartRS : Ant -> Pol -> VP -> RS ;       -- (man) not having seen her

    ApposNP : NP -> NP -> NP ;                  -- Mr Hollande, the president of France,
	
---- move to standard RGL?
    AdAdV       : AdA -> AdV -> AdV ;           -- almost always
    UttAdV      : AdV -> Utt;                   -- always!
    PositAdVAdj : A -> AdV ;                    -- (that she) positively (sleeps)

    CompS       : S -> Comp ;                   -- (the fact is) that she sleeps
    CompQS      : QS -> Comp ;                  -- (the question is) who sleeps
    CompVP      : Ant -> Pol -> VP -> Comp ;    -- (she is) to go
  
    SlashSlashV2V : V2V -> Ant -> Pol -> VPSlash -> VPSlash ;  -- induce them to sell (it) -- analogous to Verb.SlashVV

    DirectComplVS : Temp -> NP -> VS -> Utt  -> S ;    -- I am here, she said / she said: I am here  -- no negation possible
    DirectComplVQ : Temp -> NP -> VQ -> QS -> S   ;    -- who is there, she asked / she asked: who is there  -- no negation possible

    FocusObjS : NP -> SSlash -> S ;                    -- this woman I love  -- in declarative S, not in QS


}

{-
-- changes from ParseEngAbs

ComplBareVS        --> ComplVS     -- as variant
SlashBareV2S       --> SlashV2S    -- as variant
ComplSlashPartLast --> ComplSlash  -- as variant

CompoundCN Sg/Pl   --> CompoundCN  -- as variants
DashCN             --> CompoundCN  -- as variant

GerundN            --> GerundCN    -- special case: now CN
                   --> GerundNP    -- an NP version without determiner
                   --> GerundAdv   -- an Adv version without determiner or preposition

GerundAP           --> PresPartAP  -- special case: now with a VP argument

PastPartAP         --> PastPartAP  -- now with VPSlash argument
                   --> PastPartAgentAP -- VPSlash + by NP

OrdCompar          --> UseComparA  -- the only use in PTB reduces to this standard RGL function

PredVPosv          --> PredFrontVS, PredFrontVQ  -- restricted to the special case actually occurring in PTB
PredVPovs          -->                           -- inversion treated as variant: I am here, said she


-}
