concrete GrammarIta of Grammar = open ResIta, Prelude in {
  lincat  
    S  = {s : Mood => Str} ;
    Cl = {s : Mood => ResIta.Tense => Bool => Str} ; 
    NP = ResIta.NP ;  
      -- {s : Case => {clit,obj : Str ; isClit : Bool} ; a : Agr} ; 
    VP = ResIta.VP ;  
      -- {v : Verb ; clit : Str ; clitAgr : ClitAgr ; obj : Agr => Str} ;
    AP = {s : Gender => Number => Str ; isPre : Bool} ;
    CN = Noun ;           -- {s : Number => Str ; g : Gender} ;
    Det = {s : Gender => Case => Str ; n : Number} ;
    N = Noun ;            -- {s : Number => Str ; g : Gender} ;
    A = Adj ;             -- {s : Gender => Number => Str ; isPre : Bool} ;
    V = Verb ;            -- {s : VForm => Str ; aux : Aux} ;
    V2 = Verb ** {c : Case} ;
    AdA = {s : Str} ;
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str ; t : ResIta.Tense} ;
    Conj = {s : Str ; n : Number} ;
  lin
    UseCl t p cl = {s = \\m => t.s ++ p.s ++ cl.s ! m ! t.t ! p.b} ; 
    PredVP np vp = predVP (np.s ! Nom).obj np.a vp ;

    ComplV2 v2 np = 
      let
        nps = np.s ! v2.c
      in {
        v = v2 ; 
        clit = nps.clit ; 
        clitAgr = case <nps.isClit,v2.c> of {
          <True,Acc> => CAgr np.a ;
          _ => CAgrNo
          } ;
        obj  = \\_ => nps.obj
        } ;

    UseV v = useV v (\\_ => []) ;

    DetCN det cn = {
      s = \\c => {
        obj = det.s ! cn.g ! c ++ cn.s ! det.n ; 
        clit = [] ; 
        isClit = False
        } ;
      a = Ag cn.g det.n Per3
      } ;

    ModCN ap cn = {
      s = \\n => preOrPost ap.isPre (ap.s ! cn.g ! n) (cn.s ! n) ;
      g = cn.g
      } ;

    CompAP ap = useV essere_V (\\ag => case ag of {
        Ag g n _ => ap.s ! g ! n
        }
      ) ;

    AdAP ada ap = {
      s = \\g,n => ada.s ++ ap.s ! g ! n ;
      isPre = ap.isPre ;
      } ;

    ConjNP co nx ny = {
      s = \\c => {
        obj = (nx.s ! c).obj ++ co.s ++ (ny.s ! c).obj ; 
        clit = [] ; 
        isClit = False
        } ;
      a = conjAgr co.n nx.a ny.a
      } ;

    ConjS co x y = {s = \\m => x.s ! m ++ co.s ++ y.s ! m} ;

    ConjAP co x y = {
      s = \\g,n => x.s ! g ! n ++ co.s ++ y.s ! g ! n ;
      isPre = andB x.isPre y.isPre
      } ;

    UseN n = n ;

    UseA adj = adj ;

    a_Det = adjDet (mkAdj "un" "una" [] [] True) Sg ;

    every_Det = adjDet (regAdj "ogni") Sg ;

    the_Det = {
      s = table {
        Masc => table {
          Nom | Acc => elisForms "lo" "l'" "il" ;
          Dat => elisForms "allo" "all'" "al" ;
          Gen => elisForms "dello" "dell'" "del" ;
          C_in => elisForms "nello" "nell'" "nel" ;
          C_da => elisForms "dallo" "dall'" "dal" ;
          C_con => elisForms "collo" "coll'" "col"
          } ;
        Fem => table {
          Nom | Acc => elisForms "la" "'l" "la" ;
          Dat => elisForms "alla" "all'" "alla" ;
          Gen => elisForms "della" "dell'" "della" ;
          C_in => elisForms "nella" "nell'" "nella" ;
          C_da => elisForms "dalla" "dall'" "dalla" ;
          C_con => elisForms "colla" "coll'" "colla"
          }
        } ;
      n = Sg
      } ;
        
    this_Det = adjDet (regAdj "questo") Sg ;
    these_Det = adjDet (regAdj "questo") Pl ;
    that_Det = adjDet quello_A Sg ;
    those_Det = adjDet quello_A Pl ;

    i_NP     = pronNP "io"  "mi" "mi" "me"  Masc Sg Per1 ;
    youSg_NP = pronNP "tu"  "ti" "ti" "te"  Masc Sg Per2 ;
    he_NP    = pronNP "lui" "lo" "gli" "lui" Masc Sg Per3 ;
    she_NP   = pronNP "lei" "la" "le" "lei" Fem  Sg Per3 ;
    we_NP    = pronNP "noi" "ci" "ci" "noi" Masc Pl Per1 ;
    youPl_NP = pronNP "voi" "vi" "vi" "voi" Masc Pl Per2 ;
    they_NP  = pronNP "loro" "li" "loro" "loro" Masc Pl Per3 ;

    very_AdA = ss "molto" ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = ResIta.Pres} ;
    Perf = {s = [] ; t = ResIta.Perf} ;
    Past = {s = [] ; t = ResIta.Past} ;
    Fut  = {s = [] ; t = ResIta.Fut} ;

    and_Conj = {s = "e" ; n = Pl} ;
    or_Conj  = {s = "o" ; n = Sg} ;

  oper
    quello_A : Adj = mkAdj 
      (elisForms "quello" "quell'" "quel") "quella"
      (elisForms "quegli" "quegli" "quei") "quelle"
      True ;

