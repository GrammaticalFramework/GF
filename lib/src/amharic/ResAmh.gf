
--# -path=.:../abstract:../common:../../prelude


-- (c) 2010 Markos KG
-- Licensed under LGPL


resource ResAmh =  PatternsAmh** open Prelude,MorphoAmh,ParamX in {
--PatternsAmh ** open Prelude in {

        flags coding = utf8;
	
	param
		Species = Def | Indef ;	
		-- Number = Sg | Pl ; --Sg | Pl --ParamX **
		-- Gen = Gp1Sg | Gp1Pl | Gp2Sg Gender | Gp2Pl | Gp3Sg Gender | Gp3Pl ; betih == ye ante bet

		Case    = Nom | Acc | Gen | Dat ; ---source : 'Grammar of the Amharic Language' - Revised on Jun 								10th 2010 for the addition of the Dative case
		Gender  = Masc | Fem ; -- the Amharic nouns have but two genders Masculine and Feminine
                --Person = P1 | P2 | P3 ; -- P1 | P2 | P3  ParamX **
		--PerNumGen = Vp1Sg | Vp1Pl | Vp2Sg Gender | Vp2Pl | Vp3Sg Gender | Vp3Pl ;

		PerNumGen =  Per1 Number| Per2 Number Gender |Per3 Number Gender ;

		VForm = Perf  |Imperf |Jus_Imperat|Gerund|Infinitive|Parti|CompPerf|Cont  ;

		Voice = Act | Pas ;  

		--Polarity = Pos | Neg;

		--QForm = QDir | QIndir ;

                TenseAmh =  PresFut |SimplePast|PresPerf | PastPerf |  PresCont | PastCont;              
		


--
		--  Agr = Ag Gender Number Person ; 

		-- To count the length of a tail in a sequence of digits, e.g. to put commas
		-- as in 1,000,000.

		-- DTail = T1 | T2 | T3 ; -- ParamX


	oper  

		Agr = { png : PerNumGen ; isPron : Bool};

		Obj : Type = { 
		      s : Str ; 
		      a : Agr
		      };
		
		Verb : Type = {
				s : VForm =>Voice => PerNumGen  => Str 
			      } ; -- {s : s : VForm => PerNumGen  => Str  ; aux : Aux} ;

		V0,VS, VQ, VA, V2A ,V2V, V2S, V2Q  = Verb ; -- = {s : VForm => Str} ;-- {s : Tense => VPerNumGen  => Str } ;
		V2= Verb ** {c2 : Prep} ;

		V3 = ResAmh.Verb ** {c2, c3 : Prep} ;

             
	
		Noun : Type = {
				s : Number => Species => Case => Str ;
			        g : Gender
			      } ;
                N2 = {s : Number => Species => Case => Str ;
                      g : Gender} ** {c2 : Str} ;
 
                N3 = {s : Number => Species => Case => Str ;
		      g : Gender} ** {c2,c3 : Str} ;

                Adjective : Type = {
                                     s : Gender => Number => Species => Case => Str
                                   } ;
                Verb2 : Type = Verb ;---- {v : Verb ; obj : Str} ;

		VP : Type = {
			     s : TenseAmh => Polarity =>PerNumGen => Str ;
                             obj : Obj ;
                             pred: Comp;   --- DO or IO  Liju 
			     imp : Str;
	                     isPred : Bool;
			     inf: Str; --indicates if there is a predicate 
                             s2 : Str          
			    } ;
		
                Comp = {s : AmhAgr => Case => Str} ;

  		AmhAgr = { g : Gender ; n : Number  } ; -- species  later addition

 
                VPSlash = VP ** {c2 : Prep} ;

                S  = {s : Str} ;

                Cl : Type = { s : TenseAmh => Polarity => Str};

		QCl = {s : TenseAmh => Polarity  => Str} ;

                ClSlash : Type = {
		      s : TenseAmh => Polarity => Str ;
		      c2 : Prep
		   } ;
-- FIX ME : addition of the isPron -- DONE

 	        NP  = {
			      s : Case => Str ; 
                              a : Agr  
                                                      
                            } ; 
                -- Adjective

		AP : Type = {	
                               s: Gender => Number => Species => Case => Str 
			        
			    } ; 

                Quant = {	
				s : Number  => Gender => Case => Str; 
		    		d : Species;
		    		isNum : Bool;
		     		isPron: Bool
                        } ;

     		 Det : Type = {
			        s : Gender => Case => Str ; 
			        d : Species; 
			        n : Number; 
			        isNum : Bool;
			        isPron : Bool 
			      } ;

		PN : Type = {
			     s : Case => Str; 
			     g : Gender
                            } ;

    		Predet : Type = { 
      				s : Case => Str;
      				isDecl : Bool 
      				};

		Prep = {s : Str ; s2:Str ; isPre : Bool} ;
		

		CAdv : Type = { s: Str};

                 -- Numeral

    		Numeral = {
                            s : CardOrd=>Gender=>Number=>Species=>Case => Str  
                            
                          } ;

    		Digits  = {
                            s : CardOrd=>Gender=>Number=>Species=>Case => Str ; 
                            tail : DTail
                          } ;

 		Ord =  {s : Gender=>Number=>Species=>Case => Str} ;


    		Num  = {s : Species=>Case => Str ; 
			n : Number ; 
			hasCard : Bool} ;

    		Card = {s : Gender => Number=>Species=>Case => Str ; -- Decision with Number grr...should not be like this but should be. TO DO
                        } ;
     
		Imp = {s : Polarity => Gender => Number => Str} ;

		IP = {s : Str ; n : Number} ;   
                
                IDet = {s : Case => Str ; n : Number} ; 
		
		IQuant = {s : Number => Str} ;


	        Conj = {s1,s2 : Str ; n : Number} ;


		Pattern2 : Type = {C1,C1C2,C2: Str};
		Pattern3 : Type = {C1,C1C2,C2C3,C3 : Str};
		Pattern4 : Type = {C1,C1C2,C2C3,C3C4,C4 : Str};
		Root2    : Type = {C1,C2: Str};
    		Root3    : Type = Root2 ** {C3 : Str};
                Root4    : Type = Root3 ** {C4 : Str};   

             

		-- N O U N
		
		{-Note: the declension of Nouns is very simple and uniform. Nouns are inflected 		through four Cases, equally in the singular and the plural,ie. the Nominative, the 			Genetive, Dative and Accusative.

		One example may suffice to show the while mode of proceeding 
		    	sing                 			plural
		Nom:	bEt - a house    			bEtoc - houses
		Gen:	yebEt - of a house, a house's		yebEtoc - of houses
		Dat:	lebEt - to a house			lebEtoc - to houses
		Acc:	bEtn- a house				bEtocn - houses
		-}				
		


	mkNoun : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x16 : Str) -> Gender -> Noun = 
     		 \sdn,sda,sdg,sdd,sin,sia,sig,sid,pdn,pda,pdg,pdd,pin,pia,pig,pid,g -> {
     	 s = table {

                  Sg => table { 
                                  Def => table 
                                            { 
                                              Nom => sdn ; 
                                              Acc => sda ; 
                                              Gen => sdg ; 
                                              Dat => sdd 
                                            };   
                                  Indef => table 
                                            { 
                                              Nom => sin ; 
                                              Acc => sia ; 
                                              Gen => sig ; 
                                              Dat => sid 
                                            } 
                                } ;   
  
                  Pl  => table { 
                                  Def=> table 
                                            { 
                                              Nom => pdn ; 
                                              Acc => pda ; 
                                              Gen => pdg ; 
                                              Dat => pdd 
                                            }; 
                                  Indef => table 
                                            { 
                                              Nom => pin ; 
                                              Acc => pia ; 
                                              Gen => pig ; 
                                              Dat => pid 
                                            } 
                                } 
              		 
           } ;  g = g
         		 } ;

-- most amharic nouns follow the Masc trend so...

		
		regN : Str -> Noun =            
			\bEt -> 
        		 let bE = init bEt
        		 in
   		mkNoun (bE + replaceLastLet6_2_M (last bEt))
                       (bE + replaceLastLet6_2_M (last bEt)+"ን") 
                             ("የ"+bE + replaceLastLet6_2_M (last bEt)) 
                             ("ለ"+bE + replaceLastLet6_2_M (last bEt)) 
                       bEt
                       (bEt+"ን") 
                             ("የ"+bEt)
                             ("ለ"+bEt)
                       (bE + init(replaceLastLet6_7(last bEt))+replaceLastLet6_2_M (replaceLastLet6_7(last bEt)) )
                       ((bE + init(replaceLastLet6_7(last bEt)) +replaceLastLet6_2_M(replaceLastLet6_7(last bEt)))+"ን")
                             ("የ"+(bE + init(replaceLastLet6_7(last bEt))+replaceLastLet6_2_M (replaceLastLet6_7(last bEt)) ))
                             ("ለ"+(bE + init(replaceLastLet6_7(last bEt))+replaceLastLet6_2_M (replaceLastLet6_7(last bEt)) ))
                       (bE + replaceLastLet6_7 (last bEt))
                       (bE+replaceLastLet6_7 (last bEt)+"ን")
                             ("የ"+bE + replaceLastLet6_7 (last bEt))  
                             ("ለ"+bE + replaceLastLet6_7 (last bEt))
                       Masc ;


	 	regN2 :  Str -> Gender -> Noun = \root,g -> 
			case root of {
			bE + t@? => table {
		Masc => mkNoun (bE + replaceLastLet6_2_M (t)) 
                               (bE + replaceLastLet6_2_M (t)+"ን") 
                                       ("የ"+bE + replaceLastLet6_2_M (t))
                                       ("ለ"+bE + replaceLastLet6_2_M (t)) 
                               root 
                               (root+"ን") 
                                       ("የ"+root)
                                       ("ለ"+root)
                               (bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) )
                               ((bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M   (replaceLastLet6_7(t)))+"ን")
                                       ("የ"+(bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) ))
                                       ("ለ"+(bE + init(replaceLastLet6_7 (t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) ))
                               (bE + replaceLastLet6_7 (t))
			       (bE+replaceLastLet6_7 (t)+"ን")
                                       ("የ"+bE + replaceLastLet6_7 (t))
                                       ("ለ"+bE + replaceLastLet6_7 (t)) g;

		Fem => mkNoun  (bE + replaceLastLet6_2_F (t))
                               (bE + replaceLastLet6_2_F (t)+"ን") 
                                       ("የ"+bE + replaceLastLet6_2_F (t))
                                       ("ለ"+bE + replaceLastLet6_2_F (t)) 
                               root 
                               (root+"ን")      
                                       ("የ"+root)
                                       ("ለ"+root)
                               (bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) )
                               ((bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)))+"ን")
                                       ("የ"+(bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) ))
                                       ("ለ"+(bE + init(replaceLastLet6_7(t))+replaceLastLet6_2_M (replaceLastLet6_7(t)) ))
                               (bE + replaceLastLet6_7 (t))
			       (bE+replaceLastLet6_7 (t)+"ን")
                                       ("የ"+bE + replaceLastLet6_7 (t))
                                       ("ለ"+bE + replaceLastLet6_7 (t)) g
 		  } ! g
			}; 


                compN : Noun -> Noun -> Noun ;
                                       
                compN x y = 
              		{              
		          s = \\N,S,C => case C of 
                                { 
                                  Gen|Dat =>  x.s ! Sg ! Indef!C++ y.s ! N ! S ! Nom ;
                                   _      =>  x.s ! Sg ! Indef!Nom  ++ y.s ! N ! S !C  
                                }; 
                          g = y.g;  
                     	  lock_N = <>
                 	} ;


		
		

	--PN

        preOrPost2 : Bool -> Str-> Str -> Str -> Str = \pr,x,y,z -> 
    	if_then_Str pr (x ++ y) (x ++ y ++ z) ;

	
	affix :  Case => Str =
	      table {
		
		Acc => "ን";
		Gen => "የ";
		Dat =>"ለ";
		_ => ""
	      };



	mkPN : Str -> Gender -> PN = \ str,gen -> 

	    { 
		s = \\c =>case c of
		{
		Gen|Dat => affix!c + str;
		   _    => str + affix!c 
		};

	        g = gen;

		 lock_PN = <>
	    };
       

	mkPredet : Str -> Bool -> Predet = \word,decl ->
      		
	      { 
		s = \\c => 
		  case decl of {
		    True =>  case c of
			{
			Gen|Dat => affix!c + word;
			   _    => word + affix!c 
			};
		    False => word
		  };
		isDecl = decl
	      };

	mkPrep : Str -> Str-> Bool -> Prep = \word1,word2,ispre ->
      	      {
	            s = word1; s2 = word2;
		    isPre = ispre
	      };




	
  mk2Conj : Str -> Str -> Number -> Conj = \x,y,n -> 

    lin Conj (sd2 x y ** {n = n}) ;

