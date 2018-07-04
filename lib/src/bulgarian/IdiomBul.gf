--# -coding=cp1251
concrete IdiomBul of Idiom = CatBul ** open Prelude, ParadigmsBul, ResBul in {
  flags coding=cp1251 ;

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause [] (GSg Neut) (NounP3 Pos) vp ;
    GenericCl vp = mkClause "някой" (GSg Neut) (NounP3 Pos) vp ;

    CleftNP np rs = 
      mkClause (np.s ! RSubj)
               (GSg Neut) np.p
               (insertObj (\\_ => thisRP ! np.gn ++ rs.s ! personAgr np.gn np.p) (personPol np.p) (predV verbBe)) ;        

    CleftAdv ad s = {s = \\t,a,p,o => case p of {Pos=>[]; Neg=>"не"} ++ ad.s ++ s.s } ;

    ExistNP np = ExistNPAdv np (lin Adv {s = ""}) ;
    ExistIP ip = ExistIPAdv ip (lin Adv {s = ""}) ;

    ExistNPAdv np adv = 
      { s = \\t,a,p,o => 
	          let verb = case orPol p (personPol np.p) of {
	                       Pos => mkV186 "имам" ;
	                       Neg => mkV186 "нямам" 
	                     } ;
                                 
                  agr=agrP3 (GSg Neut);
                                 
                  present = verb ! (VPres   (numGenNum agr.gn) agr.p) ;
                  aorist  = verb ! (VAorist (numGenNum agr.gn) agr.p) ;
                  perfect = verb ! (VPerfect (aform agr.gn Indef (RObj Acc))) ;
                                 
                  auxPres    = auxBe ! VPres (numGenNum agr.gn) agr.p ;
                  auxAorist  = auxBe ! VAorist (numGenNum agr.gn) agr.p ;
                  auxCondS   = auxCond ! numGenNum agr.gn ! agr.p ;

                  v : {aux1:Str; aux2:Str; main:Str}
                        = case <t,a> of {
                            <Pres,Simul> => {aux1=[]; aux2=[]; main=present} 
               ;  --# notpresent
                            <Pres,Anter> => {aux1=[]; aux2=auxPres;   main=perfect} ;  --# notpresent
                            <Past,Simul> => {aux1=[]; aux2=[]; main=aorist} ;  --# notpresent
                            <Past,Anter> => {aux1=[]; aux2=auxAorist; main=perfect} ;  --# notpresent
                            <Fut, Simul> => {aux1="ще"; aux2=[]; main=present} ;  --# notpresent
                            <Fut, Anter> => {aux1="ще"++auxPres; aux2=[]; main=perfect} ;  --# notpresent
                            <Cond,_>     => {aux1=auxCondS; aux2=[]; main=perfect}  --# notpresent
                          } ;

	          in case o of {
	               Main  => v.aux1 ++ v.main ++ v.aux2 ++ np.s ! RObj Acc ++ adv.s ;
	               Inv   => np.s ! RObj Acc ++ v.aux1 ++ v.main ++ v.aux2 ++ adv.s  ;
	               Quest => v.aux1 ++ v.main ++ "ли" ++ v.aux2 ++ np.s ! RObj Acc ++ adv.s 
	             }
      } ;

    ExistIPAdv ip adv = 
      mkQuestion {s = ip.s ! RSubj}
                 (mkClause "тук" ip.gn (NounP3 Pos) (insertObj (\\_ => adv.s) Pos (predV verbBe))) ;

    ProgrVP vp = {
      s   = \\_ => vp.s ! Imperf ;
      ad = vp.ad ;
      clitics = vp.clitics ;
      compl = vp.compl ;
      vtype = vp.vtype ;
      p = vp.p ;
      isSimple = False
      } ;

    ImpPl1 vp = {s = "нека" ++ daComplex Simul Pos vp ! Perf ! {gn = GPl ; p = P1}} ;
}

