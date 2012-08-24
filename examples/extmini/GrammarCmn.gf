concrete GrammarCmn of Grammar = open ResCmn, Prelude in {
flags coding = utf8;

  lincat  
    S  = {s : Aspect => Str} ; 
    Cl = {s : Bool => Aspect => Str; 
          np: Str; 
          vp: Bool => Aspect => Str} ; 
    NP = ResCmn.NP ;  
      --  {s : Str ; n : Number} ;     
    VP = ResCmn.VP ;  
      -- { verb : Verb ; compl : Str ; prePart : Str} ;  
    AP = {s : Str; monoSyl: Bool} ;
    CN = ResCmn.Noun ;           -- {s : Str; Counter : Str} ;
    Det = {s : Str ; n : Number} ;
    N = Noun ;                   -- {s : Str; Counter : Str} ;
    A = ResCmn.Adj ;             -- {s : Str; monoSyl: Bool} ; 
    V = ResCmn.Verb;          
    -- Verb : Type = {s : Bool => Aspect => Str ; vinf : Str} ;
    V2 = ResCmn.Verb ;
    AdA = {s : Str} ; 
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str ; t : TTense} ;
    Conj = {s : SForm => Str} ;    

  lin

    UseCl t p cl = {s = \\a => cl.s ! p.b ! a } ; 
    PredVP np vp = {s = \\p,a => np.s ++ vp.prePart ++ vp.verb.s ! p ! a ++ vp.compl;
                    np = np.s;
                    vp = \\p,a => vp.verb.s ! p ! a ++ vp.compl} ;
      
    ComplV2 v2 np = {
      verb = v2 ; 
      compl = np.s ;
      prePart = []
      } ;
      
    DetCN det cn = case det.n of {
            Sg => {s = det.s ++ cn.Counter ++ cn.s ; n = Sg } ;
            Pl => {s = det.s ++ "些" ++ cn.s ; n = Pl }             
      } ;
      
    ModCN ap cn = case ap.monoSyl of {
            True => {s = ap.s ++ cn.s ; Counter = cn.Counter} ;
            False => {s = ap.s ++ "的" ++ cn.s ; Counter = cn.Counter} 
            } ;

    CompAP ap = {
      verb = copula ;
      compl = ap.s ++ "的" ;
      prePart = []
      } ;
      
    AdAP ada ap = {
      s = ada.s ++ ap.s ;
      monoSyl = False
      } ;

    ConjS  co x y = {s = \\a => x.s ! a ++ co.s ! Sent ++ y.s ! a} ;  
    ConjAP co x y = {s = x.s ++ co.s ! Phr APhrase ++ y.s;
                     monoSyl = False} ;
                     
    ConjNP co x y = {
    s = x.s ++ co.s ! Phr NPhrase ++ y.s ;
    n = Pl
    } ;


    UseN n = n ;

    UseA adj = adj ;
    
    UseV v = {
      verb = v ; 
      compl = [] ;
      prePart = [] ;
      } ; 

    
    a_Det = mkDet "一" Sg ;
    every_Det = mkDet "每" Sg ;
    the_Det = mkDet "那" Sg ;
        
    this_Det = mkDet "这" Sg ;
    these_Det = mkDet "这" Pl ;
    that_Det = mkDet "那" Sg ;
    those_Det = mkDet "那" Pl ;

    i_NP = pronNP "我" Sg ;
    youSg_NP = pronNP "你"  Sg ;
    he_NP = pronNP "他" Sg ;
    she_NP = pronNP "她" Pl ;
    we_NP = pronNP "我们" Pl ;
    youPl_NP = pronNP "你们" Pl ;
    they_NP = pronNP "他们" Pl ;

    very_AdA = ss "非常" ;    


    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    
    Pres = {s = [] ; t = TPres} ;
    Perf = {s = [] ; t = TPerf} ;
    Past = {s = [] ; t = TPast} ;
    Fut  = {s = [] ; t = TFut} ;
    
    and_Conj = {s = table {
                    Phr NPhrase => "和" ;
                    Phr APhrase => "而" ;
                    Phr VPhrase => "又" ;
                    Sent =>  []
                          }
                } ;

    or_Conj  = {s = table {
                    Phr _ => "或" ;
                    Sent => "还是"
                          }
                } ;
                
