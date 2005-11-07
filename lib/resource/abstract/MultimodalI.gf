incomplete concrete MultimodalI of Multimodal =
  open Prelude, Resource, Basic, Lang, DemRes in {

  lin
    DemNP np = np ** {s5 = [] ; lock_NP = <>} ;
    DemAdv adv = addDAdv (adv ** {lock_Adv = <>}) {s5 = []} ; 
    SentMS  p ms = {s = p.s ++ ms.s ! MInd (p.p) ++ ";" ++ ms.s5} ;
    QuestMS p ms = {s = p.s ++ ms.s ! MQuest (p.p) ++ ";" ++ ms.s5} ;
    QuestMQS p ms = {s = p.s ++ ms.s ! p.p  ++ ";" ++ ms.s5} ;

    AdvDate = AdvDate ;
    AdvTime = AdvTime ;

}

