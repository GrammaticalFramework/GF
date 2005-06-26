--# -path=.:../abstract:../../prelude

concrete ClauseFin of Clause = CategoriesFin ** 
  open Prelude, SyntaxFin in {

  flags optimize=all ;

  lin
  SPredV  np v   = 
    sats2clause (mkSats np v) ;
----  SPredPassV subj v = 
----    sats2clause (mkSatsCopula subj (v.s ! VPart (pgen2gen subj.g) subj.n)) ;
  SPredV2 np v y = 
    sats2clause (mkSatsObject np v y) ;
  SPredV3 subj verb obj1 obj2 = 
    sats2clause (
      insertObject (mkSatsObject subj verb obj1) verb.c2 verb.s5 verb.s6 obj2) ;
----  SPredReflV2 subj verb = 
----    sats2clause (
----      mkSatsObject subj
----        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
----        (reflPronNounPhrase (pgen2gen subj.g) subj.n subj.p)) ;
  SPredVS subj verb sent = 
    sats2clause (
      insertComplement (mkSats subj verb) sent.s) ;
  SPredVQ subj verb quest = 
    sats2clause (
      insertComplement (mkSats subj verb) quest.s) ;
  SPredV2S subj verb obj sent = 
    sats2clause (
      insertComplement
        (mkSatsObject subj verb obj)
        sent.s
        ) ;
  SPredV2Q subj verb obj quest = 
    sats2clause (
      insertComplement 
        (mkSatsObject subj verb obj) 
        quest.s
        ) ;
  SPredVA subj verb adj = 
   sats2clause (
     insertComplement (mkSats subj verb) (adj.s ! APred ! AN (NCase subj.n verb.c))) ;
  SPredV2A subj verb obj adj = 
    sats2clause (
      insertComplement 
        (mkSatsObject subj verb obj)
        (adj.s ! APred ! AN (NCase subj.n verb.c2))
      ) ;
  SPredVV subj verb vp = 
   sats2clause (
     insertComplement 
       (mkSats subj verb) 
       (vp.s ! VIInfinit)
     ) ;
  SPredObjV2V subj verb obj vp = 
    sats2clause (
      insertComplement 
        (mkSatsObject subj verb obj)
        (vp.s ! VIInfinit)
      ) ;
  SPredSubjV2V subj verb obj vp = 
    sats2clause (
      insertComplement 
        (mkSatsObject subj verb obj)
        (vp.s ! VIInfinit)
      ) ;
{-
  SPredProgVP np vp = sats2clause (progressiveSats np vp) ;
-}

  SPredAP subj adj = 
    sats2clause (mkSatsCopula subj (complAdjPhrase subj.n adj)) ;
  SPredCN subj cn = 
    sats2clause (mkSatsCopula subj (complCommNoun subj.n cn)) ;
  SPredNP subj np = 
    sats2clause (mkSatsCopula subj (np.s ! NPCase Nom)) ;
  SPredAdv subj adv = 
    sats2clause (mkSatsCopula subj adv.s) ;

--------
{-
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

--  QPredProgVP

  QPredAP subj adj = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (adj.s ! AF subj.g subj.n)) ;
  QPredCN subj cn = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (indefNoun subj.n cn)) ;
  QPredNP subj np = 
    sats2quest (mkSatsCopula (intNounPhrase subj) (np.s ! stressed nominative)) ;
  QPredAdv subj adv = 
    sats2quest (mkSatsCopula (intNounPhrase subj) adv.s) ;

  QPredProgVP np vp = sats2quest (progressiveSats (intNounPhrase np) vp) ;


----- gender and number of Adj

  IPredV a v = 
    sats2verbPhrase a (mkSats pronImpers v) ;
  IPredV2 a v y = 
    sats2verbPhrase a (mkSatsObject pronImpers v y) ;
  IPredAP a adj = 
    sats2verbPhrase a (mkSatsCopula pronImpers (adj.s ! AF Masc Sg)) ;
  IPredPassV a v = 
    sats2verbPhrase a (mkSatsCopula pronImpers (v.s ! VPart (pgen2gen pronImpers.g) pronImpers.n)) ;
  IPredV3 a verb obj1 obj2 = 
    sats2verbPhrase a (insertObject (mkSatsObject pronImpers verb obj1) verb.c3 verb.s3 obj2) ;
  IPredReflV2 a verb = 
    sats2verbPhrase a (
      mkSatsObject pronImpers
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        ---- {s = verb.s ; s2 = verb.s2 ; c = verb.c ; aux = AEsse}
        ---- this produces huge cf - find out why! AR 16/3/2005 
        (reflPronNounPhrase (pgen2gen pronImpers.g) pronImpers.n pronImpers.p)) ;
  IPredVS a verb sent = 
    sats2verbPhrase a (
      insertExtrapos (mkSats pronImpers verb) 
        (\\b => embedConj ++ sent.s ! subordMode verb b)) ; ---- mn
  IPredVQ a verb quest = 
    sats2verbPhrase a (
      insertExtrapos (mkSats pronImpers verb) (\\_ => quest.s ! IndirQ)) ;
  IPredV2S a verb obj sent = 
    sats2verbPhrase a (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\b => embedConj ++ sent.s ! subordMode verb b)
        ) ; ---- mn ;
  IPredV2Q a verb obj quest = 
    sats2verbPhrase a (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj) 
        (\\_ => quest.s ! IndirQ)) ;
  IPredVA a verb adj = 
   sats2verbPhrase a (
     insertExtrapos (mkSats pronImpers verb) (\\_ => adj.s ! AF (pgen2gen pronImpers.g) pronImpers.n)) ;
  IPredV2A a verb obj adj = 
    sats2verbPhrase a (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  adj.s ! AF (pgen2gen obj.g) obj.n)) ;
  IPredVV a verb vp = 
   sats2verbPhrase a (
     insertExtrapos 
       (mkSats pronImpers verb) 
       (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen pronImpers.g ! pronImpers.n ! pronImpers.p)
     ) ;

  IPredObjV2V a verb obj vp = 
    sats2verbPhrase a (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen obj.g ! obj.n ! obj.p)
      ) ;
  IPredSubjV2V a verb obj vp = 
    sats2verbPhrase a (
      insertExtrapos 
        (mkSatsObject pronImpers verb obj)
        (\\_ =>  prepCase verb.c ++ vp.s ! VIInfinit ! pgen2gen pronImpers.g ! pronImpers.n ! pronImpers.p)
      ) ;


  IPredCN a cn = 
    sats2verbPhrase a (mkSatsCopula pronImpers (indefNoun pronImpers.n cn)) ;
  IPredNP a np = 
    sats2verbPhrase a (mkSatsCopula pronImpers (np.s ! stressed nominative)) ;
  IPredAdv a adv = 
    sats2verbPhrase a (mkSatsCopula pronImpers adv.s) ;

  IPredProgVP a vp = sats2verbPhrase a (progressiveSats pronImpers vp) ;

-}

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