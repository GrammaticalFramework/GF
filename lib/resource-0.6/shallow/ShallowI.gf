--# -path=.:../../prelude:../abstract

incomplete concrete ShallowI of Shallow = open (Resource = Resource) in {
  lincat 
    Phr = Resource.Phr ;
    S   = Resource.S ;
    Qu  = Resource.Qu ;
    Imp = Resource.Imp ;
    Verb = Resource.V ;
    TV = Resource.TV ;
    Adj  = Resource.Adj1 ;
    N = Resource.N ;
    Noun = Resource.CN ;
    CN  = Resource.CN ;
    NP  = Resource.NP ;
    PN  = Resource.PN ;
    Adv = Resource.AdV ;
    Det = Resource.Det ;
    Prep = Resource.Prep ;
    Num = Resource.Num ;
    AdjDeg = Resource.AdjDeg ;
    Adj2 = Resource.Adj2 ;
    V3 = Resource.V3 ;

  lin
    PhrS = Resource.IndicPhrase ;
    PhrQu = Resource.QuestPhrase ;
    PhrImp = Resource.ImperOne ;

    SVerb x f = Resource.PredVP x (Resource.PosVG (Resource.PredV f)) ;
    SNegVerb x f = Resource.PredVP x (Resource.NegVG (Resource.PredV f)) ;
    SVerbPP x f y = Resource.PredVP x 
                      (Resource.AdvVP (Resource.PosVG (Resource.PredV f)) y) ;
    SNegVerbPP x f y = Resource.PredVP x 
                      (Resource.AdvVP (Resource.NegVG (Resource.PredV f)) y) ;
    STV x f y = Resource.PredVP x (Resource.PosVG 
                    (Resource.PredTV f y)) ;
    SNegTV x f y = Resource.PredVP x (Resource.NegVG 
                    (Resource.PredTV f y)) ;
    SAdj x f = Resource.PredVP x (Resource.PosVG 
                   (Resource.PredAP (Resource.AdjP1 f))) ;
    SNegAdj x f = Resource.PredVP x (Resource.NegVG 
                   (Resource.PredAP (Resource.AdjP1 f))) ;
    SAdjPP x f y = Resource.PredVP x (Resource.AdvVP (Resource.PosVG 
                     (Resource.PredAP (Resource.AdjP1 f))) y) ;
    SNegAdjPP x f y = Resource.PredVP x (Resource.AdvVP (Resource.NegVG 
                     (Resource.PredAP (Resource.AdjP1 f))) y) ;

    SCN x f = Resource.PredVP x (Resource.PosVG (Resource.PredCN f)) ;
    SNegCN x f = Resource.PredVP x (Resource.NegVG (Resource.PredCN f)) ;
    SAdv x f = Resource.PredVP x (Resource.PosVG (Resource.PredAdV f)) ;
    SNegAdv x f = Resource.PredVP x (Resource.NegVG (Resource.PredAdV f)) ;

    QuVerb x f = Resource.QuestVP x (Resource.PosVG (Resource.PredV f)) ;
    QuNegVerb x f = Resource.QuestVP x (Resource.NegVG (Resource.PredV f)) ;

    ImpVerb f = Resource.ImperVP (Resource.PosVG (Resource.PredV f)) ;
    ImpNegVerb f = Resource.ImperVP (Resource.NegVG (Resource.PredV f)) ;
    ImpAdj f = Resource.ImperVP (Resource.PosVG 
                   (Resource.PredAP (Resource.AdjP1 f))) ;
    ImpNegAdj f = Resource.ImperVP (Resource.NegVG 
                   (Resource.PredAP (Resource.AdjP1 f))) ;
    ImpCN f = Resource.ImperVP (Resource.PosVG (Resource.PredCN f)) ;
    ImpNegCN f = Resource.ImperVP (Resource.NegVG (Resource.PredCN f)) ;
    ImpAdv f = Resource.ImperVP (Resource.PosVG (Resource.PredAdV f)) ;
    ImpNegAdv f = Resource.ImperVP (Resource.NegVG (Resource.PredAdV f)) ;

    ModNoun a n = Resource.ModAdj (Resource.AdjP1 a) n ;
    PrepNP = Resource.PrepNP ;
    AdvNoun f a = Resource.AdvCN f a ;
    NounN = Resource.UseN ;
    CNNoun n = n ;

    DetNP = Resource.DetNP ;
    DefNP = Resource.DefOneNP ;
    IndefNP = Resource.IndefOneNP ;
    UsePN = Resource.UsePN ;

-- created in hugs from gf Warning lines by:
-- do {s <- readFile "koe2" ; mapM_ (appendFile "koe3" . (\f -> f ++ " = Resource." ++ f ++ " ;\n") . last . words) (lines s)}

AfterPrep = Resource.AfterPrep ;
AgentPrep = Resource.AgentPrep ;
AllMassDet = Resource.AllMassDet ;
AllNumDet = Resource.AllNumDet ;
AnyDet = Resource.AnyDet ;
AnyNumDet = Resource.AnyNumDet ;
BeforePrep = Resource.BeforePrep ;
BehindPrep = Resource.BehindPrep ;
BetweenPrep = Resource.BetweenPrep ;
ByMeansPrep = Resource.ByMeansPrep ;
DuringPrep = Resource.DuringPrep ;
EveryDet = Resource.EveryDet ;
EverybodyNP = Resource.EverybodyNP ;
EverythingNP = Resource.EverythingNP ;
FromPrep = Resource.FromPrep ;
HeNP = Resource.HeNP ;
INP = Resource.INP ;
InFrontPrep = Resource.InFrontPrep ;
InPrep = Resource.InPrep ;
ItNP = Resource.ItNP ;
ManyDet = Resource.ManyDet ;
MostDet = Resource.MostDet ;
MostsDet = Resource.MostsDet ;
MuchDet = Resource.MuchDet ;
NoDet = Resource.NoDet ;
NoNum = Resource.NoNum ;
NoNumDet = Resource.NoNumDet ;
NobodyNP = Resource.NobodyNP ;
NothingNP = Resource.NothingNP ;
OnPrep = Resource.OnPrep ;
PartPrep = Resource.PartPrep ;
PhrNo = Resource.PhrNo ;
PhrYes = Resource.PhrYes ;
PossessPrep = Resource.PossessPrep ;
SheNP = Resource.SheNP ;
SomeDet = Resource.SomeDet ;
SomeNumDet = Resource.SomeNumDet ;
SomebodyNP = Resource.SomebodyNP ;
SomethingNP = Resource.SomethingNP ;
ThatDet = Resource.ThatDet ;
ThatNP = Resource.ThatNP ;
TheseNumDet = Resource.TheseNumDet ;
TheseNumNP = Resource.TheseNumNP ;
TheyNP = Resource.TheyNP ;
ThisDet = Resource.ThisDet ;
ThisNP = Resource.ThisNP ;
ThoseNumDet = Resource.ThoseNumDet ;
ThoseNumNP = Resource.ThoseNumNP ;
ThouNP = Resource.ThouNP ;
ThroughPrep = Resource.ThroughPrep ;
ToPrep = Resource.ToPrep ;
UnderPrep = Resource.UnderPrep ;
WeNumNP = Resource.WeNumNP ;
WhichDet = Resource.WhichDet ;
WhichNumDet = Resource.WhichNumDet ;
WithPrep = Resource.WithPrep ;
WithoutPrep = Resource.WithoutPrep ;
YeNumNP = Resource.YeNumNP ;
YouNP = Resource.YouNP ;

}