mkConj = overload {
    mkConj : Str -> Conj = \y -> mk2Conj [] y Pl ;
    mkConj : Str -> Number -> Conj = \y,n -> mk2Conj [] y n ;
    mkConj : Str -> Str -> Conj = \x,y -> mk2Conj x y Pl ;
    mkConj : Str -> Str -> Number -> Conj = mk2Conj ;
  } ;


  mkConj : overload {
    mkConj : Str -> Conj ;                  -- and (plural agreement)
    mkConj : Str -> Number -> Conj ;        -- or (agrement number given as argument)
    mkConj : Str -> Str -> Conj ;           -- both ... and (plural)
    mkConj : Str -> Str -> Number -> Conj ; -- either ... or (agrement number given as argument)
  } ;

        mkIP : Str -> Number -> {s : Str ; n : Number} = \s,n -> {s = s ; n = n} ;
     	
	--mkAdv : Str -> C.Adv = \x -> { s = x};

	mkN2 : Noun -> Prep -> N2;

	mkN2 = \n,p -> lin N2 (n ** {c2 = p.s}) ;

	mkN3 : Noun -> Prep -> Prep -> N3 ;
	
	mkN3 = \n,p,q -> lin N3 (n ** {c2 = p.s ; c3 = q.s}) ;





--Adjective = {s : Gender (mf) => Number(sp) =>Species (di)=> Case (nagd) => Str} ;
mkAdjective : (x1,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,x32 : Str)-> Adjective = 
     		 \msdn,msda,msdg,msdd,msin,msia,msig,msid,mpdn,mpda,mpdg,mpdd,mpin,mpia,mpig,mpid,
                  fsdn,fsda,fsdg,fsdd,fsin,fsia,fsig,fsid,fpdn,fpda,fpdg,fpdd,fpin,fpia,fpig,fpid-> {
     		 s = table {

                  Masc => table { 
                                  Sg=> table 
                                            { 
                                             Def=> table 
                                                        { 
                                                         Nom => msdn ; 
                                                         Acc => msda ; 
                                                         Gen => msdg ; 
                                                         Dat => msdd 
                                                        };   
                                             Indef=> table 
                                                        { 
                                                          Nom => msin ; 
                                                          Acc => msia ; 
                                                          Gen => msig ; 
                                                          Dat => msid 
                                                         }  
                                            };   
                                  Pl=> table 
                                            { 
                                              Def=> table 
                                                        { 
                                                          Nom => mpdn ; 
                                                          Acc => mpda ; 
                                                          Gen => mpdg ; 
                                                          Dat => mpdd 
                                                        };   
                                             Indef=> table 
                                                        { 
                                                          Nom => mpin ; 
                                                          Acc => mpia ; 
                                                          Gen => mpig ; 
                                                          Dat => mpid 
                                                         }  
                                            } 
                                } ;   
  
                  Fem  => table { 
                                   Sg=> table 
                                            { 
                                             Def=> table 
                                                        { 
                                                         Nom => fsdn ; 
                                                         Acc => fsda ; 
                                                         Gen => fsdg ; 
                                                         Dat => fsdd 
                                                        };   
                                             Indef=> table 
                                                        { 
                                                          Nom => fsin ; 
                                                          Acc => fsia ; 
                                                          Gen => fsig ; 
                                                          Dat => fsid 
                                                         }  
                                            };   
                                  Pl=> table 
                                            { 
                                              Def=> table 
                                                        { 
                                                         Nom => fpdn ; 
                                                         Acc => fpda ; 
                                                         Gen => fpdg ; 
                                                         Dat => fpdd 
                                                        };   
                                             Indef=> table 
                                                        { 
                                                          Nom => fpin ; 
                                                          Acc => fpia ; 
                                                          Gen => fpig ; 
                                                          Dat => fpid 
                                                         }  
                                            } 
                                } 
              		 
           }
         		 } ;

