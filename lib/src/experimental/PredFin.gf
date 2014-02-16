--# -path=.:../finnish/stemmed:../finnish:../common:alltenses

concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,IComp,Conj,RP,RS] ** 
    PredFunctor 
     - [

-- not yet
        UseVPC,StartVPC,ContVPC

       ,PresPartAP
       ,PastPartAP,AgentPastPartAP
       ,PassUseV, AgentPassUseV

-- overridden
       ,UseV
       ,UseAP
       ,UseCN
       ,QuestVP
       ,PredVP
       ,ComplV2
       ,ReflVP2,ReflVP
       ,RelVP,RelSlash
       ,QuestIComp
     ]

with 
      (PredInterface = PredInstanceFin) ** open PredInstanceFin, ResFin in {

lin
  UseV x a t p verb = initPrVerbPhraseV a t p verb ;

  UseAP x a t p ap = useCopula a t p ** {
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\a => ap.s ! agr2aagr a ;
    } ;

  UseCN x a t p cn = useCopula a t p ** {
    c1  = cn.c1 ;
    c2  = cn.c2 ;
    adj = \\a => cn.s ! agr2nagr a ;
    } ;

  ComplV2 x vp np =  vp ** {
    obj1 = \\_ => appCompl True Pos vp.c1 np ;
    } ;

  PredVP x np vp = vp ** {
    subj : Str = appSubjCase vp.sc np ;
    verb : {fin,inf : Str} = vp.v ! np.a ;
    adj  : Str = vp.adj ! np.a ;
    obj1 : Str = vp.obj1 ! np.a ;
    obj2 : Str = vp.obj2 ! np.a ; 
    c3 : Compl = vp.c1 ; ---- could be c2
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
    adj  : Str = vp.adj ! ipa ;
    obj1 : Str = vp.obj1 ! ipa ;
    obj2 : Str = vp.obj2 ! ipa ; 
    c3 : Compl = noComplCase ;
    qforms = \\_ => <[],[]> ;
    } ;

  QuestIComp a t p icomp np = 
    let 
      vagr = (agr2vagr np.a) 
    in
    initPrClause ** {
      v    = tenseCopula (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ;
      subj = np.s ! subjCase ;
      foc = icomp.s ! np.a ;
      focType = FocObj ;
      qforms = qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ; 
    } ;

  RelVP rp vp = 
    let 
      cl : Agr -> PrClause = \a -> 
        let 
          rpa = rpagr2agr rp.a a ;
          rnp = {s = rp.s ! (complNumAgr rpa) ; a = rpa ; isPron = False}
        in
        vp ** {
          v    = applyVerb vp (agr2vagr rpa) ;
          subj : Str = appSubjCase vp.sc rnp ;
          verb : {fin,inf : Str} = vp.v ! rpa ;
          adj  : Str = vp.adj ! rpa ;
          obj1 : Str = vp.obj1 ! rpa ;
          obj2 : Str = vp.obj2 ! rpa ; 
          c3   : Compl = noComplCase ;
        }
    in {s = \\a => declCl (cl a) ; c = subjCase} ; ---- case

  RelSlash rp cl = {
      s = \\a => 
            let 
               rpa = rpagr2agr rp.a a ;
               rnp = appCompl True Pos cl.c3 {s = rp.s ! (complNumAgr rpa) ; a = rpa ; isPron = False}
            in 
            rnp ++ declCl cl ; 
      c = objCase ---- case
      } ;

  NomVPNP vpi = {
    s = \\c => vpi.s ! vvInfinitive ! defaultAgr ;
    isNeg = False ; ----
    isPron = False ; ----
    a = defaultAgr
    } ;

        UseVPC,StartVPC,ContVPC

       ,PresPartAP
       ,PastPartAP,AgentPastPartAP
       ,AgentPassUseV
           = variants {} ;

  PassUseV x a t p verb = initPrVerbPhraseV a t p verb ** {
    v : Agr => {fin,inf : Str} = case verb.sc of {
       SCNom => \\agr => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass agr        (lin PrV verb) ;
       _     => \\_   => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass defaultAgr (lin PrV verb)
       } ;
    inf : VVType => Str = \\vtt => tenseInfV (a.s ++ p.s) a.a p.p Pass (lin PrV verb) vtt ; ---- still Act
    imp : ImpType => Str = \\it => imperativeV p.s p.p it (lin PrV verb) ; ---- still Act
    isPass : Bool = True ;
    c1 : Compl = noComplCase ;
    c2 : Compl = verb.c2 ;
    vvtype = verb.vvtype ;
    sc = npform2subjcase verb.c1.c ;
    h = case a.a of {Anter => Back ; _ => verb.h} ;
    } ;

---- this will be fun!

  ByVP,       -- tekemällä
  WhenVP,     -- tehdessä
  BeforeVP,   -- ennen tekemistä
  AfterVP,    -- tehtyä
  InOrderVP,  -- tehdäkseen
  WithoutVP   -- tekemättä
           = variants {} ;

}
