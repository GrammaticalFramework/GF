concrete VerbJpn of Verb = CatJpn ** open ResJpn, Prelude in {
  
  flags coding = utf8 ;
  
  lin
  
    UseV v = {
      verb = \\sp,a,st,t,p => v.s ! st ! t ! p ;
      te = \\sp,a,st => v.te ;
      a_stem = \\sp,a,st => v.a_stem ;
      i_stem = \\sp,a,st => v.i_stem ;
      ba = \\sp,a,st => v.ba ;
      prep = [] ;
      obj = \\st => [] ; 
      prepositive = \\st => [] ;
      needSubject = v.needSubject
      } ;
      
    ComplVV v vp = case v.sense of {
      Abil => {
        verb = \\sp,a,st,t,p => vp.verb ! sp ! a ! Plain ! TPres ! ResJpn.Pos ++ 
                             "ことが" ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,a,st,p => vp.verb ! sp ! a ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                            v.te ! sp ! p ;  
        a_stem = \\sp,a,st => vp.verb ! sp ! a ! Plain ! TPres ! ResJpn.Pos ++ 
                              "ことが" ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vp.verb ! sp ! a ! Plain ! TPres ! ResJpn.Pos ++ 
                              "ことが" ++ v.i_stem ! sp ;
        ba = \\sp,a,st,p => vp.verb ! sp ! a ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                            v.ba ! sp ! p ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        needSubject = True
        } ;
      Oblig => {
        verb = \\sp,a,st,t => table {
          Pos => vp.a_stem ! sp ! a ! st ++ "なければ" ++ v.s ! sp ! st ! t ! Neg ;
          Neg => vp.te ! sp ! a ! st ! Pos ++ "は" ++ v.s ! sp ! st ! t ! Neg
          } ;
        te = \\sp,a,st => table {
          Pos => vp.a_stem ! sp ! a ! st ++ "なければ" ++ v.te ! sp ! Pos ;
          Neg => vp.te ! sp ! a ! st ! Pos ++ "は" ++ v.te ! sp ! Pos 
          } ;
        a_stem = \\sp,a,st => vp.a_stem ! sp ! a ! st ++ "なければ" ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vp.a_stem ! sp ! a ! st ++ "なければ" ++ v.i_stem ! sp ;
        ba = \\sp,a,st => table {
          Pos => vp.a_stem ! sp ! a ! st ++ "なければ" ++ v.ba ! sp ! Pos ;
          Neg => vp.te ! sp ! a ! st ! Pos ++ "は" ++ v.ba ! sp ! Pos 
          } ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        needSubject = True
        } ;
      Wish => {
        verb = \\sp,a,st,t,p => vp.i_stem ! sp ! a ! st ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,a,st,p => vp.i_stem ! sp ! a ! st ++ v.te ! sp ! p ;
        a_stem = \\sp,a,st => vp.i_stem ! sp ! a ! st ++ v.a_stem ! sp ;
        i_stem = \\sp,a,st => vp.i_stem ! sp ! a ! st ++ v.i_stem ! sp ;
        ba = \\sp,a,st,p => vp.i_stem ! sp ! a ! st ++ v.ba ! sp ! p ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        needSubject = True
        } 
      } ; 
    
    ComplVS vs sent = {
      verb = \\sp,a,st,t,p => vs.s ! st ! t ! p ;
      te = \\sp,a,st => vs.te ;
      a_stem = \\sp,a,st => vs.a_stem ;
      i_stem = \\sp,a,st => vs.i_stem ;
      ba = \\sp,a,st => vs.ba ;
      prep = vs.prep ;
      obj = \\st => sent.subj ! Ga ! st ++ sent.pred ! Plain ;
      prepositive = \\st => [] ;
      needSubject = True
      } ;
      
    ComplVQ vq qs = {
      verb = \\sp,a,st,t,p => vq.s ! st ! t ! p ;
      te = \\sp,a,st => vq.te ;
      a_stem = \\sp,a,st => vq.a_stem ;
      i_stem = \\sp,a,st => vq.i_stem ;
      ba = \\sp,a,st => vq.ba ;
      prep = "" ;
      obj = \\st => qs.s_plain_pred ! Ga ! st ;
      prepositive = \\st => [] ;
      needSubject = True
      } ;
      
    ComplVA va ap = {
      verb = \\sp,a,st,t,p => va.s ! st ! t ! p ;
      te = \\sp,a,st => va.te ;
      a_stem = \\sp,a,st => va.a_stem ;
      i_stem = \\sp,a,st => va.i_stem ;
      ba = \\sp,a,st => va.ba ;
      prep = [] ;
      obj = \\st => ap.adv ! st ;
      prepositive = ap.prepositive ;
      needSubject = True
      } ;

    SlashV2a v2 = {
      s = \\sp,st,t,p => v2.s ! st ! t ! p ;
      a_stem = \\sp => v2.a_stem ;
      i_stem = \\sp => v2.i_stem ;
      ba = \\sp => v2.ba ;
      prep = v2.prep ;
      obj = \\st => [] ;
      prepositive = \\st => [] ;
      te = \\sp => v2.te ;
      v2vType = False
      } ;
      
    Slash2V3 v3 np = {
        s = \\sp,st,t,p => v3.s ! np.meaning ! st ! t ! p ;
        a_stem = \\sp => v3.a_stem ! np.meaning ;
        i_stem = \\sp => v3.i_stem ! np.meaning ;
        ba = \\sp,p => v3.ba ! np.meaning ! p ;
        prep = v3.prep2 ;
        obj = \\st => np.s ! st ++ v3.prep1 ;
        prepositive = np.prepositive ;
        te = \\sp,p => v3.te ! np.meaning ! p ;
        v2vType = False
      } ;
      
    Slash3V3 = Slash2V3 ;
    
    SlashV2V v2v vp = {
      s = \\sp,st,t,p => vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! ResJpn.Pos ++ "ように" 
                         ++ v2v.s ! st ! t ! p ;
      a_stem = \\sp => vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! ResJpn.Pos ++ 
                       "ように" ++ v2v.a_stem ;
      i_stem = \\sp => vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! ResJpn.Pos ++ 
                       "ように" ++ v2v.i_stem ;
      ba = \\sp,p => vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ 
                     v2v.ba ! p ;
      prep = "に" ;
      obj = \\st => vp.obj ! st ++ vp.prep ;
      te = \\sp,p => vp.verb ! SomeoneElse ! Anim ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ 
                     v2v.te ! p ; 
      prepositive = vp.prepositive ;
      v2vType = True
      } ;
      
    SlashV2S v2s s = {
      s = \\sp,st,t,p => v2s.s ! st ! t ! p ;
      a_stem = \\sp => v2s.a_stem ;
      i_stem = \\sp => v2s.i_stem ;
      ba = \\sp => v2s.ba ;
      prep = "に" ;
      obj = \\st => s.subj ! Ga ! st ++ s.pred ! Plain ++ "と" ;
      prepositive = \\st => [] ;
      te = \\sp => v2s.te ; 
      v2vType = False
      } ;
      
    SlashV2Q v2q qs = {
      s = \\sp,st,t,p => v2q.s ! st ! t ! p ;
      a_stem = \\sp => v2q.a_stem ;
      i_stem = \\sp => v2q.i_stem ;
      ba = \\sp => v2q.ba ;
      prep = "に" ;
      obj = \\st => qs.s_plain_pred ! Ga ! st ;
      prepositive = \\st => [] ;
      te = \\sp => v2q.te ; 
      v2vType = True
      } ;
      
    SlashV2A v2a ap = {
      s = \\sp,st,t,p => v2a.s ! st ! t ! p ;
      a_stem = \\sp => v2a.a_stem ;
      i_stem = \\sp => v2a.i_stem ;
      ba = \\sp => v2a.ba ;
      prep = "を" ;
      obj = ap.adv ;
      prepositive = ap.prepositive ;
      te = \\sp => v2a.te ; 
      v2vType = True
      } ;
    
    ComplSlash vpslash np = {
      verb = \\sp,a,st,t,p => case np.changePolar of {
        True => vpslash.s ! sp ! st ! t ! Neg ;
        False => vpslash.s ! sp ! st ! t ! p 
        } ;
      a_stem = \\sp,a,st => vpslash.a_stem ! sp ;
      i_stem = \\sp,a,st => vpslash.i_stem ! sp ;
      ba = \\sp,a,st,p => vpslash.ba ! sp ! p ;
      prep = case np.needPart of {
        True => case vpslash.v2vType of {
          True => [] ;
          False => vpslash.prep 
          } ;
        False => [] 
        } ;
      obj = \\st => case vpslash.v2vType of {
        True => np.s ! st ++ vpslash.prep ++ vpslash.obj ! st ;
        False => vpslash.obj ! st ++ np.s ! st 
        } ;
      te = \\sp,a,st,p => vpslash.te ! sp ! p ;
      prepositive = \\st => np.prepositive ! st ++ vpslash.prepositive ! st ;
      needSubject = True
      } ;
      
    SlashVV v vpslash = case v.sense of {
      Abil => {
        s = \\sp,st,t,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ 
                           "ことが" ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                       v.te ! sp ! p ;  
        a_stem = \\sp => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                         v.a_stem ! sp ;
        i_stem = \\sp => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                         v.i_stem ! sp ;
        ba = \\sp,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ことが" ++ 
                       v.ba ! sp ! p ;
        prep = vpslash.prep ;
        obj = vpslash.obj ;
        prepositive = vpslash.prepositive ;
        v2vType = False
        } ;
      Oblig => {
        s = \\sp,st,t => table {
          Pos => vpslash.a_stem ! sp ++ "なければ" ++ v.s ! sp ! st ! t ! Neg ;
          Neg => vpslash.te ! sp ! Pos ++ "は" ++ v.s ! sp ! st ! t ! Neg 
          } ;
        te = \\sp => table {
          Pos => vpslash.a_stem ! sp ++ "なければ" ++ v.te ! sp ! Pos ;
          Neg => vpslash.te ! sp ! Pos ++ "は" ++ v.te ! sp ! Pos
          } ;
        a_stem = \\sp => vpslash.a_stem ! sp ++ "なければ" ++ v.a_stem ! sp ;
        i_stem = \\sp => vpslash.a_stem ! sp ++ "なければ" ++ v.i_stem ! sp ;
        ba = \\sp => table {
          Pos => vpslash.a_stem ! sp ++ "なければ" ++ v.ba ! sp ! Pos ;
          Neg => vpslash.te ! sp ! Pos ++ "は" ++ v.ba ! sp ! Pos
          } ;
        prep = vpslash.prep ;
        obj = vpslash.obj ;
        prepositive = vpslash.prepositive ;
        v2vType = False
        } ;
      Wish => {
        s = \\sp,st,t,p => vpslash.i_stem ! sp ++ v.s ! sp ! st ! t ! p ;
        te = \\sp,p => vpslash.i_stem ! sp ++ v.te ! sp ! p ;
        a_stem = \\sp => vpslash.i_stem ! sp ++ v.a_stem ! sp ;
        i_stem = \\sp => vpslash.i_stem ! sp ++ v.i_stem ! sp ;
        ba = \\sp,p => vpslash.i_stem ! sp ++ v.ba ! sp ! p ;
        prep = vpslash.prep ;
        obj = vpslash.obj ;
        prepositive = vpslash.prepositive ;
        v2vType = False
        } 
      } ; 

    SlashV2VNP v2v np vpslash = {
      s = \\sp,st,t,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ように" 
                         ++ v2v.s ! st ! t ! p ;
      a_stem = \\sp => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ v2v.a_stem ;
      i_stem = \\sp => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ v2v.i_stem ;
      ba = \\sp,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ v2v.ba ! p ;
      prep = vpslash.prep ;
      obj = \\st => np.s ! st ++ "に" ++ vpslash.obj ! st ;
      te = \\sp,p => vpslash.s ! sp ! Plain ! TPres ! ResJpn.Pos ++ "ように" ++ v2v.te ! p ; 
      prepositive = \\st => np.prepositive ! st ++ vpslash.prepositive ! st ;
      v2vType = True
      } ;

    ReflVP vpslash = {
      verb = \\sp,a,st,t,p => vpslash.s ! sp ! st ! t ! p ;
      a_stem = \\sp,a,st => vpslash.a_stem ! sp ;
      i_stem = \\sp,a,st => vpslash.i_stem ! sp ;
      ba = \\sp,a,st,p => vpslash.ba ! sp ! p ;
      prep = vpslash.prep ;
      obj = \\st => vpslash.obj ! st ++ "自分" ;  -- "jibun"
      te = \\sp,a,st,p => vpslash.te ! sp ! p ;
      prepositive = vpslash.prepositive ;
      needSubject = True
      } ;

    UseComp comp = {
      verb = \\sp,a,st,t,p => comp.verb ! a ! st ! t ! p; 
      te = \\sp => comp.te ;
      a_stem = \\sp,a,st => comp.a_stem ! a ! st ;
      i_stem = \\sp,a,st => comp.i_stem ! a ! st ;
      ba = \\sp => comp.ba ;
      prep = [] ;
      obj = comp.obj ; 
      prepositive = comp.prepositive ;
      needSubject = comp.needSubject
      } ;
    
    PassV2 v2 = {
      verb = \\sp,a,st,t,p => v2.pass ! st ! t ! p ; 
      te = \\sp,a,st => v2.pass_te ;
      a_stem = \\sp,a,st => v2.pass_a_stem ;
      i_stem = \\sp,a,st => v2.pass_i_stem ;
      ba = \\sp,a,st => v2.pass_ba ;
      prep = [] ;
      obj = \\st => [] ;
      prepositive = \\st => [] ;
      needSubject = True
      } ;
    
    AdvVP vp adv = {
      verb = vp.verb ;
      te = vp.te ;
      a_stem = vp.a_stem ;
      i_stem = vp.i_stem ;
      ba = vp.ba ;
      prep = vp.prep ;
      obj = \\st => case adv.prepositive of {
        True => vp.obj ! st ;
        False => adv.s ! st ++ vp.obj ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => vp.prepositive ! st ++ adv.s ! st ; 
        False => vp.prepositive ! st
        } ;
      needSubject = vp.needSubject
      } ;
    
    AdVVP adv vp = {
      verb = vp.verb ;
      te = vp.te ;
      a_stem = vp.a_stem ;
      i_stem = vp.i_stem ;
      ba = vp.ba ;
      prep = vp.prep ;
      obj = \\st => adv.s ++ vp.obj ! st ;
      prepositive = vp.prepositive ;
      needSubject = vp.needSubject
      } ;
    
    AdvVPSlash vpslash adv = {
      s = vpslash.s ;
      te = vpslash.te ;
      a_stem = vpslash.a_stem ;
      i_stem = vpslash.i_stem ;
      ba = vpslash.ba ;
      prep = vpslash.prep ;
      obj = \\st => case adv.prepositive of {
        True => vpslash.obj ! st ;
        False => adv.s ! st ++ vpslash.obj ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => vpslash.prepositive ! st ++ adv.s ! st ; 
        False => vpslash.prepositive ! st
        } ;
      v2vType = False
      } ;
      
    AdVVPSlash adv vpslash = {
      s = vpslash.s ;
      te = vpslash.te ;
      a_stem = vpslash.a_stem ;
      i_stem = vpslash.i_stem ;
      ba = vpslash.ba ;
      prep = vpslash.prep ;
      obj = \\st => adv.s ++ vpslash.obj ! st ;
      prepositive = vpslash.prepositive ; 
      v2vType = False
      } ;
      
    CompAP ap = {
      verb = \\a,st,t,p => ap.pred ! st ! t ! p ; 
      te = \\a => ap.te ;
      a_stem = \\a,st => ap.attr ! st ++ "では" ;
      i_stem = \\a,st => ap.adv ! st ++ "なり" ;
      ba = \\a => ap.ba ;
      obj = \\st => [] ; 
      prepositive = ap.prepositive ;
      needSubject = ap.needSubject
      } ;
      
    CompNP np = {
      verb = \\a,st,t,p => mkCopula.s ! st ! t ! p ;
      te = \\a,st => mkCopula.te ;
      ba = \\a,st => mkCopula.ba ;
      a_stem = \\a,st => "では" ;
      i_stem = \\a,st => "になり" ;  -- "become" - for wishes
      obj = \\st => np.s ! st ;
      prepositive = np.prepositive ;
      needSubject = True
      } ;
    
    CompAdv adv = {
      verb = mkExistV.verb ! SomeoneElse ;
      te = mkExistV.te ! SomeoneElse ;
      ba = mkExistV.ba ! SomeoneElse ;
      a_stem = mkExistV.a_stem ! SomeoneElse ;
      i_stem = mkExistV.i_stem ! SomeoneElse ;
      obj = \\st => case adv.prepositive of {
        True => [] ;
        False => adv.s ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ; 
        False => []
        } ;
      needSubject = True
      } ;
    
    CompCN cn = {
      verb = \\a => mkCopula.s ;
      te = \\a,st => mkCopula.te ;
      ba = \\a,st => mkCopula.ba ;
      a_stem = \\a,st => "では" ;
      i_stem = \\a,st => "になり" ;  -- "become" - for wishes
      obj = \\st => cn.s ! Sg ! st ;
      prepositive = cn.prepositive ;
      needSubject = True
      } ;
      
    UseCopula = {
      verb = \\sp,a => mkCopula.s ; 
      te = \\sp,a,st => mkCopula.te ;
      ba = \\sp,a,st => mkCopula.ba ;
      a_stem = \\sp,a,st => "では" ;
      i_stem = \\sp,a,st => "なり" ;  -- "become" - for wishes
      obj = \\st => [] ;
      prepositive = \\st => [] ; 
      prep = [] ;
      needSubject = True
      } ;
  }

