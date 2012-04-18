concrete NounJap of Noun = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin

    DetCN det cn = {
      s = \\st => case det.inclCard of {
        True => case cn.counterReplace of {
          True => cn.object ! st ++ det.quant ! st++ det.num ++ cn.counter ++ det.postpositive ;
          False => cn.object ! st ++ det.quant ! st ++ cn.s ! det.n ! st ++ 
                   "の" ++ det.num ++ cn.counter ++ det.postpositive
                   } ;
        False => cn.object ! st ++ det.quant ! st ++ det.num ++ cn.s ! det.n ! st 
        } ;
      prepositive = cn.prepositive ;
      needPart = True ;
      changePolar = False ;
      Pron1Sg = False ;
      anim = cn.anim
      } ;
      
    UsePN pn = {
      s = \\st => pn.s ! st ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = False ;
      Pron1Sg = False ;
      anim = pn.anim
    } ;
    
    UsePron pron = {
      s = pron.s ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = False ;
      Pron1Sg = pron.Pron1Sg ;
      anim = pron.anim
      } ;
    
    PredetNP p np = {
      s = \\st => p.s ++ np.s ! st ;
      prepositive = np.prepositive ;
      needPart = np.needPart ;
      changePolar = np.changePolar ;
      Pron1Sg = np.Pron1Sg ;
      anim = np.anim
      } ;
      
    PPartNP np v2 = {
      s = \\st => v2.pass ! Plain ! TPast ! Pos ++ np.s ! st ;
      prepositive = np.prepositive ;
      needPart = np.needPart ;
      changePolar = np.changePolar ;
      Pron1Sg = np.Pron1Sg ;
      anim = np.anim
      } ;

    AdvNP np adv = {
      s = \\st => case adv.prepositive of {
        True => np.s ! st ;
        False => adv.s ! st ++ np.s ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => [] 
        } ;
      needPart = np.needPart ;
      changePolar = np.changePolar ;
      Pron1Sg = np.Pron1Sg ;
      anim = np.anim
      } ;
    
    RelNP np rs = {
      s = \\st => rs.s ! np.anim ! st ++ np.s ! st ;
      prepositive = np.prepositive ;
      needPart = np.needPart ; 
      changePolar = np.changePolar ; 
      Pron1Sg = np.Pron1Sg ; 
      anim = np.anim
      } ;
    
    DetNP det = {
      s = \\st => case det.inclCard of {
        True => det.quant ! st ++ det.num ++ "つ" ++ det.postpositive ;
        False => det.quant ! st ++ det.num
        } ;
      prepositive = \\st => [] ;
      needPart = True ;
      changePolar = False ;
      Pron1Sg = False ;
      anim = Inanim   -- not always, depends on the context
      } ;
    
    DetQuant quant num = {
      quant = quant.s ;
      postpositive = num.postpositive ;
      num = num.s ;
      n = num.n ;
      inclCard = num.inclCard
      } ;
      
    DetQuantOrd quant num ord = {
      quant = \\st => quant.s ! st ++ ord.attr ;
      postpositive = num.postpositive ;
      num = num.s ;
      n = num.n ;
      inclCard = num.inclCard
      } ;

    NumSg = mkNum "" Sg False ;
    
    NumPl = mkNum "" Pl False ;
    
    NumCard card = card ** {inclCard = True} ;
    
    NumDigits num = num ** {postpositive = []} ;
    
    NumNumeral num = num ** {postpositive = []} ;
    
    AdNum adn card = case adn.postposition of {
      True => {
        s = card.s ;
        postpositive = adn.s ;
        n = card.n
        } ;
      False => {
        s = adn.s ++ card.s ;
        postpositive = [] ;
        n = card.n
        } 
      } ;
    
    OrdDigits d = {
      pred = \\st,t,p => d.s ++ "番目" ++ mkCopula.s ! st ! t ! p ;  -- "banme"
      attr = d.s ++ "番目の" ; 
      te = d.s ++ "番目" ++ mkCopula.te ;
      tara = d.s ++ "番目" ++ mkCopula.tara ;
      adv = d.s ++ "番目" 
      } ;
    
    OrdNumeral num = {
      pred = \\st,t,p => num.s ++ "番目" ++ mkCopula.s ! st ! t ! p ;
      attr = num.s ++ "番目の" ;
      te = num.s ++ "番目" ++ mkCopula.te ;
      tara = num.s ++ "番目" ++ mkCopula.tara ;
      adv = num.s ++ "番目" 
      } ;
      
    OrdSuperl a = {
      pred = \\st,t,p => "一番" ++ a.pred ! st ! t ! p ;  -- "ichiban"
      attr = "一番" ++ a.attr ;
      te = "一番" ++ a.te ;
      tara = "一番" ++ a.tara ;
      adv = "一番" ++ a.adv
      } ;
    
    IndefArt = {s = \\st => ""} ;
    
    DefArt = {s = \\st => ""} ;
    
    MassNP cn = {
      s = \\st => cn.object ! st ++ cn.s ! Pl ! st ;
      prepositive = cn.prepositive ;
      needPart = True ;
      changePolar = False ;
      Pron1Sg = False ;
      anim = cn.anim
      } ;
    
    PossPron pron = {
      s = \\st => pron.s ! st ++ "の" ;
      } ;
    
    UseN n = {
      s = n.s ;
      object = \\st => [] ;
      prepositive = \\st => [] ;
      hasAttr = False ;
      anim = n.anim ;
      counter = n.counter ;
      counterReplace = n.counterReplace
      } ;
      
    ComplN2 n2 np = {
      s = n2.s ;
      object = \\st => n2.object ! st ++ np.s ! st ++ n2.prep ;
      prepositive = np.prepositive ;
      hasAttr = False ;
      anim = n2.anim ;
      counter = n2.counter ;
      counterReplace = n2.counterReplace
      } ;
      
    ComplN3 n3 np = {
      s = n3.s ;
      object = \\st => np.s ! st ++ n3.prep1 ;
      prepositive = np.prepositive ;
      prep = n3.prep2 ;
      anim = n3.anim ;
      counter = n3.counter ;
      counterReplace = n3.counterReplace
      } ;
      
    UseN2 n2 = {
      s = n2.s ;
      object = n2.object ;
      prepositive = \\st => [] ;
      hasAttr = False ;
      anim = n2.anim ;
      counter = n2.counter ;
      counterReplace = n2.counterReplace
      } ;
      
    Use2N3 n3 = {
      s = n3.s ;
      object = \\st => [] ;
      prep = n3.prep1 ;
      anim = n3.anim ;
      counter = n3.counter ;
      counterReplace = n3.counterReplace
      } ;
    
    Use3N3 n3 = {
      s = n3.s ;
      object = \\st => [] ;
      prep = n3.prep2 ;
      anim = n3.anim ;
      counter = n3.counter ;
      counterReplace = n3.counterReplace
      } ;

    AdjCN ap cn = {
      s = \\n,st => case cn.hasAttr of {
        False => ap.attr ! st ++ cn.s ! n ! st ;
        True => ap.te ! st ++ cn.s ! n ! st 
        } ;
      object = cn.object ;
      prepositive = cn.prepositive ;
      hasAttr = True ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace
      } ;

    RelCN cn rs = {
      s = cn.s ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace ;
      object = \\st => rs.s ! cn.anim ! st ++ cn.object ! st ;
      prepositive = cn.prepositive ;
      hasAttr = cn.hasAttr 
      } ;
                                  
    AdvCN cn adv = {
      s = cn.s ;
      object = \\st => case adv.prepositive of {
        True => cn.object ! st ;
        False => adv.s ! st ++ cn.object ! st 
        } ;
      prepositive = \\st => case adv.prepositive of {
        True => adv.s ! st ;
        False => []
        } ;
      hasAttr = cn.hasAttr ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace
      } ;
      
    SentCN cn sc = {
      s = cn.s ;
      object = \\st => sc.s ! Ga ! st ++ cn.object ! st ;
      prepositive = cn.prepositive ;
      hasAttr = cn.hasAttr ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace
      } ;
    
    ApposCN cn np = {
      s = \\n,st => cn.s ! n ! st ++ np.s ! st ;
      object = cn.object ;
      prepositive = cn.prepositive ;
      hasAttr = cn.hasAttr ;
      anim = cn.anim ;
      counter = cn.counter ;
      counterReplace = cn.counterReplace
      } ;
}