-- most amharic nouns follow the Masc trend so...

		 regAdj : Str -> Adjective =            
			\qey -> 
        		 let qe = init qey
        		 in

   		 mkAdjective   (qe + replaceLastLet6_2_M (last qey)) 
                               (qe + replaceLastLet6_2_M (last qey)+"ን") 
                                       ("የ"+qe + replaceLastLet6_2_M (last qey))
                                       ("ለ"+qe + replaceLastLet6_2_M (last qey)) 
                               qey 
                               (qey+"ን") 
                                       ("የ"+qey)
                                       ("ለ"+qey)
                               (qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) )
                               ((qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M   (replaceLastLet6_7(last qey)))+"ን")
                                       ("የ"+(qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) ))
                                       ("ለ"+(qe + init(replaceLastLet6_7 (last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) ))
                               (qe + replaceLastLet6_7 (last qey))
			       (qe+replaceLastLet6_7 (last qey)+"ን")
                                       ("የ"+qe + replaceLastLet6_7 (last qey))
                                       ("ለ"+qe + replaceLastLet6_7 (last qey))
			       (qe + replaceLastLet6_2_F (last qey))
                               (qe + replaceLastLet6_2_F (last qey)+"ን") 
                                       ("የ"+qe + replaceLastLet6_2_F (last qey))
                                       ("ለ"+qe + replaceLastLet6_2_F (last qey)) 
                               qey 
                               (qey+"ን")      
                                       ("የ"+qey)
                                       ("ለ"+qey)
                               (qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) )
                               ((qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)))+"ን")
                                       ("የ"+(qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) ))
                                       ("ለ"+(qe + init(replaceLastLet6_7(last qey))+replaceLastLet6_2_M (replaceLastLet6_7(last qey)) ))
                               (qe + replaceLastLet6_7 (last qey))
			       (qe+replaceLastLet6_7 (last qey)+"ን")
                                       ("የ"+qe + replaceLastLet6_7 (last qey))
                                       ("ለ"+qe + replaceLastLet6_7 (last qey)) ;  


	mkAdjyh : Str -> Adjective = 
                 
                 \yh ->            
			
   		 mkAdjective    (yh+"ኛው")
				(yh+"ኛው"+"ን")
				"የዚህኛው"
				"ለዚህኛው"
				yh
				(yh+"ን")
				"የዚህ"
				"ለዚህ"
				"እነዚኞቹ"
				"እነዚኞቹን"
				"የእነዚኞቹ"
				"ለእነዚኞቹ"
				"እነዚህ"
				"እነዚህን"
				"የእነዚህ"
				"ለእነዚህ"
				(yh+"ች"+"ኛዋ")
				(yh+"ች"+"ኛዋ"+"ን")
				"የዚህችኛዋ"
				"ለዚህችኛዋ"
				 (yh+"ች")
				(yh+"ችን")
				"የዚህች"
				"ለዚህች"
				"እነዚኞቹ"
				"እነዚኞቹን"
				"የእነዚኞቹ"
				"ለእነዚኞቹ"
				"እነዚህ"
				"እነዚህን"
				"የእነዚህ"
				"ለእነዚህ" 	;

	 mkAdjya : Str -> Adjective = 
                 
                 \ya ->            
			
   		 mkAdjective    (ya+"ኛው")
				(ya+"ኛው"+"ን")
				"የዛኛው"
				"ለዛኛው"
				ya
				(ya+"ን")
				"የዛ"
				"ለዛ"
				"እነዚያኞቹ"
				"እነዚያኞቹን"
				"የእነዚያኞቹ"
				"ለእነዚያኞቹ"
				"እነዚያ"
				"እነዚያን"
				"የእነዚያ"
				"ለእነዚያ" 
				(ya+"ች"+"ኛዋ")
				(ya+"ች"+"ኛዋ"+"ን")
				"የዛችኛዋ"
				"ለዛችኛዋ"
				(ya+"ች")
				(ya+"ችን")
				"የዛች"
				"ለዛች"
				"እነዚያኞቹ"
				"እነዚያኞቹን"
				"የእነዚያኞቹ"
				"ለእነዚያኞቹ"
				"እነዚያ"
				"እነዚያን"
				"የእነዚያ"
				"ለእነዚያ" ;



   mkDet : Adjective -> Number -> Species -> Det 
      = \word,num,species -> 
      { s = \\g,c => word.s ! g ! num ! species ! c;
        d = species;  --
	n = num;
        isNum = False;
        isPron = False
      };

   
   mkQuant : Adjective ->Species -> Quant =
    \word,species ->

    { s = \\n,g,c =>word.s! g ! n ! species ! c ;
      d = species;
      isPron = False;
      isNum = False;
    
    };
  




