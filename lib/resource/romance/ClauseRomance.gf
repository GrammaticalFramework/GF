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
  SPredV2A subj verb obj adj = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj)
        (\\_ =>  adj.s ! AF (pgen2gen obj.g) obj.n)) ;
  SPredVV subj verb vp = 
   sats2clause (
     insertExtrapos 
       (mkSats subj verb) 
       (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen subj.g ! subj.n ! subj.p)
     ) ;

  SPredObjV2V subj verb obj vp = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen obj.g ! obj.n ! obj.p)
      ) ;
  SPredSubjV2V subj verb obj vp = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen subj.g ! subj.n ! subj.p)
      ) ;

  SPredProgVP np vp = sats2clause (progressiveSats np vp) ;


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
  QPredV3 subj verb obj1 obj2 = 
    sats2quest (
      insertObject (mkSatsObject (intNounPhrase subj) verb obj1) verb.c3 verb.s3 obj2
      ) ;
  QPredReflV2 subj verb = 
    sats2quest (
      mkSatsObject (intNounPhrase subj)
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
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
     insertExtrapos (mkSats (intNounPhrase subj) verb) 
       (\\_ => adj.s ! AF subj.g subj.n)) ;
  QPredV2A subj verb obj adj = 
    sats2quest (
      insertExtrapos 
        (mkSatsObject (intNounPhrase subj) verb obj)
        (\\_ =>  adj.s ! AF (pgen2gen obj.g) obj.n)) ;
  QPredVV subj verb vp = 
   sats2quest (
     insertExtrapos 
       (mkSats (intNounPhrase subj) verb) 
       (\\_ =>  prepCase verb.c ++ 
                vp.s ! VIInfinit ! subj.g ! (intNounPhrase subj).n ! P3)
     ) ;
  QPredObjV2V subj verb obj vp = 
    sats2quest (
      insertExtrapos 
        (mkSatsObject (intNounPhrase subj) verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen obj.g ! obj.n ! obj.p)
      ) ;
  QPredSubjV2V subj verb obj vp = 
    sats2quest (
      insertExtrapos 
        (mkSatsObject (intNounPhrase subj) verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! subj.g ! subj.n ! P3)
      ) ;

  QPredAP subj adj = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (adj.s ! AF subj.g subj.n)) ;
  QPredCN subj cn = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (indefNoun subj.n cn)) ;
  QPredNP subj np = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (np.s ! stressed nominative)) ;
  QPredAdv subj adv = 
    sats2quest (mkSatsCopula (intNounPhrase subj) adv.s) ;

  QPredProgVP np vp = sats2quest (progressiveSats (intNounPhrase np) vp) ;

-----------

  RPredV  np v   = 
    sats2rel 
      (\g,n,p -> mkSats (relNounPhrase np g n p) v) ;
  RPredPassV subj v = 
    sats2rel 
      (\g,n,p -> mkSatsCopula  (relNounPhrase subj g n p) 
        (v.s ! VPart g n)) ;
  RPredV2 np v y = 
    sats2rel 
      (\g,n,p -> mkSatsObject (relNounPhrase np g n p) v y) ;

  RPredV3 subj verb obj1 obj2 = 
    sats2rel 
      (\g,n,p -> 
        insertObject (mkSatsObject (relNounPhrase subj g n p) verb
           obj1) verb.c3 verb.s3 obj2
      ) ;
  RPredReflV2 subj verb = 
    sats2rel (\g,n,p ->
      mkSatsObject (relNounPhrase subj g n p)
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        (reflPronNounPhrase g n p)) ;
  RPredVS subj verb sent = 
    sats2rel (\g,n,p ->
      insertExtrapos (mkSats (relNounPhrase subj g n p) verb) 
        (\\b => embedConj ++ sent.s ! subordMode verb b)) ; ---- mn
  RPredVQ subj verb quest = 
    sats2rel (\g,n,p ->
      insertExtrapos (mkSats (relNounPhrase subj g n p) verb) (\\_ => quest.s ! IndirQ)) ;
  RPredV2S subj verb obj sent = 
    sats2rel (\g,n,p ->
      insertExtrapos 
        (mkSatsObject (relNounPhrase subj g n p) verb obj)
        (\\b => embedConj ++ sent.s ! subordMode verb b)
        ) ; ---- mn ;
  RPredV2Q subj verb obj quest = 
    sats2rel (\g,n,p ->
      insertExtrapos 
        (mkSatsObject (relNounPhrase subj g n p) verb obj) 
        (\\_ => quest.s ! IndirQ)) ;
  RPredVA subj verb adj = 
   sats2rel (\g,n,p ->
     insertExtrapos (mkSats (relNounPhrase subj g n p) verb) 
       (\\_ => adj.s ! AF g n)) ;
  RPredV2A subj verb obj adj = 
    sats2rel (\g,n,p ->
      insertExtrapos 
        (mkSatsObject (relNounPhrase subj g n p) verb obj)
        (\\_ =>  adj.s ! AF (pgen2gen obj.g) obj.n)) ;
  RPredVV subj verb vp = 
   sats2rel (\g,n,p ->
     insertExtrapos 
       (mkSats (relNounPhrase subj g n p) verb) 
       (\\_ =>  prepCase verb.c ++ 
                vp.s ! VIInfinit ! g ! n ! p)
     ) ;
  RPredObjV2V subj verb obj vp = 
    sats2rel (\g,n,p ->
      insertExtrapos 
        (mkSatsObject (relNounPhrase subj g n p) verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen obj.g ! obj.n ! obj.p)
      ) ;
{- ----
  RPredSubjV2V subj verb obj vp = 
    sats2rel (\g,n,p ->
      insertExtrapos 
        (mkSatsObject (relNounPhrase subj g n p) verb obj)
        (\\_ => prepCase verb.c ++ vp.s ! VIInfinit ! g ! n ! p)
      ) ;
-}
  RPredAP subj adj = 
    sats2rel 
      (\g,n,p -> mkSatsCopula (relNounPhrase subj g n p) (adj.s ! AF g n)) ;
  RPredCN subj cn = 
    sats2rel 
      (\g,n,p -> mkSatsCopula (relNounPhrase subj g n p) (indefNoun n cn)) ;
  RPredNP subj np = 
    sats2rel 
      (\g,n,p -> mkSatsCopula (relNounPhrase subj g n p) (np.s ! stressed nominative)) ;
  RPredAdv subj adv = 
    sats2rel 
      (\g,n,p -> mkSatsCopula (relNounPhrase subj g n p) adv.s) ;

  RPredProgVP np vp = 
    sats2rel 
      (\g,n,p -> progressiveSats (relNounPhrase np g n p) vp) ;




