incomplete concrete MultimodalI of Multimodal =
  open Prelude, Resource, Basic, Lang, DemRes in {

  lin
    DemNP np = np ** {s5 = [] ; lock_NP = <>} ;
    DemAdv adv = addDAdv (adv ** {lock_Adv = <>}) {s5 = []} ; 
    SentMS ms = {s = ms.s ! MInd ++ ";" ++ ms.s5} ;
    QuestMS ms = {s = ms.s ! MQuest ++ ";" ++ ms.s5} ;
    QuestMQ ms = {s = ms.s  ++ ";" ++ ms.s5} ;

    AdvDate = AdvDate ;
    AdvTime = AdvTime ;

}

