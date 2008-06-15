concrete IdiomBul of Idiom = CatBul ** open Prelude, ParadigmsBul, ResBul in {
  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause [] (agrP3 (GSg Neut)) vp ;
    GenericCl vp = mkClause "някой" (agrP3 (GSg Neut)) vp ;

    CleftNP np rs = 
      mkClause (np.s ! RSubj)
               {gn=GSg Neut; p=np.a.p}
               (insertObj (\\_ => thisRP ! np.a.gn ++ rs.s ! np.a.gn) (predV verbBe)) ;        
        
    CleftAdv ad s = {s = \\t,a,p,o => case p of {Pos=>[]; Neg=>"не"} ++ ad.s ++ s.s } ;

    ExistNP np = 
      { s = \\t,a,p,o => 
	          let verb = case p of {
	                       Pos => mkV186 "имам" ;
	                       Neg => mkV186 "нямам" 
	                     } ;
                                 
                      agr=agrP3 (GSg Neut);
                                 
                      present = verb ! (VPres   (numGenNum agr.gn) agr.p) ;
                      aorist  = verb ! (VAorist (numGenNum agr.gn) agr.p) ;
                      perfect = verb ! (VPerfect (aform agr.gn Indef (RObj Acc))) ;
                                 
                      auxPres    = auxBe ! VPres (numGenNum agr.gn) agr.p ;
                      auxAorist  = auxBe ! VAorist (numGenNum agr.gn) agr.p ;
                      auxCondS   = auxWould ! VAorist (numGenNum agr.gn) agr.p ;

                      v : {aux1:Str; aux2:Str; main:Str}
                        = case <t,a> of {
                            <Pres,Simul> => {aux1=[]; aux2=[]; main=present} ;
                            <Pres,Anter> => {aux1=[]; aux2=auxPres;   main=perfect} ;
                            <Past,Simul> => {aux1=[]; aux2=[]; main=aorist} ;
                            <Past,Anter> => {aux1=[]; aux2=auxAorist; main=perfect} ;
                            <Fut, Simul> => {aux1="ще"; aux2=[]; main=present} ;
                            <Fut, Anter> => {aux1="ще"++auxPres; aux2=[]; main=perfect} ;
                            <Cond,_>     => {aux1=auxCondS; aux2=[]; main=perfect}
                          } ;

	          in case o of {
	               Main  => v.aux1 ++ v.main ++ v.aux2 ++ np.s ! RObj Acc ;
	               Inv   => np.s ! RObj Acc ++ v.aux1 ++ v.main ++ v.aux2 ;
	               Quest => v.aux1 ++ v.main ++ "ли" ++ v.aux2 ++ np.s ! RObj Acc
	             }
      } ;

    ExistIP ip = 
      mkQuestion {s = ip.s ! RSubj}
                 (mkClause "тук" (agrP3 ip.gn) (predV verbBe)) ;

    ProgrVP vp = {
      s   = \\_ => vp.s ! Imperf ;
      ad = vp.ad ;
      compl = vp.compl ;
      vtype = vp.vtype
      } ;

    ImpPl1 vp = {s = "нека" ++ daComplex vp ! Perf ! {gn = GPl ; p = P1}} ;
}

