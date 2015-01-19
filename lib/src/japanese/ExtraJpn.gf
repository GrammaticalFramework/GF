concrete ExtraJpn of ExtraJpnAbs = CatJpn ** open ResJpn, Prelude, ParadigmsJpn in {

flags coding = utf8 ;

  lincat
    Level = {s : Str ; l : Style} ;
    Part = {s : Str ; p : Particle} ;

    VPS = {verb, a_stem, i_stem, te, ba : Speaker => Animateness => Style => Str ; 
           prep : Str ; obj, prepositive : Style => Str} ;

    [VPS] = {verbAnd, verbOr, verbIf, a_stemAnd, a_stemOr, a_stemIf, 
             i_stemAnd, i_stemOr, i_stemIf, teAnd, teOr, teIf,
             baAnd, baOr, baIf : Speaker => Animateness => Style => Str ; 
             prep : Str ; obj, prepositive : Style => Str} ;

    VPI = {verb : Speaker => Animateness => Str ;
           te, ba : Speaker => Animateness => Style => Polarity => Str ;
           a_stem, i_stem : Speaker => Animateness => Style => Str ;
           prep : Str ; obj, prepositive : Style => Str} ;

    [VPI] = {verbAnd, verbOr : Speaker => Animateness => Str ;
             a_stemAnd, a_stemOr, i_stemAnd, i_stemOr : Speaker => Animateness => Style => Str ; 
             teAnd, teOr, baAnd, baOr : Speaker => Animateness => Style => Polarity => Str ; 
             prep : Str ; obj, prepositive : Style => Str} ;

    Foc = {s : Particle => Style => TTense => Polarity => Str ; changePolar : Bool} ;

  lin
    Honorific = {s = [] ; l = Resp} ;
    Informal  = {s = [] ; l = Plain} ;
    
    PartWA = {s = [] ; p = Wa} ;
    PartGA = {s = [] ; p = Ga} ;
    
    StylePartPhr level part pconj utt voc = {
      s = case voc.type of {
        Please => case utt.type of {
          ImpPolite => level.s ++ part.s ++ pconj.s ++ utt.s ! part.p ! Resp ++ voc.null ;
          (Imper|NoImp) => level.s ++ part.s ++ pconj.s ++ utt.s ! part.p ! Resp ++ voc.s ! Resp
          } ;
        VocPres => case utt.type of {
          (Imper|ImpPolite) => level.s ++ part.s ++ voc.s ! Plain ++ "," ++ pconj.s ++ 
                               utt.s ! part.p ! Plain ;
          NoImp => level.s ++ part.s ++ voc.s ! level.l ++ "," ++ pconj.s ++ 
                   utt.s ! part.p ! level.l
          } ;
        VocAbs => case utt.type of {
          (Imper|ImpPolite) => level.s ++ part.s ++ voc.s ! Plain ++ pconj.s ++ 
                               utt.s ! part.p ! Plain ;
          NoImp => level.s ++ part.s ++ voc.s ! level.l ++ pconj.s ++ utt.s ! part.p ! level.l
          }
        } 
      } ;

    GenNP np = {
      s,sp = \\st => np.prepositive ! st ++ np.s ! st ++ "の" ;
      no = False
      } ;

    GenIP ip = {s = ip.s_obj ! Resp ++ "の"} ;

    GenRP num cn = {
      s = \\st => num.s ++ cn.s ! num.n ! st ;
      null = False
      } ;

    CompBareCN cn = {
      verb = \\a => mkCopula.s ;
      te = \\a,st => mkCopula.te ;
      ba = \\a,st => mkCopula.ba ;
      a_stem = \\a,st => "では" ;
      i_stem = \\a,st => "になり" ;  -- "become" - for wishes
      obj = \\st => cn.s ! Sg ! st ;
      prepositive = cn.prepositive ;
      needSubject = True
      } ;

    StrandRelSlash rp clslash = {
      s = \\_,st,t,p => case rp.null of {
        True => rp.s ! st ++ clslash.s ! st ! t ! p ;
        False => clslash.subj ! Ga ! st ++ rp.s ! st ++ clslash.pred ! Plain ! t ! p 
        } ;
      te = \\_,st,p => case rp.null of {
        True => rp.s ! st ++ clslash.te ! st ! p ;
        False => clslash.subj ! Ga ! st ++ rp.s ! st ++ clslash.pred_te ! st ! p 
        } ;
      changePolar = clslash.changePolar ;
      subj = \\part,st => rp.s ! st ++ clslash.subj ! part ! st ;
      pred = \\_,st,t,p => clslash.pred ! st ! t ! p ;
      pred_te = \\a => clslash.pred_te ;
      pred_ba = \\a => clslash.pred_ba ;
      missingSubj = False
      } ;

    EmptyRelSlash clslash = {
      s = \\_,st,t,p => clslash.s ! st ! t ! p ;
      te = \\_,st,p => clslash.te ! st ! p ;
      changePolar = clslash.changePolar ;
      subj = \\part,st => clslash.subj ! part ! st ;
      pred = \\_,st,t,p => clslash.pred ! st ! t ! p ;
      pred_te = \\a => clslash.pred_te ;
      pred_ba = \\a => clslash.pred_ba ;
      missingSubj = False
      } ;

    MkVPI vp = {
      verb = \\sp,a => vp.verb ! sp ! a ! Plain ! TPres ! Pos ;
      a_stem = vp.a_stem ;
      i_stem = vp.i_stem ;
      te = vp.te ;
      ba = vp.ba ;
      prep = vp.prep ;
      obj = vp.obj ;
      prepositive = vp.prepositive
      } ;

    ComplVPIVV v vpi = case v.sense of {
      Abil => {
        verb = \\sp,a,st,t,p => vpi.verb ! sp ! a ++ "ことが" ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,a,st,p => vpi.verb ! sp ! a ++ "ことが" ++ v.te ! sp ! p ;  
        a_stem = \\sp,a,st => vpi.verb ! sp ! a ++ "ことが" ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vpi.verb ! sp ! a ++ "ことが" ++ v.i_stem ! sp ;
        ba = \\sp,a,st,p => vpi.verb ! sp ! a ++ "ことが" ++ v.ba ! sp ! p ;
        prep = "" ;
        obj = \\st => "" ;
        prepositive = \\st => "" ;
        needSubject = True
        } ;
      Oblig => {
        verb = \\sp,a,st,t => table {
          Pos => vpi.a_stem ! sp ! a ! st ++ "なければ" ++ v.s ! sp ! st ! t ! Neg ;
          Neg => vpi.te ! sp ! a ! st ! Pos ++ "は" ++ v.s ! sp ! st ! t ! Neg
          } ;
        te = \\sp,a,st => table {
          Pos => vpi.a_stem ! sp ! a ! st ++ "なければ" ++ v.te ! sp ! Pos ;
          Neg => vpi.te ! sp ! a ! st ! Pos ++ "は" ++ v.te ! sp ! Pos 
          } ;
        a_stem = \\sp,a,st => vpi.a_stem ! sp ! a ! st ++ "なければ" ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vpi.a_stem ! sp ! a ! st ++ "なければ" ++ v.i_stem ! sp ;
        ba = \\sp,a,st => table {
          Pos => vpi.a_stem ! sp ! a ! st ++ "なければ" ++ v.ba ! sp ! Pos ;
          Neg => vpi.te ! sp ! a ! st ! Pos ++ "は" ++ v.ba ! sp ! Pos 
          } ;
        prep = "" ;
        obj = \\st => "" ;
        prepositive = \\st => "" ;
        needSubject = True
        } ;
      Wish => {
        verb = \\sp,a,st,t,p => vpi.i_stem ! sp ! a ! st ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,a,st,p => vpi.i_stem ! sp ! a ! st ++ v.te ! sp ! p ;
        a_stem = \\sp,a,st => vpi.i_stem ! sp ! a ! st ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vpi.i_stem ! sp ! a ! st ++ v.i_stem ! sp ;
        ba = \\sp,a,st,p => vpi.i_stem ! sp ! a ! st ++ v.ba ! sp ! p ;
        prep = "" ;
        obj = \\st => "" ;
        prepositive = \\st => "" ;
        needSubject = True
        } 
      } ; 

    MkVPS t p vp = {
      verb = \\sp,a,st => case t.a of {
        Simul => vp.verb ! sp ! a ! st ! t.t ! p.b ;
        Anter => case t.t of {
          TFut => vp.verb ! sp ! a ! st ! TPres ! p.b ;
          _    => vp.verb ! sp ! a ! st ! TPast ! p.b 
          }
        } ;
      a_stem = vp.a_stem ;
      i_stem = vp.i_stem ;
      te = \\sp,a,st =>  vp.te ! sp ! a ! st ! p.b ;
      ba = \\sp,a,st =>  vp.ba ! sp ! a ! st ! p.b ;
      prep = vp.prep ;
      obj = vp.obj ;
      prepositive = vp.prepositive
      } ;

    ConjVPI conj vpi = case conj.type of {
      (And | Both | IfConj) => {  -- "if" is hardly possible    
        verb = \\sp,a => conj.null ++ vpi.verbAnd ! sp ! a ;
        a_stem = \\sp,a,st => conj.null ++ vpi.a_stemAnd ! sp ! a ! st ;
        i_stem = \\sp,a,st => conj.null ++ vpi.i_stemAnd ! sp ! a ! st ;
        te = \\sp,a,st,p => conj.null ++ vpi.teAnd ! sp ! a ! st ! p ;
        ba = \\sp,a,st,p => conj.null ++ vpi.baAnd ! sp ! a ! st ! p ;
        prep = vpi.prep ; 
        obj = vpi.obj ;
        prepositive = vpi.prepositive
        } ;
      Or => {    
        verb = \\sp,a => conj.null ++ vpi.verbOr ! sp ! a ;
        a_stem = \\sp,a,st => conj.null ++ vpi.a_stemOr ! sp ! a ! st ;
        i_stem = \\sp,a,st => conj.null ++ vpi.i_stemOr ! sp ! a ! st ;
        te = \\sp,a,st,p => conj.null ++ vpi.teOr ! sp ! a ! st ! p ;
        ba = \\sp,a,st,p => conj.null ++ vpi.baOr ! sp ! a ! st ! p ;
        prep = vpi.prep ; 
        obj = vpi.obj ;
        prepositive = vpi.prepositive
        } 
      } ;

    ConjVPS conj vps = case conj.type of {
      (And | Both) => {    
        verb = \\sp,a,st => conj.null ++ vps.verbAnd ! sp ! a ! st ;
        a_stem = \\sp,a,st => conj.null ++ vps.a_stemAnd ! sp ! a ! st ;
        i_stem = \\sp,a,st => conj.null ++ vps.i_stemAnd ! sp ! a ! st ;
        te = \\sp,a,st => conj.null ++ vps.teAnd ! sp ! a ! st ;
        ba = \\sp,a,st => conj.null ++ vps.baAnd ! sp ! a ! st ;
        prep = vps.prep ; 
        obj = vps.obj ;
        prepositive = vps.prepositive
        } ;
      Or => {    
        verb = \\sp,a,st => conj.null ++ vps.verbOr ! sp ! a ! st ;
        a_stem = \\sp,a,st => conj.null ++ vps.a_stemOr ! sp ! a ! st ;
        i_stem = \\sp,a,st => conj.null ++ vps.i_stemOr ! sp ! a ! st ;
        te = \\sp,a,st => conj.null ++ vps.teOr ! sp ! a ! st ;
        ba = \\sp,a,st => conj.null ++ vps.baOr ! sp ! a ! st ;
        prep = vps.prep ; 
        obj = vps.obj ;
        prepositive = vps.prepositive
        } ;
      IfConj => {
        verb = \\sp,a,st => conj.null ++ vps.verbIf ! sp ! a ! st ;
        a_stem = \\sp,a,st => conj.null ++ vps.a_stemIf ! sp ! a ! st ;
        i_stem = \\sp,a,st => conj.null ++ vps.i_stemIf ! sp ! a ! st ;
        te = \\sp,a,st => conj.null ++ vps.teIf ! sp ! a ! st ;
        ba = \\sp,a,st => conj.null ++ vps.baIf ! sp ! a ! st ;
        prep = vps.prep ; 
        obj = vps.obj ;
        prepositive = vps.prepositive
        } 
      } ;

    PredVPS np vps = case np.needPart of {
      True => {
        s = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "が" ++ 
                            vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st
          } ;
        te = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vps.obj ! st ++ vps.prep ++ vps.te ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vps.obj ! st ++ vps.prep ++ vps.te ! np.meaning ! np.anim ! st 
          } ; 
        ba = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "は" ++ 
                          vps.obj ! st ++ vps.prep ++ vps.ba ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "が" ++ 
                          vps.obj ! st ++ vps.prep ++ vps.ba ! np.meaning ! np.anim ! st 
          } ;
        subj = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "は" ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ "が" 
          } ;
        pred = \\st => vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st ;
        pred_te = \\st => vps.obj ! st ++ vps.prep ++ vps.te ! np.meaning ! np.anim ! st ;
        pred_ba = \\st => vps.obj ! st ++ vps.prep ++ vps.ba ! np.meaning ! np.anim ! st 
        } ;
      False => {
        s = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ 
                            vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ 
                            vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st
          } ; 
        te = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ vps.obj ! st ++ 
                          vps.prep ++ vps.te ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ vps.obj ! st ++ 
                          vps.prep ++ vps.te ! np.meaning ! np.anim ! st 
          } ;
        ba = table {
          Wa => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ vps.obj ! st ++ 
                          vps.prep ++ vps.ba ! np.meaning ! np.anim ! st ;
          Ga => \\st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ++ vps.obj ! st ++ 
                          vps.prep ++ vps.ba ! np.meaning ! np.anim ! st
          } ;
        subj = \\part,st => np.prepositive ! st ++ vps.prepositive ! st ++ np.s ! st ;
        pred = \\st => vps.obj ! st ++ vps.prep ++ vps.verb ! np.meaning ! np.anim ! st ;
        pred_te = \\st => vps.obj ! st ++ vps.prep ++ vps.te ! np.meaning ! np.anim ! st ;
        pred_ba = \\st => vps.obj ! st ++ vps.prep ++ vps.ba ! np.meaning ! np.anim ! st
        } 
      } ;

    BaseVPI x y = {
      verbAnd = \\sp,a => x.prepositive ! Resp ++ x.obj ! Resp ++ x.prep ++ x.te ! sp ! a ! Resp ! Pos ++ 
                          y.prepositive ! Resp ++ y.obj ! Resp ++ y.prep ++ y.verb ! sp ! a ;
      verbOr = \\sp,a => x.prepositive ! Resp ++ x.obj ! Resp ++ x.prep ++ x.verb ! sp ! a ++ "か" ++
                         y.prepositive ! Resp ++ y.obj ! Resp ++ y.prep ++ y.verb ! sp ! a ;
      a_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                               y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.a_stem ! sp ! a ! st ;
      a_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.a_stem ! sp ! a ! st ;      
      i_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                               y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.i_stem ! sp ! a ! st ;
      i_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.i_stem ! sp ! a ! st ;
      teAnd = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                             y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.te ! sp ! a ! st ! p ;
      teOr = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                            y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.te ! sp ! a ! st ! p ; 
      baAnd = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                             y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.ba ! sp ! a ! st ! p ;
      baOr = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                            y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.ba ! sp ! a ! st ! p ; 
      prep = "" ; 
      obj = \\st => "" ;
      prepositive = \\st => ""
    } ;

    ConsVPI x xs = {
      verbAnd = \\sp,a => x.prepositive ! Resp ++ x.obj ! Resp ++ x.prep ++ x.te ! sp ! a ! Resp ! Pos ++ 
                          xs.verbAnd ! sp ! a ;
      verbOr = \\sp,a => x.prepositive ! Resp ++ x.obj ! Resp ++ x.prep ++ x.verb ! sp ! a ++ "か" ++
                         xs.verbOr ! sp ! a ;
      a_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                               xs.a_stemAnd ! sp ! a ! st ;
      a_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                              xs.a_stemOr ! sp ! a ! st ;      
      i_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                               xs.i_stemAnd ! sp ! a ! st ;
      i_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                              xs.i_stemOr ! sp ! a ! st ;
      teAnd = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                             xs.teAnd ! sp ! a ! st ! p ;
      teOr = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                            xs.teOr ! sp ! a ! st ! p ; 
      baAnd = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ! Pos ++ 
                             xs.baAnd ! sp ! a ! st ! p ;
      baOr = \\sp,a,st,p => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ++ "か" ++ 
                            xs.baOr ! sp ! a ! st ! p ; 
      prep = "" ; 
      obj = \\st => "" ;
      prepositive = \\st => ""
    } ;

    BaseVPS x y = {
      verbAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                             y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.verb ! sp ! a ! st ;
      verbOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++
                            y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.verb ! sp ! a ! st ;
      verbIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                            y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.verb ! sp ! a ! st ;
      a_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                               y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.a_stem ! sp ! a ! st ;
      a_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.a_stem ! sp ! a ! st ;
      a_stemIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.a_stem ! sp ! a ! st ;
      i_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                               y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.i_stem ! sp ! a ! st ;
      i_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.i_stem ! sp ! a ! st ;
      i_stemIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++
                              y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.i_stem ! sp ! a ! st ;
      teAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                           y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.te ! sp ! a ! st ;
      teOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                          y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.te ! sp ! a ! st ;
      teIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                          y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.te ! sp ! a ! st ;
      baAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                           y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.ba ! sp ! a ! st ;
      baOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                          y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.ba ! sp ! a ! st ;
      baIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                          y.prepositive ! st ++ y.obj ! st ++ y.prep ++ y.ba ! sp ! a ! st ;
      prep = "" ; 
      obj = \\st => "" ;
      prepositive = \\st => ""
    } ;

    ConsVPS x xs = {
      verbAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                             xs.verbAnd ! sp ! a ! st ;
      verbOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++
                            xs.verbOr ! sp ! a ! st ;
      verbIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                            xs.verbIf ! sp ! a ! st ;
      a_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                               xs.a_stemAnd ! sp ! a ! st ;
      a_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                              xs.a_stemOr ! sp ! a ! st ;
      a_stemIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++
                              xs.a_stemIf ! sp ! a ! st ;
      i_stemAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                               xs.i_stemAnd ! sp ! a ! st ;
      i_stemOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                              xs.i_stemOr ! sp ! a ! st ;
      i_stemIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++
                              xs.i_stemIf ! sp ! a ! st ;
      teAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                           xs.teAnd ! sp ! a ! st ;
      teOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                          xs.teOr ! sp ! a ! st ;
      teIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                          xs.teIf ! sp ! a ! st ;
      baAnd = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.te ! sp ! a ! st ++ 
                           xs.baAnd ! sp ! a ! st ;
      baOr = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.verb ! sp ! a ! st ++ "か" ++ 
                          xs.baOr ! sp ! a ! st ;
      baIf = \\sp,a,st => x.prepositive ! st ++ x.obj ! st ++ x.prep ++ x.ba ! sp ! a ! st ++ "、" ++ 
                          xs.baIf ! sp ! a ! st ;
      prep = "" ; 
      obj = \\st => "" ;
      prepositive = \\st => ""
    } ;

    ICompAP ap = {
      s = \\st => ap.prepositive ! st ++ "どのくらい" ++ ap.dropNaEnging ! st ;
      wh8re = False
      } ;

    IAdvAdv adv = {
      s = \\st => "どの" ++ adv.s ! st ; 
      particle = "" ;
      wh8re = False
      } ;

    CompIQuant iquant = {
      s = \\st => iquant.s ; 
      wh8re = False
      } ;

    PrepCN prep cn = {
      s = \\st => cn.prepositive ! st ++ cn.object ! st ++ cn.s ! Sg ! st ++ prep.s ;
      prepositive = False
      } ;

    FocObj np clslash = {
      s = \\part,st,t,p => clslash.subj ! part ! st ++ np.prepositive ! st ++ 
                           np.s ! st ++ "を" ++ clslash.pred ! st ! t ! p ;
      changePolar = np.changePolar   
      } ; 

    FocAdv adv cl = {
      s = \\part,st,t,p => adv.s ! st ++ cl.s ! part ! st ! t ! p ;
      changePolar = cl.changePolar   
      } ; 

    FocAdV adV cl = {
      s = \\part,st,t,p => adV.s ++ cl.s ! part ! st ! t ! p ;
      changePolar = cl.changePolar   
      } ; 

    FocAP ap np = {  -- no focal constructions in Jpn
      s = case np.needPart of {
        True => table {
          Wa => \\st,t,p => np.prepositive ! st ++ ap.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            ap.pred ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ ap.prepositive ! st ++ np.s ! st ++ "が" ++ 
                            ap.pred ! st ! t ! p
          } ;
        False => table {
          Wa => \\st,t,p => np.prepositive ! st ++ ap.prepositive ! st ++ np.s ! st ++ 
                            ap.pred ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ ap.prepositive ! st ++ np.s ! st ++ 
                            ap.pred ! st ! t ! p
          } 
        } ;   
      changePolar = np.changePolar 
      } ;

    FocNeg cl = {
      s = \\part,st,t,p => cl.s ! part ! st ! t ! p ;
      changePolar = True   
      } ;       

    FocVP vp np = {
      s = case np.needPart of {
        True => table {
          Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p
          } ;
        False => table {
          Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p ;
          Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                            vp.obj ! st ++ vp.prep ++ vp.verb ! np.meaning ! np.anim ! st ! t ! p
          } 
        } ;
      changePolar = np.changePolar 
      } ;

    FocVV v vp np = {   -- no focal constructions in Jpn
      s = case v.sense of {
        Abil => case np.needPart of {
          True => table {
            Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              "は" ++ vp.obj ! st ++ vp.prep ++ 
                              vp.verb ! np.meaning ! np.anim ! Plain ! TPres ! ResJpn.Pos ++ 
                              "ことが" ++ v.s ! np.meaning ! st ! t ! p ;
            Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              "が" ++ vp.obj ! st ++ vp.prep ++ 
                              vp.verb ! np.meaning ! np.anim ! Plain ! TPres ! ResJpn.Pos ++ 
                              "ことが" ++ v.s ! np.meaning ! st ! t ! p 
            } ;
          False => \\part,st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                                    vp.obj ! st ++ vp.prep ++ 
                                    vp.verb ! np.meaning ! np.anim ! Plain ! TPres ! ResJpn.Pos ++ 
                                    "ことが" ++ v.s ! np.meaning ! st ! t ! p 
          } ;
        Oblig => case np.needPart of {
          True => table {
            Wa => \\st,t => table {
              Pos => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                     vp.obj ! st ++ vp.prep ++ vp.a_stem ! np.meaning ! np.anim ! st ++ 
                     "なければ" ++ v.s ! np.meaning ! st ! t ! Neg ;
              Neg => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "は" ++ 
                     vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! Pos ++ 
                     "は" ++ v.s ! np.meaning ! st ! t ! Neg 
              } ;
            Ga => \\st,t => table {
              Pos => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                     vp.obj ! st ++ vp.prep ++ vp.a_stem ! np.meaning ! np.anim ! st ++ 
                     "なければ" ++ v.s ! np.meaning ! st ! t ! Neg ;
              Neg => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ "が" ++ 
                     vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! Pos ++ 
                     "は" ++ v.s ! np.meaning ! st ! t ! Neg 
              } 
            } ;
          False => \\part,st,t => table {
              Pos => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++  
                     vp.obj ! st ++ vp.prep ++ vp.a_stem ! np.meaning ! np.anim ! st ++ 
                     "なければ" ++ v.s ! np.meaning ! st ! t ! Neg ;
              Neg => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                     vp.obj ! st ++ vp.prep ++ vp.te ! np.meaning ! np.anim ! st ! Pos ++ 
                     "は" ++ v.s ! np.meaning ! st ! t ! Neg 
              } 
          } ;
      Wish => case np.needPart of {
          True => table {
            Wa => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              "は" ++ vp.obj ! st ++ vp.prep ++ 
                              vp.i_stem ! np.meaning ! np.anim ! st ++ 
                              v.s ! np.meaning ! st ! t ! p ;
            Ga => \\st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                              "が" ++ vp.obj ! st ++ vp.prep ++ 
                              vp.i_stem ! np.meaning ! np.anim ! st ++ 
                              v.s ! np.meaning ! st ! t ! p 
            } ;
          False => \\part,st,t,p => np.prepositive ! st ++ vp.prepositive ! st ++ np.s ! st ++ 
                                    vp.obj ! st ++ vp.prep ++ vp.i_stem ! np.meaning ! np.anim ! st ++ 
                                    v.s ! np.meaning ! st ! t ! p 
          } 
        } ;
      changePolar = np.changePolar 
      } ;


    UseFoc t p foc = {
      s = \\part,st => case t.a of {
        Simul => case foc.changePolar of {
          False => t.s ++ p.s ++ foc.s ! part ! st ! t.t ! p.b ; 
          True => t.s ++ p.s ++ foc.s ! part ! st ! t.t ! Neg
          } ;
        Anter => case t.t of {
          TPres => case foc.changePolar of {
            False => t.s ++ p.s ++ foc.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ foc.s ! part ! st ! TPast ! Neg
            } ;
          TPast => case foc.changePolar of {
            False => t.s ++ p.s ++ foc.s ! part ! st ! TPast ! p.b ;
            True => t.s ++ p.s ++ foc.s ! part ! st ! TPast ! Neg
            } ;
          TFut => case foc.changePolar of {
            False => t.s ++ p.s ++ foc.s ! part ! st ! TPres ! p.b ;
            True => t.s ++ p.s ++ foc.s ! part ! st ! TPres ! Neg
            } 
          }
        } ;
      type = NoImp
      } ;
  }