-- more

  lincat
    Utt = {s : Str} ; 
    QS  = {s : QForm => Str} ; 
    QCl = {s : QForm => ResIta.Tense => Bool => Str} ; 
    ClSlash = {s : Mood => ResIta.Tense => Bool => Str ; c : Case} ;  
    Adv = {s : Str} ;
    Prep = {s : Str ; c : Case} ;
    VS = Verb ** {m : Mood} ;
    VQ = Verb ; 
    VV = Verb ;
    IP = {s : Str} ;
    PN = {s : Str ; g : Gender} ;
    IAdv = {s : Str} ;
    Subj = {s : Str ; m : Mood} ;

  lin
    UttS s = {s = s.s ! Ind} ;
    UttQS s = {s = s.s ! QDir} ;

    UseQCl t p cl = {s = \\q => t.s ++ p.s ++ cl.s ! q ! t.t ! p.b} ; 

    QuestCl cl = {s = \\q,t,p => 
      case q of {
        QDir   => cl.s ! Ind ! t ! p ;
        QIndir => "se" ++ cl.s ! Ind ! t ! p
        }
      } ;

    QuestVP ip vp = 
      {s = \\_ => (predVP ip.s (Ag Masc Sg Per3) vp).s ! Ind} ; ---- agr

    QuestSlash ip cls = {
      s = \\q,t,p => prepCase cls.c ++ ip.s ++ cls.s ! Ind ! t ! p
      } ;

    QuestIAdv iadv cl = {
      s = \\q,t,p => iadv.s ++ cl.s ! Ind ! t ! p
      } ;

    SubjCl cl subj s = {
      s = \\m,t,b => cl.s ! m ! t ! b ++ subj.s ++ s.s ! subj.m
      } ;

    CompAdv adv = 
      useV essere_V (\\_ => adv.s) ;

    ComplVS v s = 
      useV v (\\_ => "che" ++ s.s ! v.m) ;

    ComplVQ v q = 
      useV v (\\_ => q.s ! QIndir) ;

    ComplVV v vp = 
      useV v (\\a => vp.v.s ! VInf ++ vp.clit ++ vp.obj ! a) ;

    SlashV2 np v2 = 
      predVP (np.s ! Nom).obj np.a (useV v2 (\\_ => [])) ** {
      c = v2.c
      } ;

    SlashPrep cl prep = {
      s = cl.s ;
      c = prep.c
      } ;

    AdvVP vp adv = {
      v = vp.v ;
      clit = vp.clit ;
      clitAgr = vp.clitAgr ;
      obj = \\a => vp.obj ! a ++ adv.s
      } ;

    UsePN pn = {
        s = \\c => {
        obj = prepCase c ++ pn.s ;
        clit = [] ; 
        isClit = False
        } ;
      a = Ag pn.g Sg Per3
      } ;

    AdvNP np adv = {
      s = \\c => {
        obj = (np.s ! c).obj ++ adv.s ;
        clit = [] ; 
        isClit = False
        } ;
      a = np.a
      } ;

    PrepNP prep np = {
      s = prep.s ++ (np.s ! prep.c).obj
      } ;

    who_IP  = ss "chi" ;
    here_Adv = ss "quí" ;
    by_Prep = {s = [] ; c = C_da} ;
    in_Prep = {s = [] ; c = C_in} ;
    of_Prep = {s = [] ; c = Gen} ;
    with_Prep = {s = [] ; c = C_con} ;

    can_VV = mkVerb "potere"
      "posso" "puoi" "può" "possiamo" "potete" "possono"
      "potevo" "potrò" "possa" "possiamo" "potuto" Avere ;

    must_VV = mkVerb "dovere"
      "devo" "devi" "deve" "dobbiamo" "dovete" "devono"
      "dovevo" "dovrò" "debba" "dobbiamo" "dovuto" Avere ;

    want_VV = mkVerb "volere"
      "voglio" "vuoi" "vuole" "vogliamo" "volete" "vogliono"
      "volevo" "vorrò" "voglia" "volessi" "voluto" Avere ;

    although_Subj = {s = "benché" ; m = Con} ;
    because_Subj = {s = "perché" ; m = Ind} ;
    when_Subj = {s = "quando" ; m = Ind} ;

    when_IAdv = ss "quando" ;
    where_IAdv = ss "dove" ;
    why_IAdv = ss "perché" ;

}
