--# -path=.:../abstract:../common:../prelude

--1 Interlingua auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResIna = ParamX ** open Prelude in {

  flags optimize=all ;


	-- Some parameters, such as $Number$, are inherited from $ParamX$.

	--2 For $Noun$

	-- This is the worst-case $Case$ needed for pronouns.

  param
    Case = Nom | Acc | Gen | Dat | Abl ; 
    -- Why do we need so many cases?
    -- Interlingua has (optional) contractions: 
    -- "a le" ->  "al"
    -- "de le" -> "del" 
    -- so, we can't get away with mere prepositions "a" and "de"
    -- but use Dative and Ablative to represent those.
    -- Pronouns have different forms in Nominative and Accusative.
    -- Genitive is used for possesives (which can also be pronominalized)

  oper
    casePrep : Str -> Case -> Str = \prep,cas -> case cas of {
      Dat => "a";
      Gen | Abl => "de";
      _ => prep
      };


    --2 For $Verb$

    -- These 7 forms are more than we need. (esser is irregular
    -- only in pres, past, fut, cond so we could do with 5, but it makes
    -- easy to reason about what happens.)

  param
    VForm
      = VInf
      | VPres
      | VPPart
      | VPresPart
      | VPast      --# notpresent
      | VFut       --# notpresent
      | VCond      --# notpresent
      ;

  param
    VVariant
      = VMono   -- "creava"
      | VSplit  -- "ha create"  -- !!! This is not implemented. One reason is that the split forms overlap with aux verb + participle as ajective. (Anterior form)
      ;
    
    -- The order of sentence is needed already in $VP$.
    Order = ODir | OQuest ;

    --2 For $Adjective$

    AForm = AAdj Degree | AAdv ;

    --2 For $Relative$

    --    RAgr = RNoAg | RAg {n : Number ; p : Person} ;
    --    RCase = RPrep | RC Case ;

    --2 For $Numeral$

    CardOrd = NCard | NOrd ;
    DForm = unit | ten  ;

    --2 Transformations between parameter types

  oper
    Agr = {n : Number ; p : Person} ;
    -- This is the agreement record for verb phrases, which is needed only for reflexive verbs.

    agrP3 : Number -> Agr = \n -> 
      {n = n ; p = P3} ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      n = conjNumber a.n b.n ;
      p = conjPerson a.p b.p
      } ;
    
    
    -- For each lexical category, here are the worst-case constructors.
    mkAdjective : (_,_,_ : Str) -> {s : AForm => Str} = 
      \bon,melior,optime -> 
      let mente = case last bon of
	    {"c" => "amente";
	     _  =>  "mente"
	    }
      in {
	s = table {
          AAdj Posit  => bon ;
          AAdj Compar => melior ; 
          AAdj Superl => optime ;
          AAdv        => bon + mente
          }
      } ;


    mkVerb : Str -> Verb = \crear->
      let crea = init crear
      in {isRefl = False;
	  s = table {
    	    VInf    => crear;
	    VPres   => crea;
	    VPast   => crea + "va"; 
	    VFut    => crear + "a"; 
	    VCond   => crear + "ea";
 	    VPPart  => case crear of {
 	      rid + "er" => rid + "ite";
 	      _         => crea + "te" 
 	      };
 	    VPresPart => case crear of {
 	      aud + "ir" => aud + "iente";
 	      _         => crea  + "nte"
 	      }}};

    -- + The 3 (optionally) irregular verbs. (we only need haberV in this module)
    esserV : Bool => Verb = \\use_irreg =>
      let reg = mkVerb "esser" 
      in {isRefl = False;
          s = case use_irreg of {
                True  => table {
	                   VPres => "es";
	                   VFut  => "sera";
	                   VCond => "serea";
	                   VPast => "era";
	                   form  => reg.s!form
	                 };
	        False => reg.s
	      }
	 };

    haberV : Bool => Verb = \\use_irreg =>
      let reg = mkVerb "haber" 
      in {isRefl = False;
          s = case use_irreg of {
	        True  => table {
		           VPres => "ha";
		           form  => reg.s!form
		         };
                False => reg.s
	      }
	 };

    vaderV : Bool => Verb = \\use_irreg =>
      let reg = mkVerb "vader" 
      in {isRefl = False;
          s = case use_irreg of {
	        True  => table {
	                   VPres => "va";
	                   form  => reg.s!form
	                 };

                False => reg.s
	      }
	 };


    mkIP : Str -> Number -> {s : Case => Str ; n : Number} = \qui,n -> {s = \\c=>casePrep [] c ++ qui; n = n};

    mkPron : (io,me,mi : Str) -> Agr -> NP  ** {possForm : Str} =
      \io,me,mi,a -> 
      let mie = case last mi of {
	    "e" => mi;
	    _ => mi + "e"
	    } in
      {	
	a = a;
	s = table {
	  Nom => io ;
	  Gen => mie ;
	  _   => me
	  } ;
	possForm = mi;
	isPronoun = True
      } ;

    
    Sp1 : Agr = {n = Sg ; p = P1};
    Sp2 : Agr = {n = Sg ; p = P2};
    Sp3 : Agr = {n = Sg ; p = P3};
    Pp1 : Agr = {n = Pl ; p = P1};
    Pp2 : Agr = {n = Pl ; p = P2};
    Pp3 : Agr = {n = Pl ; p = P3};
    
    -- make an invariant NP (not inflected)
    mkInvarNP : Str -> NP = \str -> {a = Sp3; isPronoun = False; s = \\_=> str};

    regNP : Str -> NP = mkInvarNP;

    artIndef = "un";
    artDef = "le" ;

    -- For $Verb$.
    Verb : Type = {
      s : VForm => Str ;
      isRefl : Bool
      } ;

    -- Dependency on Agr is there only because of reflexive pronouns!
    VP : Type = {
      s : Anteriority => Tense => Bool => {fin, inf : Str} ;
      rest : Agr => Str;          -- comes after the infinite part
      clitics : Agr => Str;       -- can be placed just before the finite or right after the infinite
      prp : Str ;          -- present participle (unused at the moment ???)
      inf : Str ;          -- the infinitive form ; VerbForms would be the logical place
      } ;
    NP : Type = {
      isPronoun : Bool;
      s : Case => Str;
      a : Agr;
      };
    -- Noun phrase that can be declined in person and number. (for reflexive pronouns)
    NP' : Type = {
      isPronoun : Bool;
      s : Agr => Case => Str;
      };

    predV_ : (Bool => Verb) -> VP = \verb -> {
      clitics = \\_ => [];
      rest = \\_ => [];
      s = table
	{Simul => \\t,use_irreg => {fin = (verb!use_irreg).s   ! (tenseToVFrom!t); inf = []};
	 Anter => \\t,use_irreg => {fin = (haberV!use_irreg).s ! (tenseToVFrom!t); inf = (verb!use_irreg).s!VPPart}
	};
      prp = (verb!False).s ! VPresPart;
      inf = (verb!False).s ! VInf;
      };

    predV : Verb -> VP = \verb -> predV_ (\\_ => verb) ;

    tenseToVFrom = table {
      Pres => VPres
      ;Past => VPast; --# notpresent
      Fut => VFut; --# notpresent
      Cond => VCond --# notpresent
      };

    insertInvarObj : Str -> VP -> VP = \obj -> insertObj "" Acc (mkInvarNP obj);

    insertObj : Str -> Case -> NP -> VP -> VP 
      = \prep,c,obj,vp -> insertReflObj prep c {isPronoun = obj.isPronoun; s = \\agr => obj.s} vp;

    insertReflObj : Str -> Case -> NP' -> VP -> VP = \prep,c,obj,vp -> case obj.isPronoun of
      {
	-- !!!  if the preposition is not empty, or
	--      if the case is not [Dat, Acc]
	--      then the pronoun cannot be inserted as a clitic.
	True => {
	  inf = vp.inf;
	  prp = vp.prp;
	  s = vp.s;
	  clitics = \\agr => obj.s!agr!c ++ vp.clitics!agr; -- clitics are inserted in reverse order.
	  rest = vp.rest};
	False => {
	  inf = vp.inf;
	  prp = vp.prp;
	  s = vp.s;
	  clitics = vp.clitics;
	  rest = \\agr => vp.rest!agr ++ prep ++ obj.s!agr!c;
	  } };

    infVP : VP -> Str = \vp -> variants { 
      vp.clitics ! Sp3 ++ vp.inf ++ vp.rest ! Sp3 ;
      vp.inf ++ vp.clitics  ! Sp3 ++ vp.rest ! Sp3 ;
      };

    posneg : Polarity -> Str = \b -> case b of {
      Pos => [] ;
      Neg => "non"
      } ;

    
    reflPron : Agr => Str = table {
      {n = Sg ; p = P1} => "me" ;
      {n = Sg ; p = P2} => "te" ;
      {n = Sg ; p = P3} => "se" ;
      {n = Pl ; p = P1} => "nos" ;
      {n = Pl ; p = P2} => "vos" ;
      {n = Pl ; p = P3} => "se"
      } ;

  ---- For $Sentence$.
    --
    Clause = {s : Bool => Tense => Anteriority => Polarity => Order => Str} ;
    
    mkClause : Str -> Agr -> VP -> Clause =
      \subj,agr,vp -> 
      {
	s = \\use_irreg,t,anter,b =>
	        let v = vp.s!anter!t!use_irreg
	        in case use_irreg of {
	             True  => table {
	                        ODir   => subj ++ posneg b ++ v.fin ++ v.inf ++ vp.clitics!agr ++ vp.rest!agr;
	                        OQuest => posneg b ++ v.fin ++ subj ++ v.inf ++ vp.clitics!agr ++ vp.rest!agr
                              } ;
                     False => table {
	                        ODir   => subj ++ posneg b ++ vp.clitics!agr ++ v.fin ++ v.inf ++ vp.rest!agr;
	                        OQuest => posneg b ++ vp.clitics!agr ++ v.fin ++ subj ++ v.inf ++ vp.rest!agr
	                      }
                   }
      };


    mkQuestion : 
      {s : Str} -> Clause -> Clause = \qu,cl ->
      {s=\\use_irreg,t,a,p,o => qu.s ++ cl.s ! use_irreg ! t ! a ! p ! o};
    


    -- For $Numeral$.

  oper mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
	 \duo,vinti,secunde,vintesime-> 
	 {s = table { unit => table { 
			NCard => duo ; 
			NOrd => secunde};
		      ten => table {
			NCard => vinti;
			NOrd => vintesime}}} ;
       
  oper regNum : Str -> Str -> {s : DForm => CardOrd => Str} = 
	 \cinque,quinte -> 
	 let cinqu : Str = case cinque of {
	       nov   + "em"=> nov;
	       cinq_ + "e" => cinq_;
	       cinq_ + "o" => cinq_;
	       sex         => sex}
	 in mkNum cinque quinte (cinqu + "anta") (cinqu + "esime");
       
       regOrd : Str -> Str = \cent -> case cent of {
	 mill + "e" => mill + "esime";
	 _  => cent + "esime"};
       
       regCardOrd : Str -> {s : CardOrd => Str} = \ten ->
	 {s = table {NCard => ten ; NOrd => regOrd ten}} ;

       mkCard : CardOrd -> Str -> Str = \c,ten -> 
	 (regCardOrd ten).s ! c ; 

}
