--# -path=.:../finnish/stemmed:../finnish:../common:alltenses

concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,Conj] ** 
    PredFunctor 
     - [
        UseVPC,StartVPC,ContVPC

       ,PresPartAP
       ,PastPartAP,AgentPastPartAP
       ,PassUseV, AgentPassUseV

       ,UseV --
       ,UseCN --
       ,UseAP --       
       ,QuestVP --
       ,PredVP --
       ,ComplV2 --
       ,ReflVP2,ReflVP --
     ]

with 
      (PredInterface = PredInstanceFin) ** open PredInstanceFin, ResFin in {

lin
  UseV x a t p verb = initPrVerbPhraseV a t p verb ;

  ComplV2 x vp np =  vp ** {
    obj1 = \\_ => appCompl True Pos vp.c1 np ;
    } ;

  PredVP x np vp = vp ** {
    subj : Str = appSubjCase vp.sc np ;
    verb : {fin,inf : Str} = vp.v ! np.a ;
    obj1 : Str = vp.obj1 ! np.a ;
    obj2 : Str = vp.obj2 ! np.a ; 
    c3 : Compl = noComplCase ;
    } ;

  UseAP x a t p ap = useCopula a t p ** {
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    obj1 = \\a => ap.s ! agr2aagr a ;
    } ;

  UseCN x a t p cn = useCopula a t p ** {
    c1  = cn.c1 ;
    c2  = cn.c2 ;
    obj1 = \\a => cn.s ! agr2nagr a ;
    } ;

  ReflVP x vp = vp ** {
    obj1 = \\a => (reflPron a).s ! vp.c1.c ; ---- prep
    } ;

  ReflVP2 x vp = vp ** {
    obj2 = \\a => (reflPron a).s ! vp.c2.c ; ---- prep
    } ;

  QuestVP x ip vp = 
   let 
       ipa = ipagr2agr ip.n 
   in vp ** {
    foc  = ip.s ! subjCase ;   ---- appSubjCase ip
    focType = FocSubj ;
    subj = [] ;
    verb : {fin,inf : Str} = vp.v ! ipa ;
    obj1 : Str = vp.obj1 ! ipa ;
    obj2 : Str = vp.obj2 ! ipa ; 
    c3 : Compl = noComplCase ;
    qforms = \\_ => <[],[]> ;
    } ;



        UseVPC,StartVPC,ContVPC

       ,PresPartAP
       ,PastPartAP,AgentPastPartAP
       ,PassUseV, AgentPassUseV
           = variants {} ;

}
