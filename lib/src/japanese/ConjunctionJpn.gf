concrete ConjunctionJpn of Conjunction = CatJpn ** open ResJpn, Prelude in {
  
  flags coding = utf8 ;
            
  lin

    ConjS conj s = case conj.type of {
      (And | Both) => {
        s = \\part,st => conj.null ++ s.and ! part ! st ;
        te = \\part,st => conj.null ++ s.teAnd ! part ! st ;
        ba = \\part,st => conj.null ++ s.baAnd ! part ! st ;
        subj = \\part,st => conj.null ++ s.subj ! part ! st ;
        pred = s.predAnd ;
        pred_te = s.pred_teAnd ;
        pred_ba = s.pred_baAnd
        } ;
      Or => {
        s = \\part,st => conj.null ++ s.or ! part ! st ;
        te = \\part,st => conj.null ++ s.teOr ! part ! st ;
        ba = \\part,st => conj.null ++ s.baOr ! part ! st ;
        subj = \\part,st => conj.null ++ s.subj ! part ! st ;
        pred = s.predOr ;
        pred_te = s.pred_teOr ;
        pred_ba = s.pred_baOr
        } ;
      IfConj => {
        s = \\part,st => conj.null ++ s.if ! part ! st ;
        te = \\part,st => conj.null ++ s.teIf ! part ! st ;
        ba = \\part,st => conj.null ++ s.baIf ! part ! st ;
        subj = \\part,st => conj.null ++ s.subj ! part ! st ;
        pred = s.predIf ;
        pred_te = s.pred_teIf ;
        pred_ba = s.pred_baIf
        }
      } ;

    ConjRS conj rs = case conj.type of {
      (And | Both | IfConj) => {            -- "if.. then" is hardly possible
        s = \\a,st => conj.null ++ rs.and ! a ! st ;
        te = \\a,st => conj.null ++ rs.teAnd ! a ! st ;
        pred = \\a,st => conj.null ++ rs.predAnd ! a ! st ;
        pred_te = \\a,st => conj.null ++ rs.pred_teAnd ! a ! st ;
        pred_ba = \\a,st => conj.null ++ rs.pred_baAnd ! a ! st ;
        subj = rs.subj ;
        missingSubj = rs.missingSubj
        } ;
      Or => {
        s = \\a,st => conj.null ++ rs.or ! a ! st ;
        te = \\a,st => conj.null ++ rs.teOr ! a ! st ;
        pred = \\a,st => conj.null ++ rs.predOr ! a ! st ;
        pred_te = \\a,st => conj.null ++ rs.pred_teOr ! a ! st ;
        pred_ba = \\a,st => conj.null ++ rs.pred_baOr ! a ! st ;
        subj = rs.subj ;
        missingSubj = rs.missingSubj
        }
      } ;
      
    ConjAP conj ap = case conj.type of {
      (And | Both | IfConj) => {    -- "if.. then" is hardly possible
        pred = \\st,t,p => conj.null ++ ap.s1and ! st ! p ++ ap.s2pred ! st ! t ! p ;
        attr = \\st => conj.null ++ ap.s1and ! st ! Pos ++ ap.s2attr ! st ;
        te = \\st,p => conj.null ++ ap.s1and ! st ! p ++ ap.s2te ! st ! p ;
        ba = \\st,p => conj.null ++ ap.s1and ! st ! p ++ ap.s2ba ! st ! p ;
        adv = \\st => conj.null ++ ap.s1and ! st ! Pos ++ ap.s2adv ! st ;
        dropNaEnging = \\st => conj.null ++ ap.s1and ! st ! Pos ++ ap.s2dropNaEnging ! st ;
        prepositive = ap.prepositive ;
        needSubject = True
        } ;
      Or => {    
        pred = \\st,t,p => conj.null ++ ap.s1or ! st ! p ++ ap.s2pred ! st ! t ! p ;
        attr = \\st => conj.null ++ ap.s1or ! st ! Pos ++ ap.s2attr ! st ;
        te = \\st,p => conj.null ++ ap.s1or ! st ! p ++ ap.s2te ! st ! p ;
        ba = \\st,p => conj.null ++ ap.s1or ! st ! p ++ ap.s2ba ! st ! p ;
        adv = \\st => conj.null ++ ap.s1or ! st ! Pos ++ ap.s2adv ! st ;
        dropNaEnging = \\st => conj.null ++ ap.s1or ! st ! Pos ++ ap.s2dropNaEnging ! st ;
        prepositive = ap.prepositive ;
        needSubject = True
        }
      } ;
    
    ConjAdv conj adv = {
      s = \\st => case conj.type of {
        (And | Both | IfConj) => conj.null ++ adv.and ! st ;  -- "if.. then" is hardly possible
        Or => conj.null ++ adv.or ! st
        } ;
      prepositive = adv.prepositive
      } ;

    ConjAdV conj adv = {
      s = case conj.type of {
        (And | Both | IfConj) => conj.null ++ adv.and ;  -- "if.. then" is hardly possible
        Or => conj.null ++ adv.or 
        } 
      } ;
      
    ConjNP conj np = {
      s = \\st => case conj.type of {
        And | IfConj => conj.null ++ np.and ! st ;  -- "if.. then" is hardly possible
        Or  => conj.null ++ np.or ! st ;
        Both => conj.null ++ np.both ! st
        } ;
      prepositive = np.prepositive ;
      needPart = case conj.type of {
        (And|Or|IfConj) => np.needPart ;
        Both     => False
        } ;
      changePolar = np.changePolar ;
      meaning = SomeoneElse ;
      anim = np.anim
      } ;
    
    ConjIAdv conj iadv = {
      s = \\st => conj.null ++ iadv.s ! st ;
      particle = iadv.particle ;
      wh8re = iadv.wh8re
      } ;
      
    ConjCN conj cn = {
      s = \\n,st => case conj.type of {
        (And|Both|IfConj) => conj.null ++ cn.and ! n ! st ;
        Or         => conj.null ++ cn.or ! n ! st 
        } ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace ;
      object = cn.object ;
      prepositive = cn.prepositive ;
      hasAttr = cn.hasAttr ;
      counterTsu = cn.counterTsu
      } ;
         
    ConjDet conj dap = {
      quant = \\st => case conj.type of {
        (And|Both|IfConj) => conj.null ++ dap.quantAnd ! st ;
        Or                => conj.null ++ dap.quantOr ! st 
        } ;
      num = case conj.type of {
        (And|Both|IfConj) => conj.null ++ dap.numAnd ;
        Or                => conj.null ++ dap.numOr 
        } ;
      postpositive = dap.postpositive ; 
      n = dap.n ; 
      inclCard = dap.inclCard ; 
      sp = \\st => case conj.type of {
        (And|Both|IfConj) => conj.null ++ dap.spAnd ! st ;
        Or                => conj.null ++ dap.spOr ! st 
        } ;
      no = dap.no ; 
      tenPlus = dap.tenPlus
      } ;
  
    BaseS x y = {
      and = \\part,st => x.s ! part ! st ++ "、" ++ "そして" ++ y.s ! Ga ! st ;
      or = \\part,st => x.s ! part ! st ++ "、" ++ "それとも" ++ y.s ! Ga ! st ;
      if = \\part,st => x.subj ! part ! st ++ x.pred ! Plain ++ "と、 " ++ y.s ! Ga ! st ;
      teAnd = \\part,st => x.te ! part ! st ++ "、" ++ y.te ! Ga ! st ;
      teOr = \\part,st => x.s ! part ! st ++ "、" ++ "それとも" ++ y.te ! Ga ! st ;
      teIf = \\part,st => x.subj ! part ! st ++ x.pred ! Plain ++ "と、 " ++ y.te ! Ga ! st ;
      baAnd = \\part,st => x.ba ! part ! st ++ "、" ++ y.ba ! Ga ! st ;
      baOr = \\part,st => x.s ! part ! st ++ "、" ++ "それとも" ++ y.ba ! Ga ! st ;
      baIf = \\part,st => x.subj ! part ! st ++ x.pred ! Plain ++ "と、 " ++ y.ba ! Ga ! st ;
      subj = \\part,st => x.subj ! part ! st ;
      predAnd = \\st => x.pred ! st ++ "、" ++ "そして" ++ y.s ! Ga ! st ;
      predOr = \\st => x.pred ! st ++ "、" ++ "それとも" ++ y.s ! Ga ! st ;
      predIf = \\st => x.pred ! Plain ++ "と、 " ++ y.s ! Ga ! st ;
      pred_teAnd = \\st => x.pred_te ! st ++ "、" ++ y.te ! Ga ! st ;
      pred_teOr = \\st => x.pred ! st ++ "、" ++ "それとも" ++ y.te ! Ga ! st ;
      pred_teIf = \\st => x.pred ! Plain ++ "と、 " ++ y.te ! Ga ! st ;
      pred_baAnd = \\st => x.pred_ba ! st ++ "、" ++ y.ba ! Ga ! st ;
      pred_baOr = \\st => x.pred ! st ++ "、" ++ "それとも" ++ y.ba ! Ga ! st ;
      pred_baIf = \\st => x.pred ! Plain ++ "と、 " ++ y.ba ! Ga ! st ;
      } ;
    
    ConsS x xs = {
      and = \\part,st => xs.and ! part ! st ++ "、" ++ "そして" ++ x.s ! Ga ! st ;
      or = \\part,st => xs.or ! part ! st ++ "、" ++ "それとも" ++ x.s ! Ga ! st ;
      if = \\part,st => xs.if ! part ! Plain ++ "と、 " ++ x.s ! Ga ! st ;
      teAnd = \\part,st => xs.teAnd ! part ! st ++ "、" ++ x.te ! Ga ! st ;
      teOr = \\part,st => xs.or ! part ! st ++ "、" ++ "それとも" ++ x.te ! Ga ! st ;
      teIf = \\part,st => xs.if ! part ! Plain ++ "と、 " ++ x.te ! Ga ! st ;
      baAnd = \\part,st => xs.baAnd ! part ! st ++ "、" ++ x.ba ! Ga ! st ;
      baOr = \\part,st => xs.or ! part ! st ++ "、" ++ "それとも" ++ x.ba ! Ga ! st ;
      baIf = \\part,st => xs.if ! part ! Plain ++ "と、 " ++ x.ba ! Ga ! st ;
      subj = xs.subj ;
      predAnd = \\st => xs.predAnd ! st ++ "、" ++ "そして" ++ x.s ! Ga ! st ;
      predOr = \\st => xs.predOr ! st ++ "、" ++ "それとも" ++ x.s ! Ga ! st ;
      predIf = \\st => xs.predIf ! Plain ++ "と、 " ++ x.s ! Ga ! st ;
      pred_teAnd = \\st => xs.pred_teAnd ! st ++ "、" ++ x.te ! Ga ! st ;
      pred_teOr = \\st => xs.predOr ! st ++ "、" ++ "それとも" ++ x.te ! Ga ! st ;
      pred_teIf = \\st => xs.predIf ! Plain ++ "と、 " ++ x.te ! Ga ! st ;
      pred_baAnd = \\st => xs.pred_baAnd ! st ++ "、" ++ x.ba ! Ga ! st ;
      pred_baOr = \\st => xs.predOr ! st ++ "、" ++ "それとも" ++ x.ba ! Ga ! st ;
      pred_baIf = \\st => xs.predIf ! Plain ++ "と、 " ++ x.ba ! Ga ! st ;
      } ;

    BaseRS x y = {
      and = \\a,st => x.te ! a ! st ++ "、" ++ y.s ! a ! st ;
      or = \\a,st => case <x.missingSubj, y.missingSubj> of {
        <True, True> => x.s ! a ! st ++ "か" ++ "、" ++ y.s ! a ! st ;
        _ => x.te ! a ! st ++ "、" ++ "あるいは" ++ y.s ! a ! st 
        } ;
      teAnd = \\a,st => x.te ! a ! st ++ "、" ++ y.te ! a ! st ;
      teOr = \\a,st => x.te ! a ! st ++ "、" ++ "あるいは" ++ y.te ! a ! st ;
      predAnd = \\a,st => x.pred_te ! a ! st ++ "、" ++ y.s ! a ! st ;
      predOr = \\a,st => x.pred_te ! a ! st ++ "、" ++ "あるいは" ++ y.s ! a ! st ;
      pred_teAnd = \\a,st => x.pred_te ! a ! st ++ "、" ++ y.te ! a ! st ;
      pred_teOr = \\a,st => x.pred_te ! a ! st ++ "、" ++ "あるいは" ++ y.te ! a ! st ;
      pred_baAnd = \\a,st => x.pred_te ! a ! st ++ "、" ++ y.subj ! Ga ! st ++ 
                             y.pred_ba ! a ! st ;
      pred_baOr = \\a,st => x.pred_te ! a ! st ++ "、" ++ "あるいは" ++ y.subj ! Ga ! st ++ 
                              y.pred_ba ! a ! st ;
      subj = x.subj ;
      missingSubj = x.missingSubj
      } ;
      
    ConsRS x xs = {
      and = \\a,st => xs.teAnd ! a ! st ++ "、" ++ x.s ! a ! st ;
      or = \\a,st => case <xs.missingSubj, x.missingSubj> of {
        <True, True> => xs.teOr ! a ! st ++ "か" ++ "、" ++ x.s ! a ! st ;
        _ => xs.teOr ! a ! st ++ "、" ++ "あるいは" ++ x.s ! a ! st 
        } ;
      teAnd = \\a,st => xs.teAnd ! a ! st ++ "、" ++ x.te ! a ! st ;
      teOr = \\a,st => xs.teOr ! a ! st ++ "、" ++ "あるいは" ++ x.te ! a ! st ;
      predAnd = \\a,st => xs.pred_teAnd ! a ! st ++ "、" ++ x.s ! a ! st ;
      predOr = \\a,st => xs.pred_teOr ! a ! st ++ "、" ++ "あるいは" ++ x.s ! a ! st ;
      pred_teAnd = \\a,st => xs.pred_teAnd ! a ! st ++ "、" ++ x.te ! a ! st ;
      pred_teOr = \\a,st => xs.pred_teOr ! a ! st ++ "、" ++ "あるいは" ++ x.te ! a ! st ;
      pred_baAnd = \\a,st => xs.pred_teAnd ! a ! st ++ "、" ++ x.subj ! Ga ! st ++ 
                               x.pred_ba ! a ! st ;
      pred_baOr = \\a,st => xs.pred_teOr ! a ! st ++ "、" ++ "あるいは" ++ x.subj ! Ga ! st ++ 
                              x.pred_ba ! a ! st ;
      subj = xs.subj ;
      missingSubj = xs.missingSubj
      } ;
    
    BaseAdv x y = {
      and = \\st => case <x.prepositive, y.prepositive> of {
        <False, False> => x.s ! st ++ y.s ! st ;
        _              => x.s ! st ++ "、" ++ y.s ! st 
        } ;
      or = \\st => case <x.prepositive, y.prepositive> of {
        <False, False> => x.s ! st ++ "か" ++ y.s ! st ;
        _              => x.s ! st ++ "、" ++ "あるいは" ++ y.s ! st 
        } ;
      prepositive = case <x.prepositive, y.prepositive> of {
        <False, False> => False ;
        _              => True
        }
      } ;
    
    ConsAdv x xs = {
      and = \\st => case <x.prepositive, xs.prepositive> of {
        <False, False> => xs.and ! st ++ x.s ! st ;
        _              => xs.and ! st ++ "、" ++ x.s ! st 
        } ;
      or = \\st => case <x.prepositive, xs.prepositive> of {
        <False, False> => x.s ! st ++ "か" ++ xs.or ! st ;
        _              => xs.or ! st ++ "、" ++ "あるいは" ++ x.s ! st 
        } ;
      prepositive = case <x.prepositive, xs.prepositive> of {
        <False, False> => False ;
        _              => True
        }
      } ;
    
    BaseAdV x y = {
      and = x.s ++ y.s ;
      or = x.s ++ "か" ++ y.s 
      } ;

    ConsAdV x xs = {
      and = x.s ++ xs.and ;
      or = x.s ++ "か" ++ xs.or 
      } ;
  
    BaseNP x y = {
      and = \\st => x.s ! st ++ "と" ++ y.s ! st ;
      or = \\st => x.s ! st ++ "か" ++ y.s ! st ;
      both = \\st => x.s ! st ++ "も" ++ y.s ! st ++ "も" ;
      prepositive = \\st => x.prepositive ! st ++ y.prepositive ! st ;
      needPart = case <x.needPart, y.needPart> of {
        <True, True> => True ;
        _ => False 
        } ;
      changePolar = case <x.changePolar, y.changePolar> of {
        <False, False> => False ;
        _ => True 
        } ;
      meaning = SomeoneElse ;
      anim = case <x.anim, y.anim> of {
        <Inanim, Inanim> => Inanim ;
        _ => Anim 
        } 
      } ;
      
    ConsNP x xs = {
      and = \\st => x.s ! st ++ "と" ++ xs.and ! st ;
      or = \\st => x.s ! st ++ "か" ++ xs.or ! st ;
      both = \\st => x.s ! st ++ "も" ++ xs.both ! st ;
      prepositive = \\st => x.prepositive ! st ++ xs.prepositive ! st ;
      needPart = case <xs.needPart, x.needPart> of {
        <True, True> => True ;
        _ => False 
        } ;
      changePolar = case <xs.changePolar, x.changePolar> of {
        <False, False> => False ;
        _ => True 
        } ;
      meaning = SomeoneElse ;
      anim = case <xs.anim, x.anim> of {
        <Inanim, Inanim> => Inanim ;
        _ => Anim 
        } 
      } ;

    BaseAP x y = {
      s1and = x.te ;
      s1or = \\st => table {
        Pos => x.dropNaEnging ! st ++ "か" ;
        Neg => x.pred ! Plain ! TPres ! Neg ++ "か" 
        } ;
      s2pred = y.pred ;
      s2attr = y.attr ;
      s2te = y.te ;
      s2ba = y.ba ;
      s2adv = y.adv ;
      s2dropNaEnging = y.dropNaEnging ;
      prepositive = \\st => x.prepositive ! st ++ y.prepositive ! st
      } ;
      
    ConsAP x xs = {
      s1and = \\st,p => xs.s1and ! st ! p ++ xs.s2te ! st ! p ;
      s1or = \\st => table {
        Pos => xs.s1or ! st ! Pos ++ xs.s2dropNaEnging ! st ++ "か" ;
        Neg => xs.s1or ! st ! Neg ++ xs.s2pred ! Plain ! TPres ! Neg ++ "か" 
        } ;
      s2pred = x.pred ;
      s2attr = x.attr ;
      s2te = x.te ;
      s2ba = x.ba ;
      s2adv = x.adv ;
      s2dropNaEnging = x.dropNaEnging ;
      prepositive = \\st => x.prepositive ! st ++ xs.prepositive ! st
      } ;
    
    BaseIAdv x y = {
      s = \\st => x.s ! st ++ x.particle ++ y.s ! st ;
      particle = y.particle ;
      wh8re = case <x.wh8re, y.wh8re> of {
        <False, False> => False ;
        _ => True 
        }
      } ;
      
    ConsIAdv x xs = {
      s = \\st => x.s ! st ++ x.particle ++ xs.s ! st ;
      particle = xs.particle ;
      wh8re = case <x.wh8re, xs.wh8re> of {
        <False, False> => False ;
        _ => True 
        }
      } ;
      
    BaseCN x y = {
      and = \\n,st => x.s ! n ! st ++ "と" ++ y.object ! st ++ y.s ! n ! st ;
      or = \\n,st => x.s ! n ! st ++ "か" ++ y.object ! st ++ y.s ! n ! st ;
      anim = case <x.anim, y.anim> of {
        <Inanim, Inanim> => Inanim ;
        _ => Anim 
        } ;
      counter = y.counter ;
      counterReplace = y.counterReplace ;
      object = x.object ;
      prepositive = \\st => x.prepositive ! st ++ y.prepositive ! st ;
      hasAttr = x.hasAttr ;
      counterTsu = y.counterTsu
      } ;
      
    ConsCN x xs = {
      and = \\n,st => x.s ! n ! st ++ "と" ++ xs.object ! st ++ xs.and ! n ! st ;
      or = \\n,st => x.s ! n ! st ++ "か" ++ xs.object ! st ++ xs.or ! n ! st ;
      anim = case <x.anim, xs.anim> of {
        <Inanim, Inanim> => Inanim ;
        _ => Anim 
        } ;
      counter = xs.counter ;
      counterReplace = xs.counterReplace ;
      object = x.object ;
      prepositive = \\st => x.prepositive ! st ++ xs.prepositive ! st ;
      hasAttr = x.hasAttr ;
      counterTsu = xs.counterTsu
      } ;

    BaseDAP x y = {
      quantAnd = \\st => x.quant ! st ++ "と" ++ y.quant ! st ;
      quantOr = \\st => x.quant ! st ++ "か" ++ y.quant ! st ;
      numAnd = x.num ++ "と" ++ y.num ;
      numOr = x.num ++ "か" ++ y.num ; 
      postpositive = x.postpositive ++ y.postpositive ; 
      n = case <x.n, y.n> of {
        <Sg, Sg> => Sg ;
        _ => Pl
        } ; 
      inclCard = case <x.inclCard, y.inclCard> of {
        <False, False> => False ;
        _ => True
        } ; 
      spAnd = \\st => x.sp ! st ++ "と" ++ y.sp ! st ;
      spOr = \\st => x.sp ! st ++ "か" ++ y.sp ! st ;
      no = case <x.no, y.no> of {
        <False, False> => False ;
        _ => True
        } ; 
      tenPlus = case <x.tenPlus, y.tenPlus> of {
        <False, False> => False ;
        _ => True
        } 
      } ;

    ConsDAP x xs = {
      quantAnd = \\st => x.quant ! st ++ "と" ++ xs.quantAnd ! st ;
      quantOr = \\st => x.quant ! st ++ "か" ++ xs.quantOr ! st ;
      numAnd = x.num ++ "と" ++ xs.numAnd ;
      numOr = x.num ++ "か" ++ xs.numOr ; 
      postpositive = x.postpositive ++ xs.postpositive ; 
      n = case <x.n, xs.n> of {
        <Sg, Sg> => Sg ;
        _ => Pl
        } ; 
      inclCard = case <x.inclCard, xs.inclCard> of {
        <False, False> => False ;
        _ => True
        } ; 
      spAnd = \\st => x.sp ! st ++ "と" ++ xs.spAnd ! st ;
      spOr = \\st => x.sp ! st ++ "か" ++ xs.spOr ! st ;
      no = case <x.no, xs.no> of {
        <False, False> => False ;
        _ => True
        } ; 
      tenPlus = case <x.tenPlus, xs.tenPlus> of {
        <False, False> => False ;
        _ => True
        } 
      } ;

  lincat
                
    [S] = {and, or, if, teAnd, teOr, teIf, baAnd, 
           baOr, baIf, subj : Particle => Style => Str ; 
           predAnd, predOr, predIf, pred_teAnd, pred_teOr, 
           pred_teIf, pred_baAnd, pred_baOr, pred_baIf : Style => Str} ;
    
    [RS] = {and, or, teAnd, teOr, predAnd, predOr, pred_teAnd, pred_teOr, pred_baAnd, 
            pred_baOr : Animateness => Style => Str ; subj : Particle => Style => Str ; 
            missingSubj : Bool} ;
    
    [Adv] = {and, or : Style => Str ; prepositive : Bool} ;

    [AdV] = {and, or : Str} ;
    
    [NP] = {and, or, both : Style => Str ; prepositive : Style => Str ; 
            needPart : Bool ; changePolar : Bool ; meaning : Speaker ; anim : Animateness} ; 
    
    [AP] = {s1and, s1or : Style => Polarity => Str ; s2pred : Style => TTense => Polarity => Str ; 
            s2attr, s2adv, s2dropNaEnging, prepositive : Style => Str ; 
            s2te, s2ba : Style => Polarity => Str} ;
    
    [IAdv] = {s : Style => Str ; particle : Str ; wh8re : Bool} ;
    
    [CN] = {and, or : Number => Style => Str ; anim : Animateness ; counter : Str ; 
            counterReplace : Bool ; object : Style => Str ; prepositive : Style => Str ;
            hasAttr : Bool ; counterTsu : Bool} ;

    [DAP] = {quantAnd, quantOr : Style => Str ; numAnd, numOr : Str ; 
             postpositive : Str ; n : Number ; inclCard : Bool ; 
             spAnd, spOr : Style => Str ; no : Bool ; tenPlus : Bool} ;
}
