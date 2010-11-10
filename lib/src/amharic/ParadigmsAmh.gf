--# -path=.:../abstract:../../prelude:../common
--
----1 Amharic Lexical Paradigms
----
-- (c) 2010 Markos KG
-- Licensed under LGPL
----
---- This is an API to the user of the resource grammar 
---- for adding lexical items. It gives functions for forming
---- expressions of open categories: nouns, adjectives, verbs.
---- 
---- Closed categories (determiners, pronouns, conjunctions) are
---- accessed through the resource syntax API, $Structural.gf$. 
----
---- The main difference with $MorphoAmh.gf$ is that the types
---- referred to are compiled resource grammar types. We have moreover
---- had the design principle of always having existing forms, rather
---- than stems, as string arguments of the paradigms.
----
---- The structure of functions for each word class $C$ is the following:
---- first we give a handful of patterns that aim to cover all
---- regular cases. Then we give a worst-case function $mkC$, which serves as an
---- escape to construct the most irregular words of type $C$.
---- 
---- The following modules are presupposed:
--
resource ParadigmsAmh = open 
  Predef, 
  Prelude, 
  MorphoAmh,
  ParamX,
  OrthoAmh,ResAmh,
  CatAmh
  in {

   flags coding = utf8;


oper
  
   masculine : Gender ;
   feminine : Gender ;
   masculine = Masc ; 
   feminine = Fem ; 

	mkN = overload {
    			mkN : Str-> N 
                              = \s -> regN s ** {lock_N = <>};
    			mkN : Str-> Gender-> N 
                              = \s,g -> regN2 s g ** {lock_N = <>} ;
    			mkN : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x16 : Str)-> Gender -> N = 		\bEtu,bEtun,yebEtu,lebEtu,bEt,bEtn,yebEt,lebEt,bEtocu,bEtocun,yebEtocu,lebEtocu,bEtoc,bEtocn,yebEtoc,lebEtoc,g-> mkNoun bEtu bEtun yebEtu lebEtu bEt   bEtn yebEt lebEt bEtocu bEtocun yebEtocu lebEtocu bEtoc bEtocn yebEtoc lebEtoc g ** {lock_N = <>};   
                        mkN : N -> N -> N 
                               = \s,n -> compN s n ** {lock_N = <>}; 

                   
  } ;

       mkA = overload {
    			mkA : Str-> Adjective 
                              = \s -> regAdj s ** {lock_Adj = <>};

                     --   mkA : Str-> Adjective 
                    --          = \s -> regAdj2 s ** {lock_Adj = <>};

       			mkA : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x32 : Str)-> Adjective = 		\msdn,msda,msdg,msdd,msin,msia,msig,msid,mpdn,mpda,mpdg,mpdd,mpin,mpia,mpig,mpid,
                  fsdn,fsda,fsdg,fsdd,fsin,fsia,fsig,fsid,fpdn,fpda,fpdg,fpdd,fpin,fpia,fpig,fpid-> mkAdjective msdn msda msdg msdd msin msia msig msid mpdn mpda mpdg mpdd mpin mpia mpig mpid 
                  fsdn fsda fsdg fsdd fsin fsia fsig fsid fpdn fpda fpdg fpdd fpin fpia fpig fpid ** {lock_Adj = <>}; 
                     
  } ;

	mkV = overload {
    			mkV : Str-> V 
                              = \s -> mkV3gdl s ** {lock_V = <>};


    			                 
  } ;

  
