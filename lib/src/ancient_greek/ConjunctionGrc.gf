--# -path=.:../abstract

concrete ConjunctionGrc of Conjunction = 
    CatGrc ** open ResGrc, Coordination, Prelude in {

 flags optimize=all_subs ;

 lin

   ConjS = conjunctDistrSS ;

   ConjAdv = conjunctDistrSS ;

   ConjNP conj ss = -- TODO: adapt to proper nps later
     let 
       bigNPs = conjunctDistrTable Case conj ss 
     in 
     { s = \\c => bigNPs.s ! c } ** {
       a = conjAgr (agrP3 conj.n) ss.a ;
       e = \\_ => [] ;
       isPron = False       
     } ;

   ConjAP conj ss = conjunctDistrTable AForm conj ss ;

   ConjCN conj ss = 
     let bigCNs = conjunctDistrTable2 Number Case conj ss 
     in
     { s = bigCNs.s ;
       s2 = \\n,c => [] ;
       isMod = True ;
       rel = \\_ => [] ;
       g = Neutr -- irrelevant
     } ;

-- These fun's are generated from the list cat's.

   BaseS = twoSS ;
   ConsS = consrSS comma ;
   BaseAdv = twoSS ;
   ConsAdv = consrSS comma ;
   BaseNP x y = 
     { s1 = bigNP x ; s2 = bigNP y ; a = conjAgr x.a y.a } ;
   ConsNP x xs = 
     { s1 = \\c => (bigNP x) ! c ++ comma ++ xs.s1 ! c ;
       s2 = xs.s2 ;
       a = conjAgr x.a xs.a } ;
   BaseAP x y  = 
     { s1 = bigAP x ; s2 = bigAP y } ;
   ConsAP x xs = 
     { s1 = \\a => (bigAP x) ! a ++ comma ++ xs.s1 ! a ;
       s2 = xs.s2 } ;
   BaseCN x y = 
     { s1 = bigCN x ; s2 = bigCN y } ;
   ConsCN x xs =
     { s1 = \\n,c => bigCN x ! n ! c ++ comma ++ xs.s1 ! n ! c ;
       s2 = xs.s2 } ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Case => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str} ;
    [CN] = {s1,s2 : Number => Case => Str} ;

  oper
    bigAP : AP -> AForm => Str = 
      \ap -> \\a => ap.s ! a ; -- TODO: add objects of adjective
    bigNP : NP -> Case => Str  = 
      \np -> \\c => case np.isPron of { False => np.s ! c ; True => np.e ! c } ;
    bigCN : CN -> Number => Case => Str = -- TODO: add ..., *if* cn.rel is nonempty
      \cn -> \\n,c => cn.s2 ! n ! c ++ cn.s ! n ! c ; -- ++ comma ++ cn.rel ! n ;
}