pronNP : (N,A,G,D : Str) -> PerNumGen -> NP = \N,A,G,D,png-> {
		    s = table {
		      Nom => N ;
		      Acc => A ;
		      Gen => G ;
		      Dat => D 
		      } ;
		    a = {png = png ; isPron = True} 
		    } ;

		
		 -- Adverbs

 	 
		-- (head (qey)+head(tail(qey))+"አ"+tail(qey)) --- why couldn't this be working while head and tail are still in the prelude libray.

		
----------------------
-- Verb

		 getRoot4 : Str -> Root4 = \s -> case s of {
		    C1@? + C2@? + C3@?+C4 => {C1 = C1 ; C2 = C2 ; C3 = C3;C4 = C4} ;
		    _ => Predef.error ("cannot get root from" ++ s)
		    } ;

		 appPattern4 : Root4 -> Pattern4 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3C4+ r.C4 + p.C4 ;                  	 
		
		 getRoot3 : Str -> Root3 = \s -> case s of {
		    C1@? + C2@? + C3 => {C1 = C1 ; C2 = C2 ; C3 = C3} ;
		    _ => Predef.error ("cannot get root from" ++ s)
		    } ; 

		 appPattern3 : Root3 -> Pattern3 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;
		
		 appPattern3PasPer : Root3 -> Pattern3 -> Str = \r,p ->
		    "t'" + r.C1 + "!" + r.C2 + "'" + r.C3 + p.C3 ;

		appPattern3PasImp : Root3 -> Pattern3 -> Str = \r,p ->
		    p.C1 + r.C1 + "!" + r.C2 + "'" + r.C3 + p.C3 ;
       
                 getRoot2 : Str -> Root2 = \s -> case s of {
		    C1@? + C2 => {C1 = C1 ; C2 = C2} ;
		    _ => Predef.error ("cannot get root from" ++ s)
		    } ; 

		 appPattern2 : Root2 -> Pattern2 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2;


		--remove the first letter
 			appPatternRemove : Root3 -> Pattern3 -> Str = \r,p ->
    			p.C1 +"ä"+ p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;
		--palatalization

  		 appPattern2pal : Root2 -> Pattern2 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + pallatalize (r.C2) + p.C2;
		 appPattern3pal : Root3 -> Pattern3 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + pallatalize (r.C3) + p.C3 ;
 		 appPattern4pal : Root4 -> Pattern4 -> Str = \r,p ->
		    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3C4+ pallatalize (r.C4) + p.C4 ;


		suffixDef : PerNumGen => Str = 
	    table {
	      Per1 Sg      => "t" ;
	      Per1 Pl      => "'w";
	      Per2 Sg Masc => "w";
	      Per2 Sg Fem  => "w";
	      Per2 Pl _    => "t" ;
	      Per3 Sg Masc => "w";
	      Per3 Sg Fem  => "w";
	      Per3 Pl _    => "t"
	    } ;


		suffixObjPres : Str-> (PerNumGen => Str) = \str->
	    table {
	      Per1 Sg      => str++"N" ;
	      Per1 Pl      => str++"n";
	      Per2 Sg Masc => str++"k";
	      Per2 Sg Fem  => str++"x";
	      Per2 Pl _    => str++"Ach&" ;
	      Per3 Sg Masc => str++"w";
	      Per3 Sg Fem  => str++"!t";
	      Per3 Pl _    => str++"Ac'w"
	    } ;

			suffixObjPast : Str-> (PerNumGen => Str) = \str->
	    table {
	      Per1 Sg      => str++"&+"++"N" ; -- test:
	      Per1 Pl      => str++"&+"++"n";
	      Per2 Sg Masc => str++"&+"++"k";
	      Per2 Sg Fem  => str++"&+"++"x";
	      Per2 Pl _    => str++"&+"++"Ach&" ;
	      Per3 Sg Masc => str++"&+"++"w";
	      Per3 Sg Fem  => str++"&+"++"!t";
	      Per3 Pl _    => str++"&+"++"Ac'w"
	    } ;

		suffixPos : PerNumGen => Str = 
	    table {
	      Per1 Sg      => "y7" ;
	      Per1 Pl      => "Acn";
	      Per2 Sg Masc => "h";
	      Per2 Sg Fem  => "x";
	      Per2 Pl _ => "Ach&" ;
	      Per3 Sg Masc => "&";
	      Per3 Sg Fem  => "w!";
	      Per3 Pl _=> "Ac!w"
	    } ;

		reflPron : PerNumGen => Str =
          table
            {

    	      Per1 Sg      => "ራሴ" ;
	      Per1 Pl      => "ራሳችን";
	      Per2 Sg Masc => "ራስህ";
	      Per2 Sg Fem  => "ራስሽ";
	      Per2 Pl _    => "ራሳችሁ" ;
	      Per3 Sg Masc => "ራሱ";
	      Per3 Sg Fem  => "ራሷ";
	      Per3 Pl _    => "ራሳቸው"
            } ;


 predV :Verb -> VP = \v ->

	{
		
	s = \\t,p,png =>

		 let

			ketebku		 =    v.s ! Perf !Act! png ; --
			eketbalehu       =    v.s ! Imperf !Act! png ;--
			keteb		 =    v.s ! Jus_Imperat !Act! png ; -- imperative
			ketbie		 =    v.s ! Gerund !Act! png ; --
			mekteb		 =    v.s ! Infinitive !Act! png ; --
			ketabi		 =    v.s ! Parti !Act! png ; 
			ketbiealehu      =    v.s ! CompPerf !Act! png ; --
			eketib		 =    v.s ! Cont !Act! png ; --  just play with the actives for now

		in

		  case <t,p> of {


			
			<PresFut,Pos>  => eketbalehu ;
			<PresFut,Neg>  => "!" ++"&+"++ eketib ++"&+" ++"m" ;--   case for I is unique 											  but sticking to the 												general trend
			<PresPerf,Pos>  => ketbiealehu;
			<PresPerf,Neg>  => "!l"++"&+"++ketebku++"&+"++"m";
			<PresCont,Pos>   => "(y'"++ "&+"++ketebku ++"n'w" ;
			<PresCont,Neg>   => "(y'"++ "&+"++ketebku ++"Ayd'l'm" ;			
			<SimplePast,Pos> => ketebku;
			<SimplePast,Neg> => "!l"++"&+"++ketebku++"&+"++"m";			
			<PastPerf,Pos>  => ketbie ++ "n'b'r";
			<PastPerf,Neg>  => "!l"++"&+"++ketebku++"&+"++"m"++"n'b'r"; 
			<PastCont,Pos>   => "(y'"++ "&+"++ketebku ++ "n'b'r" ;
			<PastCont,Neg>   => "(y'"++ "&+"++ketebku ++ "Aln'b'r'm"
                     

			      };

			obj = {
				s = [] ; 
				a = {png = Per3 Sg Masc  ; isPron = False} 
			}; 
			s2 = [];
			imp  = v.s ! Jus_Imperat!Act !Per2 Sg Masc ;
			inf  = v.s ! Infinitive ! Act ! Per3 Sg Masc ;-- or any
			pred = { s = \\_,_ => []};
			isPred = False


		};

  predVc : V2 -> VPSlash = \v2 -> 
       	   predV v2 ** {c2 = v2.c2} ;

     insertObj : NP -> VP -> VP = \np,vp ->
      { s = vp.s;
        obj = {s = np.s ! Acc ; a = np.a};   
        s2 = vp.s2;
        pred = vp.pred;
	inf = vp.inf;
	imp = vp.imp ; 
        isPred = vp.isPred
      };

	

   insertPred : {s : AmhAgr => Case => Str} -> VP -> VP = \p,vp ->
      { s = vp.s;
        obj = vp.obj;
        s2 = vp.s2;
	imp = vp.imp ;
	inf = vp.inf;
        pred = p;
        isPred = True
      };

    insertStr : Str -> VP -> VP = \str,vp ->
      { s = vp.s;
        obj = vp.obj;
        s2 = str;
	imp = vp.imp ;
	inf = vp.inf;
        pred = vp.pred;
        isPred = vp.isPred
      };

	
	

