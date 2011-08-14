--# -path=alltenses

concrete GrammarHeb of Grammar = open ResHeb, Prelude in {

  lincat  

    Cl = {s : ResHeb.Tense => Str} ; 
    VP = ResHeb.VP ;              -- {v : Verb ; obj : Str} ;
    NP = ResHeb.NP ;              -- {s : Case =>  {obj : Str} ; a : Agr ; isDef : Bool ; sp : Species} ;
    AP = {s : Number => Species => Gender =>  Str } ; 
    CN = ResHeb.Noun ;      	  -- {s : Number => Species => Str ; g: Gender} ;
    Det = {s :  Gender => Str ; n : Number ; sp : Species; isDef : Bool} ; 
    N = ResHeb.Noun ;         	  -- {s : Number => Species => Str ; g: Gender } ;
    A = ResHeb.Adj ;              -- {s :  Number => Species => Gender => Str} ; 
    V = ResHeb.Verb ;          	  -- {s : Tense => VPerNumGen  => Str } ;
    V2 = ResHeb.Verb2 ; 	  -- Verb ** {c : Case} ; 

  lin

-- predication

  PredVP np vp = 
       let 
	   subj = (np.s ! Nom ).obj ;
           obj = vp.obj
        in {
            s = \\t => subj ++ (agrV vp.v t np.a) ++ obj } ;


  ComplV2 v2 np = 
     let
        nps = np.s ! v2.c  
      in {
        v =  {s =  v2.s } ;
        obj  =  case <np.isDef> of  
 	     { <True> =>  "At" ++ nps.obj; -- direct objects require the object marker 'et' and must be in definite form
	         _    =>  nps.obj } 
       } ;        


-- determination
-- ha-Aysh ha-zwt : this woman 
-- ha-bait : the house
-- ha-bait ha-ze : this house
-- ha-bait ha-yarok ha-ze : this green house 

   DetCN det cn = {
    	s = \\c => {obj = cn.s ! det.n  ! det.sp ++ det.s ! cn.g } ;
 	isDef = det.isDef ;
	sp =  det.sp ;
        a = Ag cn.g det.n Per3 
      } ;
   
   ModCN cn ap = {
      s = \\sp => table {n => cn.s ! sp ! n ++  ap.s ! sp ! n  ! cn.g} ; 
      g = cn.g 
      } ;

    UseV v =  { v = v  ; obj =  [] };

    UseN n = n ; 

    UseA adj = adj ;
    	      
    a_Det =  { 
       s = table { _ => ""  } ;
       n = Sg ;
       sp = Indef ;
       isDef = False 
      } ; 
 
    the_Det = {
      s = table { _ => "" } ;
      n = Sg ;
      sp = Def ;
      isDef = True 
      } ;

    this_Det = {
      s = table { Masc =>  "hzh" ;  Fem => "hzAt" } ;
      n = Sg ;
      sp = Def ;
      isDef = True 
      } ;

     these_Det = {
       s = table {_ => "hAlh" }  ;
       n = Pl ;
       sp = Def ;
       isDef = True 
      } ;

     i_NP = pronNP "Any" "Awty" "ly" Masc Sg Per1 ; --both fem and masc
     we_NP = pronNP "AnHnw" "Awtnw" "lnw" Masc Pl Per1; --both fem and masc
     she_NP = pronNP "hyA" "Awth" "lh" Fem Sg Per3  ; 
}

