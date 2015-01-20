--# -path=.:../abstract

concrete ExtensionsJpn of Extensions = 
  CatJpn ** open ResJpn, ParadigmsJpn, SyntaxJpn, (G = GrammarJpn), (E = ExtraJpn), Prelude in {

lincat

  VPI = E.VPI ;
  VPS = E.VPS ;
  [VPS] = {verbAnd, verbOr, verbIf, a_stemAnd, a_stemOr, a_stemIf, 
             i_stemAnd, i_stemOr, i_stemIf, teAnd, teOr, teIf,
             baAnd, baOr, baIf : Speaker => Animateness => Style => Str ; 
             prep : Str ; obj, prepositive : Style => Str} ;
  [VPI] = {verbAnd, verbOr : Speaker => Animateness => Str ;
           a_stemAnd, a_stemOr, i_stemAnd, i_stemOr : Speaker => Animateness => Style => Str ; 
           teAnd, teOr, baAnd, baOr : Speaker => Animateness => Style => Polarity => Str ; 
           prep : Str ; obj, prepositive : Style => Str} ;

lin

  MkVPI = E.MkVPI ;  
  MkVPS = E.MkVPS ;

  ComplVPIVV = E.ComplVPIVV ;

  PredVPS = E.PredVPS ;
  ConjVPS = E.ConjVPS ;
  ConjVPI = E.ConjVPI ;
  BaseVPS = E.BaseVPS ;
  ConsVPS = E.ConsVPS ;
  BaseVPI = E.BaseVPI ;
  ConsVPI = E.ConsVPI ;

  GenNP = E.GenNP ;
  GenIP = E.GenIP ;
  GenRP = E.GenRP ;

  CompoundN n1 n2 = {
    s = \\n,st => n1.s ! n ! st ++ n2.s ! n ! st ;
    anim = n2.anim ;
    counter = n2.counter ;
    counterReplace = n2.counterReplace ;
    counterTsu = n2.counterTsu
    } ;

  CompoundAP n a = {
    pred = \\st,t,p => n.s ! Sg ! st ++ "に" ++ a.pred ! st ! t ! p ;
    attr = \\st => n.s ! Sg ! st ++ "に" ++ a.attr ;
    adv = \\st => n.s ! Sg ! st ++ "に" ++ a.adv ! Pos ;
    dropNaEnging = \\st => n.s ! Sg ! st ++ "に" ++ a.dropNaEnging ;
    prepositive = \\st => "" ;
    te = \\st,p => n.s ! Sg ! st ++ "に" ++ a.te ! p ;
    ba = \\st,p => n.s ! Sg ! st ++ "に" ++ a.ba ! p ;
    needSubject = True
    } ;

  GerundCN vp = {
    s = \\n,st => vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ++ "の" ;
    anim = Inanim ;
    counter = "つ" ;
    counterReplace = False ;
    counterTsu = True;
    object = \\st => vp.obj ! st ++ vp.prep ;
    prepositive = vp.prepositive ;
    hasAttr = False
    } ;

  GerundNP vp = {
    s = \\st => vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ++ "の" ;
    anim = Inanim ;
    changePolar = False ;
    needPart = True;
    meaning = SomeoneElse ;
    prepositive = vp.prepositive ;
    } ;

  GerundAdv vp = {
    s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ++ "と" ;
    prepositive = True
    } ;

  WithoutVP vp = {
    s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Neg ++ "で" ;
    prepositive = True
    } ;
  
  ByVP vp = {
    s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ++ "ことで" ;
    prepositive = True
    } ;

  InOrderToVP vp = {
    s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! SomeoneElse ! Inanim ! Plain ! TPres ! Pos ++ "ために" ;
    prepositive = True
    } ;

  PresPartAP vp = {
    pred = \\st,t,p => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ (mkVerb "いる" Gr2).s ! st ! t ! p ; 
    attr = \\st => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ "いる" ;
    te = \\st,p => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ mkExistV.te ! SomeoneElse ! Anim ! st ! p ;
    ba = \\st,p => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ mkExistV.ba ! SomeoneElse ! Anim ! st ! p ;
    adv = \\st => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ mkExistV.te ! SomeoneElse ! Anim ! st ! Pos ;
    dropNaEnging = \\st => vp.te ! SomeoneElse ! Anim ! st ! Pos ++ "いる" ;
    prepositive = vp. prepositive ;
    needSubject = vp.needSubject
    } ;

  PastPartAP vpslash = {
    pred = \\st,t,p => vpslash.a_stem ! SomeoneElse ++ "れた" ++ mkCopula.s ! st ! t ! p ; 
                          -- works only for Gr1. Have to add verb group record to VPSlash
    attr = \\st => vpslash.a_stem ! SomeoneElse ++ "れた" ;
    te = \\st,p => vpslash.a_stem ! SomeoneElse ++ "れて" ;
    ba = \\st,p => vpslash.a_stem ! SomeoneElse ++ "れば" ;
    adv = \\st => vpslash.a_stem ! SomeoneElse ++ "れて" ;
    dropNaEnging = \\st => vpslash.a_stem ! SomeoneElse ++ "れた" ;
    prepositive = vpslash.prepositive ;
    needSubject = True
    } ;

  PastPartAgentAP vpslash np = {
    pred = \\st,t,p => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れた" ++ mkCopula.s ! st ! t ! p ; 
                          -- works only for Gr1. Have to add verb group record to VPSlash
    attr = \\st => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れた" ;
    te = \\st,p => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れて" ;
    ba = \\st,p => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れば" ;
    adv = \\st => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れて" ;
    dropNaEnging = \\st => np.s ! st ++ "に" ++ vpslash.a_stem ! SomeoneElse ++ "れた" ;
    prepositive = \\st => np.prepositive ! st ++ vpslash.prepositive ! st ;
    needSubject = True
    } ;
  ApposNP np1 np2 = {
    s = \\st => np1.s ! st ++ "、" ++ np2.s ! st ;
    prepositive = \\st => np1.prepositive ! st ++ np2.prepositive ! st ;
    needPart = np1.needPart ;
    changePolar = np1.changePolar ;
    meaning = np1.meaning ;
    anim = np1.anim
    } ;

  AdAdV = cc2 ;

  UttAdV adv = {
    s = \\part,st => adv.s ; 
    type = NoImp
    } ;

  DirectComplVS t np vs utt = {
    s = case t.a of {
      Simul => table {
        Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                      utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! t.t ! Pos ;
        Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                      utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! t.t ! Pos 
        } ;
      Anter => case t.t of {
        TPres => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos 
          } ;      
        TPast => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos 
          } ;      
        TFut => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPres ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPres ! Pos 
          } 
        } 
      } ;      
    te = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                    utt.s ! Wa ! st ++ "」と" ++ vs.te ! Pos ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                    utt.s ! Wa ! st ++ "」と" ++ vs.te ! Pos 
      } ; 
    ba = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                    utt.s ! Wa ! st ++ "」と" ++ vs.ba ! Pos ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                    utt.s ! Wa ! st ++ "」と" ++ vs.ba ! Pos 
      } ; 
    subj = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は" ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が"
      } ;
    pred = case t.a of {
      Simul => \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! t.t ! Pos ;       
      Anter => case t.t of {
        TPres => \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos ;
        TPast => \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPast ! Pos ;
        TFut => \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.s ! st ! TPres ! Pos 
        } 
      } ;
    pred_te = \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.te ! Pos ; 
    pred_ba = \\st => "「" ++ utt.s ! Wa ! st ++ "」と" ++ vs.ba ! Pos 
    } ; 

  DirectComplVQ t np vq qs = {
    s = case t.a of {
      Simul => table {
        Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                      qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! t.t ! Pos ;
        Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                      qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! t.t ! Pos 
        } ;
      Anter => case t.t of {
        TPres => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos 
          } ;      
        TPast => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos 
          } ;      
        TFut => table {
          Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPres ! Pos ;
          Ga =>  \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                        qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPres ! Pos 
          } 
        } 
      } ;      
    te = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                    qs.s ! Wa ! st ++ "」と" ++ vq.te ! Pos ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                    qs.s ! Wa ! st ++ "」と" ++ vq.te ! Pos 
      } ; 
    ba = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は「" ++ 
                    qs.s ! Wa ! st ++ "」と" ++ vq.ba ! Pos ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が「" ++ 
                    qs.s ! Wa ! st ++ "」と" ++ vq.ba ! Pos 
      } ; 
    subj = table {
      Wa => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "は" ;
      Ga => \\st => t.s ++ np.prepositive ! st ++ np.s ! st ++ "が"
      } ;
    pred = case t.a of {
      Simul => \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! t.t ! Pos ;       
      Anter => case t.t of {
        TPres => \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos ;
        TPast => \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPast ! Pos ;
        TFut => \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.s ! st ! TPres ! Pos 
        } 
      } ;
    pred_te = \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.te ! Pos ; 
    pred_ba = \\st => "「" ++ qs.s ! Wa ! st ++ "」と" ++ vq.ba ! Pos 
    } ;
{-
FocusObjS, PastPartAgentAP,

ListVPI = E.ListVPI ;

  ListVPS = E.ListVPS ;
  
lin

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

----  EmptyRelSlash = E.EmptyRelSlash ;

lin
  that_RP = which_RP ;

-- lexical entries

--  another_Quant = mkQuantifier "otro" "otra" "otros" "otras" ;
--  some_Quant = mkQuantifier "algún" "alguna" "algunos" "algunas" ;
--  anySg_Det = mkDeterminer "algún" "alguna" Sg False ; ---- also meaning "whichever" ? 
--  each_Det = SyntaxJpn.every_Det ;

--  but_Subj = {s = "pero" ; m = Indic} ; ---- strange to have this as Subj

  CompoundN noun cn  = {s = noun.s ++ cn.s ; c = cn.c} ; ----
  CompoundAP noun adj = complexAP (noun.s ++ possessive_s ++ adj.s) ; ----


----  PastPartAP v = v ; ----


  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;


  PositAdVAdj a = {s = a.s} ;


  UseQuantPN q pn = {s = q.s ++ ge_s ++ pn.s} ; ---- ge

  SlashV2V v a p vp = 
    insertObj (ResJpn.mkNP (a.s ++ p.s ++ useVerb vp.verb ! p.p ! APlain ++ vp.compl))   
              (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ; ---- aspect


  SlashVPIV2V v p vpi = insertObjc (\\a => p.s ++ 
                                           v.c3 ++ 
                                           vpi.s ! VVAux ! a)
                                   (predVc v) ;


---- TODO: find proper expressions for OSV and OVS in Jpn
  PredVPosv np vp = G.PredVP np vp ; ---- (lin NP np) (lin VP vp) ; ----
  PredVPovs np vp = G.PredVP np vp ; ----  (lin NP np) (lin VP vp) ; ----


  CompS s = insertObj s (predV copula []) ; ----


  CompQS qs = insertObj (ss (qs.s ! False)) (predV copula []) ; ----
  CompVP ant p vp = insertObj (ss (infVP vp)) (predV copula []) ; ----


  VPSlashVS vs vp = 
    insertObj (\\a => infVP VVInf vp Simul CPos a) (predV vs []) **
    {c2 = ""; gapInMiddle = False} ;



  PastPartRS ant pol vp = { ---- copied from PresPartRS
       s = ant.s ++ pol.s ++ vp.prePart ++ useVerb vp.verb ! pol.p ! APlain ++ vp.compl ++ which_RP.s  ---- aspect
       } ; ---- ??


  PresPartRS ant pol vp = { ---- copied from RelVP
       s = ant.s ++ pol.s ++ vp.prePart ++ useVerb vp.verb ! pol.p ! APlain ++ vp.compl ++ which_RP.s  ---- aspect
       } ; ---- ??

    ComplVV v a p vp = {
      verb = v ;
      compl = a.s ++ p.s ++ vp.topic ++ vp.prePart ++ useVerb vp.verb ! p.p ! APlain ++ vp.compl ; ---- aspect
      prePart, topic = []
      } ;

  ApposNP np1 np2 = {
    s = np1.s ++ chcomma ++ np2.s
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;
-}

}