{-

  insertObjPre : (PerNumGen => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    obj = vp.s ! obj;
    pred = vp.pred;
    isPred = vp.isPred

		
    } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ;
    s2 = \\a => vp.s2 ! a ++ obj ! a
    } ;

  insertObjPre : (PerNumGen => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ;
    s2 = \\a => obj ! a ++ vp.s2 ! a 
    } ;


  insertObjc : (Agr => Str) -> SlashVP -> SlashVP = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;

-}


--  impVP : VP -> PerNumGen -> Str = \vp,a ->
  --            vp.imp ! a;


  mkV2  : Verb -> Prep -> V2 = \ v, p ->                  
	lin V2 (v ** {c2 = p ; lock_V2 = <>}) ;
 
  mkV3     : Verb -> Prep -> Prep -> V3 = \ v, p ,q  ->  
	lin V3 (v ** {c2 = p ; c3 = q ; lock_V3 = <>} );

------
-- For Sentence

-- Transformations between parameter types



  png2gn : PerNumGen -> {g : Gender; n : Number} = \png ->
      case png of {
        Per3  nm gn => {g = gn; n = nm};
        Per2  nm gn => {g = gn; n = nm};
        _ 	    => {g = Masc; n = Sg} --randomly
      };




     toAgr : Number -> Person -> Gender -> PerNumGen = \n,p,g -> 
      case p of {
        P1 => Per1 n ;
        P2 =>case n of {
          Sg => Per2 Sg g ;
          Pl => Per2 Pl g
          };
        P3 => case n of {
          Sg => Per3 Sg g ;
          Pl => Per3 Pl g 
          }
        } ;

    fromAgr : PerNumGen -> {n : Number ; p : Person ; g : Gender} = \png -> case png of {
      Per1 n    => {n = n ; p = P1 ; g = Masc} ; -- random (Ramona)
      Per2 Pl g   => {n = Pl ; p = P2 ; g = Masc} ;
      Per2 Sg g => {n = Sg ; p = P2 ; g = g} ;
      Per3 Sg g => {n = Sg ; p = P3 ; g = g} ;
      Per3 Pl g   => {n = Pl ; p = P3 ; g = Masc}
      } ;

    agrP3 : Number -> PerNumGen = \n -> agrgP3 n Masc ;

    agrgP3 : Number -> Gender -> PerNumGen = \n,g -> toAgr n P3 g ;

    conjAgr : PerNumGen -> PerNumGen -> PerNumGen = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
        (conjPerson a.p b.p) a.g ;



