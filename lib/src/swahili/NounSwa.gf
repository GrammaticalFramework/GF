
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


--   Num

    NumSg = {s = \\_ => [] ; n = Sg} ;
    NumPl = {s = \\_ => [] ; n = Pl} ; 


    DetQuant quant num = {
 	s = \\g,c,anim => quant.s ! num.n ! g ! anim ! c ++ num.s ! g; 
        n = num.n               
      };

    AdjCN ap cn = 
      let 
        anim = cn.anim ;
        g = cn.g;
	mod = cn.hasAdj 
        in{
	 s  = \\n =>  cn.s ! n ++  ap.s ! (AF n g anim) ;
        s1 = \\n =>  cn.s1 ! n;
	s2=case <mod> of {
	<False> => \\n =>  ap.s ! (AF n g anim);		   
	<True> => \\n =>  cn.s2 ! n ++ ap.s ! (AF n g anim)  				
	};          
        g = g ;
        anim = anim ;
        hasAdj=True
         
        } ;

     
   --DetCN   : Det -> CN -> NP ;   -- mtu huyo

  
     DetCN det cn = 
     let 
        anim = cn.anim ;
        g = cn.g ;
        n = det.n ;     
        mod = cn.hasAdj 
      		in case <mod> of {
        	<False> => {
                s = \\c => cn.s ! n ++ det.s ! g ! c ! anim  ;
                a = agr n g anim P3
                } ;
        	<True> => {
                s = \\c => cn.s1 ! n ++ det.s ! g ! c ! anim ++ cn.s2 ! n  ; 
                a = agr n g anim P3
                }
       };

    
   




}
