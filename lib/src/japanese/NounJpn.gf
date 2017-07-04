concrete NounJpn of Noun = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin

    DetCN det cn = {
      s = \\st => case det.inclCard of {
        True => case cn.counterReplace of {
          True => case cn.hasAttr of {
            True => cn.object ! st ++ det.quant ! st ++ det.num ++ cn.counter ++ det.postpositive
                    ++ "の" ++ cn.s ! det.n ! st ;
            False => cn.object ! st ++ det.quant ! st ++ det.num ++ cn.counter ++ det.postpositive 
            } ;
          False => case <det.tenPlus, cn.counterTsu> of {
            <True, True> => cn.object ! st ++ det.quant ! st ++ det.num ++ "個" ++ det.postpositive 
                            ++ "の" ++ cn.s ! det.n ! st ;
             _ => cn.object ! st ++ det.quant ! st ++ det.num ++ cn.counter ++ det.postpositive 
                  ++ "の" ++ cn.s ! det.n ! st 
            } 
          } ;
        False => cn.object ! st ++ det.quant ! st ++ det.num ++ cn.s ! det.n ! st 
        } ;
      prepositive = cn.prepositive ;
      needPart = True ;
      changePolar = case det.no of {
        True => True ;
        False => False
        } ;
      meaning = SomeoneElse ;
      anim = cn.anim
      } ;
      
    UsePN pn = {
      s = \\st => pn.s ! st ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = False ;
      meaning = SomeoneElse ;
      anim = pn.anim
    } ;
    
    UsePron pron = {
      s = pron.s ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = False ;
      meaning = case pron.Pron1Sg of {
        True => Me ;
        False => SomeoneElse
        } ;
      anim = pron.anim
      } ;
    
    PredetNP p np = {
      s = \\st => p.s ++ np.s ! st ;
      prepositive = np.prepositive ;
      needPart = np.needPart ;
      changePolar = case p.not of {
        True => True ;
        False => np.changePolar
        } ;
      meaning = np.meaning ;
      anim = np.anim
      } ;
      
    PPartNP np v2 = np ** {
      s = \\st => v2.pass ! Plain ! TPast ! Pos ++ np.s ! st ;
      } ;

    AdvNP np adv = np ** {
      s = \\st => case adv.prepositive of {
        True => np.s ! st ;
        False => adv.s ! st ++ np.s ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => [] 
        } 
      } ;

    ExtAdvNP = AdvNP ;
    
    RelNP np rs = np ** {
      s = \\st => rs.s ! np.anim ! st ++ np.s ! st 
      } ;
    
    DetNP det = {
      s = det.sp ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = case det.no of {
        True => True ;
        False => False
        } ;
      meaning = SomeoneElse ;
      anim = Inanim   -- not always, depends on the context
      } ;
    
    DetQuant quant num = {
      quant = quant.s ;
      postpositive = num.postpositive ;
      num = num.s ;
      n = num.n ;
      inclCard = num.inclCard ;
      sp = \\st => case num.inclCard of {
        True => case num.tenPlus of {
          False => quant.s ! st ++ num.s ++ "つ" ++ num.postpositive ;
          True => quant.s ! st ++ num.s ++ num.postpositive
          } ;
        False => quant.sp ! st ++ num.s
        } ;
      no = quant.no ;
      tenPlus = num.tenPlus
      } ;
      
    DetQuantOrd quant num ord = {
      quant = \\st => quant.s ! st ++ ord.attr ;
      postpositive = num.postpositive ;
      num = num.s ;
      n = num.n ;
      inclCard = num.inclCard ;
      sp = \\st => case num.inclCard of {
        True => case num.tenPlus of {
          False => quant.s ! st ++ ord.attr ++ num.s ++ "つ" ++ num.postpositive ;
          True => quant.s ! st ++ ord.attr ++ num.s ++ num.postpositive
          } ;
        False => quant.s ! st ++ ord.attr ++ num.s
        } ;
      no = quant.no ;
      tenPlus = num.tenPlus
      } ;

    NumSg = mkNum "" Sg ;
    
    NumPl = mkNum "" Pl ;
    
    NumCard card = card ** {inclCard = True} ;
    
    NumDigits num = num ** {postpositive = []} ;
    
    NumNumeral num = num ** {postpositive = []} ;
    
    AdNum adn card = case adn.postposition of {
      True => {
        s = card.s ;
        postpositive = adn.s ;
        n = card.n ;
        tenPlus = card.tenPlus
        } ;
      False => {
        s = adn.s ++ card.s ;
        postpositive = [] ;
        n = card.n ;
        tenPlus = card.tenPlus
        } 
      } ;
    
    OrdDigits, OrdNumeral = mkOrd ; -- "banme"
      
    OrdSuperl a = {
      pred = \\st,t,p => "一番" ++ a.pred ! st ! t ! p ;  -- "ichiban"
      attr = "一番" ++ a.attr ;
      te = \\p => "一番" ++ a.te ! p ;
      ba = \\p => "一番" ++ a.ba ! p ;
      adv = \\p => "一番" ++ a.adv ! p ;
      dropNaEnging = "一番" ++ a.dropNaEnging
      } ;

    OrdNumeralSuperl n a = {
      pred = \\st,t,p => n.s ++ "番" ++ a.pred ! st ! t ! p ;  -- "ichiban"
      attr = n.s ++ "番" ++ a.attr ;
      te = \\p => n.s ++ "番" ++ a.te ! p ;
      ba = \\p => n.s ++ "番" ++ a.ba ! p ;
      adv = \\p => n.s ++ "番" ++ a.adv ! p ;
      dropNaEnging = n.s ++ "番" ++ a.dropNaEnging
      } ;
    
    IndefArt = {s = \\st => "" ; sp = \\st => "何か" ; no = False} ;
    
    DefArt = {s = \\st => "" ; sp = \\st => "これ" ; no = False} ;
    
    MassNP cn = {
      s = \\st => cn.object ! st ++ cn.s ! Pl ! st ;
      prepositive = cn.prepositive ;
      needPart = True ;
      changePolar = False ;
      meaning = SomeoneElse ;
      anim = cn.anim
      } ;
    
    PossPron pron = {
      s, sp = \\st => pron.s ! st ++ "の" ;
      no = False
      } ;
    
    UseN n = n ** {
      object = \\st => [] ;
      prepositive = \\st => [] ;
      hasAttr = False ;
      } ;
      
    ComplN2 n2 np = n2 ** {
      object = \\st => n2.object ! st ++ np.s ! st ++ n2.prep ;
      prepositive = np.prepositive ;
      hasAttr = False ;
      } ;
      
    ComplN3 n3 np = n3 ** {
      object = \\st => np.s ! st ++ n3.prep1 ;
      prepositive = np.prepositive ;
      prep = n3.prep2 ;
      } ;
      
    UseN2 n2 = n2 ** {
      prepositive = \\st => [] ;
      hasAttr = False ;
      } ;
      
    Use2N3 n3 = n3 ** {
      object = \\st => [] ;
      prep = n3.prep1 ;
      } ;
    
    Use3N3 n3 = n3 ** {
      object = \\st => [] ;
      prep = n3.prep2 ;
      } ;

    AdjCN ap cn = cn ** {
      s = \\n,st => case cn.hasAttr of {
        False => ap.attr ! st ++ cn.s ! n ! st ;
        True => ap.te ! st ! Pos ++ cn.s ! n ! st 
        } ;
      hasAttr = True ;
      } ;

    RelCN cn rs = cn ** {
      object = \\st => rs.s ! cn.anim ! st ++ cn.object ! st ;
      } ;
                                  
    AdvCN cn adv = cn ** {
      object = \\st => case adv.prepositive of {
        True => cn.object ! st ;
        False => adv.s ! st ++ cn.object ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => []
        } ;
      } ;
      
    SentCN cn sc = cn ** {
      object = \\st => sc.s ! Ga ! st ++ cn.object ! st ;
      } ;
    
    ApposCN cn np = cn ** {
      s = \\n,st => np.s ! st ++ cn.s ! n ! st ;
      } ;

    PossNP cn np = cn ** {     -- house of Paris, house of mine
      s = \\n,st => np.s ! st ++ "の" ++ cn.s ! n ! st ;
      } ;      

    PartNP = PossNP ;

    CountNP det np = {
      s = \\st => np.s ! st ++ "の" ++ det.sp ! st ;
      prepositive = np.prepositive ;
      needPart = True ;
      changePolar = det.no ;
      meaning = SomeoneElse ;
      anim = np.anim
      } ;

    AdjDAP dap ap = lin Det {
      quant = \\st => dap.quant ! st ++ ap.prepositive ! st ++ ap.attr ! st ;
      num = dap.num ;
      postpositive = dap.postpositive ; 
      n = dap.n ; 
      inclCard = dap.inclCard ; 
      sp = \\st => dap.sp ! st ++ ap.prepositive ! st ++ ap.attr ! st ;
      no = dap.no ; 
      tenPlus = dap.tenPlus    
      } ;  

    DetDAP det = det ;
}
