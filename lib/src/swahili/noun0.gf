
concrete NounSwa of Noun = CatSwa ** open MorphoSwa, ResSwa, Prelude in {

  flags optimize=all_subs ;

lin 

  UseN noun = {
   s  = noun.s ;
   s1 = noun.s ;
   s2 = noun.s ;
   g = noun.g ;
   anim  = noun.anim ;
   hasAdj = False
   } ;

  UseN2 noun = {
   s  = noun.s ;
   s1 = noun.s ;
   s2 = noun.s ;
   g = noun.g ;
   anim  = noun.anim ;
   hasAdj = False
   } ;


{--  Use2N3 noun = {
   s  = noun.s ;
   s1 = noun.s ;
   s2 = noun.s ;
   g = noun.g ;
   anim  = noun.anim ;
   hasAdj = False;
   c2 = noun.c2
   } ;


 --}  
     




  {--
     AdjCN ap cn = 
      let 
        anim = cn.anim ;
        g = cn.g 
      in {
        s  = \\n =>  cn.s ! n ++  ap.s ! (AF n g anim) ;
        s1 = \\n =>  cn.s ! n ;
        s2 = \\n =>  ap.s ! (AF n g anim) ;
        g = g ;
        anim = anim ;
        hasAdj = True 
        } ;


     AdjCN ap cn = 
      let 
        anim = cn.anim ;
        g = cn.g;
	mod = cn.hasAdj 
        in{
	 s  = \\n =>  cn.s ! n ++  ap.s ! (AF n g anim) ;
        s1 = \\n =>  cn.s1 ! n;
	--s2 = \\n =>  cn.s2 ++ ap.s ! (AF n g anim) ; 
         s2=case <mod> of {
	<False> => \\n =>  ap.s ! (AF n g anim);		   
	<True> => \\n =>  cn.s2 ! n ++ ap.s ! (AF n g anim)  				
	};          
        g = g ;
        anim = anim ;
        hasAdj=True
         
        } ;
--}

--   Num

    NumSg = {s = \\_ => [] ; n = Sg} ;
    NumPl = {s = \\_ => [] ; n = Pl} ; 
    
  
--    DetQuant : Quant -> Num -> Det ;  -- these five
--    Det = {s : Gender => Animacy => Case => Str ; n : Number} ;
--    Quant   = {s : Number => Gender => Animacy => Case => Str} ;
--    Num = {s : Gender => Animacy => Str ; n : Number} ;


      DetQuant quant num = {
 	s = \\g,anim,c => quant.s ! num.n ! g ! anim ! c ++ num.s ! g ; 
        n = num.n        
      };

--DetCN   : Det -> CN -> NP ;   -- mtu huyo

{--  
     DetCN det cn = 
     let 
        anim = cn.anim ;
        g = cn.g ;
        n = det.n ;     
        mod = cn.hasAdj 
      		in case <mod> of {
        	<False> => {
                --s = \\c => n ++ det.s ! g ! c ++ cn.s ! n ++ det.s2 ;
		s =\\c => c ++ cn.s ! n ++ det.s ! g ! anim ;
                a = agr n g anim P3
                } ;
        	<True> => {
                s =   cn.s1 ! n ++ det.s ! g ! anim ++ cn.s2 ! n ; 
                a = agr n g anim P3
                }
       };
--}





}