mkV3gdl : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  { 

			Act => table {

		     			      Per1 Sg      => appPattern3 root C1aC2aC3ku ;
					      Per1 Pl      => appPattern3 root C1aC2aC3n ;
					      Per2 Sg Masc => appPattern3 root C1aC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root C1aC2aC3sh ;
					      Per2 Pl _     => appPattern3 root C1aC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root C1aC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root C1aC2aC3ech ;
					      Per3 Pl _=> appPattern3 root C1aC2aC3u};

                         Pas => table {

					      Per1 Sg      => appPattern3 root pteC1aC2aC3ku ;
					      Per1 Pl      => appPattern3 root pteC1aC2aC3n ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root pteC1aC2aC3sh ;
					      Per2 Pl _     => appPattern3 root pteC1aC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root pteC1aC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2aC3ech ;
					      Per3 Pl _=> appPattern3 root pteC1aC2aC3u

				}
			    	} ;

               CompPerf => table  {  

       			Act => table {
	 	     			      Per1 Sg      => appPattern3pal root C1aC2C3iealehu ;
					      Per1 Pl      => appPattern3 root C1aC2C3enal ;
					      Per2 Sg Masc => appPattern3 root C1aC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root C1aC2C3eshal ;
					      Per2 Pl _      => appPattern3 root C1aC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root C1aC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root C1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root C1aC2C3ewwal };

			Pas => table {	      Per1 Sg      => appPattern3pal root pteC1aC2C3iealehu ;
					      Per1 Pl      => appPattern3 root pteC1aC2C3enal ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root pteC1aC2C3eshal ;
					      Per2 Pl _      => appPattern3 root pteC1aC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root pteC1aC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root pteC1aC2C3ewwal }
			    	} ;
 

                Cont => table {    

				Act => table {
					      Per1 Sg      => appPattern3 root eC1aC2C3 ;
					      Per1 Pl      => appPattern3 root enC1aC2C3e ;
					      Per2 Sg Masc => appPattern3 root teC1aC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root teC1aC2C3 ;
					      Per2 Pl _     => appPattern3 root teC1aC2C3u ;
					      Per3 Sg Masc => appPattern3 root yeC1aC2C3 ;
					      Per3 Sg Fem  => appPattern3 root teC1aC2C3 ;
					      Per3 Pl _=> appPattern3 root yeC1aC2C3u};

  			Pas =>table {	      Per1 Sg      => appPattern3 root peC1aC2C3 ;
					      Per1 Pl      => appPattern3 root penC1aC2C3e ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root pteC1aC2C3 ;
					      Per2 Pl _     => appPattern3 root pteC1aC2C3u ;
					      Per3 Sg Masc => appPattern3 root pyeC1aC2C3 ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2C3 ;
					      Per3 Pl _=> appPattern3 root pyeC1aC2C3u}
  };
		 
		Imperf => table {     
		   
			Act => table {
					      Per1 Sg      => appPattern3 root eC1aC2C3alehu ;
					      Per1 Pl      => appPattern3 root enC1aC2C3alen ;
					      Per2 Sg Masc => appPattern3 root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root teC1aC2C3aleh ;
					      Per2 Pl _      => appPattern3 root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPattern3 root teC1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root yeC1aC2C3alu 
				} ;

			Pas => table {Per1 Sg      => appPattern3 root peC1aC2aC3alehu ;
					      Per1 Pl      => appPattern3 root penC1aC2aC3alen ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2aC3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root pteC1aC2aC3aleh ;
					      Per2 Pl _      => appPattern3 root pteC1aC2aC3alachehu ;
					      Per3 Sg Masc => appPattern3 root pyeC1aC2aC3al ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2aC3alech ;
					      Per3 Pl _=> appPattern3 root pyeC1aC2aC3alu }
		  	         } ;

		Jus_Imperat => table {  

				Act => table {   
		   
					      Per1 Sg      => appPattern3 root leC1C2aC3  ;
					      Per1 Pl      => appPattern3 root enC1C2aC3 ;
					      Per2 Sg Masc => appPattern3 root C1C2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root C1C2aC3i ;
					      Per2 Pl _      => appPattern3 root C1C2aC3u ;
					      Per3 Sg Masc => appPattern3 root yC1C2aC3 ;
					      Per3 Sg Fem  => appPattern3 root tC1C2aC3 ;
					      Per3 Pl _=> appPattern3 root yC1C2aC3u };

			      Pas => table  {
						 Per1 Sg      => appPattern3 root pleC1C2aC3  ;
					      Per1 Pl      => appPattern3 root penC1C2aC3 ;
					      Per2 Sg Masc => appPattern3 root pC1C2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root pC1C2aC3i ;
					      Per2 Pl _      => appPattern3 root pC1C2aC3u ;
					      Per3 Sg Masc => appPattern3 root pyC1C2aC3 ;
					      Per3 Sg Fem  => appPattern3 root ptC1C2aC3 ;
					      Per3 Pl _=> appPattern3 root pyC1C2aC3u 
						
						}
		  	         } ;

		
		Gerund => table {   

				Act => table {  
		   
					      Per1 Sg      => appPattern3pal root C1aC2C3ie ;
					      Per1 Pl      => appPattern3 root C1aC2C3en ;
					      Per2 Sg Masc => appPattern3 root C1aC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root C1aC2C3esh ;
					      Per2 Pl _      => appPattern3 root C1aC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root C1aC2C3o ;
					      Per3 Sg Fem  => appPattern3 root C1aC2C3a ;
					      Per3 Pl _=> appPattern3 root C1aC2C3ew };

				Pas => table {Per1 Sg      => appPattern3pal root ptC1aC2C3ie ;
					      Per1 Pl      => appPattern3 root ptC1aC2C3en ;
					      Per2 Sg Masc => appPattern3 root ptC1aC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root ptC1aC2C3esh ;
					      Per2 Pl _      => appPattern3 root ptC1aC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root ptC1aC2C3o ;
					      Per3 Sg Fem  => appPattern3 root ptC1aC2C3a ;
					      Per3 Pl _=> appPattern3 root ptC1aC2C3ew }
		  	         } ;

		
	Infinitive => table {     
		   			Act => table {
					     	 _    => appPattern3 root meC1C2aC3 };

				       Pas => table {  _    => appPattern3 root pmeC1C2aC3 }
					   
		     
		  	         }; 
	Parti => table {     
		   			Act => table {
					      _    => appPattern3pal root C1eC2aC3 };
					Pas => table { _ => appPattern3pal root pteC1eC2aC3 }
					   
		     
		  	         }

			  }
		  };




	mkV3mls : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  {  

			Act => table {
      
		     			      Per1 Sg      => appPattern3 root C1aC2aC3ku ;
					      Per1 Pl      => appPattern3 root C1aC2aC3n ;
					      Per2 Sg Masc => appPattern3 root C1aC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root C1aC2aC3sh ;
					      Per2 Pl _      => appPattern3 root C1aC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root C1aC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root C1aC2aC3ech ;
					      Per3 Pl _=> appPattern3 root C1aC2aC3u 
			    	} ; 

			Pas => table  { 
      
		     			      Per1 Sg      => appPattern3 root pteC1aC2aC3ku ;
					      Per1 Pl      => appPattern3 root pteC1aC2aC3n ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root pteC1aC2aC3sh ;
					      Per2 Pl _     => appPattern3 root pteC1aC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root pteC1aC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2aC3ech ;
					      Per3 Pl _=> appPattern3 root pteC1aC2aC3u
			    	}


};


      CompPerf => table  {  
      
		     	Act => table {		      Per1 Sg      => appPattern3 root C1aC2C3iealehu ;
					      Per1 Pl      => appPattern3 root C1aC2C3enal ;
					      Per2 Sg Masc => appPattern3 root C1aC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root C1aC2C3eshal ;
					      Per2 Pl _      => appPattern3 root C1aC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root C1aC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root C1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root C1aC2C3ewwal };

		Pas => table  {  
      
		     			      Per1 Sg      => appPattern3pal root pteC1aC2C3iealehu ;
					      Per1 Pl      => appPattern3 root pteC1aC2C3enal ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root pteC1aC2C3eshal ;
					      Per2 Pl _      => appPattern3 root pteC1aC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root pteC1aC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root pteC1aC2C3ewwal 
			    	}



 
			    	} ;

		 Cont => table {   
					Act => table {  	      Per1 Sg      => appPattern3 root eC1aC2C3 ;
					      Per1 Pl      => appPattern3 root enC1aC2C3e ;
					      Per2 Sg Masc => appPattern3 root teC1aC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root teC1aC2C3 ;
					      Per2 Pl _     => appPattern3 root teC1aC2C3u ;
					      Per3 Sg Masc => appPattern3 root yeC1aC2C3 ;
					      Per3 Sg Fem  => appPattern3 root teC1aC2C3 ;
					      Per3 Pl _=> appPattern3 root yeC1aC2C3u  };

				Pas => table {    Per1 Sg      => appPattern3 root peC1aC2C3 ;
					      Per1 Pl      => appPattern3 root penC1aC2C3e ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root pteC1aC2C3 ;
					      Per2 Pl _     => appPattern3 root pteC1aC2C3u ;
					      Per3 Sg Masc => appPattern3 root pyeC1aC2C3 ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2C3 ;
					      Per3 Pl _=> appPattern3 root pyeC1aC2C3u  }

};
		Imperf => table {     
		                       Act => table {
					      Per1 Sg      => appPattern3 root eC1aC2C3alehu ;
					      Per1 Pl      => appPattern3 root enC1aC2C3alen ;
					      Per2 Sg Masc => appPattern3 root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root teC1aC2C3aleh ;
					      Per2 Pl _=> appPattern3 root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPattern3 root teC1aC2C3alech ;
					      Per3 Pl _=> appPattern3 root yeC1aC2C3alu };
		      Pas => table {     
		   
					      Per1 Sg      => appPattern3 root peC1aC2aC3alehu ;
					      Per1 Pl      => appPattern3 root penC1aC2aC3alen ;
					      Per2 Sg Masc => appPattern3 root pteC1aC2aC3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root pteC1aC2aC3aleh ;
					      Per2 Pl _      => appPattern3 root pteC1aC2aC3alachehu ;
					      Per3 Sg Masc => appPattern3 root pyeC1aC2aC3al ;
					      Per3 Sg Fem  => appPattern3 root pteC1aC2aC3alech ;
					      Per3 Pl _=> appPattern3 root pyeC1aC2aC3alu 

		  	         }

		  	         } ;

		Jus_Imperat => table {     
		                     Act=> table{
					      Per1 Sg      => appPattern3 root leC1aC2C3  ;
					      Per1 Pl      => appPattern3 root enC1aC2C3 ;
					      Per2 Sg Masc => appPattern3 root C1aC2C3 ;
					      Per2 Sg Fem  =>appPattern3pal root C1aC2C3i;
					      Per2 Pl _      => appPattern3 root C1aC2C3u ;
					      Per3 Sg Masc => appPattern3 root yC1aC2C3 ;
					      Per3 Sg Fem  => appPattern3 root tC1aC2C3 ;
					      Per3 Pl _=> appPattern3 root yC1aC2C3u  };

            Pas => table {     
		   
					      Per1 Sg      => appPattern3 root pleC1C2aC3  ;
					      Per1 Pl      => appPattern3 root penC1C2aC3 ;
					      Per2 Sg Masc => appPattern3 root pC1C2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root pC1C2aC3i ;
					      Per2 Pl _      => appPattern3 root pC1C2aC3u ;
					      Per3 Sg Masc => appPattern3 root pyC1C2aC3 ;
					      Per3 Sg Fem  => appPattern3 root ptC1C2aC3 ;
					      Per3 Pl _=> appPattern3 root pyC1C2aC3u 
		  	         } 
		     
		  	         } ;

		
		Gerund => table {     
		                Act => table {
					      Per1 Sg      => appPattern3 root C1aC2C3ie ;
					      Per1 Pl      => appPattern3 root C1aC2C3en ;
					      Per2 Sg Masc => appPattern3 root C1aC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root C1aC2C3esh ;
					      Per2 Pl _      => appPattern3 root C1aC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root C1aC2C3o ;
					      Per3 Sg Fem  => appPattern3 root C1aC2C3a ;
					      Per3 Pl _=> appPattern3 root C1aC2C3ew  };

			Pas => table {     
		   
					      Per1 Sg      => appPattern3pal root ptC1aC2C3ie ;
					      Per1 Pl      => appPattern3 root ptC1aC2C3en ;
					      Per2 Sg Masc => appPattern3 root ptC1aC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root ptC1aC2C3esh ;
					      Per2 Pl _      => appPattern3 root ptC1aC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root ptC1aC2C3o ;
					      Per3 Sg Fem  => appPattern3 root ptC1aC2C3a ;
					      Per3 Pl _=> appPattern3 root ptC1aC2C3ew 
		  	         } 
		     
		  	         } ;

		Infinitive => table {   

         Act => table {  
		   
					      _      => appPattern3 root meC1aC2aC3 };
					      
		     Pas => table {     
		   
					      _    => appPattern3 root pmeC1C2aC3 
					   
		     
		  	         }
		  	         };
                	Parti => table {   

                                     Act => table 

				{  
		   
					      _    => appPattern3pal root C1eC2aC3
					};

			Pas  => table {     
		   
					      _    => appPattern3pal root pteC1eC2aC3 
					   
		     
		  	         }   
		     
		  	         }    


			  }
		  };
	mkV3brk : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  {  

					Act=> table {
      
		     			      Per1 Sg      => appPattern3 root C1AC2aC3ku ;
					      Per1 Pl      => appPattern3 root C1AC2aC3n ;
					      Per2 Sg Masc => appPattern3 root C1AC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root C1AC2aC3sh ;
					      Per2 Pl _      => appPattern3 root C1AC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root C1AC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root C1AC2aC3ech ;
					      Per3 Pl _=> appPattern3 root C1AC2aC3u 
			    	} ;
					Pas=> table {
		     			      Per1 Sg      => appPattern3 root pC1AC2aC3ku ;
					      Per1 Pl      => appPattern3 root pC1AC2aC3n ;
					      Per2 Sg Masc => appPattern3 root pC1AC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root pC1AC2aC3sh ;
					      Per2 Pl _      => appPattern3 root pC1AC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root pC1AC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root pC1AC2aC3ech ;
					      Per3 Pl _=> appPattern3 root pC1AC2aC3u }  } ;


      CompPerf => table  {  
      					Act =>table{
		     			      Per1 Sg      => appPattern3 root C1AC2C3iealehu ;
					      Per1 Pl      => appPattern3 root C1AC2C3enal ;
					      Per2 Sg Masc => appPattern3 root C1AC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root C1AC2C3eshal ;
					      Per2 Pl _      => appPattern3 root C1AC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root C1AC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root C1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root C1AC2C3ewwal 
			    	} ;

			Pas => table {
		     			      Per1 Sg      => appPattern3 root pC1AC2C3iealehu ;
					      Per1 Pl      => appPattern3 root pC1AC2C3enal ;
					      Per2 Sg Masc => appPattern3 root pC1AC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root pC1AC2C3eshal ;
					      Per2 Pl _      => appPattern3 root pC1AC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root pC1AC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root pC1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root pC1AC2C3ewwal  }
} ;

	Cont => table {    

				Act => table {

					     Per1 Sg      => appPattern3 root eC1AC2C3 ;
					      Per1 Pl      => appPattern3 root enC1AC2C3e ;
					      Per2 Sg Masc => appPattern3 root teC1AC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root teC1AC2C3 ;
					      Per2 Pl _      => appPattern3 root teC1AC2C3u ;
					      Per3 Sg Masc => appPattern3 root yeC1AC2C3 ;
					      Per3 Sg Fem  => appPattern3 root teC1AC2C3 ;
					      Per3 Pl _=> appPattern3 root yeC1AC2C3u   };

				Pas => table {    

					     Per1 Sg      => appPattern3 root peC1AC2C3 ;
					      Per1 Pl      => appPattern3 root penC1AC2C3e ;
					      Per2 Sg Masc => appPattern3 root pteC1AC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root pteC1AC2C3 ;
					      Per2 Pl _      => appPattern3 root pteC1AC2C3u ;
					      Per3 Sg Masc => appPattern3 root pyeC1AC2C3 ;
					      Per3 Sg Fem  => appPattern3 root pteC1AC2C3 ;
					      Per3 Pl _=> appPattern3 root pyeC1AC2C3u  }

				
};	 
		Imperf => table {     
		   			Act => table {
					      Per1 Sg      => appPattern3 root eC1AC2C3alehu ;
					      Per1 Pl      => appPattern3 root enC1AC2C3alen ;
					      Per2 Sg Masc => appPattern3 root teC1AC2C3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root teC1AC2C3aleh ;
					      Per2 Pl _      => appPattern3 root teC1AC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root yeC1AC2C3al ;
					      Per3 Sg Fem  => appPattern3 root teC1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root yeC1AC2C3alu };


		     Pas => table {     
		   
					      
					      Per1 Sg      => appPattern3 root peC1AC2C3alehu ;
					      Per1 Pl      => appPattern3 root penC1AC2C3alen ;
					      Per2 Sg Masc => appPattern3 root pteC1AC2C3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root pteC1AC2C3aleh ;
					      Per2 Pl _      => appPattern3 root pteC1AC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root pyeC1AC2C3al ;
					      Per3 Sg Fem  => appPattern3 root pteC1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root pyeC1AC2C3alu

		  	         }

		  	         } ;

		Jus_Imperat => table {     
	Act => table {
		   
					      Per1 Sg      => appPattern3 root leC1AC2C3  ;
					      Per1 Pl      => appPattern3 root enC1AC2C3 ;
					      Per2 Sg Masc => appPattern3 root C1AC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root C1AC2C3i;
					      Per2 Pl _      => appPattern3 root C1AC2C3u ;
					      Per3 Sg Masc => appPattern3 root yC1AC2C3 ;
					      Per3 Sg Fem  => appPattern3 root tC1AC2C3 ;
					      Per3 Pl _=> appPattern3 root yC1AC2C3u };

	Pas => table {     
		   
					      Per1 Sg      => appPattern3 root pleC1AC2C3  ;
					      Per1 Pl      => appPattern3 root penC1AC2C3 ;
					      Per2 Sg Masc => appPattern3 root pC1AC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root pC1AC2C3i;
					      Per2 Pl _      => appPattern3 root pC1AC2C3u ;
					      Per3 Sg Masc => appPattern3 root pyC1AC2C3 ;
					      Per3 Sg Fem  => appPattern3 root ptC1AC2C3 ;
					      Per3 Pl _=> appPattern3 root pyC1AC2C3u 
		  	         } 
		     
		  	         } ;

		
		Gerund => table {     
		   		Act => table {
					      Per1 Sg      => appPattern3PasPer root C1AC2C3ie ;
					      Per1 Pl      => appPattern3PasPer root C1AC2C3en ;
					      Per2 Sg Masc => appPattern3PasPer root C1AC2C3ek ;
					      Per2 Sg Fem  => appPattern3PasPer root C1AC2C3esh ;
					      Per2 Pl _      => appPattern3PasPer root C1AC2C3achehu ;
					      Per3 Sg Masc => appPattern3PasPer root C1AC2C3o ;
					      Per3 Sg Fem  => appPattern3PasPer root C1AC2C3a ;
					      Per3 Pl _=> appPattern3PasPer root C1AC2C3ew  };

		Pas => table {     
		   
					      Per1 Sg      => appPattern3PasPer root pC1AC2C3ie ;
					      Per1 Pl      => appPattern3PasPer root pC1AC2C3en ;
					      Per2 Sg Masc => appPattern3PasPer root pC1AC2C3ek ;
					      Per2 Sg Fem  => appPattern3PasPer root pC1AC2C3esh ;
					      Per2 Pl _      => appPattern3PasPer root pC1AC2C3achehu ;
					      Per3 Sg Masc => appPattern3PasPer root pC1AC2C3o ;
					      Per3 Sg Fem  => appPattern3PasPer root pC1AC2C3a ;
					      Per3 Pl _=> appPattern3PasPer root pC1AC2C3ew 
		  	         } 
		     
		  	         } ;

		Infinitive => table {     
		   Act => table {
					      _      => appPattern3 root meC1AC2aC3 };
		Pas => table {     
		   
					      _      => appPattern3 root pmeC1AC2aC3 
					   
		     
		  	         }

				      
		  	            } ;

	Parti => table {     
		   Act => table {
					      _    => appPattern3pal root C1aC2aC3i };

		Pas => table {     
		   
					      _    => appPattern3pal root pC1aC2aC3i 
					   
		     
		  	         }
					   
		     
		  	         }


			  }
		  };

	mkV3tTb : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  { 


				Act=>table { 
      
		     			      Per1 Sg      => appPattern3 root C1AC2aC3ku ;
					      Per1 Pl      => appPattern3 root C1AC2aC3n ;
					      Per2 Sg Masc => appPattern3 root C1AC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root C1AC2aC3sh ;
					      Per2 Pl _      => appPattern3 root C1AC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root C1AC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root C1AC2aC3ech ;
					      Per3 Pl _=> appPattern3 root C1AC2aC3u };

				Pas => table {Per1 Sg      => appPattern3 root pC1AC2aC3ku ;
					      Per1 Pl      => appPattern3 root pC1AC2aC3n ;
					      Per2 Sg Masc => appPattern3 root pC1AC2aC3k ;
					      Per2 Sg Fem  => appPattern3 root pC1AC2aC3sh ;
					      Per2 Pl _      => appPattern3 root pC1AC2aC3achehu ;   
					      Per3 Sg Masc => appPattern3 root pC1AC2aC3e ;
					      Per3 Sg Fem  => appPattern3 root pC1AC2aC3ech ;
					      Per3 Pl _=> appPattern3 root pC1AC2aC3u }
			    	} ;

      CompPerf => table  {  

				Act => table {
      
		     			      Per1 Sg      => appPattern3 root C1AC2C3iealehu ;
					      Per1 Pl      => appPattern3 root C1AC2C3enal ;
					      Per2 Sg Masc => appPattern3 root C1AC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root C1AC2C3eshal ;
					      Per2 Pl _      => appPattern3 root C1AC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root C1AC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root C1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root C1AC2C3ewwal }; 
			    	
				Pas => table { Per1 Sg      => appPattern3 root pC1AC2C3iealehu ;
					      Per1 Pl      => appPattern3 root pC1AC2C3enal ;
					      Per2 Sg Masc => appPattern3 root pC1AC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root pC1AC2C3eshal ;
					      Per2 Pl _      => appPattern3 root pC1AC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root pC1AC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root pC1AC2C3alech ;
					      Per3 Pl _=> appPattern3 root pC1AC2C3ewwal}
			} ;

				

	Cont => table {    
				Act => table {

						Per1 Sg      => appPattern3 root eC1AC2aC3 ;
					      Per1 Pl      => appPattern3 root enC1AC2aC3e ;
					      Per2 Sg Masc => appPattern3 root teC1AC2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root teC1AC2aC3 ;
					      Per2 Pl _      => appPattern3 root teC1AC2aC3u ;
					      Per3 Sg Masc => appPattern3 root yeC1AC2aC3 ;
					      Per3 Sg Fem  => appPattern3 root teC1AC2aC3 ;
					      Per3 Pl _=> appPattern3 root yeC1AC2aC3u  };

				Pas => table {Per1 Sg      => appPattern3 root peC1AC2aC3 ;
					      Per1 Pl      => appPattern3 root penC1AC2aC3e ;
					      Per2 Sg Masc => appPattern3 root pteC1AC2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root pteC1AC2aC3 ;
					      Per2 Pl _      => appPattern3 root pteC1AC2aC3u ;
					      Per3 Sg Masc => appPattern3 root pyeC1AC2aC3 ;
					      Per3 Sg Fem  => appPattern3 root pteC1AC2aC3 ;
					      Per3 Pl _=> appPattern3 root pyeC1AC2aC3u}

};	 
		Imperf => table {     

				Act => table {
		   
					      Per1 Sg      => appPattern3 root eC1AC2aC3alehu ;
					      Per1 Pl      => appPattern3 root enC1AC2aC3alen ;
					      Per2 Sg Masc => appPattern3 root teC1AC2aC3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root teC1AC2aC3aleh ;
					      Per2 Pl _      => appPattern3 root teC1AC2aC3alachehu ;
					      Per3 Sg Masc => appPattern3 root yeC1AC2aC3al ;
					      Per3 Sg Fem  => appPattern3 root teC1AC2aC3alech ;
					      Per3 Pl _=> appPattern3 root yeC1AC2aC3alu};

				Pas => table {Per1 Sg      => appPattern3 root peC1AC2aC3alehu ;
					      Per1 Pl      => appPattern3 root penC1AC2aC3alen ;
					      Per2 Sg Masc => appPattern3 root pteC1AC2aC3yaleh ;
					      Per2 Sg Fem  => appPattern3pal root pteC1AC2aC3aleh ;
					      Per2 Pl _      => appPattern3 root pteC1AC2aC3alachehu ;
					      Per3 Sg Masc => appPattern3 root pyeC1AC2aC3al ;
					      Per3 Sg Fem  => appPattern3 root pteC1AC2aC3alech ;
					      Per3 Pl _=> appPattern3 root pyeC1AC2aC3alu}
		     

		  	         } ;

		Jus_Imperat => table {   

				Act => table {  
		   
					      Per1 Sg      => appPattern3 root leC1AC2aC3  ;
					      Per1 Pl      => appPattern3 root enC1AC2aC3 ;
					      Per2 Sg Masc => appPattern3 root C1AC2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root C1AC2aC3i;
					      Per2 Pl _      => appPattern3 root C1AC2aC3u ;
					      Per3 Sg Masc => appPattern3 root yC1AC2aC3 ;
					      Per3 Sg Fem  => appPattern3 root tC1AC2aC3 ;
					      Per3 Pl _=> appPattern3 root yC1AC2aC3u } ;


				Pas => table { Per1 Sg      => appPattern3 root pleC1AC2aC3  ;
					      Per1 Pl      => appPattern3 root penC1AC2aC3 ;
					      Per2 Sg Masc => appPattern3 root pC1AC2aC3 ;
					      Per2 Sg Fem  => appPattern3pal root pC1AC2aC3i;
					      Per2 Pl _      => appPattern3 root pC1AC2aC3u ;
					      Per3 Sg Masc => appPattern3 root pyC1AC2aC3 ;
					      Per3 Sg Fem  => appPattern3 root ptC1AC2aC3 ;
					      Per3 Pl _=> appPattern3 root pyC1AC2aC3u}
		     
		  	         } ;

		
		Gerund => table {     


				Act => table {
		   
					      Per1 Sg      => appPattern3 root C1AC2C3ie ;
					      Per1 Pl      => appPattern3 root C1AC2C3en ;
					      Per2 Sg Masc => appPattern3 root C1AC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root C1AC2C3esh ;
					      Per2 Pl _      => appPattern3 root C1AC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root C1AC2C3o ;
					      Per3 Sg Fem  => appPattern3 root C1AC2C3a ;
					      Per3 Pl _=> appPattern3 root C1AC2C3ew };


				Pas => table {
					      Per1 Sg      => appPattern3 root pC1AC2C3ie ;
					      Per1 Pl      => appPattern3 root pC1AC2C3en ;
					      Per2 Sg Masc => appPattern3 root pC1AC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root pC1AC2C3esh ;
					      Per2 Pl _      => appPattern3 root pC1AC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root pC1AC2C3o ;
					      Per3 Sg Fem  => appPattern3 root pC1AC2C3a ;
					      Per3 Pl _=> appPattern3 root pC1AC2C3ew}
		     
		  	         } ;

		Infinitive => table {     

				Act => table {	   
					      _      => appPattern3 root meC1AC2aC3 };

				Pas => table {_      => appPattern3 root pmeC1AC2aC3}

				      
		  	            } ;
	Parti => table {     
		   		Act => table {
					      _    => appPattern3pal root C1aC2aC3i };

				Pas => table {_    => appPattern3pal root pC1aC2aC3i}
					   
		     
		  	         }


			  }
		  };


		mkV3qTr : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  {  
					Act=> table {
      
		     			      Per1 Sg      => appPattern3 root C1oC2eC3ku ;
					      Per1 Pl      => appPattern3 root C1oC2eC3n ;
					      Per2 Sg Masc => appPattern3 root C1oC2eC3k ;
					      Per2 Sg Fem  => appPattern3 root C1oC2eC3sh ;
					      Per2 Pl _      => appPattern3 root C1oC2eC3achehu ;   
					      Per3 Sg Masc => appPattern3 root C1oC2eC3e ;
					      Per3 Sg Fem  => appPattern3 root C1oC2eC3ech ;
					      Per3 Pl _=> appPattern3 root C1oC2eC3u };

					Pas => table {     Per1 Sg      => appPattern3 root pC1oC2eC3ku ;
					      Per1 Pl      => appPattern3 root pC1oC2eC3n ;
					      Per2 Sg Masc => appPattern3 root pC1oC2eC3k ;
					      Per2 Sg Fem  => appPattern3 root pC1oC2eC3sh ;
					      Per2 Pl _      => appPattern3 root pC1oC2eC3achehu ;   
					      Per3 Sg Masc => appPattern3 root pC1oC2eC3e ;
					      Per3 Sg Fem  => appPattern3 root pC1oC2eC3ech ;
					      Per3 Pl _=> appPattern3 root pC1oC2eC3u}
			    	} ;

      		CompPerf => table  { 

				Act => table {
      
		     			      Per1 Sg      => appPattern3pal root C1oC2C3iealehu ;
					      Per1 Pl      => appPattern3 root C1oC2C3enal ;
					      Per2 Sg Masc => appPattern3 root C1oC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root C1oC2C3eshal ;
					      Per2 Pl _      => appPattern3 root C1oC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root C1oC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root C1oC2C3alech ;
					      Per3 Pl _=> appPattern3 root C1oC2C3ewwal };


				Pas => table {Per1 Sg      => appPattern3pal root pC1oC2C3iealehu ;
					      Per1 Pl      => appPattern3 root pC1oC2C3enal ;
					      Per2 Sg Masc => appPattern3 root pC1oC2C3ekal ;
					      Per2 Sg Fem  => appPattern3 root pC1oC2C3eshal ;
					      Per2 Pl _      => appPattern3 root pC1oC2C3achehual ;   
					      Per3 Sg Masc => appPattern3 root pC1oC2C3oal ;
					      Per3 Sg Fem  => appPattern3 root pC1oC2C3alech ;
					      Per3 Pl _=> appPattern3 root pC1oC2C3ewwal}
			    	} ;
     Cont => table {  				
				Act => table {

						Per1 Sg      => appPattern3 root eC1oC2C3 ;
					      Per1 Pl      => appPattern3 root enC1oC2C3e ;
					      Per2 Sg Masc => appPattern3 root teC1oC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root teC1oC2C3 ;
					      Per2 Pl _      => appPattern3 root teC1oC2C3u ;
					      Per3 Sg Masc => appPattern3 root yeC1oC2C3 ;
					      Per3 Sg Fem  => appPattern3 root teC1oC2C3 ;
					      Per3 Pl _=> appPattern3 root yeC1oC2C3u  };


				Pas => table {Per1 Sg      => appPattern3 root peC1oC2C3 ;
					      Per1 Pl      => appPattern3 root penC1oC2C3e ;
					      Per2 Sg Masc => appPattern3 root pteC1oC2C3 ;
					      Per2 Sg Fem  => appPattern3pal root pteC1oC2C3 ;
					      Per2 Pl _      => appPattern3 root pteC1oC2C3u ;
					      Per3 Sg Masc => appPattern3 root pyeC1oC2C3 ;
					      Per3 Sg Fem  => appPattern3 root pteC1oC2C3 ;
					      Per3 Pl _=> appPattern3 root pyeC1oC2C3u  }
		      };
		 
		Imperf => table {    

					Act => table { 
		   
					      Per1 Sg      => appPattern3 root eC1oC2C3alehu ;
					      Per1 Pl      => appPattern3 root enC1oC2C3alen ;
					      Per2 Sg Masc => appPattern3 root teC1oC2C3aleh ;
					      Per2 Sg Fem  => appPattern3pal root teC1oC2C3yalesh ;
					      Per2 Pl _      => appPattern3 root teC1oC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root yeC1oC2C3al ;
					      Per3 Sg Fem  => appPattern3 root teC1oC2C3alech ;
					      Per3 Pl _=> appPattern3 root yeC1oC2C3alu };

					Pas => table {Per1 Sg      => appPattern3 root peC1oC2C3alehu ;
					      Per1 Pl      => appPattern3 root penC1oC2C3alen ;
					      Per2 Sg Masc => appPattern3 root pteC1oC2C3aleh ;
					      Per2 Sg Fem  => appPattern3pal root pteC1oC2C3yalesh ;
					      Per2 Pl _      => appPattern3 root pteC1oC2C3alachehu ;
					      Per3 Sg Masc => appPattern3 root pyeC1oC2C3al ;
					      Per3 Sg Fem  => appPattern3 root pteC1oC2C3alech ;
					      Per3 Pl _=> appPattern3 root pyeC1oC2C3alu}
		     

		  	         } ;

		Jus_Imperat => table {  


					Act => table {   
		   
					      Per1 Sg      => appPattern3 root leC1uC2eC3  ;
					      Per1 Pl      => appPattern3 root enC1uC2eC3 ;
					      Per2 Sg Masc => appPattern3 root C1uC2eC3 ;
					      Per2 Sg Fem  => appPattern3pal root C1uC2eC3i;
					      Per2 Pl _      => appPattern3 root C1uC2eC3u ;
					      Per3 Sg Masc => appPattern3 root yC1uC2eC3 ;
					      Per3 Sg Fem  => appPattern3 root tC1uC2eC3 ;
					      Per3 Pl _=> appPattern3 root yC1uC2eC3u };
					
					Pas => table {Per1 Sg      => appPattern3 root pleC1uC2eC3  ;
					      Per1 Pl      => appPattern3 root penC1uC2eC3 ;
					      Per2 Sg Masc => appPattern3 root pC1uC2eC3 ;
					      Per2 Sg Fem  => appPattern3pal root pC1uC2eC3i;
					      Per2 Pl _      => appPattern3 root pC1uC2eC3u ;
					      Per3 Sg Masc => appPattern3 root pyC1uC2eC3 ;
					      Per3 Sg Fem  => appPattern3 root ptC1uC2eC3 ;
					      Per3 Pl _=> appPattern3 root pyC1uC2eC3u} 
		     
		  	         } ;

		
		Gerund => table {

					Act => table {     
		   
					      Per1 Sg      => appPattern3pal root C1oC2C3ie ;
					      Per1 Pl      => appPattern3 root C1oC2C3en ;
					      Per2 Sg Masc => appPattern3 root C1oC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root C1oC2C3esh ;
					      Per2 Pl _      => appPattern3 root C1oC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root C1oC2C3o ;
					      Per3 Sg Fem  => appPattern3 root C1oC2C3a ;
					      Per3 Pl _=> appPattern3 root C1oC2C3ew };

					Pas => table { Per1 Sg      => appPattern3pal root pC1oC2C3ie ;
					      Per1 Pl      => appPattern3 root pC1oC2C3en ;
					      Per2 Sg Masc => appPattern3 root pC1oC2C3ek ;
					      Per2 Sg Fem  => appPattern3 root pC1oC2C3esh ;
					      Per2 Pl _      => appPattern3 root pC1oC2C3achehu ;
					      Per3 Sg Masc => appPattern3 root pC1oC2C3o ;
					      Per3 Sg Fem  => appPattern3 root pC1oC2C3a ;
					      Per3 Pl _=> appPattern3 root pC1oC2C3ew}
		     
		  	         } ;

		Infinitive => table { 

					Act => table {    
		   
					      _      => appPattern3 root meC1uC2eC3 };
					Pas => table {_      => appPattern3 root pmeC1uC2eC3}

				      
		  	            } ;

	Parti => table {     
		   			Act => table {
					      _    => appPattern3pal root C1oC2aC3i };

					Pas => table {_    => appPattern3pal root pC1oC2aC3i }
					   
		     
		  	         }


			  }
		  };
       




	mkV2bl : Str -> Verb = \v ->

		let root = getRoot2 v

		in {

		s = table { 


		Perf => table  {  

					Act=>table {
      		     			      Per1 Sg      => appPattern2 root C1aC2hu ;
					      Per1 Pl      => appPattern2 root C1aC2n ;
					      Per2 Sg Masc => appPattern2 root C1aC2k ;
					      Per2 Sg Fem  => appPattern2 root C1aC2sh ;
					      Per2 Pl _      => appPattern2 root C1aC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1aC2a ;
					      Per3 Sg Fem  => appPattern2 root C1aC2ach ;
					      Per3 Pl _=> appPattern2 root C1aC2u };

					Pas => table {      Per1 Sg      => appPattern2 root pC1aC2hu ;
					      Per1 Pl      => appPattern2 root pC1aC2n ;
					      Per2 Sg Masc => appPattern2 root pC1aC2k ;
					      Per2 Sg Fem  => appPattern2 root pC1aC2sh ;
					      Per2 Pl _      => appPattern2 root pC1aC2achehu ;   
					      Per3 Sg Masc => appPattern2 root pC1aC2a ;
					      Per3 Sg Fem  => appPattern2 root pC1aC2ach ;
					      Per3 Pl _=> appPattern2 root pC1aC2u}
			    	} ;

CompPerf => table  { 			      
					Act => table {
						Per1 Sg      => appPattern2 root C1eC2ciealehu ;
					      Per1 Pl      => appPattern2 root C1eC2tenal ;
					      Per2 Sg Masc => appPattern2 root C1eC2tekal ;
					      Per2 Sg Fem  => appPattern2 root C1eC2teshal ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehual ;
					      Per3 Sg Masc => appPattern2 root C1eC2toal ;
					      Per3 Sg Fem  => appPattern2 root C1eC2talech ;
					      Per3 Pl _=> appPattern2 root C1eC2tewal};


					Pas => table {	Per1 Sg      => appPattern2 root pC1eC2ciealehu ;
					      Per1 Pl      => appPattern2 root pC1eC2tenal ;
					      Per2 Sg Masc => appPattern2 root pC1eC2tekal ;
					      Per2 Sg Fem  => appPattern2 root pC1eC2teshal ;
					      Per2 Pl _      => appPattern2 root pC1eC2tachehual ;
					      Per3 Sg Masc => appPattern2 root pC1eC2toal ;
					      Per3 Sg Fem  => appPattern2 root pC1eC2talech ;
					      Per3 Pl _=> appPattern2 root pC1eC2tewal}



 };

Cont => table {  				
					Act => table {
					Per1 Sg      => appPattern2 root eC1eC2a ;
					      Per1 Pl      => appPattern2 root enC1eC2a ;
					      Per2 Sg Masc => appPattern2 root teC1eC2a ;
					      Per2 Sg Fem  => appPattern2pal root teC1eC2i ;
					      Per2 Pl _      => appPattern2 root teC1eC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1eC2a ;
					      Per3 Sg Fem  => appPattern2 root teC1eC2a ;
					      Per3 Pl _=> appPattern2 root yeC1eC2u };

					Pas => table {Per1 Sg      => appPattern2 root peC1eC2a ;
					      Per1 Pl      => appPattern2 root penC1eC2a ;
					      Per2 Sg Masc => appPattern2 root pteC1eC2a ;
					      Per2 Sg Fem  => appPattern2pal root pteC1eC2i ;
					      Per2 Pl _      => appPattern2 root pteC1eC2u ;
					      Per3 Sg Masc => appPattern2 root pyeC1eC2a ;
					      Per3 Sg Fem  => appPattern2 root pteC1eC2a ;
					      Per3 Pl _=> appPattern2 root pyeC1eC2u}

				};		 
		Imperf => table {    
					Act => table { 
					      Per1 Sg      => appPattern2 root eC1eC2alehu ;
					      Per1 Pl      => appPattern2 root enC1eC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1eC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1eC2aleh ;
					      Per2 Pl _     => appPattern2 root teC1eC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1eC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1eC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1eC2alu};

					Pas => table {   Per1 Sg      => appPattern2 root peC1eC2alehu ;
					      Per1 Pl      => appPattern2 root penC1eC2alen ;
					      Per2 Sg Masc => appPattern2 root pteC1eC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root pteC1eC2aleh ;
					      Per2 Pl _     => appPattern2 root pteC1eC2alachehu ;
					      Per3 Sg Masc => appPattern2 root pyeC1eC2al ;
					      Per3 Sg Fem  => appPattern2 root pteC1eC2alech ;
					      Per3 Pl _=> appPattern2 root pyeC1eC2alu}		     

		  	         } ;

		Jus_Imperat => table {  

					Act => table {   
		   
					      Per1 Sg      => appPattern2 root leC1C2a  ;
					      Per1 Pl      => appPattern2 root enC1C2a ;
					      Per2 Sg Masc => appPattern2 root C1C2a ;
					      Per2 Sg Fem  => appPattern2pal root C1C2i ;
					      Per2 Pl _      => appPattern2 root C1C2u ;
					      Per3 Sg Masc => appPattern2 root yC1C2a ;
					      Per3 Sg Fem  => appPattern2 root tC1C2a ;
					      Per3 Pl _=> appPattern2 root yC1C2u };


					Pas => table { Per1 Sg      => appPattern2 root pleC1C2a  ;
					      Per1 Pl      => appPattern2 root penC1C2a ;
					      Per2 Sg Masc => appPattern2 root pC1C2a ;
					      Per2 Sg Fem  => appPattern2pal root pC1C2i ;
					      Per2 Pl _      => appPattern2 root pC1C2u ;
					      Per3 Sg Masc => appPattern2 root pyC1C2a ;
					      Per3 Sg Fem  => appPattern2 root ptC1C2a ;
					      Per3 Pl _=> appPattern2 root pyC1C2u}
		     
		  	         } ;

		
		Gerund => table {     
		   			Act => table {
					      Per1 Sg      => appPattern2 root C1eC2cie ;
					      Per1 Pl      => appPattern2 root C1eC2ten ;
					      Per2 Sg Masc => appPattern2 root C1eC2tek ;
					      Per2 Sg Fem  => appPattern2 root C1eC2tesh ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehu ;
					      Per3 Sg Masc => appPattern2 root C1eC2to ;
					      Per3 Sg Fem  => appPattern2 root C1eC2ta ;
					      Per3 Pl _=> appPattern2 root C1eC2tew};

					Pas => table {    Per1 Sg      => appPattern2 root pC1eC2cie ;
					      Per1 Pl      => appPattern2 root pC1eC2ten ;
					      Per2 Sg Masc => appPattern2 root pC1eC2tek ;
					      Per2 Sg Fem  => appPattern2 root pC1eC2tesh ;
					      Per2 Pl _      => appPattern2 root pC1eC2tachehu ;
					      Per3 Sg Masc => appPattern2 root pC1eC2to ;
					      Per3 Sg Fem  => appPattern2 root pC1eC2ta ;
					      Per3 Pl _=> appPattern2 root pC1eC2tew}
		  	         } ;

		
		Infinitive => table {     
		   			Act => table {
					      _    => appPattern2 root meC1C2at };

					Pas => table {_    => appPattern2 root pmeC1C2at}
					   
		     
		  	         } ;

	Parti => table {     
		   			Act => table {
					      _    => appPattern2pal root C1eC2 };

					Pas => table {_    => appPattern2pal root pC1eC2}
					   
		     
		  	         }


			  }
		  };

	mkV2yz : Str -> Verb = \v ->

		let root = getRoot2 v

		in {

		s = table { 
 

		Perf => table  {  

					Act => table {
      
		     			      Per1 Sg      => appPattern2 root C1AC2hu ;
					      Per1 Pl      => appPattern2 root C1AC2n ;
					      Per2 Sg Masc => appPattern2 root C1AC2k ;
					      Per2 Sg Fem  => appPattern2 root C1AC2sh ;
					      Per2 Pl _      => appPattern2 root C1AC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1AC2a ;
					      Per3 Sg Fem  => appPattern2 root C1AC2ach ;
					      Per3 Pl _=> appPattern2 root C1AC2u};


					Pas => table {Per1 Sg      => appPattern2 root C1AC2hu ;
					      Per1 Pl      => appPattern2 root C1AC2n ;
					      Per2 Sg Masc => appPattern2 root C1AC2k ;
					      Per2 Sg Fem  => appPattern2 root C1AC2sh ;
					      Per2 Pl _      => appPattern2 root C1AC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1AC2a ;
					      Per3 Sg Fem  => appPattern2 root C1AC2ach ;
					      Per3 Pl _=> appPattern2 root C1AC2u}
			    	} ;

CompPerf => table  {  			     
				Act => table {

						 Per1 Sg      => appPattern2 root C1C2iealehu ;
					      Per1 Pl      => appPattern2 root C1C2enal ;
					      Per2 Sg Masc => appPattern2 root C1C2ekal ;
					      Per2 Sg Fem  => appPattern2 root C1C2eshal ;
					      Per2 Pl _      => appPattern2 root C1C2achehual ;
					      Per3 Sg Masc => appPattern2 root C1C2oal ;
					      Per3 Sg Fem  => appPattern2 root C1C2alech ;
					      Per3 Pl _=> appPattern2 root C1C2ewal };

				Pas => table {

						 Per1 Sg      => appPattern2 root C1C2iealehu ;
					      Per1 Pl      => appPattern2 root C1C2enal ;
					      Per2 Sg Masc => appPattern2 root C1C2ekal ;
					      Per2 Sg Fem  => appPattern2 root C1C2eshal ;
					      Per2 Pl _      => appPattern2 root C1C2achehual ;
					      Per3 Sg Masc => appPattern2 root C1C2oal ;
					      Per3 Sg Fem  => appPattern2 root C1C2alech ;
					      Per3 Pl _=> appPattern2 root C1C2ewal }



				};

Cont => table {      				

					Act => table {

						Per1 Sg      => appPattern2 root eC1C2  ;
					      Per1 Pl      => appPattern2 root enC1C2 ;
					      Per2 Sg Masc => appPattern2 root teC1C2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1C2 ;
					      Per2 Pl _      => appPattern2 root teC1C2u ;
					      Per3 Sg Masc => appPattern2 root yeC1C2 ;
					      Per3 Sg Fem  => appPattern2 root teC1C2 ;
					      Per3 Pl _=> appPattern2 root yeC1C2u };

					Pas => table {Per1 Sg      => appPattern2 root eC1C2  ;
					      Per1 Pl      => appPattern2 root enC1C2 ;
					      Per2 Sg Masc => appPattern2 root teC1C2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1C2 ;
					      Per2 Pl _      => appPattern2 root teC1C2u ;
					      Per3 Sg Masc => appPattern2 root yeC1C2 ;
					      Per3 Sg Fem  => appPattern2 root teC1C2 ;
					      Per3 Pl _=> appPattern2 root yeC1C2u} 
};
		 
		Imperf => table {

					Act => table { 
				    
		   
					      Per1 Sg      => appPattern2 root eC1C2alehu  ;
					      Per1 Pl      => appPattern2 root enC1C2alen ;
					      Per2 Sg Masc => appPattern2 root teC1C2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1C2aleh ;
					      Per2 Pl _      => appPattern2 root teC1C2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1C2al ;
					      Per3 Sg Fem  => appPattern2 root teC1C2alech ;
					      Per3 Pl _=> appPattern2 root yeC1C2alu };

					Pas => table {
					      Per1 Sg      => appPattern2 root eC1C2alehu  ;
					      Per1 Pl      => appPattern2 root enC1C2alen ;
					      Per2 Sg Masc => appPattern2 root teC1C2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1C2aleh ;
					      Per2 Pl _      => appPattern2 root teC1C2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1C2al ;
					      Per3 Sg Fem  => appPattern2 root teC1C2alech ;
					      Per3 Pl _=> appPattern2 root yeC1C2alu} 
		     

		  	         } ;

		Jus_Imperat => table {   

					Act => table {   
		   
					      Per1 Sg      => appPattern2 root leC1aC2a  ;
					      Per1 Pl      => appPattern2 root enC1aC2a ;
					      Per2 Sg Masc => appPattern2 root C1aC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1aC2i ;
					      Per2 Pl _      => appPattern2 root C1eC2u ;
					      Per3 Sg Masc => appPattern2 root yC1aC2a ;
					      Per3 Sg Fem  => appPattern2 root tC1aC2a ;
					      Per3 Pl _=> appPattern2 root yC1aC2u };


					Pas => table {Per1 Sg      => appPattern2 root leC1aC2a  ;
					      Per1 Pl      => appPattern2 root enC1aC2a ;
					      Per2 Sg Masc => appPattern2 root C1aC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1aC2i ;
					      Per2 Pl _      => appPattern2 root C1eC2u ;
					      Per3 Sg Masc => appPattern2 root yC1aC2a ;
					      Per3 Sg Fem  => appPattern2 root tC1aC2a ;
					      Per3 Pl _=> appPattern2 root yC1aC2u} 
		     
		  	         } ;

		
		Gerund => table {    

					Act => table {  
		   
					      Per1 Sg      => appPattern2 root C1C2ie ;
					      Per1 Pl      => appPattern2 root C1C2en ;
					      Per2 Sg Masc => appPattern2 root C1C2ek ;
					      Per2 Sg Fem  => appPattern2 root C1C2esh ;
					      Per2 Pl _      => appPattern2 root C1C2achehu ;
					      Per3 Sg Masc => appPattern2 root C1C2o ;
					      Per3 Sg Fem  => appPattern2 root C1C2a ;
					      Per3 Pl _=> appPattern2 root C1C2ew };

					Pas => table {Per1 Sg      => appPattern2 root C1C2ie ;
					      Per1 Pl      => appPattern2 root C1C2en ;
					      Per2 Sg Masc => appPattern2 root C1C2ek ;
					      Per2 Sg Fem  => appPattern2 root C1C2esh ;
					      Per2 Pl _      => appPattern2 root C1C2achehu ;
					      Per3 Sg Masc => appPattern2 root C1C2o ;
					      Per3 Sg Fem  => appPattern2 root C1C2a ;
					      Per3 Pl _=> appPattern2 root C1C2ew} 
		  	         } ;

		
		Infinitive => table {     
					Act => table { 
		   
					      _    => appPattern2 root meC1aC2};

					Pas => table { _    => appPattern2 root meC1aC2} 
					   
		     
		  	         } ;

	Parti => table { 
				Act => table {_    => appPattern2pal root C1aC2ii  };

				Pas => table {_    => appPattern2pal root C1aC2ii  }      
		   
					      
					   
		     
		  	         }


			  }
		  };



	mkV2nr : Str -> Verb = \v ->

		let root = getRoot2 v

		in {

		s = table { 


		Perf => table  {  

					Act => table {
      
		     			      Per1 Sg      => appPattern2 root C1oC2hu ;
					      Per1 Pl      => appPattern2 root C1oC2n ;
					      Per2 Sg Masc => appPattern2 root C1oC2k ;
					      Per2 Sg Fem  => appPattern2 root C1oC2sh ;
					      Per2 Pl _      => appPattern2 root C1oC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1oC2a ;
					      Per3 Sg Fem  => appPattern2 root C1oC2ach ;
					      Per3 Pl _=> appPattern2 root C1oC2u };

					Pas => table {      Per1 Sg      => appPattern2 root C1oC2hu ;
					      Per1 Pl      => appPattern2 root C1oC2n ;
					      Per2 Sg Masc => appPattern2 root C1oC2k ;
					      Per2 Sg Fem  => appPattern2 root C1oC2sh ;
					      Per2 Pl _      => appPattern2 root C1oC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1oC2a ;
					      Per3 Sg Fem  => appPattern2 root C1oC2ach ;
					      Per3 Pl _=> appPattern2 root C1oC2u}
			    	} ;

		CompPerf => table  { 
					Act => table {
					      Per1 Sg      => appPattern2pal root C1oC2iealehu ;
					      Per1 Pl      => appPattern2 root C1oC2enal ;
					      Per2 Sg Masc => appPattern2 root C1oC2ekal ;
					      Per2 Sg Fem  => appPattern2 root C1oC2eshal;
					      Per2 Pl _      => appPattern2 root C1oC2achehual;
					      Per3 Sg Masc => appPattern2 root C1oC2oal ;
					      Per3 Sg Fem  => appPattern2 root C1oC2Alech ;
					      Per3 Pl _=> appPattern2 root C1oC2ewal };

					Pas => table  {
					      Per1 Sg      => appPattern2pal root C1oC2iealehu ;
					      Per1 Pl      => appPattern2 root C1oC2enal ;
					      Per2 Sg Masc => appPattern2 root C1oC2ekal ;
					      Per2 Sg Fem  => appPattern2 root C1oC2eshal;
					      Per2 Pl _      => appPattern2 root C1oC2achehual;
					      Per3 Sg Masc => appPattern2 root C1oC2oal ;
					      Per3 Sg Fem  => appPattern2 root C1oC2Alech ;
					      Per3 Pl _=> appPattern2 root C1oC2ewal}
				};

Cont => table { 	Act => table {		      
					      Per1 Sg      => appPattern2 root eC1oC2  ;
					      Per1 Pl      => appPattern2 root enC1oC2 ;
					      Per2 Sg Masc => appPattern2 root teC1oC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2i ;
					      Per2 Pl _      => appPattern2 root teC1oC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2 ;
					      Per3 Pl _=> appPattern2 root yeC1oC2u};

			Pas => table { Per1 Sg      => appPattern2 root eC1oC2  ;
					      Per1 Pl      => appPattern2 root enC1oC2 ;
					      Per2 Sg Masc => appPattern2 root teC1oC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2i ;
					      Per2 Pl _      => appPattern2 root teC1oC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2 ;
					      Per3 Pl _=> appPattern2 root yeC1oC2u}
 };		 
		Imperf => table {  

					Act => table {  
		   
					      Per1 Sg      => appPattern2 root eC1oC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1oC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1oC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2alesh ;
					      Per2 Pl _      => appPattern2 root teC1oC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1oC2alu } ;
					Pas => table { Per1 Sg      => appPattern2 root eC1oC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1oC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1oC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2alesh ;
					      Per2 Pl _      => appPattern2 root teC1oC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1oC2alu}
		     

		  	         } ;

		Jus_Imperat => table {   


					Act => table {  
		   
					      Per1 Sg      => appPattern2 root leC1uC2;
					      Per1 Pl      => appPattern2 root enC1uC2;
					      Per2 Sg Masc => appPattern2 root C1uC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1uC2i ;
					      Per2 Pl __      => appPattern2 root C1uC2u ;
					      Per3 Sg Masc => appPattern2 root yC1uC2 ;
					      Per3 Sg Fem  => appPattern2 root tC1uC2 ;
					      Per3 Pl _=> appPattern2 root yC1uC2u };

					Pas => table {  Per1 Sg      => appPattern2 root leC1uC2;
					      Per1 Pl      => appPattern2 root enC1uC2;
					      Per2 Sg Masc => appPattern2 root C1uC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1uC2i ;
					      Per2 Pl __      => appPattern2 root C1uC2u ;
					      Per3 Sg Masc => appPattern2 root yC1uC2 ;
					      Per3 Sg Fem  => appPattern2 root tC1uC2 ;
					      Per3 Pl _=> appPattern2 root yC1uC2u}
		     
		  	         } ;

		
		Gerund => table { 

					Act => table {    
		   
					      Per1 Sg      => appPattern2 root C1oC2ie ;
					      Per1 Pl      => appPattern2 root C1oC2en ;
					      Per2 Sg Masc => appPattern2 root C1oC2ek ;
					      Per2 Sg Fem  => appPattern2 root C1oC2esh;
					      Per2 Pl _      => appPattern2 root C1oC2achehu;
					      Per3 Sg Masc => appPattern2 root C1oC2o ;
					      Per3 Sg Fem  => appPattern2 root C1oC2A ;
					      Per3 Pl _=> appPattern2 root C1oC2ew };

					Pas => table {      Per1 Sg      => appPattern2 root C1oC2ie ;
					      Per1 Pl      => appPattern2 root C1oC2en ;
					      Per2 Sg Masc => appPattern2 root C1oC2ek ;
					      Per2 Sg Fem  => appPattern2 root C1oC2esh;
					      Per2 Pl _      => appPattern2 root C1oC2achehu;
					      Per3 Sg Masc => appPattern2 root C1oC2o ;
					      Per3 Sg Fem  => appPattern2 root C1oC2A ;
					      Per3 Pl _=> appPattern2 root C1oC2ew}
		     
		  	         } ;

		
		Infinitive => table {     

					Act => table {
		   
					      _    => appPattern2 root meC1oC2 };

					Pas => table {_    => appPattern2 root meC1oC2 }
					   
		     
		  	         } ;
	Parti => table {     
					Act => table {
		   
					      _    => appPattern2pal root C1uaC2i };

					Pas => table { _    => appPattern2pal root C1uaC2i } 
					   
		     
		  	         }


			  }
		  };

	mkV2sT : Str -> Verb = \v ->

		let root = getRoot2 v

		in {

		s = table { 


		Perf => table  { 


				Act => table { 
      
		     			      Per1 Sg      => appPattern2 root C1eC2hu ;
					      Per1 Pl      => appPattern2 root C1eC2n ;
					      Per2 Sg Masc => appPattern2 root C1eC2k ;
					      Per2 Sg Fem  => appPattern2 root C1eC2sh ;
					      Per2 Pl _      => appPattern2 root C1eC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1eC2a ;
					      Per3 Sg Fem  => appPattern2 root C1eC2ach ;
					      Per3 Pl _=> appPattern2 root C1aC2u };

			    Pas => table {     Per1 Sg      => appPattern2 root C1eC2hu ;
					      Per1 Pl      => appPattern2 root C1eC2n ;
					      Per2 Sg Masc => appPattern2 root C1eC2k ;
					      Per2 Sg Fem  => appPattern2 root C1eC2sh ;
					      Per2 Pl _      => appPattern2 root C1eC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1eC2a ;
					      Per3 Sg Fem  => appPattern2 root C1eC2ach ;
					      Per3 Pl _=> appPattern2 root C1aC2u}
			    	} ;

CompPerf => table  {			      

				Act => table {
						Per1 Sg      => appPattern2 root C1eC2ciealehu ;
					      Per1 Pl      => appPattern2 root C1eC2tenal ;
					      Per2 Sg Masc => appPattern2 root C1eC2tekal ;
					      Per2 Sg Fem  => appPattern2 root C1eC2teshal ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehual ;
					      Per3 Sg Masc => appPattern2 root C1eC2toal ;
					      Per3 Sg Fem  => appPattern2 root C1eC2talech ;
					      Per3 Pl _=> appPattern2 root C1eC2tewal };

				 Pas => table {	Per1 Sg      => appPattern2 root C1eC2ciealehu ;
					      Per1 Pl      => appPattern2 root C1eC2tenal ;
					      Per2 Sg Masc => appPattern2 root C1eC2tekal ;
					      Per2 Sg Fem  => appPattern2 root C1eC2teshal ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehual ;
					      Per3 Sg Masc => appPattern2 root C1eC2toal ;
					      Per3 Sg Fem  => appPattern2 root C1eC2talech ;
					      Per3 Pl _=> appPattern2 root C1eC2tewal }
		   } ;
Cont => table {    
				Act => table {
						Per1 Sg      => appPattern2 root eC1oC2  ;
					      Per1 Pl      => appPattern2 root enC1oC2 ;
					      Per2 Sg Masc => appPattern2 root teC1oC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2i ;
					      Per2 Pl _      => appPattern2 root teC1oC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2 ;
					      Per3 Pl _=> appPattern2 root yeC1oC2u };

				 Pas => table {Per1 Sg      => appPattern2 root eC1oC2  ;
					      Per1 Pl      => appPattern2 root enC1oC2 ;
					      Per2 Sg Masc => appPattern2 root teC1oC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1oC2i ;
					      Per2 Pl _      => appPattern2 root teC1oC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1oC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1oC2 ;
					      Per3 Pl _=> appPattern2 root yeC1oC2u}
};		 
		Imperf => table {  

				 Act => table {   
		   
					      Per1 Sg      => appPattern2 root eC1eC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1eC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1eC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1eC2aleh ;
					      Per2 Pl _      => appPattern2 root teC1eC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1eC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1eC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1eC2alu };


				 Pas => table {     Per1 Sg      => appPattern2 root eC1eC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1eC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1eC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1eC2aleh ;
					      Per2 Pl _      => appPattern2 root teC1eC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1eC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1eC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1eC2alu }
		     

		  	         } ;

		Jus_Imperat => table {  


				 Act => table {   
		   
					      Per1 Sg      => appPattern2 root leC1eC2;
					      Per1 Pl      => appPattern2 root enC1eC2;
					      Per2 Sg Masc => appPattern2 root C1C2  ;
					      Per2 Sg Fem  => appPattern2pal root C1eC2i ;
					      Per2 Pl _      => appPattern2 root C1C2u ;
					      Per3 Sg Masc => appPattern2 root yC1eC2 ;
					      Per3 Sg Fem  => appPattern2 root tC1eC2 ;
					      Per3 Pl _=> appPattern2 root yC1C2u };

				 Pas => table {	      Per1 Sg      => appPattern2 root leC1eC2;
					      Per1 Pl      => appPattern2 root enC1eC2;
					      Per2 Sg Masc => appPattern2 root C1C2  ;
					      Per2 Sg Fem  => appPattern2pal root C1eC2i ;
					      Per2 Pl _      => appPattern2 root C1C2u ;
					      Per3 Sg Masc => appPattern2 root yC1eC2 ;
					      Per3 Sg Fem  => appPattern2 root tC1eC2 ;
					      Per3 Pl _=> appPattern2 root yC1C2u}
		  	         } ;

		
		Gerund => table {    


				 Act => table { 
		   
					      Per1 Sg      => appPattern2 root C1eC2cie ;
					      Per1 Pl      => appPattern2 root C1eC2ten ;
					      Per2 Sg Masc => appPattern2 root C1eC2tek ;
					      Per2 Sg Fem  => appPattern2 root C1eC2tesh ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehu ;
					      Per3 Sg Masc => appPattern2 root C1eC2to ;
					      Per3 Sg Fem  => appPattern2 root C1eC2ta ;
					      Per3 Pl _=> appPattern2 root C1eC2tew };

				 Pas => table {Per1 Sg      => appPattern2 root C1eC2cie ;
					      Per1 Pl      => appPattern2 root C1eC2ten ;
					      Per2 Sg Masc => appPattern2 root C1eC2tek ;
					      Per2 Sg Fem  => appPattern2 root C1eC2tesh ;
					      Per2 Pl _      => appPattern2 root C1eC2tachehu ;
					      Per3 Sg Masc => appPattern2 root C1eC2to ;
					      Per3 Sg Fem  => appPattern2 root C1eC2ta ;
					      Per3 Pl _=> appPattern2 root C1eC2tew }
		  	         } ;

		
		Infinitive => table { 

				 Act => table {   
		   
					      _    => appPattern2 root meC1C2et } ;

				 Pas => table { _    => appPattern2 root meC1C2et}
					   
		     
		  	         } ;
	Parti => table {     
		   		 Act => table {
					      _    => appPattern2pal root C1eC2 };
				
				 Pas => table {
					      _    => appPattern2pal root C1eC2 }
					   
		     
		  	         }


			  }
		  };



