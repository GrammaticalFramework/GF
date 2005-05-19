--# -path=.:../abstract:../../prelude

incomplete concrete ClauseRomance of Clause = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

  flags optimize=all ; --- parametrize much worse, 15/2

  lin
  SPredV  np v   = 
    sats2clause (mkSats np v) ;
  SPredPassV subj v = 
    sats2clause (mkSatsCopula subj (v.s ! VPart (pgen2gen subj.g) subj.n)) ;
  SPredV2 np v y = 
    sats2clause (mkSatsObject np v y) ;
  SPredV3 subj verb obj1 obj2 = 
    sats2clause (insertObject (mkSatsObject subj verb obj1) verb.c3 verb.s3 obj2) ;

  SPredReflV2 subj verb = 
    sats2clause (
      mkSatsObject subj
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        ---- {s = verb.s ; s2 = verb.s2 ; c = verb.c ; aux = AEsse}
        ---- this produces huge cf - find out why! AR 16/3/2005 
        (reflPronNounPhrase (pgen2gen subj.g) subj.n subj.p)) ;

  SPredVS subj verb sent = 
    sats2clause (
      insertExtrapos (mkSats subj verb) 
        (\\b => embedConj ++ sent.s ! subordMode verb b)) ; ---- mn
  SPredVQ subj verb quest = 
    sats2clause (
      insertExtrapos (mkSats subj verb) (\\_ => quest.s ! IndirQ)) ;
  SPredV2S subj verb obj sent = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj)
        (\\b => embedConj ++ sent.s ! subordMode verb b)
        ) ; ---- mn ;
  SPredV2Q subj verb obj quest = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj) 
        (\\_ => quest.s ! IndirQ)) ;
  SPredVA subj verb adj = 
   sats2clause (
     insertExtrapos (mkSats subj verb) (\\_ => adj.s ! AF (pgen2gen subj.g) subj.n)) ;

  SPredVV subj verb vp = 
   sats2clause (
     insertExtrapos 
       (mkSats subj verb) 
       (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen subj.g ! subj.n ! subj.p)
     ) ;

--  SPredObjV2V 

--  SPredProgVP

--  SPredSubjV2V

--  SPredV2A


  SPredAP subj adj = 
    sats2clause (mkSatsCopula subj (adj.s ! AF (pgen2gen subj.g) subj.n)) ;
  SPredCN subj cn = 
    sats2clause (mkSatsCopula subj (indefNoun subj.n cn)) ;
  SPredNP subj np = 
    sats2clause (mkSatsCopula subj (np.s ! stressed nominative)) ;
  SPredAdv subj adv = 
    sats2clause (mkSatsCopula subj adv.s) ;

--------

  QPredV  np v   = 
    sats2quest (mkSats (intNounPhrase np) v) ;

  QPredPassV subj v = 
    sats2quest (mkSatsCopula  (intNounPhrase subj) (v.s ! VPart subj.g subj.n)) ;
  QPredV2 np v y = 
    sats2quest (mkSatsObject (intNounPhrase np) v y) ;
--  QPredV3 subj verb obj1 obj2 = 
--    sats2quest (insertObject (mkSatsObject (intNounPhrase subj) verb obj1) verb.c3 verb.s3 obj2) ;

  QPredReflV2 subj verb = 
    sats2quest (
      mkSatsObject (intNounPhrase subj)
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        ---- {s = verb.s ; s2 = verb.s2 ; c = verb.c ; aux = AEsse}
        ---- this produces huge cf - find out why! AR 16/3/2005 
        (reflPronNounPhrase subj.g subj.n P3)) ;

  QPredVS subj verb sent = 
    sats2quest (
      insertExtrapos (mkSats (intNounPhrase subj) verb) 
        (\\b => embedConj ++ sent.s ! subordMode verb b)) ; ---- mn
  QPredVQ subj verb quest = 
    sats2quest (
      insertExtrapos (mkSats (intNounPhrase subj) verb) (\\_ => quest.s ! IndirQ)) ;
  QPredV2S subj verb obj sent = 
    sats2quest (
      insertExtrapos 
        (mkSatsObject (intNounPhrase subj) verb obj)
        (\\b => embedConj ++ sent.s ! subordMode verb b)
        ) ; ---- mn ;
  QPredV2Q subj verb obj quest = 
    sats2quest (
      insertExtrapos 
        (mkSatsObject (intNounPhrase subj) verb obj) 
        (\\_ => quest.s ! IndirQ)) ;
  QPredVA subj verb adj = 
   sats2quest (
     insertExtrapos (mkSats (intNounPhrase subj) verb) (\\_ => adj.s ! AF subj.g subj.n)) ;

  QPredVV subj verb vp = 
   sats2quest (
     insertExtrapos 
       (mkSats (intNounPhrase subj) verb) 
       (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! subj.g ! (intNounPhrase subj).n ! P3)
     ) ;

--  QPredObjV2V 

--  QPredProgVP

--  QPred(IntNounPhrase Subj)V2V

--  QPredV2A


  QPredAP subj adj = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (adj.s ! AF subj.g subj.n)) ;
  QPredCN subj cn = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (indefNoun subj.n cn)) ;
  QPredNP subj np = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (np.s ! stressed nominative)) ;
  QPredAdv subj adv = 
    sats2quest (mkSatsCopula (intNounPhrase subj) adv.s) ;


{-
-- Use VPs

  PredVP = predVerbGroupClause ;
  IntVP = intVerbPhrase ;
  RelVP = relVerbPhrase ;


  PosVP tp = predVerbGroup True tp.a ;
  NegVP tp = predVerbGroup False tp.a ;

  AdvVP = adVerbPhrase ;
  SubjVP = subjunctVerbPhrase ;
-}



}
