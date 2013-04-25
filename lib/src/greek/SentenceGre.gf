concrete SentenceGre of Sentence = CatGre ** open Prelude, ResGre,ParadigmsGre  in {

  flags coding= utf8;

  lin

    PredVP np vp = predVPPol np.isNeg ((np.s ! Nom).comp) np.a vp ;
----    PredVP np vp = predVPPol np.isNeg ((np.s ! Nom).comp | [] ) np.a vp ; -- AR removed empty subject variant

    PredSCVP sc vp = predVP sc.s (agrP3 Neut Sg) vp ;



    SlashVP np v2 =  {s = \\agr =>
    let 
      vp = v2
    in 
     (predVP  (np.s ! Nom).comp np.a vp).s ;n3 = v2.n3 ; c2 = v2.c2 };


     AdvSlash slash adv = {
        s  = \\ag,o,m,t,a,p => slash.s !ag ! o ! m ! t! a ! p ++ adv.s ;
        n3 = slash.n3 ;
        c2 = slash.c2
     } ;


     SlashPrep cl prep = {
        s  = \\_ => cl.s ; 
        n3 = \\_ => [] ;
        c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;


    SlashVS np vs slash = {
    s = \\ag =>
        (predVP 
          (np.s ! Nom).comp  np.a
          (insertComplement (\\b => conjThat ++ slash.s ! ag ! Ind)
            (predV vs))).s 
      } ** {n3 = slash.n3 ; c2 = slash.c2};


    ImpVP vp = {
      s = \\pol,n,aspect=> 
      let 
          a   = Ag  Masc Sg P2 ;
          a2  = Ag  Masc Pl P2 ;
      in
         case <pol,n,aspect> of {
            <Pos,Sg,Perf> =>   vp.v.s ! VImperative Perf Sg Active ++ vp.clit ++ vp.clit2 ++ vp.comp ! a ;
            <Pos,Pl,Perf> =>   vp.v.s ! VImperative Perf Pl Active  ++ vp.clit ++ vp.clit2 ++vp.comp ! a2 ;
            <Pos,Sg,Imperf> =>   vp.v.s ! VImperative Imperf Sg Active ++ vp.clit ++ vp.clit2 ++ vp.comp ! a ;
            <Pos,Pl,Imperf> =>   vp.v.s ! VImperative Imperf Pl Active  ++ vp.clit ++ vp.clit2 ++vp.comp ! a2 ;
            <Neg,Sg,Perf> => "μην" ++  vp.clit ++ vp.clit2 ++ vp.v.s ! VPres Con  Sg P2 Active Perf++ vp.comp ! a ;
            <Neg,Pl,Perf> => "μην" ++  vp.clit ++ vp.clit2++ vp.v.s ! VPres Con  Pl P2 Active Perf++ vp.comp ! a2;
            <Neg,Sg,Imperf> => "μην" ++  vp.clit ++ vp.clit2 ++ vp.v.s ! VPres Ind  Sg P2 Active Perf++ vp.comp ! a ;
            <Neg,Pl,Imperf> => "μην" ++  vp.clit ++ vp.clit2++ vp.v.s ! VPres Ind  Pl P2 Active Perf++ vp.comp ! a2
            } ;   
          } ;


    EmbedS  s  = {s =  conjThat ++ s.s ! Ind} ;

    EmbedQS qs = {s = qs.s ! QIndir} ;

    EmbedVP vp = {s = (predVP [] (Ag Masc Sg P3) vp).s ! Main !  TPres ! Simul ! Pos !Con}; 

   
 
    UseCl t p cl = {s = \\o => t.s ++ p.s ++ cl.s !Main !  t.t !t.a! p.p !  t.m  } ;
    
  
    UseQCl t p cl = {
     s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
     } ;


    UseRCl t p cl = {
      s = \\r,ag => t.s ++ p.s ++ cl.s ! ag ! t.t ! t.a ! p.p ! r ; 
      c = cl.c
      } ;
  
   UseSlash t p cl = {
     s = \\ag,m => 
       t.s ++ p.s ++ cl.s ! ag ! Main  ! t.t ! t.a ! p.p ! m ;
       n3 = cl.n3 ;
       c2 = cl.c2
    } ;
    
   AdvS a s ={s = \\m => a.s ++ s.s ! m} ;  

   ExtAdvS a s ={s = \\m => a.s ++ "," ++ s.s ! m} ;   

   SSubjS a s b = {
      s = \\m => a.s  !m ++ s.s ++ b.s ! s.m
      } ;

   RelS s r = {
      s = \\o => s.s ! o ++ "," ++ r.s ! Ind ! agrP3 Neut Sg
      } ;

}