{-
  infVP : Bool -> VP -> Agr -> Str = \isAux,vp,a ->
    vp.ad ++ vp.inf ++ vp.s2 ! a  
    ;-}







  mkClause : Str -> PerNumGen -> VP -> Cl =
    \subj,png,vp -> {
      s = \\t,b => 
        let 
          verb  = vp.s ! t !b ! png ;
          obj = vp.obj.s;
          gn = png2gn png ;
	  pred = vp.pred.s ! gn ! Nom     -- Totawa / muzun / lita belach
          
        in
	       subj ++ obj ++ pred ++ verb ;
             --  subj ++ obj ++ pred ++ suffixObjPast(verb) !vp.obj.a.png ;
   
    } ;


  regNP : Str -> Number -> NP = \word,n ->
    {     
      s = \\c =>case c of
		{
		Gen|Dat => affix!c + word;
		   _    => word + affix!c 
		};
      a = {png = Per3 n Masc ; isPron = False };
      lock_NP = <>
    };


  mkDeterminer : Number -> Str -> {s : Case => Str; n : Number} = \n,s ->
    {
     s = affix2 s ;
     n = n
      } ;


--------
					     -- speak, 									with, about
  {-dirV3    : Verb -> Prep -> V3 = \ v,p -> 
	mkV3 v [] p.s ;				               -- give,_,to
  dirdirV3 : Verb -> V3 = \ v ->
	dirV3 v [] ;			                       -- give,_,_
  mkV0  : Verb -> V0 = \ v ->
	v ** {lock_V = <>} ;
  mkVS  : Verb -> VS = \ v ->
	v ** {lock_VS = <>} ;
  mkV2S : Verb -> Str -> V2S = \ v,p ->
	mkV2 v p ** {lock_V2S = <>} ;
  --mkV2V : V -> Str -> Str -> V2V = \ v,p,t -> 
	--mkV2 v p ** {s4 = t ; lock_V2V = <>} ;
  mkVA  : Verb -> VA = \ v ->
	v ** {lock_VA = <>} ;
  mkV2A : Verb -> Str -> V2A = \ v,p ->
	mkV2 v p ** {lock_V2A = <>} ;
  mkVQ  : Verb -> VQ = \ v ->
	v ** {lock_VQ = <>} ; 
  mkV2Q : Verb -> Str -> V2Q = \ v,p -> 
	mkV2 v p ** {lock_V2Q = <>} ;
-}