mkV2wN : Str -> Verb = \v ->

		let root = getRoot2 v

		in {

		s = table { 


		Perf => table  {  

				Act => table {
      
		     			      Per1 Sg      => appPattern2 root C1AC2ehu ;
					      Per1 Pl      => appPattern2 root C1AC2en ;
					      Per2 Sg Masc => appPattern2 root C1AC2ek;
					      Per2 Sg Fem  => appPattern2 root C1AC2esh;
					      Per2 Pl _      => appPattern2 root C1AC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1AC2a ;
					      Per3 Sg Fem  => appPattern2 root C1AC2ach ;
					      Per3 Pl _=> appPattern2 root C1AC2u };

				Pas => table {      Per1 Sg      => appPattern2 root C1AC2ehu ;
					      Per1 Pl      => appPattern2 root C1AC2en ;
					      Per2 Sg Masc => appPattern2 root C1AC2ek;
					      Per2 Sg Fem  => appPattern2 root C1AC2esh;
					      Per2 Pl _      => appPattern2 root C1AC2achehu ;   
					      Per3 Sg Masc => appPattern2 root C1AC2a ;
					      Per3 Sg Fem  => appPattern2 root C1AC2ach ;
					      Per3 Pl _=> appPattern2 root C1AC2u}

			    	} ;

CompPerf => table  {  			      
				Act => table {
					      Per1 Sg      => appPattern2 root C1aC2ciealehu ;
					      Per1 Pl      => appPattern2 root C1aC2tenal ;
					      Per2 Sg Masc => appPattern2 root C1aC2tekal ;
					      Per2 Sg Fem  => appPattern2 root C1aC2teshal ;
					      Per2 Pl _      => appPattern2 root C1aC2tachehual ;
					      Per3 Sg Masc => appPattern2 root C1aC2toal ;
					      Per3 Sg Fem  => appPattern2 root C1aC2talech ;
					      Per3 Pl _=> appPattern2 root C1aC2tewal};
				
				Pas => table {	      Per1 Sg      => appPattern2 root C1aC2ciealehu ;
					      Per1 Pl      => appPattern2 root C1aC2tenal ;
					      Per2 Sg Masc => appPattern2 root C1aC2tekal ;
					      Per2 Sg Fem  => appPattern2 root C1aC2teshal ;
					      Per2 Pl _      => appPattern2 root C1aC2tachehual ;
					      Per3 Sg Masc => appPattern2 root C1aC2toal ;
					      Per3 Sg Fem  => appPattern2 root C1aC2talech ;
					      Per3 Pl _=> appPattern2 root C1aC2tewal}
				

				 };

Cont => table {      			  Act => table {    
				             Per1 Sg      => appPattern2 root eC1aC2  ;
					      Per1 Pl      => appPattern2 root enC1aC2 ;
					      Per2 Sg Masc => appPattern2 root teC1aC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1aC2 ;
					      Per2 Pl _      => appPattern2 root teC1aC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1aC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1aC2 ;
					      Per3 Pl _=> appPattern2 root yeC1aC2u };

					Pas => table {   
				             Per1 Sg      => appPattern2 root eC1aC2  ;
					      Per1 Pl      => appPattern2 root enC1aC2 ;
					      Per2 Sg Masc => appPattern2 root teC1aC2 ;
					      Per2 Sg Fem  => appPattern2pal root teC1aC2 ;
					      Per2 Pl _      => appPattern2 root teC1aC2u ;
					      Per3 Sg Masc => appPattern2 root yeC1aC2 ;
					      Per3 Sg Fem  => appPattern2 root teC1aC2 ;
					      Per3 Pl _=> appPattern2 root yeC1aC2u}
		      };		 
		Imperf => table {     

				Act => table {
		   
					      Per1 Sg      => appPattern2 root eC1aC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1aC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1aC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1aC2alesh ;
					      Per2 Pl _      => appPattern2 root teC1aC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1aC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1aC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1aC2alu };

				Pas => table {	      Per1 Sg      => appPattern2 root eC1aC2alehu  ;
					      Per1 Pl      => appPattern2 root enC1aC2alen ;
					      Per2 Sg Masc => appPattern2 root teC1aC2yaleh ;
					      Per2 Sg Fem  => appPattern2pal root teC1aC2alesh ;
					      Per2 Pl _      => appPattern2 root teC1aC2alachehu ;
					      Per3 Sg Masc => appPattern2 root yeC1aC2al ;
					      Per3 Sg Fem  => appPattern2 root teC1aC2alech ;
					      Per3 Pl _=> appPattern2 root yeC1aC2alu}
		     

		  	         } ;

		Jus_Imperat => table {   

				Act => table {  
		   
					      Per1 Sg      => appPattern2 root leC1aC2a  ;
					      Per1 Pl      => appPattern2 root enC1aC2a ;
					      Per2 Sg Masc => appPattern2 root C1aC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1aC2i ;
					      Per2 Pl _      => appPattern2 root C1eC2u ;
					      Per3 Sg Masc => appPattern2 root yC1aC2a ;
					      Per3 Sg Fem  => appPattern2 root tC1aC2a ;
					      Per3 Pl _=> appPattern2 root yC1aC2u };

				Pas => table {   Per1 Sg      => appPattern2 root leC1aC2a  ;
					      Per1 Pl      => appPattern2 root enC1aC2a ;
					      Per2 Sg Masc => appPattern2 root C1aC2  ;
					      Per2 Sg Fem  => appPattern2pal root C1aC2i ;
					      Per2 Pl _      => appPattern2 root C1eC2u ;
					      Per3 Sg Masc => appPattern2 root yC1aC2a ;
					      Per3 Sg Fem  => appPattern2 root tC1aC2a ;
					      Per3 Pl _=> appPattern2 root yC1aC2u}
		  	         } ;

		
		Gerund => table {    

				Act => table {
		   
					      Per1 Sg      => appPattern2 root C1aC2cie ;
					      Per1 Pl      => appPattern2 root C1aC2ten ;
					      Per2 Sg Masc => appPattern2 root C1aC2tek ;
					      Per2 Sg Fem  => appPattern2 root C1aC2tesh ;
					      Per2 Pl _      => appPattern2 root C1aC2tachehu ;
					      Per3 Sg Masc => appPattern2 root C1aC2to ;
					      Per3 Sg Fem  => appPattern2 root C1aC2ta ;
					      Per3 Pl _=> appPattern2 root C1aC2tew} ;

				Pas => table {      Per1 Sg      => appPattern2 root C1aC2cie ;
					      Per1 Pl      => appPattern2 root C1aC2ten ;
					      Per2 Sg Masc => appPattern2 root C1aC2tek ;
					      Per2 Sg Fem  => appPattern2 root C1aC2tesh ;
					      Per2 Pl _      => appPattern2 root C1aC2tachehu ;
					      Per3 Sg Masc => appPattern2 root C1aC2to ;
					      Per3 Sg Fem  => appPattern2 root C1aC2ta ;
					      Per3 Pl _=> appPattern2 root C1aC2tew}
		  	         } ;

		
		Infinitive => table { 

				Act => table {    
		   
					      _    => appPattern2 root meC1aC2et };

				Pas => table {_    => appPattern2 root meC1aC2et}
					   
		     
		  	         } ;
	Parti => table {    
				Act => table { 
		   
					      _    => appPattern2pal root C1aC2i };

				Pas => table {_    => appPattern2pal root C1aC2i }
					   
		     
		  	         }


			  }
		  };


	
