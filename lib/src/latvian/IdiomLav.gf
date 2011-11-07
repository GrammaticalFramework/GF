concrete IdiomLav of Idiom = CatLav ** open Prelude, ResLav, VerbLav, ParadigmsVerbsLav in {
flags optimize=all_subs ;

  lin
	ImpersCl vp = let
	  a = AgP3 Sg Masc
	in{
      s = \\mood,pol =>
		buildVerb vp.v mood pol a ++ -- Verb
        vp.s2 ! a					-- Object(s), complements, adverbial modifiers; 
    } ;  
  
	GenericCl vp = let
	  a = AgP3 Sg Masc
	in{
      s = \\mood,pol =>
		buildVerb vp.v mood pol a ++ -- Verb
        vp.s2 ! a					-- Object(s), complements, adverbial modifiers; 
    } ;  
	
	ExistNP np = let
	  v = lin V mkVerb_toBe;
	  a = np.a
	in {
      s = \\mood,pol =>
		buildVerb v mood pol a ++ -- Verb
        np.s ! Nom				  
    } ;  
	
	ExistIP ip = let
	  v = lin V mkVerb_toBe;
	  a = AgP3 ip.n Masc
	in {
      s = \\mood,pol =>
	    ip.s ! Nom ++
		buildVerb v mood pol a -- Verb          
    } ;  
	
	ProgrVP v = v; -- FIXME - needs restriction so that only VerbMood Indicative _ _ Present is allowed; but can't do that on VP level..
	
	ImpPl1 vp = let
	  a = AgP1 Pl
	in {
      s = 
	    vp.v.s ! Pos ! (Indicative P1 Pl Pres) ++ -- Verb
        vp.s2 ! a		         		  -- Object(s), complements, adverbial modifiers; 
    } | {
      s = 
	    vp.v.s ! Pos ! (Indicative P1 Pl Fut) ++ -- Verb
        vp.s2 ! a		         		  -- Object(s), complements, adverbial modifiers; 
	};  
	
	ImpP3 np vp = {
      s = "lai" ++ np.s ! Nom ++ buildVerb vp.v (Ind Simul Pres) Pos np.a ++ vp.s2 ! np.a;
    };  
	
	--FIXME placeholder
	CleftNP np rs = { s = \\_,_ => NON_EXISTENT } ;
	CleftAdv ad s = { s = \\_,_ => NON_EXISTENT } ;
{-  
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
	
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => rs.s ! np.a)
        (insertObj (\\_ => np.s ! rs.c) (predAux auxBe))) ;

    CleftAdv ad s = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => conjThat ++ s.s)
        (insertObj (\\_ => ad.s) (predAux auxBe))) ;

    ExistNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;

    ExistIP ip = 
      mkQuestion (ss (ip.s ! Nom)) 
        (mkClause "there" (agrP3 ip.n) (predAux auxBe)) ;

    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;

    ImpPl1 vp = {s = "let's" ++ infVP True vp (AgP1 Pl)} ;

    ImpP3 np vp = {s = "let" ++ np.s ! Acc ++ infVP True vp np.a} ;
-}
}