----- gender and number of Adj

  IPredV v = 
    sats2verbPhrase (mkSats pronImpers v) ;
  IPredV2 v y = 
    sats2verbPhrase (mkSatsObject pronImpers v y) ;
  IPredAP adj = 
    sats2verbPhrase (mkSatsCopula pronImpers (adj.s ! AF Masc Sg)) ;
  IPredPassV v = 
    sats2verbPhrase (mkSatsCopula pronImpers (v.s ! VPart (pgen2gen pronImpers.g) pronImpers.n)) ;
  IPredV3 verb obj1 obj2 = 
    sats2verbPhrase (insertObject (mkSatsObject pronImpers verb obj1) verb.c3 verb.s3 obj2) ;
  IPredReflV2 verb = 
    sats2verbPhrase (
      mkSatsObject pronImpers
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        ---- {s = verb.s ; s2 = verb.s2 ; c = verb.c ; aux = AEsse}
        ---- this produces huge cf - find out why! AR 16/3/2005 
        (reflPronNounPhrase (pgen2gen pronImpers.g) pronImpers.n pronImpers.p)) ;
  IPredVS verb sent = 
    sats2verbPhrase (
      insertExtrapos (mkSats pronImpers verb) 
        (\\b => embedConj ++ sent.s ! subordMode verb b)) ; ---- mn
  IPredVQ verb quest = 
    sats2verbPhrase (
      insertExtrapos (mkSats pronImpers verb) (\\_ => quest.s ! IndirQ)) ;
  IPredV2S verb obj sent = 
    sats2verbPhrase (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\b => embedConj ++ sent.s ! subordMode verb b)
        ) ; ---- mn ;
  IPredV2Q verb obj quest = 
    sats2verbPhrase (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj) 
        (\\_ => quest.s ! IndirQ)) ;
  IPredVA verb adj = 
   sats2verbPhrase (
     insertExtrapos (mkSats pronImpers verb) (\\_ => adj.s ! AF (pgen2gen pronImpers.g) pronImpers.n)) ;
  IPredV2A verb obj adj = 
    sats2verbPhrase (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  adj.s ! AF (pgen2gen obj.g) obj.n)) ;
  IPredVV verb vp = 
   sats2verbPhrase (
     insertExtrapos 
       (mkSats pronImpers verb) 
       (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen pronImpers.g ! pronImpers.n ! pronImpers.p)
     ) ;

  IPredObjV2V verb obj vp = 
    sats2verbPhrase (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen obj.g ! obj.n ! obj.p)
      ) ;
  IPredSubjV2V verb obj vp = 
    sats2verbPhrase (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen pronImpers.g ! pronImpers.n ! pronImpers.p)
      ) ;


  IPredCN cn = 
    sats2verbPhrase (mkSatsCopula pronImpers (indefNoun pronImpers.n cn)) ;
  IPredNP np = 
    sats2verbPhrase (mkSatsCopula pronImpers (np.s ! stressed nominative)) ;
  IPredAdv adv = 
    sats2verbPhrase (mkSatsCopula pronImpers adv.s) ;

  IPredProgVP vp = sats2verbPhrase (progressiveSats pronImpers vp) ;



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