---------- QUAD

	mkV4dbdb : Str -> Verb = \v ->

		let root = getRoot4 v

		in {

		s = table { 


		Perf => table  { 

				Act => table { 
      
		     			      Per1 Sg      => appPattern4 root C1aC2aC3aC4hu ;
					      Per1 Pl      => appPattern4 root C1aC2aC3aC4n ;
					      Per2 Sg Masc => appPattern4 root C1aC2aC3aC4k ;
					      Per2 Sg Fem  => appPattern4 root C1aC2aC3aC4sh ;
					      Per2 Pl _      => appPattern4 root C1aC2aC3aC4achehu ;   
					      Per3 Sg Masc => appPattern4 root C1aC2aC3aC4a ;
					      Per3 Sg Fem  => appPattern4 root C1aC2aC3aC4ech ;
					      Per3 Pl _=> appPattern4 root C1aC2aC3aC4u };

				Pas => table {Per1 Sg      => appPattern4 root C1aC2aC3aC4hu ;
					      Per1 Pl      => appPattern4 root C1aC2aC3aC4n ;
					      Per2 Sg Masc => appPattern4 root C1aC2aC3aC4k ;
					      Per2 Sg Fem  => appPattern4 root C1aC2aC3aC4sh ;
					      Per2 Pl _      => appPattern4 root C1aC2aC3aC4achehu ;   
					      Per3 Sg Masc => appPattern4 root C1aC2aC3aC4a ;
					      Per3 Sg Fem  => appPattern4 root C1aC2aC3aC4ech ;
					      Per3 Pl _=> appPattern4 root C1aC2aC3aC4u}

			    	} ;

CompPerf => table  {  			      
				Act => table {
					      Per1 Sg      => appPattern4pal root C1aC2C3C4iealehu ;
					      Per1 Pl      => appPattern4 root C1aC2C3C4enal ;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4ekal ;
					      Per2 Sg Fem  => appPattern4 root C1aC2C3C4eshal ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4achehual ;
					      Per3 Sg Masc => appPattern4 root C1aC2C3C4oal ;
					      Per3 Sg Fem  => appPattern4 root C1aC2C3C4alech ;
					      Per3 Pl _=> appPattern4 root C1aC2C3C4ewal  };


				Pas => table {   Per1 Sg      => appPattern4pal root C1aC2C3C4iealehu ;
					      Per1 Pl      => appPattern4 root C1aC2C3C4enal ;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4ekal ;
					      Per2 Sg Fem  => appPattern4 root C1aC2C3C4eshal ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4achehual ;
					      Per3 Sg Masc => appPattern4 root C1aC2C3C4oal ;
					      Per3 Sg Fem  => appPattern4 root C1aC2C3C4alech ;
					      Per3 Pl _=> appPattern4 root C1aC2C3C4ewal}
};

Cont => table {	     			
      				Act => table {
					      Per1 Sg      => appPattern4 root eC1aC2aC3C4  ;
					      Per1 Pl      => appPattern4 root enC1aC2aC3C4 ;
					      Per2 Sg Masc => appPattern4 root teC1aC2aC3C4 ;
					      Per2 Sg Fem  => appPattern4pal root teC1aC2aC3C4i ;
					      Per2 Pl _      => appPattern4 root teC1aC2aC3C4u ;
					      Per3 Sg Masc => appPattern4 root yeC1aC2aC3C4 ;
					      Per3 Sg Fem  => appPattern4 root teC1aC2aC3C4 ;
					      Per3 Pl _=> appPattern4 root yeC1aC2aC3C4u };

				Pas => table {   Per1 Sg      => appPattern4 root eC1aC2aC3C4  ;
					      Per1 Pl      => appPattern4 root enC1aC2aC3C4 ;
					      Per2 Sg Masc => appPattern4 root teC1aC2aC3C4 ;
					      Per2 Sg Fem  => appPattern4pal root teC1aC2aC3C4i ;
					      Per2 Pl _      => appPattern4 root teC1aC2aC3C4u ;
					      Per3 Sg Masc => appPattern4 root yeC1aC2aC3C4 ;
					      Per3 Sg Fem  => appPattern4 root teC1aC2aC3C4 ;
					      Per3 Pl _=> appPattern4 root yeC1aC2aC3C4u }
				
 };		 
		Imperf => table {     

					Act => table {
		   
					      Per1 Sg      => appPattern4 root eC1aC2aC3C4alehu  ;
					      Per1 Pl      => appPattern4 root enC1aC2aC3C4alen ;
					      Per2 Sg Masc => appPattern4 root teC1aC2aC3C4yaleh ;
					      Per2 Sg Fem  => appPattern4pal root teC1aC2aC3C4aleh ;
					      Per2 Pl _     => appPattern4 root teC1aC2aC3C4alachehu ;
					      Per3 Sg Masc => appPattern4 root yeC1aC2aC3C4al ;
					      Per3 Sg Fem  => appPattern4 root teC1aC2aC3C4alech ;
					      Per3 Pl _=> appPattern4 root yeC1aC2aC3C4alu};


					Pas => table {      Per1 Sg      => appPattern4 root eC1aC2aC3C4alehu  ;
					      Per1 Pl      => appPattern4 root enC1aC2aC3C4alen ;
					      Per2 Sg Masc => appPattern4 root teC1aC2aC3C4yaleh ;
					      Per2 Sg Fem  => appPattern4pal root teC1aC2aC3C4aleh ;
					      Per2 Pl _     => appPattern4 root teC1aC2aC3C4alachehu ;
					      Per3 Sg Masc => appPattern4 root yeC1aC2aC3C4al ;
					      Per3 Sg Fem  => appPattern4 root teC1aC2aC3C4alech ;
					      Per3 Pl _=> appPattern4 root yeC1aC2aC3C4alu}
		  	         } ;

		Jus_Imperat => table {    

					Act => table { 
		   
					      Per1 Sg      => appPattern4 root leC1aC2C3C4;
					      Per1 Pl      => appPattern4 root enC1aC2C3C4;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4  ;
					      Per2 Sg Fem  => appPattern4pal root C1aC2C3C4i ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4u ;
					      Per3 Sg Masc => appPattern4 root yC1aC2C3C4 ;
					      Per3 Sg Fem  => appPattern4 root tC1aC2C3C4 ;
					      Per3 Pl _=> appPattern4 root yC1aC2C3C4u};

					Pas => table {     Per1 Sg      => appPattern4 root leC1aC2C3C4;
					      Per1 Pl      => appPattern4 root enC1aC2C3C4;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4  ;
					      Per2 Sg Fem  => appPattern4pal root C1aC2C3C4i ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4u ;
					      Per3 Sg Masc => appPattern4 root yC1aC2C3C4 ;
					      Per3 Sg Fem  => appPattern4 root tC1aC2C3C4 ;
					      Per3 Pl _=> appPattern4 root yC1aC2C3C4u}
		  	         } ;

		
		Gerund => table {  

					Act => table {   
		   
					      Per1 Sg      => appPattern4pal root C1aC2C3C4ie ;
					      Per1 Pl      => appPattern4 root C1aC2C3C4en ;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4ek ;
					      Per2 Sg Fem  => appPattern4 root C1aC2C3C4esh ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4achehu ;
					      Per3 Sg Masc => appPattern4 root C1aC2C3C4o ;
					      Per3 Sg Fem  => appPattern4 root C1aC2C3C4a ;
					      Per3 Pl _=> appPattern4 root C1aC2C3C4ew};

					Pas => table { Per1 Sg      => appPattern4pal root C1aC2C3C4ie ;
					      Per1 Pl      => appPattern4 root C1aC2C3C4en ;
					      Per2 Sg Masc => appPattern4 root C1aC2C3C4ek ;
					      Per2 Sg Fem  => appPattern4 root C1aC2C3C4esh ;
					      Per2 Pl _      => appPattern4 root C1aC2C3C4achehu ;
					      Per3 Sg Masc => appPattern4 root C1aC2C3C4o ;
					      Per3 Sg Fem  => appPattern4 root C1aC2C3C4a ;
					      Per3 Pl _=> appPattern4 root C1aC2C3C4ew}
		  	         } ;

		
		Infinitive => table {     
					Act => table {
		   
					      _    => appPattern4 root meC1aC2C3aC4 };

					Pas => table {_    => appPattern4 root meC1aC2C3aC4 }
					   
		     
		  	         } ;

		Parti => table {   
					Act => table {  
		   
					      _    => appPattern4pal root C1eC2C3aC4i };

					Pas => table {_    => appPattern4pal root C1eC2C3aC4i}
					   
		     
		  	         }


			  }
		  };



