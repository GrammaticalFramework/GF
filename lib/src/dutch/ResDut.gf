--# -path=.:../abstract:../common

--1 Dutch auxiliary operations.
--
-- (c) 2009 Femke Johansson and Aarne Ranta

resource ResDut = ParamX ** open Prelude, Predef in {

  flags optimize=all ;
    coding=utf8 ;

--2 For $Noun$

  param
    Case = Nom | Gen ;
    Gender = Utr | Neutr ;

    NForm = NF Number Case ;

    NPCase = NPNom | NPAcc ;

  oper 
    Noun = {s : NForm => Str ; g : Gender} ;

    mkNoun : (_,_ : Str) -> Gender -> Noun = \sg,pl,g -> {
      s = table {
        NF Sg Nom => sg ;
        NF Sg Gen => add_s sg ; 
        NF Pl Nom => pl ;
        NF Pl Gen => add_s pl
        } ;
     g = g
     } ;

    regNoun : Str -> Noun = \s -> case s of {
      _ + ("a" | "o" | "y" | "u" | "oe" | "é") => mkNoun s (s + "'s") Utr ;
      _ + ("oir" | "ion" | "je") => mkNoun s (s + "s") Neutr ;
      ? + ? + ? + _ + 
        ("el" | "em" | "en" | "er" | "erd" | "aar" | "aard" | "ie") => -- unstressed
                                            mkNoun s (s + "s") Utr ;
      _ +                     ("i"|"u")  => mkNoun s (endCons s + "en") Utr ;
      b + v@("aa"|"ee"|"oo"|"uu") + c@?  => mkNoun s (b + shortVoc v c + "en") Utr ; 
      b + ("ei"|"eu"|"oe"|"ou"|"ie"|"ij"|"ui") + ? => mkNoun s (endCons s + "en") Utr ;
      _ + "ie" => mkNoun s (s + "ën") Utr ;
      b + v@("a"|"e"|"i"|"o"|"u" ) + c@? => mkNoun s (b + v + c + c + "en") Utr ;
      _ => mkNoun s (endCons s + "en") Utr
      } ;

    regNounG : Str -> Gender -> Noun = \s,g -> {
      s = (regNoun s).s ;
      g = g
      } ;

    shortVoc : Str -> Str -> Str = \v,s -> init v + endCons s ;

    endCons : Str -> Str = \s -> case s of {
      _ + ("ts" |"rs" | "ls" | "ds" | "ns" | "ms") => s ;
      b + "s" => b + "z" ;
      b + "f" => b + "v" ;
      _ => s
      } ;

    dupCons : pattern Str = #("b"|"d"|"f"|"g"|"k"|"l"|"m"|"n"|"p"|"r"|"s"|"t") ;

    add_s : Str -> Str = \s -> case s of {
      _ + "s" => s ;
      _       => s + "s"
      } ; 

  param 
    AForm = APred | AAttr | AGen ;
    
  oper
    Adjective = {s : Degree => AForm => Str} ;

    mkAdjective : (_,_,_,_,_ : Str) -> Adjective = \ap,aa,ag,ac,as -> {
      s = table {
        Posit  => table {APred => ap ; AAttr => aa ; AGen => ag} ; 
        Compar => table {APred => ac ; AAttr => ac + "e" ; AGen => ac + "s"} ; ----
        Superl => table {APred => as ; AAttr => as + "e" ; AGen => as + "s"}   ----
        }
      } ;
      
    reg2Adjective : Str -> Str -> Adjective = \s,se -> 
      let
        ser : Str = case s of {
          _ + "r" => s + "der" ;
          _ => se + "r"
          } ;
        sst : Str = case s of {
          _ + "s" => s + "t" ;
          _ => s + "st"
          } ;
      in
      mkAdjective s se (s + "s") ser sst ;

    regAdjective : Str -> Adjective = \s ->
      let 
        se : Str = case s of {
          _ + ("er"|"en"|"ig")  => s + "e" ; --- for unstressed adjective suffixes 
          _ + ("i"|"u"|"ij") => endCons s + "e" ;
          b + v@("aa"|"ee"|"oo"|"uu") + c@?             => b + shortVoc v c + "e" ;
          b + ("ei"|"eu"|"oe"|"ou"|"ie"|"ij"|"ui") + ?  => endCons s + "e" ;
          b + v@("a"|"e"|"i"|"o"|"u" )            + c@? => b + v + c + c + "e" ;
          _ => endCons s + "e"
          } ;
      in reg2Adjective s se ;
      
param 
    VForm = 
       VInf      -- zijn
     | VInfFull  -- zijn (including prefix, e.g. oplossen)
     | VPresSg1  -- ben 
     | VPresSg2  -- bent
     | VPresSg3  -- is
     | VPresPl   -- zijn
     | VPastSg   -- was  --# notpresent
     | VPastPl   -- waren --# notpresent
     | VImp2     -- wees
     | VImp3     -- weest
     | VImpPl    -- wezen
     | VPerf     -- geweest
     | VPresPart -- zijnde
     | VGer      -- zijnde
     ;

    VPart = VPart_aan | VPart_af | VPart_be ;

  oper
    Verb : Type = {s: VForm => Str};
    
  mkVerb : (_,_,_,_,_,_,_ : Str) -> 
    	Verb = \aai, aait, aaien, aaide, _, aaiden, geaaid -> {
    	s = table {
        VInf | VInfFull | VImpPl | VPresPl => aaien; -- hij/zij/het/wij aaien
    		VPresSg1 | VImp2 => aai; -- ik aai
    		VPresSg2 | VPresSg3 | VImp3 => aait; -- jij aait
    		VPastSg => aaide; -- ik aaide  --# notpresent
    		VPastPl => aaiden; -- hij/zij/het/wij aaiden --# notpresent
    		VPerf   => geaaid ; -- ik heb geaaid 
                VPresPart => aaien + "de" ;
                VGer => aaien + "d"
    	}
    };
    
  regVerb : Str -> Verb = \s -> smartVerb s (mkStem s) ;

  irregVerb : (breken,brak,gebroken : Str) -> Verb = \breken,brak,gebroken ->
    let brek = (regVerb breken).s 
    in
    mkVerb (brek ! VPresSg1) (brek ! VPresSg3) (brek ! VInf) brak brak (brak + "en") gebroken ; 

  irregVerb2 : (breken,brak,braken,gebroken : Str) -> Verb = \breken,brak,braken,gebroken ->
    let brek = (regVerb breken).s 
    in
    mkVerb (brek ! VPresSg1) (brek ! VPresSg3) (brek ! VInf) brak brak (braken) gebroken ; 

-- To add a prefix (like "ein") to an already existing verb.

  prefixV : Str -> VVerb -> VVerb = \ein,verb ->
    let
      vs = verb.s ;
      -- einb : Bool -> Str -> Str = \b,geb -> 
      --  if_then_Str b (ein + geb) geb ;
    in
    {s = table {
      f@(VInfFull | VPerf) => ein + vs ! f; 
      f => vs ! f
      } ;
     prefix = ein ;
     aux = verb.aux ;
     particle = verb.particle ;
     vtype = verb.vtype 
     } ;

	-- Pattern matching verbs
    smartVerb : (_,_:Str) -> Verb = \verb,stem ->
    	let raw = Predef.tk 2 verb;
    	in
    	case raw of {
    	 _+ ("k"|"f"|"s"|"c"|"h"|"p") => t_regVerb verb stem;
    	 _+ "v" => v_regVerb verb;
    	 _+ "z" => z_regVerb verb;
    	 _+ ("t" | "tt") => t_end_regVerb verb;
    	 _+ "d" => d_end_regVerb verb;
    	 
    	 _ => d_regVerb verb stem
    	 
    	};
     consonant : pattern Str = #("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"v"|"w"|"x"|"y"|"z") ;
     vowel : pattern Str = #("a"|"e"|"i"|"o"|"u") ;
    -- To make a stem out of a verb
    -- If a stem ends in a 'v' then the 'v' changes into a 'f'
    -- If a stem ends in a 'z' then the 'z' changes into an 's'
    -- If a stem ends on a double consonant then one of them disappears
    -- If a stem ends on a consonant but that consonant has exactly 1 vowel before it
    -- then we have to double this vowel
    mkStem : Str -> Str =\lopen -> 
    let 
      lop  = tk 2 lopen ;    --drop the -en
      lo   = init lop ;
      o    = last lo  ;
      p    = case last lop of { 
	       "v" => "f" ;
	       "z" => "s" ;
	       p   => p
	      } ;
      loop = lo + o + p ;  -- voiced consonant to unvoiced, vowel doubling
      kerf = lo + p ;      -- voiced consonant to unvoiced, no vowel doubling
      zeg  = tk 3 lopen ;  -- double consonant disappearing
      werk = lop           -- no changes to stem
      
    in
    case lop of {
    	_+ #consonant + #vowel + #consonant => loop ; 
    	_+ ("bb" | "dd" | "ff" | "gg" | "kk" | "ll" | "mm" | "nn" | "pp" | 
            "rr" | "ss" | "tt")    => zeg ;
    	_+ #consonant + ("v"|"z")  => kerf ;
    	_                          => werk --default case, #consonant + #consonant 
    };
    
    
	-- To add a particle to a verb
    --  addPartVerb : Str -> Verb -> Verb = \aanmoedigen ->
    --  let verbpiece = Predef.drop 3 aanmoedigen;
    --	part = Predef.take 3 aanmoedigen;
    --	in
    --	mkVerb (smartVerb verbpiece) part;
    
    -- For regular verbs with past tense 'd'
    d_regVerb : (_,_ :Str) -> Verb = \geeuwen,geeuw ->
    	let stem = geeuw --- mkStem geeuwen
    	in
    	mkVerb stem (stem + "t") geeuwen 
    	  (stem + "de") (stem + "de") (stem + "den") 
    	  ("ge" + stem + "d");	

	-- For regular verbs with past tense 't'
   	t_regVerb : (_,_ :Str) -> Verb = \botsen,bots ->
   		let bots = mkStem botsen
   		in
   		mkVerb bots (bots + "t") botsen 
   		  (bots + "te") (bots + "te") (bots + "ten")
   		  ("ge" + bots + "t");
     
 	-- For verbs that dont need an extra 't' at the end
    t_end_regVerb : Str -> Verb = \achten ->
   		let acht = mkStem achten
   		in
      	mkVerb acht (acht) achten
     		(acht + "te") (acht +"te") (acht+"ten") ("ge"+acht);
    
    -- For verbs that dont need an extra 'd' at the end
    d_end_regVerb : Str -> Verb = \aarden ->
   		let aard = mkStem aarden
   		in
      	mkVerb aard (aard+"t") aarden
     		(aard + "de") (aard +"de") (aard+"den") ("ge"+aard);
  
	-- For verbs that need a vowel doubled in singular
	 add_vowel_regVerb : Str -> Verb = \absorberen ->
		let stem = mkStem absorberen 
		in
		case stem of {
			_+ ("t"|"k"|"f"|"s"|"c"|"h"|"p") => t_regVerb absorberen stem;
			_ => d_regVerb absorberen stem
		};

	-- For verbs that have their stem ending with a 'z'
	z_regVerb : Str -> Verb = \omhelzen ->
	let stem = mkStem omhelzen
	in
	d_regVerb omhelzen stem;
	
	-- For verbs that have their stem ending with a 'v'
	v_regVerb : Str -> Verb = \hoeven ->
	let hoef = mkStem hoeven
	in
	mkVerb hoef (hoef +"t") hoeven (hoef+"de") (hoef+"de") (hoef+"den")
		("ge"+hoef+"d");  

  zijn_V : VVerb = {
    s = table {
       VInf      => "zijn" ;
       VInfFull  => "zijn" ;
       VPresSg1  => "ben" ; 
       VPresSg2  => "bent" ;
       VPresSg3  => "is" ;
       VPresPl   => "zijn" ;
       VPastSg   => "was" ; --# notpresent
       VPastPl   => "waren" ; --# notpresent
       VImp2     => "wees" ;
       VImp3     => "weest" ;
       VImpPl    => "wezen" ;
       VPerf     => "geweest" ;
       VPresPart => "zijnde" ;
       VGer      => "wezend"
       } ;
    aux = VZijn ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  hebben_V : VVerb = {
    s = table {
       VInf      => "hebben" ;
       VInfFull  => "hebben" ;
       VPresSg1  => "heb" ; 
       VPresSg2  => "hebt" ;
       VPresSg3  => "heeft" ;
       VPresPl   => "hebben" ;
       VPastSg   => "had" ; --# notpresent
       VPastPl   => "hadden" ; --# notpresent
       VImp2     => "heb" ;
       VImp3     => "heeft" ;
       VImpPl    => "hebben" ;
       VPerf     => "gehad" ;
       VPresPart => "hebbende" ;
       VGer      => "hebbend"
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  zullen_V : VVerb = {
    s = table {
       VInf      => "zullen" ;
       VInfFull  => "zullen" ;
       VPresSg1  => "zal" ; 
       VPresSg2  => "zult" ;
       VPresSg3  => "zal" ;
       VPresPl   => "zullen" ;
       VPastSg   => "zou" ; --# notpresent
       VPastPl   => "zouden" ; --# notpresent
       VImp2     => "zoud" ;  ---- not used
       VImp3     => "zoudt" ;
       VImpPl    => "zouden" ; ----
       VPerf     => "gezoudt" ;
       VPresPart => "zullende" ;
       VGer      => "zullend" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  kunnen_V : VVerb = {
    s = table {
       VInf      => "kunnen" ;
       VInfFull  => "kunnen" ;
       VPresSg1  => "kan" ; 
       VPresSg2  => "kunt" ;
       VPresSg3  => "kan" ; ---- kun je
       VPresPl   => "kunnen" ;
       VPastSg   => "kon" ; --# notpresent
       VPastPl   => "konden" ; --# notpresent
       VImp2     => "kan" ;  ---- not used
       VImp3     => "kant" ;
       VImpPl    => "kunnen" ; ----
       VPerf     => "gekund" ;
       VPresPart => "kunnende" ;
       VGer      => "kunnend"
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  worden_V = irregVerb2 "worden" "werd" "werden" "geworden" ** {
    aux = VZijn ; prefix = [] ; particle = [] ; vtype = VAct} ; 

    Pronoun : Type = {
      unstressed,stressed : {nom, acc, poss : Str} ;
      substposs : Str ;
      a : Agr
      } ; 

    mkPronoun : (x1,_,_,_,_,x6,x7 : Str) -> Gender -> Number -> Person -> Pronoun = 
      \ik,me,mn,Ik,mij,mijn,mijne,g,n,p -> {
         unstressed = {nom = ik ; acc = me  ; poss = mn} ;
         stressed   = {nom = Ik ; acc = mij ; poss = mijn} ;
         substposs  = mijne ;
         a = {g = g ; n = n ; p = p}
         } ;

    het_Pron : Pronoun = mkPronoun "het" "het" "ze" "hij" "hem" "zijn" "zijne" Neutr Sg P3 ; -- cunger: 't -> het 


-- Complex $CN$s, like adjectives, have strong and weak forms.

param
    Adjf = Strong | Weak ;


  oper VVerb = Verb ** {prefix : Str ;       -- af + stappen
			particle : Str ;     -- non-inflecting component, e.g. leuk vinden
			aux : VAux ;         -- hebben or zijn
			vtype : VType} ;     -- active or reflexive

  param VAux = VHebben | VZijn ;

  param VType = VAct | VRefl ;

  oper 
    v2vvAux : Verb -> VAux -> VVerb = \v,a -> 
      {s = v.s ; aux = a ; prefix = [] ; particle = [] ; vtype = VAct} ;
    v2vv : Verb -> VVerb = \v -> v2vvAux v VHebben ;



---- The order of sentence is depends on whether it is used as a main
---- clause, inverted, or subordinate.

  oper 
    Preposition = Str ; 
    appPrep : Preposition -> (NPCase => Str) -> Str = \p,np -> p ++ np ! NPAcc ; ----

  param  
    Order = Main | Inv | Sub ;

  oper
    vForm : Tense -> Gender -> Number -> Person -> Order -> VForm = \t,g,n,p,o -> case <t,n,p> of {
      <Pres
        |Fut --# notpresent
       ,Sg,P2> => case <o,g> of {
        <Inv,Neutr> => VPresSg1 ;   --- Neutr is a hack for familiar you, "je", in StructuralDut
        _   => VPresSg2
        } ;
      <Pres
        |Fut --# notpresent
       ,Sg,P1> => VPresSg1 ;
      <Pres
        |Fut --# notpresent
       ,Sg,P3> => VPresSg3 ;
      <Pres 
       |Fut --# notpresent
       ,Pl,_ > => VPresPl
      ; --# notpresent

      <Past|Cond,Sg,_> => VPastSg ;   -- Fut and Cond affect zullen --# notpresent
      <Past|Cond,Pl,_> => VPastPl --# notpresent
      } ;

--2 For $Relative$

  param 
    RAgr = RNoAg | RAg Number Person ;

--2 For $Numeral$

  param
    CardOrd = NCard Gender Case | NOrd AForm ;
    DForm = DUnit  | DTeen  | DTen ;

--2 Transformations between parameter types

  oper Agr : Type = {g : Gender ; n : Number ; p : Person} ;

  oper
    agrP3 : Number -> Agr = agrgP3 Neutr ;

    agrgP3 : Gender -> Number -> Agr = \g,n -> 
      {g = g ; n = n ; p = P3} ;

-- Used in $NounDut$.

    agrAdj : Gender -> Adjf -> NForm -> AForm = \g,a,n ->
      case <a,g,n> of {
        <Strong,Neutr,NF Sg _> => APred ;
        _ => AAttr
        } ;

  param NegPosition = BeforeObjs | AfterObjs | BetweenObjs;

  oper VP : Type = {
      s  : VVerb ;
      a1 : Polarity => Str ; -- niet
      n0 : Agr => Str ;      -- je
      n2 : Agr => Str ;      -- je vrouw
      a2 : Str ;             -- vandaag
      isAux : Bool ;         -- is a double infinitive
      negPos : NegPosition ; -- ik schoop X niet ; ik houd niet van X ; dat is niet leuk
      inf : Str * Bool ;     -- zeggen (True = non-empty)
      ext : Str              -- dat je komt
      } ;

  predV : VVerb -> VP = predVGen False AfterObjs;

  predVGen : Bool -> NegPosition -> VVerb -> VP = \isAux, negPos, verb -> {
    s = verb ;
    a1  : Polarity => Str = negation ;
    n0  : Agr => Str = \\a => case verb.vtype of {
      VAct  => [] ;
      VRefl => reflPron ! a
      } ;
    n2  : Agr => Str = \\a => [] ;
    a2  : Str = [] ;
    isAux = isAux ; 
    negPos = negPos ;
    inf : Str * Bool = <[],False> ;
    ext : Str = []
    } ;

  negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "niet"
      } ;

-- Extending a verb phrase with new constituents.

  --when we call it with a normal VP, just copy the negPos field of the vp
  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> insertObjNP False vp.negPos obj vp;

  --this is needed when we call insertObjNP in ComplSlash: VPSlash is a subtype of VP so it works
  insertObjNP : Bool -> NegPosition -> (Agr => Str) -> VP -> VP = \isPron,negPos,obj,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n0 = \\a => case isPron of {True  => obj ! a ; _ => []} ++ vp.n0 ! a ;
    n2 = \\a => case isPron of {False => obj ! a ; _ => []} ++ vp.n2 ! a ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    negPos = negPos ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = \\a => adv ++ vp.a1 ! a ; -- immer nicht
    n0 = vp.n0 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    negPos = vp.negPos ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n0 = vp.n0 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ++ adv ;
    isAux = vp.isAux ;
    negPos = vp.negPos ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertExtrapos : Str -> VP -> VP = \ext,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n0 = vp.n0 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    negPos = vp.negPos ;
    inf = vp.inf ;
    ext = vp.ext ++ ext
    } ;

  insertInf : Str -> VP -> VP = \inf,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n0 = vp.n0 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ; ----
    negPos = vp.negPos ;
    inf = <inf ++ vp.inf.p1, True> ;
    ext = vp.ext
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause = \subj,agr,vp -> {
      s = \\t,a,b,o =>
        let
          ord   = case o of {
            Sub => True ;  -- glue prefix to verb
            _ => False
            } ;
          vform = vForm t agr.g agr.n agr.p o ;
          auxv = (auxVerb vp.s.aux).s ;
          vperf = vp.s.s ! VPerf ;
          verb : Str * Str = case <t,a> of {
            <Fut|Cond,Simul>  => <zullen_V.s ! vform, vp.s.s ! VInf> ; --# notpresent
            <Fut|Cond,Anter>  => <zullen_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <_,       Anter>  => <auxv ! vform,       vperf> ; --# notpresent
            <_,       Simul>  => <vp.s.s ! vform,     []>
            } ;
          fin   = verb.p1 ;
          neg   = vp.a1 ! b ;
          obj0  = vp.n0 ! agr ;
          obj   = vp.n2 ! agr ;
	  part  = vp.s.particle ;
	  compl = case vp.negPos of {
	    BeforeObjs  => neg ++ obj0 ++ obj ++ part ++ vp.a2 ++ vp.s.prefix ;
	    AfterObjs   => obj0 ++ obj ++ neg ++ part ++ vp.a2 ++ vp.s.prefix ;
      BetweenObjs => obj0 ++ neg ++ obj ++ part ++ vp.a2 ++ vp.s.prefix 
	  } ;
          inf : Str  =                                               
            case <vp.isAux, vp.inf.p2, a> of {                  
              <True,True,Anter> => vp.s.s ! VInf ++ vp.inf.p1 ; --# notpresent
              _                 => verb.p2 ++ vp.inf.p1 } ; -- cunger: changed from vp.inf.p1 ++ verb.p2 
          extra = vp.ext ;

          --for the Sub word order 
          inffin : Str =                                           
            case <t,a,vp.isAux> of {                          
            -- gezien zou/zal hebben  
                <Cond,Anter,False> => vperf ++ fin ++ auxv ! VInf ; --# notpresent
                <Fut,Anter,False>  => vperf ++ fin ++ auxv ! VInf ; --# notpresent
            -- zou/zal zien
               <Cond,Simul,False> => fin ++ verb.p2 ;          
               <Fut,Simul,False>  => fin ++ verb.p2 ;          
            -- wil kunnen zien (first line in inf)
               <_,Anter,True> => fin ++ inf ; -- double inf    --# notpresent
               _   =>  fin ++ inf                              
            -- no inf ++ fin, this is not German :-P
            }                                                  
        in
        case o of {
          Main => subj ++ fin ++ compl ++ inf ++ extra ;
          Inv  => fin ++ subj ++ compl ++ inf ++ extra ;
          Sub  => subj ++ compl ++ inffin ++ extra
          }
    } ;

  auxVerb : VAux -> Verb = \a -> case a of {
    VHebben => hebben_V ;
    VZijn   => zijn_V 
    } ;

  infVP : Bool -> VP -> ((Agr => Str) * Str * Str) = \isAux, vp -> 
    <
     \\agr => vp.n0 ! agr ++ vp.n2 ! agr ++ vp.a2,
     let vverb = vp.s 
     in 
     vp.a1 ! Pos ++ 
     if_then_Str isAux (vverb.s ! VInfFull) (vverb.prefix ++ "te" ++ vverb.s ! VInf),
     vp.inf.p1 ++ vp.ext
    > ;

  useInfVP : Bool -> VP -> Str = \isAux,vp ->
    let vpi = infVP isAux vp in
    "om" ++ vpi.p1 ! agrP3 Sg ++ vpi.p3 ++ vpi.p2 ; -- TODO

  reflPron : Agr => Str = table {
    {n = Sg ; p = P1} => "me" ;
    {n = Sg ; p = P2} => "je" ;
    {n = Sg ; p = P3} => "zich" ;
    {n = Pl ; p = P1} => "ons" ;
    {n = Pl ; p = P2} => "je" ;
    {n = Pl ; p = P3} => "zich"
    } ;

  conjThat : Str = "dat" ;

  conjThan : Str = "dan" ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> {
      g = Utr ; ----
      n = conjNumber a.n b.n ;
      p = conjPerson a.p b.p
      } ;

-- The infinitive particle "te" is used if and only if $vv.isAux = False$.
 
  infPart : Bool -> Str = \b -> if_then_Str b [] "te" ;

  mkDet : Str -> Str -> Number -> {s,sp : Gender => Str ; n : Number ; a : Adjf} =
    \deze,dit,n -> {
      s  = \\g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      sp = \\g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      n = n ;
      a = Weak
      } ;

  mkQuant : Str -> Str -> {
    s  : Bool => Number => Gender => Str ; 
    sp : Number => Gender => Str ; 
    a  : Adjf
    } = 
    \deze,dit -> {
      s  = \\_ ,n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      sp = \\   n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      a = Weak
      } ;

  mkPredet : Str -> Str -> {s : Number => Gender => Str} = 
    \deze,dit -> {
      s  = \\n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze}
      } ;

  mkNP : Str -> Gender -> Number -> {s : NPCase => Str ; a : Agr ; isPron : Bool} = 
    \s,g,n -> heavyNP {
      s = \\_ => s ;
      a = agrgP3 g n ;
      } ;

  auxVV : VVerb -> VVerb ** {isAux : Bool} = \v -> v ** {isAux = True} ;

  heavyNP : 
    {s : NPCase => Str ; a : Agr} -> {s : NPCase => Str ; a : Agr ; isPron : Bool} = \np ->
    np ** {isPron = False} ;

}
