concrete VerbAmh of Verb = CatAmh ** open Prelude,ParamX, ResAmh in {
--
 flags optimize=all_subs ;
            coding = utf8;
--
  lin


	    UseV = predV ;

	    SlashV2a v = predVc v ;

	    Slash3V3 v np = insertObj np (predV v) ** {c2 = v.c2};

	    ComplSlash vp np = insertObj np vp ;    

	    CompAP ap = {s = \\amhagr,c => ap.s ! amhagr.g ! amhagr.n ! Indef ! c} ; --FIXME

	    CompNP np = {s = \\_,c => np.s ! c};

	    CompAdv a = {s = \\_,_ => a.s} ;

	--    PassV2   : V2 -> VP ;               -- be loved
	  	PassV2 v2 = {
				s = \\t,p,png =>

		 let

			teketebku		 =    v2.s ! Perf !Pas! png ; --
			eketebalehu       =    v2.s ! Imperf !Pas! png ;--
			teketeb		 =    v2.s ! Jus_Imperat !Pas! png ; -- imperative
			teketbie		 =    v2.s ! Gerund !Pas! png ; --
			meketeb		 =    v2.s ! Infinitive !Pas! png ; --
			teketabi		 =    v2.s ! Parti !Pas! png ; 
			teketbiealehu      =    v2.s ! CompPerf !Pas! png ; --
			eketeb		 =    v2.s ! Cont !Pas! png ; --  just play with the actives for now

		in

		  case <t,p> of {


			
			<PresFut,Pos>  => eketebalehu ;
			<PresFut,Neg>  => "!" ++"&+"++ eketeb ++"&+" ++"m" ;--   case for I is unique 											  but sticking to the 												general trend
			<PresPerf,Pos>  => teketbiealehu;
			<PresPerf,Neg>  => "!l"++"&+"++teketebku++"&+"++"m";
			<PresCont,Pos>   => "(y'"++ "&+"++teketebku ++"n'w" ;
			<PresCont,Neg>   => "(y'"++ "&+"++teketebku ++"Ayd'l'm" ;			
			<SimplePast,Pos> => teketebku;
			<SimplePast,Neg> => "!l"++"&+"++teketebku++"&+"++"m";			
			<PastPerf,Pos>  => teketbie ++ "n'b'r";
			<PastPerf,Neg>  => "!l"++"&+"++teketebku++"&+"++"m"++"n'b'r"; 
			<PastCont,Pos>   => "(y'"++ "&+"++teketebku ++ "n'b'r" ;
			<PastCont,Neg>   => "(y'"++ "&+"++teketebku ++ "Aln'b'r'm"
                     

			      };
			obj = {
				s = [] ; 
				a = {png = Per3 Sg Masc  ; isPron = False} 
			}; 
			s2 = [];
			imp  = v2.s ! Jus_Imperat!Act !Per2 Sg Masc;
			inf = v2.s ! Infinitive ! Pas ! Per3 Sg Masc ;
			pred = { s = \\_,_ => []};
			isPred = False
			} ;

	--  AdvVP    : VP -> Adv -> VP ; 

		AdvVP vp adv = { 

			s = \\t,p,pgn =>  adv.s ++ vp.s!t!p!pgn ; 
			
			obj = vp.obj; 
			s2 = [];
			imp  = vp.imp ;
			inf = vp.inf;
			pred = { s = \\_,_ => []};
			isPred = False
		};


		--  AdVVP    : AdV -> VP -> VP ;        -- always sleep


  --     : Comp -> VP ;            -- be warm -- 
--
	UseComp comp = {s= \\t,p,png => 
       			let 
				gn = png2gn png 
				
       			in 
	
		 case <png,t,p> of {


			<Per1 Sg,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ነኝ"; 
			<Per1 Sg,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለሁም"; 
			<Per1 Sg,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበርኩ";
			<Per1 Sg,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበርኩም"; 
			<Per1 Sg,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንኩ ነው";
			<Per1 Sg,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንኩ አይደለም";			
			<Per1 Sg,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበርኩ";
			<Per1 Sg,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበርኩም"; 			
			<Per1 Sg,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበርኩ";
			<Per1 Sg,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበርኩም" ; 
			<Per1 Sg,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንኩ ነበር";  
			<Per1 Sg,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንኩ አልነበረም";


			<Per1 Pl,PresFut,Pos>  => comp.s ! gn ! Nom ++ "ነን";
			<Per1 Pl,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለንም"; 
			<Per1 Pl,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበርን";
			<Per1 Pl,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበርንም"; 
			<Per1 Pl,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንን ነው";
			<Per1 Pl,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንን አይደለም";			
			<Per1 Pl,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበርን";
			<Per1 Pl,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበርንም"; 			
			<Per1 Pl,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበርን";
			<Per1 Pl,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበርንም" ; 
			<Per1 Pl,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንን ነበር";  
			<Per1 Pl,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንን አልነበረም";
			

			<Per2 Sg Masc,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ነህ"; 
			<Per2 Sg Masc,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለህም"; 
			<Per2 Sg Masc,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበርክ";
			<Per2 Sg Masc,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበርክም"; 
			<Per2 Sg Masc,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንክ ነው";
			<Per2 Sg Masc,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንክ አይደለም";			
			<Per2 Sg Masc,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበርክ";
			<Per2 Sg Masc,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበርክም"; 			
			<Per2 Sg Masc,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበርክ";
			<Per2 Sg Masc,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበርክም" ; 
			<Per2 Sg Masc,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንክ ነበር";  
			<Per2 Sg Masc,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንክ አልነበረም";


			<Per2 Sg Fem,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ነሽ"; 
			<Per2 Sg Fem,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለሽም"; 
			<Per2 Sg Fem,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበርሽ";
			<Per2 Sg Fem,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበርሽም"; 
			<Per2 Sg Fem,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንሽ ነው";
			<Per2 Sg Fem,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንሽ አይደለም";			
			<Per2 Sg Fem,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበርሽ";
			<Per2 Sg Fem,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበርሽም"; 			
			<Per2 Sg Fem,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበርሽ";
			<Per2 Sg Fem,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበርሽም" ; 
			<Per2 Sg Fem,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆንሽ ነበር";  
			<Per2 Sg Fem,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆንሽ አልነበረም";

			<Per2 Pl _,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ናችሁ"; 
			<Per2 Pl _,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደላችሁም"; 
			<Per2 Pl _,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበራችሁ";
			<Per2 Pl _,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበራችሁም"; 
			<Per2 Pl _,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆናችሁ ነው";
			<Per2 Pl _,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆናችሁ አይደለም";			
			<Per2 Pl _,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበራችሁ";
			<Per2 Pl _,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበራችሁም"; 			
			<Per2 Pl _,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበራችሁ";
			<Per2 Pl _,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበራችሁም" ; 
			<Per2 Pl _,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆናችሁ ነበር";  
			<Per2 Pl _,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆናችሁ አልነበረም";
		
			<Per3 Sg Masc,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ነው"; 
			<Per3 Sg Masc,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለም"; 
			<Per3 Sg Masc,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበረ";
			<Per3 Sg Masc,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበረም"; 
			<Per3 Sg Masc,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆነ ነው";
			<Per3 Sg Masc,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆነ  አይደለም";			
			<Per3 Sg Masc,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበረ ";
			<Per3 Sg Masc,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበረም"; 			
			<Per3 Sg Masc,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበረ";
			<Per3 Sg Masc,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበረም" ; 
			<Per3 Sg Masc,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆነ ነበር";  
			<Per3 Sg Masc,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆነ አልነበረም";	

	
			<Per3 Sg Fem,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ነች"; 
			<Per3 Sg Fem,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደለችም"; 
			<Per3 Sg Fem,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበረች";
			<Per3 Sg Fem,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበረችም"; 
			<Per3 Sg Fem,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆነች ነው";
			<Per3 Sg Fem,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆነች  አይደለም";			
			<Per3 Sg Fem,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበረች ";
			<Per3 Sg Fem,SimplePast,Neg >  => comp.s ! gn ! Nom ++ "አልነበረችም"; 			
			<Per3 Sg Fem,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበረች";
			<Per3 Sg Fem,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበረችም" ; 
			<Per3 Sg Fem,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆነች ነበር";  
			<Per3 Sg Fem,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆነች አልነበረም";


			<Per3 Pl _,PresFut,Pos >  => comp.s ! gn ! Nom ++ "ናቸው"; 
			<Per3 Pl _,PresFut,Neg >  => comp.s ! gn ! Nom ++ "አይደሉም"; 
			<Per3 Pl _,PresPerf,Pos>  => comp.s ! gn ! Nom ++"ነበሩ";
			<Per3 Pl _,PresPerf,Neg>  => comp.s ! gn ! Nom ++"አልነበሩም"; 
			<Per3 Pl _,PresCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆኑ ነው";
			<Per3 Pl _,PresCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆኑ  አይደለም";			
			<Per3 Pl _,SimplePast,Pos> => comp.s ! gn ! Nom ++"ነበሩ ";
			<Per3 Pl _,SimplePast,Neg>  => comp.s ! gn ! Nom ++ "አልነበሩም"; 			
			<Per3 Pl _,PastPerf,Pos>  => comp.s ! gn ! Nom ++ "ነበሩ";
			<Per3 Pl _,PastPerf,Neg>  => comp.s ! gn ! Nom ++ "አልነበሩም" ; 
			<Per3 Pl _,PastCont,Pos>   => comp.s ! gn ! Nom ++ "እየሆኑ ነበር";  
			<Per3 Pl _,PastCont,Neg>   => comp.s ! gn ! Nom ++ "እየሆኑ አልነበረም"
	
			      };
			
			obj = {
				s = [] ; 
				a = {png = Per3 Sg Masc  ; isPron = False} 
			}; 
			s2 = [];
  			imp  = [] ;
			inf = [];
			pred = { s = \\_,_ => []};
			isPred = False
					  			
			};


			ComplVA v2 ap= {

				s = \\t,p,png =>

		 let
			
			teketebku	=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Perf !Pas! png ; --
			eketebalehu     =    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Imperf !Pas! png ;--
			teketeb		=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Jus_Imperat !Pas! png ; -- imperative
			teketbie	=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Gerund !Pas! png ; --
			meketeb		=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Infinitive !Pas! png ; --
			teketabi	=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Parti !Pas! png ; 
			teketbiealehu   =    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! CompPerf !Pas! png ; --
			eketeb		=    ap.s!Masc!Sg!Indef!Nom ++ v2.s ! Cont !Pas! png ; --  just play with the actives for now

		in

		  case <t,p> of {


			
			<PresFut,Pos>  => eketebalehu ;
			<PresFut,Neg>  => "!" ++"&+"++ eketeb ++"&+" ++"m" ;--   case for I is unique 											  but sticking to the 												general trend
			<PresPerf,Pos>  => teketbiealehu;
			<PresPerf,Neg>  => "!l"++"&+"++teketebku++"&+"++"m";
			<PresCont,Pos>   => "(y'"++ "&+"++teketebku ++"n'w" ;
			<PresCont,Neg>   => "(y'"++ "&+"++teketebku ++"Ayd'l'm" ;			
			<SimplePast,Pos> => teketebku;
			<SimplePast,Neg> => "!l"++"&+"++teketebku++"&+"++"m";			
			<PastPerf,Pos>  => teketbie ++ "n'b'r";
			<PastPerf,Neg>  => "!l"++"&+"++teketebku++"&+"++"m"++"n'b'r"; 
			<PastCont,Pos>   => "(y'"++ "&+"++teketebku ++ "n'b'r" ;
			<PastCont,Neg>   => "(y'"++ "&+"++teketebku ++ "Aln'b'r'm"
                     

			      };
			obj = {
				s = [] ; 
				a = {png = Per3 Sg Masc  ; isPron = False} 
			}; 
			s2 = [];
			imp  = v2.s ! Jus_Imperat!Act!Per2 Sg Masc ;
			inf = v2.s ! Infinitive ! Act ! Per3 Sg Masc ;
			pred = { s = \\_,_ => []};
			isPred = False
			} ;

	




 	ComplVV v2 vp = {
				s = \\t,p,png =>

		 let

			teketebku		 =    v2.s ! Perf !Act! png ; --
			eketebalehu       =    v2.s ! Imperf !Act! png ;--
			teketeb		 =    v2.s ! Jus_Imperat !Act! png ; -- imperative
			teketbie		 =    v2.s ! Gerund !Act! png ; --
			meketeb		 =    v2.s ! Infinitive !Act! png ; --
			teketabi		 =    v2.s ! Parti !Act! png ; 
			teketbiealehu      =    v2.s ! CompPerf !Act! png ; --
			eketeb		 =    v2.s ! Cont !Act! png ; --  just play with the actives for now

		in

		  case <t,p> of {


			
			<PresFut,Pos>  => vp.inf ++ eketebalehu ;
			<PresFut,Neg>  => vp.inf ++ "!" ++"&+"++ eketeb ++"&+" ++"m" ;--   case for I is unique 											  but sticking to the 												general trend
			<PresPerf,Pos>  => vp.inf ++ teketbiealehu;
			<PresPerf,Neg>  => vp.inf ++ "!l"++"&+"++teketebku++"&+"++"m";
			<PresCont,Pos>   => vp.inf ++ "(y'"++ "&+"++teketebku ++"n'w" ;
			<PresCont,Neg>   => vp.inf ++ "(y'"++ "&+"++teketebku ++"Ayd'l'm" ;			
			<SimplePast,Pos> => vp.inf ++ teketebku;
			<SimplePast,Neg> => vp.inf ++ "!l"++"&+"++teketebku++"&+"++"m";			
			<PastPerf,Pos>  => vp.inf ++ teketbie ++ "n'b'r";
			<PastPerf,Neg>  => vp.inf ++ "!l"++"&+"++teketebku++"&+"++"m"++"n'b'r"; 
			<PastCont,Pos>   => vp.inf ++ "(y'"++ "&+"++teketebku ++ "n'b'r" ;
			<PastCont,Neg>   => vp.inf ++ "(y'"++ "&+"++teketebku ++ "Aln'b'r'm"
                     

			      };
			obj = vp.obj;
			s2 = [];
			imp  = v2.s ! Jus_Imperat!Act!Per2 Sg Masc ;
			inf = v2.s ! Infinitive ! Pas ! Per3 Sg Masc ;
			pred = vp.pred;
			isPred = False
			} ;

		--  v vp = vp.inf ++ (predV v)** {c2 = v.c2};


		--      ReflVP   : VPSlash -> VP ;         -- love himself
		--	ReflVP v = insertObj (\\a => reflPron ! a ++ v.c2) v ;
		--Slash3V3 v np = insertObj np (predV v) ** {c2 = v.c2};

		-- ComplVA  : VA  -> AP -> VP ;  -- they become red
		--			ComplVA  v    ap = insertObj2 (ap.s!Masc!Sing!Indef) (predV v) ;
		-- ComplVV  : VV  -> VP -> VP ;  -- want to run  



}
