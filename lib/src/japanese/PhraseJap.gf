concrete PhraseJap of Phrase = CatJap
** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lin
    
    PhrUtt pconj utt voc = {
      s = case voc.please of {
        True => pconj.s ++ utt.s ! Resp ++ voc.s ! Resp ;
        False => (voc.s ! Resp ++ pconj.s ++ utt.s ! Resp | 
                  voc.s ! Plain ++ pconj.s ++ utt.s ! Plain)
        } 
      } ;
    
    UttS sent = {s = \\st => sent.s ! (Wa|Ga) ! st} ;

    UttQS s = {s = \\st => s.s ! (Wa | Ga) ! st ++ "か"} ;
    
    UttImpSg p imp = {s = \\st => p.s ++ imp.s ! st ! p.b} ;
    
    UttImpPl = UttImpSg ;
    
    UttImpPol p imp = {s = \\st => p.s ++ imp.s ! Resp ! p.b} ;
    
    UttIP ip = {s = \\st => ip.s ! st ++ "ですか"} ;
    
    UttIAdv iadv = {s = \\st => iadv.s ! st ++ "ですか"} ;
    
    UttNP np = {s = \\st => np.prepositive ! st ++ np.s ! st} ;
    
    UttAdv adv = {s = \\st => adv.s ! st} ;
    
    UttVP vp = {s = \\st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
                vp.verb ! (Anim | Inanim) ! st ! (TPres | TPast | TFut) ! (Pos | Neg)} ;
                
    UttCN cn = {s = \\st => cn.prepositive ! st ++ cn.object ! st ++ cn.s ! (Sg | Pl) ! st} ;
    
    UttCard card = {s = \\st => card.s ++ card.postpositive} ;
    
    UttAP ap = {s = \\st => ap.prepositive ! st ++ ap.attr ! st} ;
    
    UttInterj interj = {s = \\st => interj.s} ;
    
    NoPConj = ss "" ;
    
    PConjConj conj = {s = conj.s} ;
    
    NoVoc = {s = \\st => [] ; please = False} ;
    
    VocNP np = {s = \\st => np.prepositive ! st ++ np.s ! st ; please = False} ;
}
