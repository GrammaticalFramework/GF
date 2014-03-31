--# -path=.:../finnish/stemmed:../finnish:../common:alltenses

concrete PredFin of Pred = 
  CatFin [Ant,NP,Utt,IP,IAdv,IComp,Conj,Subj,RP,RS] ** 
    PredFunctor 
     - [

-- overridden
        UseV
       ,UseAP
       ,UseNP
       ,UseCN
       ,QuestVP
       ,PredVP
       ,ComplV2
       ,ReflVP2
       ,ReflVP
       ,RelVP
       ,RelSlash
       ,QuestIComp
       ,PassUseV
       ,PresPartAP
       ,PastPartAP
       ,AgentPastPartAP
       ,AgentPassUseV
       ,UseVPC
       ,StartVPC
       ,ContVPC
       ,ComplVV
       ,SlashV2V
     ]

with 
      (PredInterface = PredInstanceFin) ** open PredInstanceFin, (S = StemFin), ResFin in {

lin
  ComplVV x vp vpo = addObj2VP vp (\\a => vpo.s ! VPIVV vp.vvtype ! a) ;
  SlashV2V x vp vpo = addObj2VP vp (\\a => vpo.s ! VPIVV vp.vvtype ! a) ;

  UseV x a t p verb = initPrVerbPhraseV a t p verb ;

  UseAP x a t p ap = useCopula a t p ** {
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\a => ap.s ! agr2aagr a ;
    } ;

  UseNP a t p np = useCopula a t p ** {
    adj = \\a => np.s ! subjCase ;
    } ;

  UseCN x a t p cn = useCopula a t p ** {
    c1  = cn.c1 ;
    c2  = cn.c2 ;
    adj = \\a => cn.s ! agr2nagr a ;
    } ;

  ComplV2 x vp np =  vp ** {
    obj1 = \\_ => appCompl True Pos vp.c1 np ; ---- True,Pos ?
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


  PassUseV x a t p verb = initPrVerbPhraseV a t p verb ** {
    v : Agr => {fin,inf : Str} = case verb.sc of {
       SCNom => \\agr => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass agr        (lin PrV verb) ;
       _     => \\_   => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass defaultAgr (lin PrV verb)
       } ;
    inf : VPIType => Str = \\vtt => tenseInfV (a.s ++ p.s) a.a p.p Pass (lin PrV verb) vtt ; ---- still Act
    imp : ImpType => Str = \\it => imperativeV p.s p.p it (lin PrV verb) ; ---- still Act
    isPass : Bool = True ;
    c1 : Compl = noComplCase ;
    c2 : Compl = verb.c2 ;
    vvtype = verb.vvtype ;
    sc = npform2subjcase verb.c1.c ;
    h = case a.a of {Anter => Back ; _ => verb.h} ;
    } ;

  AgentPassUseV x a t p verb np = initPrVerbPhraseV a t p verb ** {
    sc = npform2subjcase verb.c1.c ;
    obj1 = \\a => appSubjCase verb.sc np ;
    } ;

  PresPartAP x v = {            
    s = \\a => vPresPart v a ;
    c1 = v.c1 ;                    -- looking at her
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  PastPartAP x v = {            
    s = \\a => vPastPart v a ;
    c1 = v.c1 ;                    -- looking at her
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  AgentPastPartAP x v np = {
    s = \\a => (S.sverb2verbSep v).s ! AgentPart (aForm a) ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = \\_ => appComplCase agentCase np ; ---- addObj
    } ;


  StartVPC x c v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          let 
            vv = v.v ! a ; 
            wv = w.v ! a ;
            vpa = vagr2agr a ;
          in 
          vv.fin ++ v.adV ++ vv.inf ++ v.adj ! vpa ++ 
          v.obj1 ! vpa ++ v.obj2 ! vpa ++ v.adv ++ v.ext
            ++ c.s2 ++  
          wv.fin ++ w.adV ++ wv.inf ++ w.adj ! vpa ++   
          w.obj1 ! vpa ++ w.obj2 ! vpa ++ w.adv ++ w.ext ;
    inf = \\a,vt => 
            infVP vt a v ++ c.s2 ++ infVP vt a w ;
    imp = \\i => 
            impVP i v ++ c.s2 ++ impVP i w ;
    c1 = noComplCase ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = noComplCase ; ---- w.c2 ? 
    s1 = c.s1 ;
    } ;

  ContVPC x v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          let 
            vv = v.v ! a ; 
            wv = w.v ! a ;
            vpa = vagr2agr a ;
          in 
          vv.fin ++ v.adV ++ vv.inf ++ v.adj ! vpa ++ 
          v.obj1 ! vpa ++ v.obj2 ! vpa ++ v.adv ++ v.ext
            ++ "," ++  
          wv ;
    inf = \\a,vt => 
            infVP vt a v ++ "," ++ w.inf ! a ! vt ;
    imp = \\i => 
            impVP i v ++ "," ++ w.imp ! i ;
    c1 = noComplCase ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = noComplCase ; ---- w.c2 ? 
    s1 = w.s1 ;
    } ;

  UseVPC x vpc = initPrVerbPhrase ** { ---- big loss of quality (overgeneration) seems inevitable
    v   = \\a => {fin = vpc.s1 ++ vpc.v ! a ; inf = []} ;
    inf = \\vt => vpc.inf ! defaultAgr ! vt ; ---- agr 
    imp = vpc.imp ;
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    } ;


  ByVP x vp vpi = vp ** {adv = vpi.s ! VPIInf3Adess ! defaultAgr} ;        -- tekemällä
  WhenVP x vp vpi = vp ** {adv = vpi.s ! VPIInf2Iness ! defaultAgr} ;      -- tehdessä ---- agr
  BeforeVP x vp vpi = vp ** {adv = "ennen" ++ vpi.s ! VPIInf4Part ! defaultAgr} ;    -- ennen tekemistä
  InOrderVP  x vp vpi = vp ** {adv = vpi.s ! VPIInf1Long ! defaultAgr} ;  -- tehdäkseen ---- agr
  WithoutVP x vp vpi = vp ** {adv = vpi.s ! VPIInf3Abess ! defaultAgr} ;    -- tekemättä

  AfterVP    -- tehtyä
           = variants {} ;

}
