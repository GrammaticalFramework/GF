--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete PhrasePol of Phrase = CatPol ** open Prelude, ResPol, VerbMorphoPol in {

 lin
   PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

   UttS s = s ;
   UttQS qs = {s = qs.s} ;
   UttImpSg  pol imp = {s = imp.s !pol.p ! Sg} ;
   UttImpPl  pol imp = {s = imp.s !pol.p ! Pl} ;
   UttImpPol pol imp = {s = imp.s !pol.p ! Sg} ;

   UttIP ip = {s = ip.nom};
   UttIAdv iadv = iadv ;
   UttNP np = {s = np.nom};
   UttVP vp = { -- I assume the positive polarization to avoid variants
        s = vp.prefix ++
            (infinitive_form vp.verb vp.imienne Pos) ++ 
            vp.sufix !Pos !MascAniSg 
   };
   UttAdv adv = adv ;
   UttCN n = {s = n.s ! Sg ! Nom};
   UttAP ap = {s = ap.s ! AF MascPersSg Nom} ;
   UttCard c = {s = c.s ! Nom ! Fem } ;
   
   NoPConj = {s = []} ;
   PConjConj conj = {s = conj.s2} ; ---

   NoVoc = {s = []} ;
   VocNP np = {s = "," ++ np.voc} ;

}
