--# -path=.:../Romance:../common:../abstract:../common:prelude

concrete NounAmh of Noun = CatAmh ** open ResAmh,ParamX, Prelude in {

flags optimize=noexpand ; 
flags coding = utf8;


lin

	DetCN det cn = 
          
	{
	s = \\ c => case c of 
		{
	   Acc =>	det.s ! cn.g ! Nom ++ cn.s ! det.n! det.d ! c ; 
	   _   =>	det.s ! cn.g ! c ++ cn.s ! det.n! det.d ! Nom
		};
	a = {png = Per3 det.n cn.g; isPron = False} 
         
	};  

	--
	UsePN pn = { 
	s = pn.s; 
	a = {png=Per3 Sg pn.g; isPron = False} 
        
	};
	--  
	UsePron p = p ;

	--  
	PredetNP pred np = {
	s = \\c => case pred.isDecl of {
	True => pred.s! c ++ np.s ! Nom ; -- amzaNaw temari, yeabzaNaw temari , lebzaNaw temari
	False => np.s ! c ++ pred.s!c
	};
	a = np.a
	} ;

-- FIX NEEDED! consider the case for number and gender later !!! --- arabic book table --- to solve affices

--Compound Participle : is formed  by prefixing the relative pronoun yete : to the forms of the 				perfect mood -- there are three ways of building the participle in Amh

	PPartNP np v2 = 
	     

	{
	s = \\c =>  "y'"++ (v2.s ! Perf!Pas! np.a.png) ++ np.s ! c;

	a = np.a   
	} ;


        DetNP det = {
    
        s = \\_ => det.s!Masc!Nom;
        a =  { png = Per3 det.n Masc ; isPron = False}

        };


	AdvNP np adv = {
	s = \\c => np.s ! c ++ adv.s;
	a = np.a
	};

	DetQuantOrd quant num ord = {

	  s = \\g,c=> quant.s!num.n!g!c ++ num.s!quant.d!Nom ++ ord.s!g!num.n!quant.d!Nom;
	  d = Indef;
	  n = num.n;
	  isNum = True;
	  isPron = quant.isPron

	} ;

	DetQuant quant num = {

	s = \\g,c =>quant.s!num.n!g!c ++ num.s!quant.d!c ;
	d = quant.d;
	n = num.n;
	isNum = True;
	isPron = quant.isPron

	} ;

	PossPron p = {
	s = \\_,_,_ => p.s ! Gen; 
	d = Indef;
	isNum = False;
	isPron = True } ;
        
	NumCard n = {s = \\s,c => n.s!Masc!Sg!s!c ; n = Pl; hasCard = True} ;

	NumDigits n = {s = n.s ! NCard } ;
	
	NumNumeral numeral = {s = numeral.s ! NCard} ;

	OrdDigits n = {s = n.s ! NOrd} ;


	OrdNumeral numeral = {s = numeral.s ! NOrd} ;
     

        NumSg = {s = \\s,c => []; n = Sg ; hasCard = False} ;
   
        NumPl = {s = \\s,c => []; n = Pl ; hasCard = False} ;


	--  AdNum adn num = {
	--    s = \\g,d,c => adn.s ++ num.s ! g ! d ! c ;
	--    n = num.n } ;
	--  

	 OrdSuperl a = {
			s = \\g,n,s,c =>  a.s!g!n!s!c ;
		
			};


 
	DefArt = {
	s = \\_,_,_ => []; 
	d = Def ;
	isNum,isPron = False
	} ;



	IndefArt = {
	s = \\n,g,_ => case <n,g> of {
        <Sg,Masc> =>"አንድ" ++ [];
	<Sg,Fem>  =>"አንዲት" ++ [];
        <Pl,_> => [] };
 	d = Indef ;
	isNum,isPron = False
	} ;


	MassNP cn = 
	{s = \\_=> cn.s ! Sg ! Indef!Nom ;
 
	a =  { png = Per3 Sg cn.g; isPron = False } };  


	UseN n = n ; 

	--UseN n = n ** {adj = \\_,_,_ => []};


	ComplN2 f x = {s = \\n,s,c => f.c2++ x.s ! c ++ f.s ! n !Indef! Nom ; 
		   g = f.g } ;

	ComplN3 f x = {s = \\n,s,c =>  f.c2 ++ x.s ! c ++ f.s ! n !Indef! Nom ;g = f.g; c2 = f.c3} ; 

--<Sg> => f.c2 ++ x.s ! c++"ያለው" ++ f.s ! n !Indef! Nom ;
--<Pl> => f.c2 ++ x.s ! c ++"ያሉት"++ f.s ! n !Indef! Nom  };
--                       g = f.g; c2 = f.c3;

        UseN2 n = n ;

        UseN3 n = n ;

  	Use2N3 f = {
		      s = \\n,s,c => f.s ! n !Indef! Nom ;
		      g = f.g ;
		      c2 = f.c2
		   } ;

   	Use3N3 f = {
		      s = \\n,s,c => f.s ! n !Indef! Nom ;
		      g = f.g ;
		      c2 = f.c3
		   } ;
        --TO DO!!
	AdjCN ap cn = {
	s = \\n,s,c => 
		case c of
		{
		Acc => ap.s ! cn.g !n ! s !Nom++ cn.s ! n! Indef ! c  ;
		_   => ap.s ! cn.g !n ! s !c  ++ cn.s ! n! Indef ! Nom
		};

	g = cn.g
	} ;


	--  --    RelCN cn rs = {s = \\n,c => cn.s ! n ! c ++ rs.s ! {n = n ; p = P3}} ;

	AdvCN cn ad = {s = \\n,s,c => ad.s ++ cn.s ! n ! Indef ! c ;
                       g = cn.g} ;
	--  --
	--  --    SentCN cn sc = {s = \\n,c => cn.s ! n ! c ++ sc.s} ;


	ApposCN cn np = {s = \\n,s,c => cn.s ! n !Indef! Nom ++ np.s ! c ; 
                         g = cn.g} ;


	} 
