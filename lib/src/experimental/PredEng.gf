concrete PredEng of Pred = 
  CatEng [Ant,NP,Utt,IP,IAdv,IComp,Conj,RP,RS,Subj] ** 
    PredFunctor - [
      -- for all these, special qforms added in Eng
      PassUseV,
      AgentPassUseV,
      UseVPC,
      PredVP,
      QuestVP,
      RelVP,

      UseCN,  -- insert article

      UseCl,  -- for contracted forms

      QuestIComp  ---- IComp has no parameters in Eng
      ]  
  with 
      (PredInterface = PredInstanceEng) 

  ** open PredInstanceEng, (R = ResEng) in {

-- overrides

lin
  PassUseV x a t p v = initPrVerbPhraseV a t p v ** {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p passive agr v ;
    vc  = \\agr => tenseVContracted (a.s ++ t.s ++ p.s) t.t a.a p.p passive agr v ;
    inf = \\vt => tenseInfV a.s a.a p.p passive v vt ;
    obj2 = <noObj, True> ; -- becomes subject control even if object control otherwise "*she was promised by us to love ourselves"
    qforms = \\agr => qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  AgentPassUseV x a t p v np = initPrVerbPhraseV a t p v ** {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p passive agr v ;
    v   = \\agr => tenseVContracted (a.s ++ t.s ++ p.s) t.t a.a p.p passive agr v ;
    inf = \\vt => tenseInfV a.s a.a p.p passive v vt ;
    obj2 = <noObj, True> ; -- becomes subject control even if object control otherwise "*she was promised by us to love ourselves"
    adv = appComplCase agentCase np ;
    qforms = \\agr => qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  UseCN x a t p cn = useCopula a t p ** {
    c1  = cn.c1 ;
    c2  = cn.c2 ;
    adj = \\a => case agr2nagr a of {Sg => R.artIndef ++ cn.s ! Sg ; Pl => cn.s ! Pl} ;
    obj1 = <cn.obj1, defaultAgr> ;
    } ;

  PredVP x np vp = vp ** {
    v    = applyVerb vp (agr2vagr np.a) ;
    vc   = vp.vc ! (agr2vagr np.a) ;
    subj = appSubjCase np ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! np.a ;  ---- apply complCase ---- place of part depends on obj
    obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => np.a ; False => vp.obj1.p2}) ;   ---- apply complCase
    c3   = vp.c1 ; -- in case there is any free slot left ---- could be c2 
    qforms = qformsVP vp (agr2vagr np.a) ; 
    } ;

  QuestVP x ip vp = 
   let 
       ipa = ipagr2agr ip.n 
   in {
    v    = applyVerb vp (ipagr2vagr ip.n) ;
    vc   = vp.vc ! (ipagr2vagr ip.n) ;
    foc  = ip.s ! subjCase ;
    focType = FocSubj ;
    subj = [] ;
    adj  = vp.adj ! ipa ;
    obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! ipa ; ---- appComplCase
    obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ipa ; False => vp.obj1.p2}) ; ---- appComplCase
    c3   = noComplCase ;      -- for one more prep to build ClSlash ---- ever needed for QCl?
    adv  = vp.adv ;
    adV  = vp.adV ;
    ext  = vp.ext ; 
    qforms = qformsVP vp (ipagr2vagr ip.n) ;
    } ;

  UseCl  cl =  {s = declCl cl}
             | {s = declClContracted cl} ;

  RelVP rp vp = 
    let 
      cl : Agr -> PrClause = \a -> 
        let rpa = rpagr2agr rp.a a in
        
        vp ** {
        v    = applyVerb vp (agr2vagr rpa) ;
        vc   = vp.vc ! (agr2vagr rpa) ;
        subj = rp.s ! subjRPCase a ;
        adj  = vp.adj ! rpa ;
        obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! rpa ;  ---- apply complCase ---- place of part depends on obj
        obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => rpa ; False => vp.obj1.p2}) ;   ---- apply complCase
        c3   = noComplCase ;      -- for one more prep to build ClSlash 
        qforms = qformsVP vp (agr2vagr rpa) ; 
        }
    in {s = \\a => declCl (cl a) ; c = subjCase} ;

  UseVPC x vpc = initPrVerbPhrase ** { ---- big loss of quality (overgeneration) seems inevitable
    v   = \\a => <[], [], vpc.s1 ++ vpc.v ! a> ;
    inf = \\vt => vpc.inf ! defaultAgr ! vt ; ---- agr 
    imp = vpc.imp ;
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    qforms = \\a => <"do", vpc.inf ! defaultAgr ! vvInfinitive> ; ---- do/does/did
    } ;

lin
  QuestIComp a t p icomp np = 
    let vagr = (agr2vagr np.a) in
    initPrClause ** {
    v    = tenseCopula  (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ;
    vc   = tenseCopulaC (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ;
    subj = np.s ! subjCase ;
    foc = icomp.s ;
    focType = FocObj ;
    qforms = qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p vagr ; 
    } ;

-- not in functor anyway

  NomVPNP vpi = {
    s = \\c => vpi.s ! R.VVPresPart ! defaultAgr ;
    a = defaultAgr
    } ;

  ByVP x vp vpi = vp ** {adv = "by" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  WhenVP x vp vpi = vp ** {adv = "when" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  BeforeVP x vp vpi = vp ** {adv = "before" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  AfterVP x vp vpi = vp ** {adv = "after" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr
  InOrderVP x vp vpi = vp ** {adv = "in order" ++ vpi.s ! R.VVInf ! defaultAgr} ; ---- agr
  WithoutVP x vp vpi = vp ** {adv = "without" ++ vpi.s ! R.VVPresPart ! defaultAgr} ; ---- agr

}
