concrete GrammarEng of Grammar = open ResEng, Prelude in {
  lincat  
    S  = {s : Str} ;
    Cl = {s : ClForm => TTense => Bool => Str} ; 
    NP = ResEng.NP ;  
      -- {s : Case => Str ; a : Agr} ; 
    VP = ResEng.VP ;  
      -- {v : AgrVerb ; compl : Str} ;
    AP = {s : Str} ;
    CN = Noun ;           -- {s : Number => Str} ;
    Det = {s : Str ; n : Number} ;
    N = Noun ;            -- {s : Number => Str} ;
    A = Adj ;             -- {s : Str} ;
    V = Verb ;            -- {s : VForm => Str} ;
    V2 = Verb ** {c : Str} ;
    AdA = {s : Str} ;
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str ; t : TTense} ;
    Conj = {s : Str ; n : Number} ;
  lin
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! ClDir ! t.t ! p.b} ; 
    PredVP np vp = {
      s = \\d,t,b => 
        let 
          vps = vp.verb.s ! d ! t ! b ! np.a 
        in case d of {
          ClDir => np.s ! Nom ++ vps.fin ++ vps.inf ++ vp.compl ;
          ClInv => vps.fin ++ np.s ! Nom ++ vps.inf ++ vp.compl
          }
      } ;

    ComplV2 v2 np = {
      verb = agrV v2 ; 
      compl = v2.c ++ np.s ! Acc
      } ;

    UseV v = {
      verb = agrV v ; 
      compl = []
      } ;

    DetCN det cn = {
      s = \\_ => det.s ++ cn.s ! det.n ;
      a = Ag det.n Per3
      } ;

    ModCN ap cn = {
      s = \\n => ap.s ++ cn.s ! n
      } ;

    CompAP ap = {
      verb = copula ;
      compl = ap.s 
      } ;

    AdAP ada ap = {
      s = ada.s ++ ap.s
      } ;

    ConjS  co x y = {s = x.s ++ co.s ++ y.s} ;
    ConjAP co x y = {s = x.s ++ co.s ++ y.s} ;

    ConjNP co nx ny = {
      s = \\c => nx.s ! c ++ co.s ++ ny.s ! c ;
      a = conjAgr co.n nx.a ny.a
      } ;

    UseN n = n ;

    UseA adj = adj ;

    a_Det = mkDet (pre {#vowel => "an" ; _ => "a"}) Sg ;

    every_Det = mkDet "every" Sg ;

    the_Det = mkDet "the" Sg ;
        
    this_Det = mkDet "this" Sg ;
    these_Det = mkDet "these" Pl ;
    that_Det = mkDet "that" Sg ;
    those_Det = mkDet "those" Pl ;

    i_NP = pronNP "I" "me" Sg Per1 ;
    youSg_NP = pronNP "you" "you" Sg Per2 ;
    he_NP = pronNP "her" "him" Sg Per3 ;
    she_NP = pronNP "she" "her" Sg Per3 ;
    we_NP = pronNP "we" "us" Pl Per1 ;
    youPl_NP = pronNP "you" "you" Pl Per2 ;
    they_NP = pronNP "they" "them" Pl Per3 ;

    very_AdA = ss "very" ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = TPres} ;
    Perf = {s = [] ; t = TPerf} ;
    Past = {s = [] ; t = TPast} ;
    Fut  = {s = [] ; t = TFut} ;

    and_Conj = {s = "and" ; n = Pl} ;
    or_Conj  = {s = "or" ; n = Sg} ;

-- more

  lincat
    Utt = {s : Str} ; 
    QS  = {s : QForm => Str} ; 
    QCl = {s : QForm => TTense => Bool => Str} ; 
    ClSlash = {s : ClForm => TTense => Bool => Str ; c : Str} ;  
    Adv, Prep = {s : Str} ;
    VS = Verb ;
    VQ = Verb ; 
    VV = {s : AgrVerb ; isAux : Bool} ;
    IP = {s : Str} ;
    PN = {s : Str} ;
    IAdv, Subj = {s : Str} ;

  lin
    UttS s = s ;
    UttQS s = {s = s.s ! QDir} ;

    UseQCl t p cl = {s = \\q => t.s ++ p.s ++ cl.s ! q ! t.t ! p.b} ; 
    
    QuestCl cl = {s = \\q,t,p => 
      case q of {
        QDir   => cl.s ! ClInv ! t ! p ;
        QIndir => "if" ++ cl.s ! ClDir ! t ! p
        }
      } ;

    QuestVP ip vp = {
     s = \\d,t,b => 
        let 
          vps = vp.verb.s ! ClDir ! t ! b ! Ag Sg Per3 
        in
        ip.s ++ vps.fin ++ vps.inf ++ vp.compl
      } ;
-- {-
    QuestSlash ip cls = {
      s = (\\q,t,p => ip.s ++ cls.s ! ClInv ! t ! p ++ cls.c) 
        | (\\q,t,p => cls.c ++ ip.s ++ cls.s ! ClInv ! t ! p)
      } ;
-- -}

{- 132451 rules, 5071 msec, vs. 1383, 78 msec in the previous
    QuestSlash ip cls = {
      s = \\q,t,p => (ip.s ++ cls.s ! ClInv ! t ! p ++ cls.c) 
                   | (cls.c ++ ip.s ++ cls.s ! ClInv ! t ! p)
      } ;
-}

    QuestIAdv iadv cl = {s = \\q,t,p => 
      iadv.s ++ 
      case q of {
        QDir   => cl.s ! ClInv ! t ! p ;
        QIndir => cl.s ! ClDir ! t ! p
        }
      } ;

    SubjCl cl subj s = {
      s = \\d,t,b => cl.s ! d ! t ! b ++ subj.s ++ s.s
      } ;

    CompAdv adv = {
      verb = copula ; 
      compl = adv.s
      } ;

    PrepNP prep np = {
      s = prep.s ++ np.s ! Acc
      } ;

    ComplVS v s = {
      verb = agrV v ;
      compl = "that" ++ s.s
      } ;

    ComplVQ v q = {
      verb = agrV v ;
      compl = q.s ! QIndir
      } ;

    ComplVV v vp = {
      verb = v.s ;
      compl = case v.isAux of {
        True => infVP vp ;
        False => "to" ++ infVP vp
        }
      } ;

    SlashV2 np v2 = {
      s = \\d,t,b => 
        let 
          vps = (agrV v2).s ! d ! t ! b ! np.a 
        in case d of {
          ClDir => np.s ! Nom ++ vps.fin ++ vps.inf ;
          ClInv => vps.fin ++ np.s ! Nom ++ vps.inf
          } ;
      c = v2.c
      } ;

    SlashPrep cl prep = {
      s = \\d,t,b => cl.s ! d ! t ! b ;
      c = prep.s
      } ;

    AdvVP vp adv = {
      verb = vp.verb ;
      compl = vp.compl ++ adv.s
      } ;

    UsePN pn = {
      s = \\_ => pn.s ;
      a = Ag Sg Per3
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    who_IP  = ss "who" ;
    here_Adv = ss "here" ;
    by_Prep = ss "by" ;
    in_Prep = ss "in" ;
    of_Prep = ss "of" ;
    with_Prep = ss "with" ;

    can_VV  = {s = agrAux "can"  "could" "been able to" "be able to" ; isAux = True} ;
    must_VV = {s = agrAux "must" "must"  "had to" "have to" ; isAux = True} ;
    want_VV = {s = agrV (regVerb "want") ; isAux = False} ;

    although_Subj = ss "although" ;
    because_Subj = ss "because" ;
    when_Subj = ss "when" ;

    when_IAdv = ss "when" ;
    where_IAdv = ss "where" ;
    why_IAdv = ss "why" ;

}
