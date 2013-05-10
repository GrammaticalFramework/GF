concrete VerbGre of Verb = CatGre ** open ResGre,CommonGre, Prelude in {

  flags coding = utf8;

  lin

    UseV v = predV v ;


    ComplVV v vp = 
      insertComplement (\\a => case a of {
        Ag _ n p  => let vo= vp.voice ; as = vp.aspect  in  "να" ++ vp.clit  ++ vp.clit2 ++ vp.v.s ! VPres Con n p vo as ++ vp.comp ! a}) (predV v) ;


    ComplVS v s = 
      insertComplement(\\_ => "ότι" ++ s.s ! Ind) (predV v);
      
    ComplVQ v q = 
      insertComplement  (\\_ => q.s ! QIndir) (predV v) ;


    ComplVA v ap = insertComplement  (\\a => case a of {
      Ag g n _ => ap.s ! Posit ! g ! n ! Nom } ) (predV v) ;

    SlashV2a v =  mkVPSlash v.c2 (predV v)** {n3 = \\_ => [] ;c2 = v.c2 } ;

    Slash2V3 v np = mkVPSlash v.c3 (insertObject v.c2 np (predV v)) ** {n3 = \\_ => [] ;c2 = v.c3 } ;

    Slash3V3 v np = mkVPSlash v.c2 (insertObject v.c3 np (predV v))** {n3 = \\_ => []; c2 = v.c2 } ;

    SlashV2V v vp = mkVPSlash v.c2 ( predV v) ** {
      n3 = \\a =>  
          let agr = clitAgr a ;
          vo = vp.voice ;
          as = vp.aspect  
          in   
            v.c3.s  ++ "να" ++ vp.clit ++ vp.clit2  ++ vp.v.s ! VPres Con agr.n agr.p vo as ++ vp.comp! a  ; 
      c2 = v.c2
      } ;
    

    SlashV2S v s =  mkVPSlash v.c2 (predV v) ** {
      n3 = \\_ => "οτι" ++ s.s ! Ind;
      c2 = v.c2
      }  ;


   SlashV2Q v q =  mkVPSlash v.c2 (predV v )** {
      n3 = \\_ => q.s ! QIndir;
      c2 = v.c2
      } ; 


   SlashV2A v ap =  mkVPSlash v.c2 (predV v )** {
      n3 =\\a => let agr = complAgr a  in  ap.s ! Posit !  agr.g ! agr.n ! Acc ;
      c2 = v.c2
     } ;

   
 
    ComplSlash vp np = insertObject vp.c2 np (insertComplement (\\a => vp.c2.s  ++ vp.n3 ! np.a ) vp )  ;

  
    SlashVV v vp = 
      insertComplement (\\a => case a of {
      Ag _ n p  => let vo=vp.voice ; as =vp.aspect in "να" ++ vp.clit  ++ vp.clit2 ++ vp.v.s ! VPres Con n p vo as++ vp.comp ! a})
      (predV v) ** {n3 = vp.n3 ; c2 = vp.c2} ;


    SlashV2VNP v np vp = 
      mkVPSlash vp.c2( insertObject v.c2 np (predV v)) ** {
      n3 = \\a => 
          let agr = clitAgr a ;
          vo=vp.voice ; 
          as =vp.aspect  
          in   
            v.c2.s  ++ "να" ++ vp.clit ++ vp.clit2  ++ vp.v.s ! VPres Con agr.n agr.p vo as ++ vp.comp! a  ; 
      c2 = v.c2
      } ;

  
     ReflVP v = insertComplement (\\a => v.c2.s ++ reflPron ! a ! Acc) v ;

     UseComp comp = insertComplement comp.s (predV copula) ;

     PassV2 v = let vp = predV v in {
        v = v ; 
        clit = [] ;
        clit2 = [] ; 
        comp   = \\a => [] ;
        isNeg = False; 
        voice = Passive ;
        aspect = vp.aspect;
        } ;

 
     AdvVP vp adv = insertAdv adv.s vp ;

     AdVVP adv vp=  insertAdV adv.s vp ; 

     AdvVPSlash vp adv = insertAdv adv.s vp ** {n3 = \\_ => [] ;c2 = vp.c2} ;

     AdVVPSlash adv vp = insertAdV adv.s vp ** {n3 = \\_ => [] ;c2 = vp.c2} ;

     VPSlashPrep vp prep = vp ** {n3 = \\_ => [] ;
      c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;      
   
    
     CompAP ap = {s=\\a => case a of {      
          Ag g n _ => ap.s ! Compar!  g ! n ! Nom
        } 
      } ;

      CompNP np = {s = \\_  => (np.s ! Nom).comp} ;

      CompAdv a = {s = \\_  => a.s} ;      

      CompCN cn = {s=\\a => case a of {      
          Ag _ n p => cn.s !  n ! Nom
         } 
      } ;
    
      UseCopula = predV copula ;

 
}
