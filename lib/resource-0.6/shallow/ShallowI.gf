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
    Noun = Resource.CN ;
    CN  = Resource.CN ;
    NP  = Resource.NP ;
    Adv = Resource.AdV ;
    Det = Resource.Det ;
    Prep = Resource.Prep ;

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
    PrepNoun f p x = Resource.AdvCN f (Resource.PrepNP p x) ;
    CNNoun n = n ;

    AllNP = Resource.DetNP (Resource.AllNumDet Resource.NoNum) ;
    EveryNP = Resource.DetNP Resource.EveryDet ;
    DefNP = Resource.DefOneNP ;
    IndefNP = Resource.IndefOneNP ;

    PossessPrep = Resource.PossessPrep ;
}
