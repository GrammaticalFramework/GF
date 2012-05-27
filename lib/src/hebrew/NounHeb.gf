concrete NounHeb of Noun = CatHeb ** open ResHeb, Prelude in {

  flags optimize=all_subs ; coding=utf8 ;

 lin

   DetCN det cn =  {
    	s = \\c => {obj = cn.s ! det.n  ! det.sp ++ det.s ! cn.g } ; 
 	isDef = det.isDef ;
	sp =  det.sp ;
        a = Ag cn.g det.n Per3 
      } ;
  
   AdjCN ap cn = 
      let 
        g = cn.g 
      in {
      	 s = \\sp => table {n => cn.s ! sp ! n ++  ap.s ! sp ! n  ! g}  ; 
         g = g 
      } ;

   UseN n = n ; 

   DefArt = {
      s = \\_,_ => ""  ;
      n = Sg ;
      sp = Def ;
      isSNum, isDef = True
      } ;

   IndefArt = { 
       s = \\_,_ => ""  ;
       n = Sg ;
       sp = Indef ;
       isSNum, isDef = False 
      } ; 

   DetQuant quant num = {
       s =  \\g =>  quant.s ! num.n ! g  ++ num.s ! Nom  ;  --- fix case 
       n = num.n;
       sp = Def ;
       isDef = True ;
       isSNum = False 
    } ;

   NumSg = {s = \\_ => []; n = Sg} ;
   NumPl = {s = \\_ => []; n = Pl} ;

   UsePN pn = {
      s = \\c =>  {obj = pn.s ! Nom} ;  --TODO define a function for case
      a = Ag pn.g Sg Per3;   
      sp = Def ; 
      isDef = False  
   } ; 
    
   UsePron p = p ;
    
}
