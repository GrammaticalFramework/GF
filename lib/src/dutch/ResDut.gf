--# -path=.:../abstract:../common

--1 Dutch auxiliary operations.
--
-- (c) 2009 Femke Johansson and Aarne Ranta

resource ResDut = ParamX ** open Prelude in {

  flags optimize=all ;

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
        NF Sg _ => sg ;
        NF Pl _ => pl
        } ;
     g = g
     } ;

    regNoun : Str -> Noun = \s -> case s of {
      _ + ("a" | "o" | "y" | "u" | "oe" | "é") => mkNoun s (s + "'s") Utr ;
      _ + ("oir" | "ion" | "je") => mkNoun s (s + "s") Neutr ;
      ? + ? + ? + _ + ("el" | "em" | "en" | "er" | "erd" | "aar" | "aard") => -- unstressed
        mkNoun s (s + "s") Utr ; 
      _ + ("i"|"u") => mkNoun s (endCons s + "en") Utr ;
      b + v@("aa"|"ee"|"oo"|"uu") + c@? => mkNoun s (b + shortVoc v c + "en") Utr ;
      b + v@("a" |"e" |"o" |"u" ) + c@? => mkNoun s (b + v + c + c + "en") Utr ;
      _ => mkNoun s (endCons s + "en") Utr
      } ;

    regNounG : Str -> Gender -> Noun = \s,g -> {
      s = (regNoun s).s ;
      g = g
      } ;

    shortVoc : Str -> Str -> Str = \v,s -> init v + endCons s ;

    endCons : Str -> Str = \s -> case s of {
      _ + ("ts" |"rs") => s ;
      b + "s" => b + "z" ;
      b + "f" => b + "v" ;
      _ => s
      } ;

  param 
    AForm = APred | AAttr | AGen ;
    
  oper
    Adjective = {s : Degree => AForm => Str} ;

    mkAdjective : (_,_,_,_,_ : Str) -> Adjective = \ap,aa,ag,ac,as -> {
      s = table {
        Posit  => table {APred => ap ; AAttr => aa ; AGen => ag} ; 
        Compar => table {APred => ac ; AAttr => ac + "e" ; AGen => ac + "es"} ; ----
        Superl => table {APred => as ; AAttr => as + "e" ; AGen => as + "es"}   ----
        }
      } ;
    regAdjective : Str -> Adjective = \s ->  ----
      let 
        se : Str = case s of {
          _ + ("i"|"u") => s + "e" ;
          b + v@("aa"|"ee"|"oo"|"uu") + c@? => b + shortVoc v c + "e" ;
          b + v@("a" |"e" |"o" |"u" ) + c@? => b + v + c + c + "en" ;
          _ => endCons s + "e"
          } ;
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

  param 
    VForm = 
       VInf      -- zijn
     | VPresSg1  -- ben 
     | VPresSg2  -- bent
     | VPresSg3  -- is
     | VPastSg   -- was  --# notpresent
     | VPastPl   -- waren --# notpresent
     | VImp2     -- wees
     | VImp3     -- weest
     | VImpPl    -- wezen
     | VPerf     -- geweest
     ;

    VPart = VPart_aan | VPart_af | VPart_be ;

  oper
    Verb : Type = {s: VForm => Str};
    
  mkVerb : (_,_,_,_,_,_,_ : Str) -> 
    	Verb = \aai, aait, aaien, aaide, _, aaiden, geaaid -> {
    	s = table {
    		VInf | VImpPl    => aaien; -- hij/zij/het/wij aaien
    		VPresSg1 | VImp2 => aai; -- ik aai
    		VPresSg2 | VPresSg3 | VImp3 => aait; -- jij aait
    		VPastSg => aaide; -- ik aaide  --# notpresent
    		VPastPl => aaiden; -- hij/zij/het/wij aaiden --# notpresent
    		VPerf   => geaaid -- ik heb geaaid 
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
      einb : Bool -> Str -> Str = \b,geb -> 
        if_then_Str b (ein + geb) geb ;
    in
    {s = table {
      f@(VInf | VPerf) => ein + vs ! f ; ---- TODO: eingegeven
      f       => vs ! f
      } ;
     prefix = ein ;
     aux = verb.aux ;
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

    -- To make a stem out of a verb
    -- If a stem ends in a 'v' then the 'v' changes into a 'f'
    -- If a stem ends in a 'z' then the 'z' changes into an 's'
    -- If a stem ends on a double consonant then one of them disappears
    -- If a stem ends on a consonant but that consonant has exactly 1 vowel before it
    -- then we have to double this vowel
    mkStem : Str -> Str =\werken -> 
    let stem = Predef.tk 2 werken
    in
    case stem of {
    	-- Vowel doubling for verbs whose stem does not end on 'v' or 'z' 	
    	_+ ("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"v"|"w"|"x"|"y"|"z") 
    	 + ("a"|"e"|"i"|"o"|"u")
    	 + ("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"w"|"x"|"y") 
    	 => Predef.tk 2 stem + (Predef.tk 1 (Predef.dp 2 stem)) + Predef.dp 2 stem;
    	 
     	-- Vowel doubling for verbs whose stem end on 'v'	
    	_+ ("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"v"|"w"|"x"|"y"|"z") 
    	 + ("a"|"e"|"i"|"o"|"u")
    	 + "v" => Predef.tk 2 stem + (Predef.tk 1 (Predef.dp 2 stem)) + 
    	 	(Predef.tk 1 (Predef.dp 2 stem)) +"f";
    
        -- Vowel doubling for verbs whose stem end on 'z`'	
    	_+ ("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"v"|"w"|"x"|"y"|"z") 
    	 + ("a"|"e"|"i"|"o"|"u")
    	 + "z" => Predef.tk 2 stem + (Predef.tk 1 (Predef.dp 2 stem)) + 
    	 	(Predef.tk 1 (Predef.dp 2 stem)) + "s";
    
    	_+ "v" => (Predef.tk 1 stem) + "f";
    	_+ "z" => (Predef.tk 1 stem) + "s";
    	
    	_+ ("bb" | "dd" | "ff" | "gg" | "kk" | "ll" | "mm" | "nn" | "pp" | 
    		"rr" | "ss" | "tt") => Predef.tk 1 stem;

    	 
    	_ => stem
    };
    
    
	-- To add a particle to a verb
    --  addPartVerb : Str -> Verb -> Verb = \aanmoedigen ->
    --  let verbpiece = Predef.drop 3 aanmoedigen;
    --	part = Predef.take 3 aanmoedigen;
    --	in
    --	mkVerb (smartVerb verbpiece) part;
    
    -- For regular verbs with past tense 'd'
    d_regVerb : (_,_ :Str) -> Verb = \geeuwen,geeuw ->
    	let stem = mkStem geeuwen
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
       VPresSg1  => "ben" ; 
       VPresSg2  => "bent" ;
       VPresSg3  => "is" ;
       VPastSg   => "was" ; --# notpresent
       VPastPl   => "waren" ; --# notpresent
       VImp2     => "wees" ;
       VImp3     => "weest" ;
       VImpPl    => "wezen" ;
       VPerf     => "geweest" 
       } ;
    aux = VZijn ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  hebben_V : VVerb = {
    s = table {
       VInf      => "hebben" ;
       VPresSg1  => "heb" ; 
       VPresSg2  => "hebt" ;
       VPresSg3  => "heeft" ;
       VPastSg   => "had" ; --# notpresent
       VPastPl   => "hadden" ; --# notpresent
       VImp2     => "heb" ;
       VImp3     => "heeft" ;
       VImpPl    => "hebben" ;
       VPerf     => "gehad" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  zullen_V : VVerb = {
    s = table {
       VInf      => "zullen" ;
       VPresSg1  => "zal" ; 
       VPresSg2  => "zult" ;
       VPresSg3  => "zal" ;
       VPastSg   => "zou" ; --# notpresent
       VPastPl   => "zouden" ; --# notpresent
       VImp2     => "zoud" ;  ---- not used
       VImp3     => "zoudt" ;
       VImpPl    => "zouden" ; ----
       VPerf     => "gezoudt" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  kunnen_V : VVerb = {
    s = table {
       VInf      => "kunnen" ;
       VPresSg1  => "kan" ; 
       VPresSg2  => "kunt" ;
       VPresSg3  => "kan" ; ---- kun je
       VPastSg   => "kon" ; --# notpresent
       VPastPl   => "konden" ; --# notpresent
       VImp2     => "kan" ;  ---- not used
       VImp3     => "kant" ;
       VImpPl    => "kunnen" ; ----
       VPerf     => "gekund" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  worden_V = irregVerb2 "worden" "werd" "werden" "geworden" ** {
    aux = VZijn ; prefix = [] ; vtype = VAct} ; 

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

    het_Pron : Pronoun = mkPronoun "'t" "'t" "ze" "hij" "hem" "zijn" "zijne" Neutr Sg P3 ;


-- Complex $CN$s, like adjectives, have strong and weak forms.

param
    Adjf = Strong | Weak ;


  oper VVerb = Verb ** {prefix : Str ; aux : VAux ; vtype : VType} ;
  param VAux = VHebben | VZijn ;

  param VType = VAct | VRefl ;

  oper 
    v2vvAux : Verb -> VAux -> VVerb = \v,a -> 
      {s = v.s ; aux = a ; prefix = [] ; vtype = VAct} ;
    v2vv : Verb -> VVerb = \v -> v2vvAux v VHebben ;



---- The order of sentence is depends on whether it is used as a main
---- clause, inverted, or subordinate.

  oper 
    Preposition = Str ;
    appPrep : Preposition -> (NPCase => Str) -> Str = \p,np -> p ++ np ! NPAcc ; ----

  param  
    Order = Main | Inv | Sub ;

  oper
    vForm : Tense -> Number -> Person -> Order -> VForm = \t,n,p,o -> case <t,n,p> of {
      <Pres
        |Fut --# notpresent
       ,Sg,P2> => case o of {
        Inv => VPresSg1 ;
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
       ,Pl,_ > => VInf 
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


--
---- This is used when forming determiners that are like adjectives.
--
--  appAdj : Adjective -> Number => Gender => Case => Str = \adj ->
--    let
--      ad : GenNum -> Case -> Str = \gn,c -> 
--        adj.s ! Posit ! AMod gn c
--    in
--    \\n,g,c => case n of {
--       Sg => ad (GSg g) c ;
--       _  => ad GPl c
--     } ;
--
---- This auxiliary gives the forms in each degree of adjectives. 
--
--  adjForms : (x1,x2 : Str) -> AForm => Str = \teuer,teur ->
--   table {
--    APred => teuer ;
--    AMod (GSg Masc) c => 
--      caselist (teur+"er") (teur+"en") (teur+"em") (teur+"es") ! c ;
--    AMod (GSg Fem) c => 
--      caselist (teur+"e") (teur+"e") (teur+"er") (teur+"er") ! c ;
--    AMod (GSg Neut) c => 
--      caselist (teur+"es") (teur+"es") (teur+"em") (teur+"es") ! c ;
--    AMod GPl c => 
--      caselist (teur+"e") (teur+"e") (teur+"en") (teur+"er") ! c
--    } ;
--
---- For $Verb$.
--
--  VPC : Type = {
--      s : Bool => Agr => VPForm => { -- True = prefix glued to verb
--        fin : Str ;          -- hat
--        inf : Str            -- wollen
--        } 
--      } ;
--

  oper VP : Type = {
      s  : VVerb ;
      a1 : Polarity => Str ; -- niet
      n2 : Agr => Str ;      -- dich
      a2 : Str ;             -- heute
      isAux : Bool ;         -- is a double infinitive
      inf : Str ;            -- sagen
      ext : Str              -- dass sie kommt
      } ;

  predV : VVerb -> VP = predVGen False ;


  predVGen : Bool -> VVerb -> VP = \isAux, verb -> {
    s = verb ;
    a1  : Polarity => Str = negation ;
    n2  : Agr => Str = \\a => case verb.vtype of {
      VAct  => [] ;
      VRefl => reflPron ! a
      } ;
    a2  : Str = [] ;
    isAux = isAux ; ----
    inf,ext : Str = []
    } ;

  negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "niet"
      } ;

-- Extending a verb phrase with new constituents.

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = \\a => obj ! a ++ vp.n2 ! a ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = \\a => adv ++ vp.a1 ! a ; -- immer nicht
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ++ adv ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertExtrapos : Str -> VP -> VP = \ext,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext ++ ext
    } ;

  insertInf : Str -> VP -> VP = \inf,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ; ----
    inf = inf ++ vp.inf ;
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
          vform = vForm t agr.n agr.p o ;
          auxv = (auxVerb vp.s.aux).s ;
          vperf = vp.s.s ! VPerf ;
          verb : Str * Str = case <t,a> of {
            <Fut|Cond,Simul>  => <zullen_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <Fut|Cond,Anter>  => <zullen_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <_,       Anter>  => <auxv ! vform,       vperf> ; --# notpresent
            <_,       Simul>  => <vp.s.s ! vform,     []>
            } ;
          fin   = verb.p1 ;
          neg   = vp.a1 ! b ;
          obj   = vp.n2 ! agr ;
          compl = obj ++ neg ++ vp.a2 ++ vp.s.prefix ;
          inf   = vp.inf ++ verb.p2 ;
          extra = vp.ext ;
          inffin = 
            case <a,vp.isAux> of {                              --# notpresent
              <Anter,True> => fin ++ inf ; -- double inf   --# notpresent
              _ =>                                              --# notpresent
              inf ++ fin              --- or just auxiliary vp
            }                                                   --# notpresent
        in
        case o of {
          Main => subj ++ fin ++ compl ++ inf ++ extra ;
          Inv  => fin ++ subj ++ compl ++ inf ++ extra ;
          Sub  => subj ++ compl ++ inffin ++ extra
          }
    } ;

  auxVerb : VAux -> VVerb = \a -> case a of {
    VHebben => hebben_V ;
    VZijn   => zijn_V 
    } ;

  infVP : Bool -> VP -> ((Agr => Str) * Str * Str) = \isAux, vp -> 
    <
     \\agr => vp.n2 ! agr ++  vp.a2,
     vp.a1 ! Pos ++ 
     if_then_Str isAux [] "te" ++ vp.s.s ! VInf,
     vp.inf ++ vp.ext
    > ;

  useInfVP : Bool -> VP -> Str = \isAux,vp ->
    let vpi = infVP isAux vp in
    vpi.p1 ! agrP3 Sg ++ vpi.p3 ++ vpi.p2 ;

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

-- The infinitive particle "zu" is used if and only if $vv.isAux = False$.
 
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

  mkNP : Str -> Gender -> Number -> {s : NPCase => Str ; a : Agr} = \s,g,n -> {
    s = \\_ => s ;
    a = agrgP3 g n ;
    } ;

  auxVV : VVerb -> VVerb ** {isAux : Bool} = \v -> v ** {isAux = True} ;

}