--PerNumGen =  Per1 Number| Per2 Number Gender |Per3 Number Gender ;


--- N U M E R A L S

   param  CardOrd = NCard | NOrd ;
  
   param DForm = unit | ten  ;

   oper affix2 : Str -> Case => Str = \str-> 
	
	table {
		
		Gen => "የ"  + str;
		Dat => "ለ"  + str;
                Acc => str + "ን" ;
		_   =>       str 
	  };
	
-- This is as well a proposed solution to solve the  confusion...
   oper affix3 : Str -> Species => Case => Str= \str-> 
	     table {


                     Def=> table 
                                { 

                                  Gen => "የ"  + regOrdMasc(str);
				  Dat => "ለ"  + regOrdMasc(str);
				  Acc => regOrdMasc(str) + "ን" ;
				  _   => regOrdMasc(str)
				};
         
                     Indef=> table 
                                { 
                                  Gen => "የ"  + str;
				  Dat => "ለ"  + str;
				  Acc => str + "ን" ;
				  _   =>       str

                                 }  
                                           
                   };   
 
   
--}

 adjaffix :  Str -> Gender=>Number=>Species=>Case=> Str= \str->  
     		table {

                    Masc => table { 
                                  Sg=> table 
                                            { 
                                             Def=> table 
                                                        { 
							Gen => "የ"  + regOrdMasc(str);
							Dat => "ለ"  + regOrdMasc(str);
							Acc => regOrdMasc(str)+ "ን" ;
							_   => regOrdMasc(str)
                                                        };   
                                             Indef=> table 
                                                        { 
							Gen => "የ"  + str;
							Dat => "ለ"  + str;
							Acc => str + "ን" ;
							_   =>       str 
                                                         }  
                                            };   
                                  Pl=> table 
                                            { 
                                              Def=> table 
                                                        { 
							Gen => "የ"  + regordPlDef(str);
							Dat => "ለ"  + regordPlDef(str);
							Acc => regordPlDef(str)+ "ን" ;
							_   => regordPlDef(str)
                                                        };   
                                             Indef=> table 
                                                        { 
							Gen => "የ"  + regOrdPlIndef(str);
							Dat => "ለ"  + regOrdPlIndef(str); 
							Acc => regOrdPlIndef(str)+ "ን" ;
							_   =>   regOrdPlIndef(str)
                                                         }  
                                            } 
                                } ;   
  
                  Fem  => table { 
                                   Sg=> table 
                                            { 
                                             Def=> table 
                                                        { 
							Gen => "የ"  + regOrdFem(str);
							Dat => "ለ"  + regOrdFem(str);
							Acc => regOrdFem(str)+ "ን" ;
							_   => regOrdFem(str)
                                                        };   
                                             Indef=> table 
                                                        { 
							Gen => "የ"  + str;
							Dat => "ለ"  + str;
							Acc => str + "ን" ;
							_   =>       str
                                                         }  
                                            };   
                                  Pl=> table 
                                            { 
                                              Def=> table 
                                                        { 
							Gen => "የ"  + regordPlDef(str);
							Dat => "ለ"  + regordPlDef(str);
							Acc => regordPlDef(str)+ "ን" ;
							_   => regordPlDef(str)
                                                        };   
                                             Indef=> table 
                                                        { 
							Gen => "የ"  + regOrdPlIndef(str);
							Dat => "ለ"  + regOrdPlIndef(str); 
							Acc => regOrdPlIndef(str)+ "ን" ;
							_   =>   regOrdPlIndef(str)
                                                         }  
                                            } 
                                } 
              		 
           		};
        


 
   oper regOrdMasc :  Str -> Str = \str -> 
		case last str of
          {   
		"ድ" => init str + "ዱ" ;
     		"ት" => init str + "ቱ" ;
     		"ኝ" => init str + "ኙ" ;
      		"ር" => init str + "ሩ" ;
 		_ => str+"ዉ"
           } ;

   oper regOrdFem : Str -> Str = \ str ->
           		case last str of
          {   
		"ድ" => init str + "ዷ" ;
     		"ት" => init str + "ቷ" ;
     		"ኝ" => init str + "ኟ" ;
      		"ር" => init str + "ሯ" ;
 		_ => str+"ዋ"
           } ;

 oper regOrdPlIndef : Str -> Str = \ str ->
           		case last str of
          {   
		"ድ" => init str + "ደኞች" ;
     		"ት" => init str + "ተኞች" ;
     		"ኝ" => init str + "ነኞች" ;
      		"ር" => init str + "ሮች" ;
 		_ => str+"ዎች"
           } ;

 oper regordPlDef : Str -> Str =\ str ->

		case last str of 
{
		"ድ" => init str + "ደኞቹ" ;
     		"ት" => init str + "ተኞቹ" ;
     		"ኝ" => init str + "ነኞቹ" ;
      		"ር" => init str + "ሮቹ" ;
 		_ => str+"ዎቹ"

};




   oper regOrd : Str -> Str = \ten -> 
     case last ten of {
      		"ድ" => init ten + "ደኛ" ;
     		"ት" => init ten + "ተኛ" ;
     		"ኝ" => init ten + "ነኛ" ;
      		"ር" => init ten + "ረኛ" ;
   	       	 _ => ten + "ኛ"
      } ;

  oper regCardOrd : Str -> {s :CardOrd =>Gender=>Number=>Species=>Case=> Str} = \ten ->
    {s = table {
                NCard => adjaffix ten ; 
		NOrd =>  adjaffix (regOrd ten)
               } 
    } ;
  

  oper mkCard : CardOrd -> Str ->Gender=>Number=>Species=>Case=> Str = \o,ten -> 
    (regCardOrd ten).s ! o ; 



  oper mkNum : Str -> Str -> Str -> {s : DForm => CardOrd =>Gender=>Number=>Species=>Case=> Str} = 
    \hulet,haya, huleteNa ->
    {s = table {
      		 unit => 
			table {	
				NCard => adjaffix hulet ; 
				NOrd =>  adjaffix huleteNa
			      } ;
    
                  		       			
		ten  => \\c => mkCard c haya
       }
    } ;

	

 oper mkQuestion :  {s : Str} -> Cl ->  {s : TenseAmh => Polarity  => Str} = \wh,cl ->
     	{ 
		s = \\t,p =>  wh.s ++ cl.s ! t ! p 
	};

	
}