-- more

  lincat
    Utt = {s : Str} ;
    QS  = {s : Aspect => Str} ;
    QCl = {s : Bool => Aspect => Str; 
           np: Str; 
           vp: Bool => Aspect => Str} ; 
    PN = {s : Str ; n : Number } ; 
    
    ClSlash = {s : Bool => Aspect => Str ; 
               np: Str ; 
               vp: Bool => Aspect => Str ;
               prepMain : Str ; 
               prepPre : Str} ;  
    Adv = {s : Str ; prePart : Str} ; 
    Prep = {s : Str ; prePart : Str} ; 
    VS = Verb ;
    VQ = Verb ;
    VV = {s : Bool => Aspect => Str ; vinf : Str} ;  
    IP = {s : Str} ;
    Subj = {prePart : Str ;sufPart : Str} ;
    IAdv = {s : Str} ;
  
  lin    
  
    UttS s = {s = s.s ! (ResCmn.Perf | ResCmn.DurStat | 
                         ResCmn.DurProg | ResCmn.Exper) } ;

    UttQS s = {s = s.s ! (ResCmn.Perf | ResCmn.DurStat | 
                       ResCmn.DurProg | ResCmn.Exper) } ; 
  
    UseQCl t p cl = {s = \\a => cl.s ! p.b ! a} ; 
  
    QuestCl cl = {s = \\p,a => cl.s ! p ! a ++ "吗";
                  np = cl.np ;
                  vp = cl.vp } ;
  
    QuestVP ip vp = {
     s = \\p,a => ip.s ++ vp.prePart ++ vp.verb.s ! p ! a ++ vp.compl ;
     np = ip.s ;
     vp = \\p,a => vp.prePart ++ vp.verb.s ! p ! a ++ vp.compl 
      } ;
  
    QuestSlash ip cls =  {
           s =\\p,a => cls.prepPre ++ cls.np ++ cls.prepMain ++ cls.vp ! p ! a ++ "的是" ++ ip.s ;
      np = cls.np ;
      vp = cls.vp 
      } ;       
      
    QuestIAdv iadv cl = {s = \\p,a => cl.np ++ iadv.s ++ cl.vp ! p ! a ;
                         np = cl.np ;
                         vp = \\p,a => cl.vp ! p ! a
                      } ;
  
    SubjCl cl subj s = {
      s = \\p,a => subj.prePart ++ s.s ! a ++ subj.sufPart ++ cl.s ! p ! a ;
      np = subj.prePart ++ s.s ! ResCmn.Perf ++ subj.sufPart ++ cl.np ;
      vp = \\p,a => cl.vp ! p ! a } ;
  
    CompAdv adv = {
      verb = {s = table {
                    True => table { _ => "在"} ;
                    False => table { _ => "不在"}
                    } ;
              vinf = "在"
              } ; 
      compl = adv.s ;
      prePart = []
      } ;
  
    PrepNP prep np = {
      s = np.s ++ prep.s ;
      prePart = prep.prePart
      } ;   
      
    ComplVS v s = {
      verb = v ;
      compl = s.s ! ResCmn.Perf  ;
      prePart = []
      } ;
    
    ComplVQ v q = {
      verb = v ;
      compl = q.s ! ResCmn.Perf ;
      prePart = []
     } ;
      
    ComplVV v vp = {
      verb = v ;
      compl = vp.verb.vinf ++ vp.compl ;
      prePart = vp.prePart
      } ;
      
    SlashV2 np v2 = {
      s = \\p,a => np.s ++ v2.s ! p ! a ;
      np = np.s ;
      vp = \\p,a => v2.s ! p ! a ;
      prepMain = [] ;
      prepPre = []
      } ;          

    SlashPrep cl prep = {
      s = \\b, a => cl.s ! b ! a ;
      np = cl.np ;
      vp = cl.vp ;      
      prepMain = prep.s ;
      prepPre = prep.prePart 
      } ;      
      
    AdvVP vp adv = {
      verb = vp.verb ;
      compl = vp.compl ;
      prePart = adv.prePart ++ adv.s
      } ;        

    UsePN pn = {
      s = pn.s ;
      n = pn.n
      } ;
      
    AdvNP np adv = {
      s = adv.prePart ++ adv.s ++ "的" ++ np.s ;
      n = np.n
      } ;

    who_IP  = ss "谁" ;      
    here_Adv = mkAdv [] "这里" ; 
    by_Prep = mkPrep "旁边" [] ;
    in_Prep = mkPrep "里" [];
    of_Prep = mkPrep "的" [];
    with_Prep = mkPrep "一起" "和"; 
    
    can_VV  = {s = table{True => table{ _ => "能"};
                         False =>table{ _ => "不能"} } ;
               vinf = [] };
    must_VV = {s = table{True => table{ _ => "必须"};
                         False =>table{ _ => "不能"} } ;
               vinf = []};
    want_VV = {s = table{True => table{ _ => "想"};
                         False =>table{ _ => "不想"} } ;
               vinf = []};   
               
    although_Subj = mkSubj "虽然" "但";
    because_Subj = mkSubj "因为" "所以" ;
    when_Subj = mkSubj [] "的时候" ; 
    
    when_IAdv = ss "什么时候" ;
    where_IAdv = ss "在哪里" ;
    why_IAdv = ss "为什么" ;   

}