--test : for verbs that start with A - need further clearup with those -AS as well
	mkV3asr : Str -> Verb = \v ->

		let root = getRoot3 v

		in {

		s = table { 


		Perf => table  { 

				Act => table { 
      
		     			      Per1 Sg      => appPatternRemove root C1aC2aC3ku ;
					      Per1 Pl      => appPatternRemove root C1aC2aC3n ;
					      Per2 Sg Masc => appPatternRemove root C1aC2aC3k ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2aC3sh ;
					      Per2 Pl _      => appPatternRemove root C1aC2aC3achehu ;   
					      Per3 Sg Masc => appPatternRemove root C1aC2aC3e ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2aC3ech ;
					      Per3 Pl _=> appPatternRemove root C1aC2aC3u };

				Pas => table {    Per1 Sg      => appPatternRemove root C1aC2aC3ku ;
					      Per1 Pl      => appPatternRemove root C1aC2aC3n ;
					      Per2 Sg Masc => appPatternRemove root C1aC2aC3k ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2aC3sh ;
					      Per2 Pl _      => appPatternRemove root C1aC2aC3achehu ;   
					      Per3 Sg Masc => appPatternRemove root C1aC2aC3e ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2aC3ech ;
					      Per3 Pl _=> appPatternRemove root C1aC2aC3u }
			    	} ;

CompPerf => table  {    			
				Act => table {
					Per1 Sg      => appPatternRemove root C1aC2C3ie ;
					      Per1 Pl      => appPatternRemove root C1aC2C3en ;
					      Per2 Sg Masc => appPatternRemove root C1aC2C3ek ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2C3esh ;
					      Per2 Pl _     => appPatternRemove root C1aC2C3achehu ;
					      Per3 Sg Masc => appPatternRemove root C1aC2C3o ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2C3a ;
					      Per3 Pl _=> appPatternRemove root C1aC2C3ew};

			Pas => table {Per1 Sg      => appPatternRemove root C1aC2C3ie ;
					      Per1 Pl      => appPatternRemove root C1aC2C3en ;
					      Per2 Sg Masc => appPatternRemove root C1aC2C3ek ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2C3esh ;
					      Per2 Pl _     => appPatternRemove root C1aC2C3achehu ;
					      Per3 Sg Masc => appPatternRemove root C1aC2C3o ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2C3a ;
					      Per3 Pl _=> appPatternRemove root C1aC2C3ew}

			

  };

Cont => table { 	

				Act => table {			
						Per1 Sg      => appPatternRemove root eC1aC2C3alehu ;
					      Per1 Pl      => appPatternRemove root enC1aC2C3alen ;
					      Per2 Sg Masc => appPatternRemove root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPatternRemove root teC1aC2C3aleh ;
					      Per2 Pl _      => appPatternRemove root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPatternRemove root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPatternRemove root teC1aC2C3alech ;
					      Per3 Pl _=> appPatternRemove root yeC1aC2C3alu };


				Pas => table {	Per1 Sg      => appPatternRemove root eC1aC2C3alehu ;
					      Per1 Pl      => appPatternRemove root enC1aC2C3alen ;
					      Per2 Sg Masc => appPatternRemove root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPatternRemove root teC1aC2C3aleh ;
					      Per2 Pl _      => appPatternRemove root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPatternRemove root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPatternRemove root teC1aC2C3alech ;
					      Per3 Pl _=> appPatternRemove root yeC1aC2C3alu}
			};
		 
		Imperf => table {  
					Act => table {		   
					      Per1 Sg      => appPatternRemove root eC1aC2C3alehu ;
					      Per1 Pl      => appPatternRemove root enC1aC2C3alen ;
					      Per2 Sg Masc => appPatternRemove root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPatternRemove root teC1aC2C3aleh ;
					      Per2 Pl _      => appPatternRemove root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPatternRemove root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPatternRemove root teC1aC2C3alech ;
					      Per3 Pl _=> appPatternRemove root yeC1aC2C3alu};

					Pas => table {   Per1 Sg      => appPatternRemove root eC1aC2C3alehu ;
					      Per1 Pl      => appPatternRemove root enC1aC2C3alen ;
					      Per2 Sg Masc => appPatternRemove root teC1aC2C3yaleh ;
					      Per2 Sg Fem  => appPatternRemove root teC1aC2C3aleh ;
					      Per2 Pl _      => appPatternRemove root teC1aC2C3alachehu ;
					      Per3 Sg Masc => appPatternRemove root yeC1aC2C3al ;
					      Per3 Sg Fem  => appPatternRemove root teC1aC2C3alech ;
					      Per3 Pl _=> appPatternRemove root yeC1aC2C3alu}

		  	         } ;

		Jus_Imperat => table { 

					Act => table {    
		   
					      Per1 Sg      => appPatternRemove root leC1C2aC3  ;
					      Per1 Pl      => appPatternRemove root enC1C2aC3 ;
					      Per2 Sg Masc => appPatternRemove root C1C2aC3 ;
					      Per2 Sg Fem  => appPatternRemove root C1C2aC3i ;
					      Per2 Pl _      => appPatternRemove root C1C2aC3u ;
					      Per3 Sg Masc => appPatternRemove root yC1C2aC3 ;
					      Per3 Sg Fem  => appPatternRemove root tC1C2aC3 ;
					      Per3 Pl _=> appPatternRemove root yC1C2aC3u };

					Pas => table {Per1 Sg      => appPatternRemove root leC1C2aC3  ;
					      Per1 Pl      => appPatternRemove root enC1C2aC3 ;
					      Per2 Sg Masc => appPatternRemove root C1C2aC3 ;
					      Per2 Sg Fem  => appPatternRemove root C1C2aC3i ;
					      Per2 Pl _      => appPatternRemove root C1C2aC3u ;
					      Per3 Sg Masc => appPatternRemove root yC1C2aC3 ;
					      Per3 Sg Fem  => appPatternRemove root tC1C2aC3 ;
					      Per3 Pl _=> appPatternRemove root yC1C2aC3u}
		  	         } ;

		
		Gerund => table { 


				Act => table {    
		   
					      Per1 Sg      => appPatternRemove root C1aC2C3ie ;
					      Per1 Pl      => appPatternRemove root C1aC2C3en ;
					      Per2 Sg Masc => appPatternRemove root C1aC2C3ek ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2C3esh ;
					      Per2 Pl _     => appPatternRemove root C1aC2C3achehu ;
					      Per3 Sg Masc => appPatternRemove root C1aC2C3o ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2C3a ;
					      Per3 Pl _=> appPatternRemove root C1aC2C3ew };

				Pas => table { Per1 Sg      => appPatternRemove root C1aC2C3ie ;
					      Per1 Pl      => appPatternRemove root C1aC2C3en ;
					      Per2 Sg Masc => appPatternRemove root C1aC2C3ek ;
					      Per2 Sg Fem  => appPatternRemove root C1aC2C3esh ;
					      Per2 Pl _     => appPatternRemove root C1aC2C3achehu ;
					      Per3 Sg Masc => appPatternRemove root C1aC2C3o ;
					      Per3 Sg Fem  => appPatternRemove root C1aC2C3a ;
					      Per3 Pl _=> appPatternRemove root C1aC2C3ew}
		  	         } ;

		
	Infinitive => table { 

				Act => table {    
		   
					      _    => appPatternRemove root meC1C2aC3 };

				Pas => table {_    => appPatternRemove root meC1C2aC3}
					   
		     
		  	         } ;

	Parti => table {     
		   		Act => table {
					      _    => appPatternRemove root meC1C2aC3  };

				Pas => table { _    => appPatternRemove root meC1C2aC3  }
					   
		     
		  	         }


			  }
		  };

