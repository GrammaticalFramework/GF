--# -path=..:../../translator

abstract New =

--abstract NDTrans =

----  Tense,
  NDPred - [Pol,Tense],
  NDLift [LiftV,LiftV2,LiftVS,LiftVQ,LiftVA,LiftVN,LiftVV,
                LiftV3,LiftV2S,LiftV2Q,LiftV2A,LiftV2N,LiftV2V,
                LiftAP,LiftA2,LiftCN,LiftN2,LiftAdv,LiftAdV,LiftPrep,

                AppAPCN
         ],
  Noun,
  Adjective,
---  Numeral,
  Conjunction,
----  Verb,
  Adverb,
  Phrase,
----  Sentence,
  Question - [QuestCl,QuestVP,QuestSlash,QuestIAdv,QuestIComp],
  Relative - [RelCl,RelVP,RelSlash],
  Idiom [NP, VP, Cl, Tense, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP], 

  Symbol [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP]         ---- why only these?

----  Construction,
----  Extensions,
----  Documentation ;
  ,Extensions [CN,NP,AdA,AdV,CompoundCN,AdAdV,UttAdV,ApposNP]

;

{-
New> pg -cats
A A2 AP AdA AdN AdV Adv Ant CAdv CN Card Cl ClC_none ClC_np ClSlash Comp Conj Det Digits Float IAdv IComp IDet IP IQuant Imp Int Interj ListAP ListAdV ListAdv ListCN ListIAdv ListNP ListRS ListS N N2 N3 NP Num Numeral Ord PConj PN Phr Pol PrAP_none PrAP_np PrAdv_none PrAdv_np PrCN_none PrCN_np PrCl_none PrCl_np PrQCl_none PrQCl_np PrS PrVPI_none PrVPI_np PrVP_a PrVP_n PrVP_none PrVP_np PrVP_np_a PrVP_np_n PrVP_np_np PrVP_np_q PrVP_np_s PrVP_np_v PrVP_q PrVP_s PrVP_v PrV_a PrV_n PrV_none PrV_np PrV_np_a PrV_np_n PrV_np_np PrV_np_q PrV_np_s PrV_np_v PrV_q PrV_s PrV_v Predet Prep Pron QCl QS Quant RCl RP RS S SC SSlash String Subj Symb Temp Tense Text Utt V V2 V2A V2Q V2S V2V V3 VA VP VPC_none VPC_np VPSlash VQ VS VV Voc
0 msec
New> pg -funs
AAnter : Ant ;
ASimul : Ant ;
AdAP : AdA -> AP -> AP ;
AdAdV : AdA -> AdV -> AdV ;
AdAdv : AdA -> Adv -> Adv ;
AdNum : AdN -> Card -> Card ;
AdjCN : AP -> CN -> CN ;
AdjOrd : Ord -> AP ;
AdnCAdv : CAdv -> AdN ;
AdvAP : AP -> Adv -> AP ;
AdvCN : CN -> Adv -> CN ;
AdvCl_none : PrAdv_none -> PrCl_none -> PrCl_none ;
AdvCl_np : PrAdv_np -> PrCl_none -> PrCl_np ;
AdvNP : NP -> Adv -> NP ;
AdvQCl_none : PrAdv_none -> PrQCl_none -> PrQCl_none ;
AdvQCl_np : PrAdv_np -> PrQCl_none -> PrQCl_np ;
AgentPassUseV_a : Ant -> Tense -> Pol -> PrV_np_a -> NP -> PrVP_a ;
AgentPassUseV_n : Ant -> Tense -> Pol -> PrV_np_n -> NP -> PrVP_n ;
AgentPassUseV_none : Ant -> Tense -> Pol -> PrV_np -> NP -> PrVP_none ;
AgentPassUseV_np : Ant -> Tense -> Pol -> PrV_np_np -> NP -> PrVP_np ;
AgentPassUseV_q : Ant -> Tense -> Pol -> PrV_np_q -> NP -> PrVP_q ;
AgentPassUseV_s : Ant -> Tense -> Pol -> PrV_np_s -> NP -> PrVP_s ;
AgentPassUseV_v : Ant -> Tense -> Pol -> PrV_np_v -> NP -> PrVP_v ;
AgentPastPartAP_none : PrV_np -> NP -> PrAP_none ;
ApposCN : CN -> NP -> CN ;
ApposNP : NP -> NP -> NP ;
BaseAP : AP -> AP -> ListAP ;
BaseAdV : AdV -> AdV -> ListAdV ;
BaseAdv : Adv -> Adv -> ListAdv ;
BaseCN : CN -> CN -> ListCN ;
BaseIAdv : IAdv -> IAdv -> ListIAdv ;
BaseNP : NP -> NP -> ListNP ;
BaseRS : RS -> RS -> ListRS ;
BaseS : S -> S -> ListS ;
CAdvAP : CAdv -> AP -> NP -> AP ;
CNNumNP : CN -> Card -> NP ;
ComparA : A -> NP -> AP ;
ComparAdvAdj : CAdv -> A -> NP -> Adv ;
ComparAdvAdjS : CAdv -> A -> S -> Adv ;
ComplA2 : A2 -> NP -> AP ;
ComplAdv_none : PrAdv_np -> NP -> PrAdv_none ;
ComplN2 : N2 -> NP -> CN ;
ComplN3 : N3 -> NP -> N2 ;
ComplV2_none : PrVP_np -> NP -> PrVP_none ;
ComplVA_none : PrVP_a -> PrAP_none -> PrVP_none ;
ComplVN_none : PrVP_n -> PrCN_none -> PrVP_none ;
ComplVQ_none : PrVP_q -> PrQCl_none -> PrVP_none ;
ComplVS_none : PrVP_s -> PrCl_none -> PrVP_none ;
ComplVS_np : PrVP_s -> PrCl_np -> PrVP_np ;
ComplVV_none : PrVP_v -> PrVPI_none -> PrVP_none ;
ComplVV_np : PrVP_v -> PrVPI_np -> PrVP_np ;
CompoundCN : N -> CN -> CN ;
ConjAP : Conj -> ListAP -> AP ;
ConjAdV : Conj -> ListAdV -> AdV ;
ConjAdv : Conj -> ListAdv -> Adv ;
ConjCN : Conj -> ListCN -> CN ;
ConjIAdv : Conj -> ListIAdv -> IAdv ;
ConjNP : Conj -> ListNP -> NP ;
ConjRS : Conj -> ListRS -> RS ;
ConjS : Conj -> ListS -> S ;
ConsAP : AP -> ListAP -> ListAP ;
ConsAdV : AdV -> ListAdV -> ListAdV ;
ConsAdv : Adv -> ListAdv -> ListAdv ;
ConsCN : CN -> ListCN -> ListCN ;
ConsIAdv : IAdv -> ListIAdv -> ListIAdv ;
ConsNP : NP -> ListNP -> ListNP ;
ConsRS : RS -> ListRS -> ListRS ;
ConsS : S -> ListS -> ListS ;
ContClC_none : PrCl_none -> ClC_none -> ClC_none ;
ContClC_np : PrCl_np -> ClC_np -> ClC_np ;
ContVPC_none : PrVP_none -> VPC_none -> VPC_none ;
ContVPC_np : PrVP_np -> VPC_np -> VPC_np ;
CountNP : Det -> NP -> NP ;
DefArt : Quant ;
DetCN : Det -> CN -> NP ;
DetNP : Det -> NP ;
DetQuant : Quant -> Num -> Det ;
DetQuantOrd : Quant -> Num -> Ord -> Det ;
ExtAdvNP : NP -> Adv -> NP ;
FunRP : Prep -> NP -> RP -> RP ;
IdRP : RP ;
IndefArt : Quant ;
InfVP_none : PrVP_none -> PrVPI_none ;
InfVP_np : PrVP_np -> PrVPI_np ;
MassNP : CN -> NP ;
MkSymb : String -> Symb ;
NoPConj : PConj ;
NoVoc : Voc ;
NumCard : Card -> Num ;
NumDigits : Digits -> Card ;
NumNumeral : Numeral -> Card ;
NumPl : Num ;
NumSg : Num ;
OrdDigits : Digits -> Ord ;
OrdNumeral : Numeral -> Ord ;
OrdSuperl : A -> Ord ;
PConjConj : Conj -> PConj ;
PNeg : Pol ;
PPartNP : NP -> V2 -> NP ;
PPos : Pol ;
PartNP : CN -> NP -> CN ;
PassUseV_a : Ant -> Tense -> Pol -> PrV_np_a -> PrVP_a ;
PassUseV_n : Ant -> Tense -> Pol -> PrV_np_n -> PrVP_n ;
PassUseV_none : Ant -> Tense -> Pol -> PrV_np -> PrVP_none ;
PassUseV_np : Ant -> Tense -> Pol -> PrV_np_np -> PrVP_np ;
PassUseV_q : Ant -> Tense -> Pol -> PrV_np_q -> PrVP_q ;
PassUseV_s : Ant -> Tense -> Pol -> PrV_np_s -> PrVP_s ;
PassUseV_v : Ant -> Tense -> Pol -> PrV_np_v -> PrVP_v ;
PastPartAP_none : PrV_np -> PrAP_none ;
PhrUtt : PConj -> Utt -> Voc -> Phr ;
PositA : A -> AP ;
PositAdAAdj : A -> AdA ;
PositAdvAdj : A -> Adv ;
PossNP : CN -> NP -> CN ;
PossPron : Pron -> Quant ;
PredVP_none : NP -> PrVP_none -> PrCl_none ;
PredVP_np : NP -> PrVP_np -> PrCl_np ;
PredetNP : Predet -> NP -> NP ;
PrepNP : Prep -> NP -> Adv ;
PresPartAP_none : PrV_none -> PrAP_none ;
PresPartAP_np : PrV_np -> PrAP_np ;
QuestCl_none : PrCl_none -> PrQCl_none ;
QuestCl_np : PrCl_np -> PrQCl_np ;
QuestIAdv_none : IAdv -> PrCl_none -> PrQCl_none ;
QuestSlash_none : IP -> PrQCl_np -> PrQCl_none ;
QuestVP_none : IP -> PrVP_none -> PrQCl_none ;
ReflA2 : A2 -> AP ;
ReflVP2_np : PrVP_np_np -> PrVP_np ;
ReflVP_a : PrVP_np_a -> PrVP_a ;
ReflVP_n : PrVP_np_n -> PrVP_n ;
ReflVP_none : PrVP_np -> PrVP_none ;
ReflVP_np : PrVP_np_np -> PrVP_np ;
ReflVP_q : PrVP_np_q -> PrVP_q ;
ReflVP_s : PrVP_np_s -> PrVP_s ;
ReflVP_v : PrVP_np_v -> PrVP_v ;
RelCN : CN -> RS -> CN ;
RelCl : Cl -> RCl ;
RelNP : NP -> RS -> NP ;
RelSlash : RP -> ClSlash -> RCl ;
RelVP : RP -> VP -> RCl ;
SentAP : AP -> SC -> AP ;
SentCN : CN -> SC -> CN ;
SlashClNP_none : PrCl_np -> NP -> PrCl_none ;
SlashV2A_none : PrVP_np_a -> PrAP_none -> PrVP_np ;
SlashV2N_none : PrVP_np_n -> PrCN_none -> PrVP_np ;
SlashV2Q_none : PrVP_np_q -> PrQCl_none -> PrVP_np ;
SlashV2S_none : PrVP_np_s -> PrCl_none -> PrVP_np ;
SlashV2V_none : PrVP_np_v -> PrVPI_none -> PrVP_np ;
SlashV2V_np : PrVP_np_v -> PrVPI_np -> PrVP_np_np ;
SlashV3_none : PrVP_np_np -> NP -> PrVP_np ;
StartClC_none : Conj -> PrCl_none -> PrCl_none -> ClC_none ;
StartClC_np : Conj -> PrCl_np -> PrCl_np -> ClC_np ;
StartVPC_none : Conj -> PrVP_none -> PrVP_none -> VPC_none ;
StartVPC_np : Conj -> PrVP_np -> PrVP_np -> VPC_np ;
SubjS : Subj -> S -> Adv ;
SymbPN : Symb -> PN ;
TCond : Tense ;
TFut : Tense ;
TPast : Tense ;
TPres : Tense ;
Use2N3 : N3 -> N2 ;
Use3N3 : N3 -> N2 ;
UseA2 : A2 -> AP ;
UseAP_none : Ant -> Tense -> Pol -> PrAP_none -> PrVP_none ;
UseAP_np : Ant -> Tense -> Pol -> PrAP_np -> PrVP_np ;
UseAdvCl_none : PrAdv_none -> PrCl_none -> PrS ;
UseAdv_none : Ant -> Tense -> Pol -> PrAdv_none -> PrVP_none ;
UseAdv_np : Ant -> Tense -> Pol -> PrAdv_np -> PrVP_np ;
UseCN_none : Ant -> Tense -> Pol -> PrCN_none -> PrVP_none ;
UseCN_np : Ant -> Tense -> Pol -> PrCN_np -> PrVP_np ;
UseClC_none : ClC_none -> PrCl_none ;
UseClC_np : ClC_np -> PrCl_np ;
UseCl_none : PrCl_none -> PrS ;
UseComparA : A -> AP ;
UseN : N -> CN ;
UseN2 : N2 -> CN ;
UseNP_none : Ant -> Tense -> Pol -> NP -> PrVP_none ;
UsePN : PN -> NP ;
UsePron : Pron -> NP ;
UseQCl_none : PrQCl_none -> PrS ;
UseVPC_none : VPC_none -> PrVP_none ;
UseVPC_np : VPC_np -> PrVP_np ;
UseV_a : Ant -> Tense -> Pol -> PrV_a -> PrVP_a ;
UseV_n : Ant -> Tense -> Pol -> PrV_v -> PrVP_n ;
UseV_none : Ant -> Tense -> Pol -> PrV_none -> PrVP_none ;
UseV_np : Ant -> Tense -> Pol -> PrV_np -> PrVP_np ;
UseV_np_a : Ant -> Tense -> Pol -> PrV_np_a -> PrVP_np_a ;
UseV_np_n : Ant -> Tense -> Pol -> PrV_np_n -> PrVP_np_n ;
UseV_np_np : Ant -> Tense -> Pol -> PrV_np_np -> PrVP_np_np ;
UseV_np_q : Ant -> Tense -> Pol -> PrV_np_q -> PrVP_np_q ;
UseV_np_s : Ant -> Tense -> Pol -> PrV_np_s -> PrVP_np_s ;
UseV_np_v : Ant -> Tense -> Pol -> PrV_np_v -> PrVP_np_v ;
UseV_q : Ant -> Tense -> Pol -> PrV_q -> PrVP_q ;
UseV_s : Ant -> Tense -> Pol -> PrV_s -> PrVP_s ;
UseV_v : Ant -> Tense -> Pol -> PrV_v -> PrVP_v ;
UttAP : AP -> Utt ;
UttAdV : AdV -> Utt ;
UttAdv : Adv -> Utt ;
UttCN : CN -> Utt ;
UttCard : Card -> Utt ;
UttIAdv : IAdv -> Utt ;
UttIP : IP -> Utt ;
UttImpPl : Pol -> Imp -> Utt ;
UttImpPol : Pol -> Imp -> Utt ;
UttImpSg : Pol -> Imp -> Utt ;
UttInterj : Interj -> Utt ;
UttNP : NP -> Utt ;
UttPrS : PrS -> Utt ;
UttQS : QS -> Utt ;
UttS : S -> Utt ;
UttVP : VP -> Utt ;
VocNP : NP -> Voc ;


-}

