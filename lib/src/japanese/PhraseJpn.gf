concrete PhraseJpn of Phrase = CatJpn
** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lin
    
    PhrUtt pconj utt voc = {
      s = case voc.type of {
        Please => case utt.type of {
          ImpPolite => pconj.s ++ utt.s ! Wa ! Resp ++ voc.null ;
          (Imper|NoImp) => pconj.s ++ utt.s ! Wa ! Resp ++ voc.s ! Resp
          } ;
        VocPres => case utt.type of {
          ImpPolite => voc.s ! Resp ++ "、" ++ pconj.s ++ utt.s ! Wa ! Resp ;
          Imper => voc.s ! Plain ++ "、" ++ pconj.s ++ utt.s ! Wa ! Plain ;
          NoImp => voc.s ! Plain ++ "、" ++ pconj.s ++ utt.s ! Wa ! Plain
          } ;
        VocAbs => case utt.type of {
          (Imper|ImpPolite) => voc.s ! Plain ++ pconj.s ++ utt.s ! Wa ! Plain ;
          NoImp => voc.s ! Plain ++ pconj.s ++ utt.s ! Wa ! Plain
          }
        } 
      } ;
    
    UttS sent = {s = \\part,st => sent.s ! part ! st ; type = NoImp} ;

    UttQS s = {s = \\part,st => s.s ! part ! st ; type = NoImp} ;
    
    UttImpSg p imp = {s = \\part,st => p.s ++ imp.s ! st ! p.b ; type = Imper} ;
    
    UttImpPl = UttImpSg ;
    
    UttImpPol p imp = {s = \\part,st => p.s ++ imp.s ! Resp ! p.b ++ "ください" ; type = ImpPolite} ;
    
    UttIP ip = {s = \\part,st => ip.s_subj ! st ; type = NoImp} ;
    
    UttIAdv iadv = {s = \\part,st => iadv.s ! st ; type = NoImp} ;
    
    UttNP np = {s = \\part,st => np.prepositive ! st ++ np.s ! st ; type = NoImp} ;
    
    UttAdv adv = {s = \\part,st => adv.s ! st ; type = NoImp} ;
    
    UttVP vp = {s = \\part,st => vp.prepositive ! st ++ vp.obj ! st ++ vp.prep ++ 
       vp.verb ! SomeoneElse ! Inanim ! st ! TPres ! Pos ; type = NoImp} ;
                
    UttCN cn = {s = \\part,st => cn.prepositive ! st ++ cn.object ! st ++ cn.s ! Sg ! st ; 
                type = NoImp} ;
    
    UttCard card = {s = \\part,st => card.s ++ card.postpositive ; type = NoImp} ;
    
    UttAP ap = {s = \\part,st => ap.prepositive ! st ++ ap.attr ! st ; type = NoImp} ;
    
    UttInterj interj = {s = \\part,st => interj.s ; type = NoImp} ;
    
    NoPConj = ss "" ;
    
    PConjConj conj = {s = conj.s} ;
    
    NoVoc = {s = \\st => [] ; type = VocAbs ; null = ""} ;
    
    VocNP np = {s = \\st => np.prepositive ! st ++ np.s ! st ; type = VocPres ; null = ""} ;
}