-- trial
mkV3al: Str -> Verb = \v ->

	{

		s = table { 


		Perf => table  { 

			Act => table {

		     			      Per1 Sg      => "ነበረኝ" ;
					      Per1 Pl      => "ነበረን";
					      Per2 Sg Masc =>"ነበረህ";
					      Per2 Sg Fem  => "ነበረሽ";
					      Per2 Pl _    => "ነበራችሁ";
					      Per3 Sg Masc => "ነበረው";
					      Per3 Sg Fem  => "ነበራት";
					      Per3 Pl _=>  "ነበራቸው"};

                         Pas => table {

					      Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""

				}
			    	} ;

               CompPerf => table  {  

       			Act => table {
	 	     			      Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> "" };

			Pas => table {	       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> "" }
			    	} ;
 

                Cont => table {    

				Act => table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""};

  			Pas =>table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""}
};
		 
		Imperf => table {     
		   
			Act => table {
					       Per1 Sg      => "አለኝ" ;
					      Per1 Pl      => "አለን";
					      Per2 Sg Masc =>"አለህ";
					      Per2 Sg Fem  => "አለሽ";
					      Per2 Pl _    => "አላችሁ";
					      Per3 Sg Masc => "አለው";
					      Per3 Sg Fem  => "አላት";
					      Per3 Pl _=>  "አላቸው"};

			Pas => table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""}};

		Jus_Imperat => table {  

				Act => table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> "" };
			      Pas => table  {
					      Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""}
		  	         } ;

		
		Gerund => table {   

				Act => table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""};

				Pas => table {
					       Per1 Sg      => "" ;
					      Per1 Pl      => "" ;
					      Per2 Sg Masc => "" ;
					      Per2 Sg Fem  => "" ;
					      Per2 Pl _     => "" ;   
					      Per3 Sg Masc => "" ;
					      Per3 Sg Fem  => "" ;
					      Per3 Pl _=> ""}
		  	         } ;

		
	Infinitive => table {     
		   			Act => table {
					     	 _    => "" };

				       Pas => table {  _    => "" }
					   
		     
		  	         }; 
	Parti => table {     
		   			Act => table {
					      _    => "" };
					Pas => table { _ => "" }
					   
		     
		  	         }
}
			  
};		




} ;
