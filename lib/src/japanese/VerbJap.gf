concrete VerbJap of Verb = CatJap ** open ResJap, Prelude in {
  
  flags coding = utf8 ;
  
  lin
  
    UseV v = {
      verb = \\a,st,t,p => v.s ! st ! t ! p ;
      te = \\a,st => v.te ;
      a_stem = \\a,st => v.a_stem ;
      i_stem = \\a,st => v.i_stem ;
      ba = \\a,st => v.ba ;
      prep = [] ;
      obj = \\st => [] ; 
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;
      
    ComplVV v vp = case v.sense of {
      Abil => {
        verb = \\a,st,t,p => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ 
                             "ことが" ++ v.s ! st ! t ! p ;
        te = \\a,st => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.te ;  
        a_stem = \\a,st => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.a_stem ;
        i_stem = \\a,st => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.i_stem ;
        ba = \\a,st => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.ba ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        compar = NoCompar
        } ;
      Oblig => {
        verb = \\a,st,t,p => vp.a_stem ! Anim ! st ++ "なければ" ++ v.s ! st ! t ! Neg ;
        te = \\a,st => vp.a_stem ! Anim ! st ++ "なければ" ++ v.te ;
        a_stem = \\a,st => vp.a_stem ! Anim ! st ++ "なければ" ++ v.a_stem ;
        i_stem = \\a,st => vp.a_stem ! Anim ! st ++ "なければ" ++ v.i_stem ;
        ba = \\a,st => vp.a_stem ! Anim ! st ++ "なければ" ++ v.ba ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        compar = NoCompar
        } ;
      Wish => {
        verb = \\a,st,t,p => vp.i_stem ! Anim ! st ++ "たがって" ++ v.s ! st ! t ! p ;
        te = \\a,st => vp.i_stem ! Anim ! st ++ "たがって" ++ v.te ;
        a_stem = \\a,st => vp.i_stem ! Anim ! st ++ "たがって" ++ v.a_stem ;
        i_stem = \\a,st => vp.i_stem ! Anim ! st ++ "たがって" ++ v.i_stem ;
        ba = \\a,st => vp.i_stem ! Anim ! st ++ "たがって" ++ v.ba ;
        prep = vp.prep ;
        obj = \\st => vp.obj ! st ;
        prepositive = vp.prepositive ;
        compar = NoCompar
        } 
      } ; 
    
    ComplVS vs sent = {
      verb = \\a,st,t,p => vs.s ! st ! t ! p ;
      te = \\a,st => vs.te ;
      a_stem = \\a,st => vs.a_stem ;
      i_stem = \\a,st => vs.i_stem ;
      ba = \\a,st => vs.ba ;
      prep = vs.prep ;
      obj = \\st => sent.s ! Ga ! Plain ;
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;
      
    ComplVQ vq qs = {
      verb = \\a,st,t,p => vq.s ! st ! t ! p ;
      te = \\a,st => vq.te ;
      a_stem = \\a,st => vq.a_stem ;
      i_stem = \\a,st => vq.i_stem ;
      ba = \\a,st => vq.ba ;
      prep = vq.prep ;
      obj = \\st => qs.s ! Ga ! Plain ++ "こと" ;
      prepositive = \\st => [] ;
      compar = NoCompar
      } ;
      
    ComplVA va ap = {
      verb = \\a,st,t,p => va.s ! st ! t ! p ;
      te = \\a,st => va.te ;
      a_stem = \\a,st => va.a_stem ;
      i_stem = \\a,st => va.i_stem ;
      ba = \\a,st => va.ba ;
      prep = [] ;
      obj = \\st => ap.adv ! st ;
      prepositive = ap.prepositive ;
      compar = NoCompar
      } ;

    SlashV2a v2 = {
      s = \\st,t,p => v2.s ! st ! t ! p ;
      a_stem = v2.a_stem ;
      i_stem = v2.i_stem ;
      ba = v2.ba ;
      prep = v2.prep ;
      obj = \\st => [] ;
      prepositive = \\st => [] ;
      te = v2.te ;
      v2vType = False ;
      compar = NoCompar
      } ;
      
    Slash2V3 v3 np = case v3.give of {
      True => {
        s = \\st,t,p => case np.Pron1Sg of {
          True => (mkVerb "呉れ" "呉れ" "呉れる" "呉れた").s ! st ! t ! p ;  -- "kureru"
          False => v3.s ! st ! t ! p 
          } ;
        a_stem = case np.Pron1Sg of {
          True => "呉れ" ;
          False => "上げ" 
          } ;
        i_stem = case np.Pron1Sg of {
          True => "呉れ" ;
          False => "上げ" 
          } ;
        ba = case np.Pron1Sg of {
          True => "呉れれば" ;
          False => "上げれば" 
          } ;
        prep = v3.prep2 ;
        obj = \\st => np.s ! st ++ v3.prep1 ;
        prepositive = np.prepositive ;
        te = case np.Pron1Sg of {
          True => "呉れて" ;
          False => "上げて" 
          } ;
        v2vType = False ;
        compar = NoCompar
        } ;
      False => {
        s = \\st,t,p => v3.s ! st ! t ! p ;
        a_stem = v3.a_stem ;
        i_stem = v3.i_stem ;
        ba = v3.ba ;
        prep = v3.prep2 ;
        obj = \\st => np.s ! st ++ v3.prep1 ;
        prepositive = np.prepositive ;
        te = v3.te ;
        v2vType = False ;
        compar = NoCompar
        }
      } ;
      
    Slash3V3 = Slash2V3 ;
    
    SlashV2V v2v vp = {
      s = \\st,t,p => vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ように" 
                      ++ v2v.s ! st ! t ! p ;
      a_stem = vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.a_stem ;
      i_stem = vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.i_stem ;
      ba = vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.ba ;
      prep = "に" ;
      obj = \\st => vp.obj ! st ++ vp.prep ;
      te = vp.verb ! Anim ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.te ; 
      prepositive = vp.prepositive ;
      v2vType = True ;
      compar = NoCompar
      } ;
      
    SlashV2S v2s s = {
      s = v2s.s ;
      a_stem = v2s.a_stem ;
      i_stem = v2s.i_stem ;
      ba = v2s.ba ;
      prep = "に" ;
      obj = \\st => s.s ! Ga ! Plain ++ "と" ;
      prepositive = \\st => [] ;
      te = v2s.te ; 
      v2vType = False ;
      compar = NoCompar
      } ;
      
    SlashV2Q v2q qs = {
      s = v2q.s ;
      a_stem = v2q.a_stem ;
      i_stem = v2q.i_stem ;
      ba = v2q.ba ;
      prep = "に" ;
      obj = \\st => qs.s ! Ga ! Plain ++ "ことを" ;
      prepositive = \\st => [] ;
      te = v2q.te ; 
      v2vType = True ;
      compar = NoCompar
      } ;
      
    SlashV2A v2a ap = {
      s = v2a.s ;
      a_stem = v2a.a_stem ;
      i_stem = v2a.i_stem ;
      ba = v2a.ba ;
      prep = "を" ;
      obj = ap.adv ;
      prepositive = ap.prepositive ;
      te = v2a.te ; 
      v2vType = True ;
      compar = NoCompar
      } ;
    
    ComplSlash vpslash np = {
      verb = \\a,st,t,p => case np.changePolar of {
        True => vpslash.s ! st ! t ! Neg ;
        False => vpslash.s ! st ! t ! p 
        } ;
      a_stem = \\a,st => vpslash.a_stem ;
      i_stem = \\a,st => vpslash.i_stem ;
      ba = \\a,st => vpslash.ba ;
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
      te = \\a,st => vpslash.te ;
      prepositive = \\st => np.prepositive ! st ++ vpslash.prepositive ! st ;
      compar = vpslash.compar
      } ;
      
    SlashVV v vpslash = {
      s = \\st,t,p => case v.sense of {
        Abil => vpslash.s ! Plain ! TPres ! ResJap.Pos ++ 
                "ことが" ++ v.s ! st ! t ! p ;
        Oblig => vpslash.a_stem ++ "なければ" ++ v.s ! st ! t ! p ;
        Wish => vpslash.i_stem ++ "たがって" ++ v.s ! st ! t ! p 
        } ;
      te = case v.sense of {
        Abil => vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.te ; 
        Oblig => vpslash.a_stem ++ "なければ" ++ v.te ;
        Wish => vpslash.i_stem ++ "たがって" ++ v.te 
        } ;
      a_stem = [] ;
      i_stem = [] ;
      ba = case v.sense of {
        Abil => vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ことが" ++ v.ba ;
        Oblig => vpslash.a_stem ++ "なければ" ++ v.ba ;
        Wish => vpslash.i_stem ++ "たがって" ++ v.ba
        } ;
      prep = vpslash.prep ;
      obj = vpslash.obj ;
      prepositive = vpslash.prepositive ;
      v2vType = False ;
      compar = vpslash.compar
      } ;

    SlashV2VNP v2v np vpslash = {
      s = \\st,t,p => vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ように" 
                      ++ v2v.s ! st ! t ! p ;
      a_stem = vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.a_stem ;
      i_stem = vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.i_stem ;
      ba = vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.ba ;
      prep = vpslash.prep ;
      obj = \\st => np.s ! st ++ "に" ;
      te = vpslash.s ! Plain ! TPres ! ResJap.Pos ++ "ように" ++ v2v.te ; 
      prepositive = vpslash.prepositive ;
      v2vType = True ;
      compar = vpslash.compar
      } ;

    ReflVP vpslash = {
      verb = \\a,st,t,p => vpslash.s ! st ! t ! p ;
      a_stem = \\a,st => vpslash.a_stem ;
      i_stem = \\a,st => vpslash.i_stem ;
      ba = \\a,st => vpslash.ba ;
      prep = vpslash.prep ;
      obj = \\st => "自分" ;  -- "jibun"
      te = \\a,st => vpslash.te ;
      prepositive = vpslash.prepositive ;
      compar = vpslash.compar
      } ;

    UseComp comp = {
      verb = comp.verb ; 
      te = comp.te ;
      a_stem = comp.a_stem ;
      i_stem = comp.i_stem ;
      ba = comp.ba ;
      prep = [] ;
      obj = comp.obj ; 
      prepositive = comp.prepositive ;
      compar = comp.compar
      } ;
    
    PassV2 v2 = {
      verb = \\a,st,t,p => v2.pass ! st ! t ! p ; 
      te = \\a,st => v2.pass_te ;
      a_stem = \\a,st => v2.pass_a_stem ;
      i_stem = \\a,st => v2.pass_i_stem ;
      ba = \\a,st => v2.pass_ba ;
      prep = [] ;
      obj = \\st => [] ;
      prepositive = \\st => [] ;
      compar = NoCompar
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
        True => adv.s ! st ; 
        False => []
        } ;
      compar = adv.compar
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
      compar = NoCompar
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
        True => adv.s ! st ; 
        False => []
        } ;
      v2vType = False ;
      compar = adv.compar
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
      v2vType = False ;
      compar = vpslash.compar
      } ;
      
    CompAP ap = {
      verb = \\a,st,t,p => ap.pred ! st ! t ! p ; 
      te = \\a,st => ap.te ! st ;
      a_stem = \\a,st => ap.adv ! st ;
      i_stem = \\a,st => ap.adv ! st ;  -- for wishes - not correct!
      ba = \\a,st => ap.ba ! st ;
      obj = \\st => [] ; 
      prepositive = ap.prepositive ; 
      compar = ap.compar
      } ;
      
    CompNP np = {
      verb = \\a,st,t,p => mkCopula.s ! st ! t ! p ;
      te = \\a,st => "だって" ;
      ba = \\a,st => "であれば" ;
      a_stem = \\a,st => "で" ;
      i_stem = \\a,st => "で" ;  -- for wishes - not correct!
      obj = \\st => np.s ! st ;
      prepositive = np.prepositive ; 
      compar = NoCompar
      } ;
    
    CompAdv adv = {
      verb = mkExistV.verb ;
      te = mkExistV.te ;
      ba = mkExistV.ba ;
      a_stem = mkExistV.a_stem ;
      i_stem = mkExistV.i_stem ;
      obj = \\st => case adv.prepositive of {
        True => [] ;
        False => adv.s ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ; 
        False => []
        } ;
      compar = NoCompar
      } ;
    
    CompCN cn = {
      verb = \\a,st,t,p => mkCopula.s ! st ! t ! p ;
      te = \\a,st => "だって" ;
      ba = \\a,st => "であれば" ;
      a_stem = \\a,st => "で" ;
      i_stem = \\a,st => "で" ;  -- for wishes - not correct!
      obj = \\st => cn.s ! (Sg|Pl) ! st ;
      prepositive = cn.prepositive ; 
      compar = NoCompar
      } ;
      
    UseCopula = {
      verb = \\a,st,t,p => mkCopula.s ! st ! t ! p ; 
      te = \\a,st => "だって" ;
      ba = \\a,st => "であれば" ;
      a_stem = \\a,st => "で" ;
      i_stem = \\a,st => "で" ;  -- for wishes - not correct!
      obj = \\st => [] ;
      prepositive = \\st => [] ; 
      prep = [] ;
      compar = NoCompar
      } ;
  }


