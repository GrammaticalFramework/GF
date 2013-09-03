--# -path=.:../prelude

--1 A Simple Latin Resource Morphology.

-- Herbert Lange 2013

-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsLat$, which
-- gives a higher-level access to this module.

resource MorphoLat = ParamX, ResLat ** open Prelude in {
--
--  flags optimize=all ;
--

----2 Phonology
oper
  -- sounds and sound changes
  vowel : pattern Str = #( "a" | "e" | "o" | "u" | "y" );
  semivowel : pattern Str = #( "j" | "w" );
  consonant : pattern Str = #( "p" | "b" | "f" | "v" | "m" | "t" | "d" | "s" | "z" | "n" | "r" | "c" | "g" | "l" | "q" | "qu" | "h" );
  stop : pattern Str = #( "p" | "b" | "t" | "d" | "c" | "q" | "q" ); 
  fricative : pattern Str = #( "f" | "v" | "s" | "z" | "h" );
  nasal : pattern Str = #( "m" | "n" );
  liquid : pattern Str = #( "r" | "l" );
--  consonant : pattern Str = #(#stop | #fricative | #nasal | #liquid ); -- not working
----2 Nouns  
    
-- declensions
oper

  -- a-Declension
  noun1 : Str -> Noun = \mensa ->
    let 
      mensae = mensa + "e" ;
      mensis = init mensa + "is" ;
    in
    mkNoun 
      mensa (mensa +"m") mensae mensae mensa mensa
      mensae (mensa + "s") (mensa + "rum") mensis
      Fem ;

  -- o-Declension
  noun2us : Str -> Noun = \servus ->
    let
      serv = Predef.tk 2 servus ;
      servum = serv + "um" ;
      servi = serv + "i" ;
      servo = serv + "o" ;
    in
    mkNoun 
      servus servum servi servo servo (serv + "e")
      servi (serv + "os") (serv + "orum") (serv + "is")
      Masc ;

  noun2er : Str -> Str -> Noun = \liber,libri ->
    let
      libr : Str = Predef.tk 1 libri;
      librum = libr + "um" ;
      libri = libr + "i" ;
      libro = libr + "o" ;
    in
    mkNoun 
      liber librum libri libro libro liber
      libri ( libr + "os" ) ( libr + "orum" ) ( libr + "is" )
      Masc ;

  noun2um : Str -> Noun = \bellum ->
    let
      bell = Predef.tk 2 bellum ;
      belli = bell + "i" ;
      bello = bell + "o" ;
      bella = bell + "a" ;
    in
    mkNoun 
      bellum bellum belli bello bello (bell + "um")
      bella bella (bell + "orum") (bell + "is")
      Neutr ;

  -- Consonant declension
  noun3c : Str -> Str -> Gender -> Noun = \rex,regis,g ->
    let
      reg : Str = Predef.tk 2 regis ;
      regemes : Str * Str = case g of {
	Masc | Fem => < reg + "em" , reg + "es" > ;
	Neutr => < rex , reg + "a" > 
	} ;
    in
    mkNoun
      rex regemes.p1 ( reg + "is" ) ( reg + "i" ) ( reg + "e" ) rex
      regemes.p2 regemes.p2 ( reg + "um" ) ( reg + "ibus" ) 
      g ;

  -- i-declension
  noun3i : Str -> Str -> Gender -> Noun = \ars,artis,g ->
    let 
      art : Str = Predef.tk 2 artis ;
      artemes : Str * Str = case g of {
	Masc | Fem => < art + "em" , art + "es" > ;
	Neutr => case art of {
	  _ + #consonant + #consonant => < ars , art + "a" > ; -- maybe complete fiction but may be working
	  _ => < ars , art + "ia" > -- Bayer-Lindauer 32 4
	  }
	} ;
      arte : Str = case ars of {
	_ + ( "e" | "al" | "ar" ) => art + "i" ;
	_ => art + "e"
	};
    in
    mkNoun
      ars artemes.p1 ( art + "is" ) ( art + "i" ) arte ars
      artemes.p2 artemes.p2 ( art + "ium" ) ( art + "ibus" ) 
      g ;

  -- u-Declension

  noun4us : Str -> Noun = \fructus -> 
    let
      fructu = init fructus ;
      fruct  = init fructu
    in
    mkNoun
      fructus (fructu + "m") fructus (fructu + "i") fructu fructus
      fructus fructus (fructu + "um") (fruct + "ibus")
      Masc ;
  
  noun4u : Str -> Noun = \cornu -> 
    let
      corn = init cornu ;
      cornua = cornu + "a"
    in
    mkNoun
      cornu cornu (cornu + "s") cornu cornu cornu
      cornua cornua (cornu + "um") (corn + "ibus")
      Neutr ;

  -- e-Declension
  noun5 : Str -> Noun = \res -> 
    let
      re = init res ;
      rei = re + "i"
    in
    mkNoun
      res (re+ "m") rei rei re res
      res res (re + "rum") (re + "bus")
      Fem ;

  -- smart paradigms

  noun_ngg : Str -> Str -> Gender -> Noun = \verbum,verbi,g -> 
    let s : Noun = case <verbum,verbi> of {
      <_ + "a",  _ + "ae"> => noun1 verbum ;
      <_ + "us", _ + "i">  => noun2us verbum ;
      <_ + "um", _ + "i">  => noun2um verbum ;
      <_ + ( "er" | "ir" ) , _ + "i">  => noun2er verbum verbi ;

      <_ + "us", _ + "us"> => noun4us verbum ;
      <_ + "u",  _ + "us"> => noun4u verbum ;
      <_ + "es", _ + "ei"> => noun5 verbum ;
      _  => noun3 verbum verbi g
      }
    in  
    nounWithGen g s ;

  noun : Str -> Noun = \verbum -> 
    case verbum of {
      _ + "a"  => noun1 verbum ;
      _ + "us" => noun2us verbum ;
      _ + "um" => noun2um verbum ;
      _ + ( "er" | "ir" ) => noun2er verbum ( (Predef.tk 2 verbum) + "ri" ) ;
      _ + "u"  => noun4u verbum ;
      _ + "es" => noun5 verbum ;
      _  => Predef.error ("3rd declinsion cannot be applied to just one noun form " ++ verbum)
      } ;
  

  noun12 : Str -> Noun = \verbum -> 
    case verbum of {
      _ + "a"  => noun1 verbum ;
      _ + "us" => noun2us verbum ;
      _ + "um" => noun2um verbum ;
      _ + ( "er" | "ir" ) => 
	let
	  puer = verbum ; 
	  pue = Predef.tk 1 puer ; 
	  e = case puer of {
	    -- Exception of nouns where e is part of the word stem Bayer-Lindauer 27 4.2
	    "puer" | "socer" | "gener" | "vesper" => "e" ;
	    -- Exception of adjectives where e is part of the word stem 31 3.2
	    ("asper" | "miser" | "tener" | "frugifer") + _ => "e";
	    -- "liber" => ( "e"  | "" ) ; conflicting with noun liber
	    _ => ""
	    } ;
	  pu = Predef.tk 1 pue ;
	in noun2er verbum ( pu + e + "ri" );
      _  => Predef.error ("noun12 does not apply to" ++ verbum)
    } ;

  noun3 : Str -> Str -> Gender -> Noun = \rex,regis,g ->
    let
      reg : Str = Predef.tk 2 regis ;
    in
    case <rex,reg> of {
      -- Bos has to many exceptions to be handled correctly
      < "bos" , "bov" > => mkNoun "bos" "bovem" "bovis" "bovi" "bove" "bos" "boves" "boves" "boum" "bobus" g;
      -- Some exceptions with no fitting rules
      < "nix" , _ > => noun3i rex regis g; -- L...
      < ( "sedes" | "canis" | "iuvenis" | "mensis" | "sal" ) , _ > => noun3c rex regis g ;  -- Bayer-Lindauer 31 3 and Exercitia Latina 32 b), sal must be handled here because it will be handled wrongly by the next rule 
      < _ + ( "e" | "al" | "ar" ) , _ > => noun3i rex regis g ; -- Bayer-Lindauer 32 2.3
      < _ + "ter", _ + "tr" > => noun3c rex regis g ; -- might not be right but seems fitting for Bayer-Lindauer 31 2.2 
      < _ , _ + #consonant + #consonant > => noun3i rex regis g ; -- Bayer-Lindauer 32 2.2
      < _ + ( "is" | "es" ) , _ > => 
	if_then_else 
	  Noun 
	  -- assumption based on Bayer-Lindauer 32 2.1
	  ( pbool2bool ( Predef.eqInt ( Predef.length rex ) ( Predef.length regis ) ) ) 
	  ( noun3i rex regis g ) 
	  ( noun3c rex regis g ) ;
      _ => noun3c rex regis g
    } ;


----3 Proper names

----2 Determiners

----2 Pronouns

----2 Adjectives
oper
  comp_super : Noun -> ( Agr => Str ) * ( Agr => Str ) = 
    \bonus ->
    case bonus.s!Sg!Gen of {
      -- Exception Bayer-Lindauer 50 1
      "boni" => < comp "meli" , table { Ag g n c => table Gender [ (noun2us "optimus").s ! n ! c ; (noun1 "optima").s ! n ! c ; (noun2um "optimum").s ! n ! c ] ! g } > ;
      "mali" => < comp "pei" , super "pessus" > ;
      "magni" => < comp "mai" , table { Ag g n c => table Gender [ (noun2us "maximus").s ! n ! c ; (noun1 "maxima").s ! n ! c ; (noun2um "maximum").s ! n ! c ] ! g } > ;
      "parvi" => < comp "mini" , table { Ag g n c => table Gender [ (noun2us "minimus").s ! n ! c ; (noun1 "minima").s ! n ! c ; (noun2um "minimum").s ! n ! c ] ! g } >;
      --Exception Bayer-Lindauer 50.3
      "novi" => < comp "recenti" , super "recens" > ;
      "feri" => < comp "feroci" , super "ferox" > ;
      "sacris" => < comp "sancti" , super "sanctus" >;
      "frugiferi" => < comp "fertilis" , super "fertilis" > ;
      "veti" => < comp "vetusti" , super "vetustus" >;
      "inopis" => < comp "egentis" , super "egens" >;
      -- Default Case use Singular Genetive to determine comparative
      sggen => < comp sggen , super (bonus.s!Sg!Nom) >
    } ;
  
  comp : Str -> ( Agr => Str ) = \boni -> -- Bayer-Lindauer 46 2
    case boni of {
      bon + ( "i" | "is" ) => 
	table
	{
	  Ag ( Fem | Masc ) Sg c => table Case [ bon + "ior" ; 
			       bon + "iorem" ; 
			       bon + "ioris" ; 
			       bon + "iori" ; 
			       bon + "iore"; 
			       bon + "ior" ] ! c ;
	  Ag ( Fem | Masc ) Pl c => table Case [ bon + "iores" ; 
			       bon + "iores" ; 
			       bon + "iorum" ; 
			       bon + "ioribus" ; 
			       bon + "ioribus" ; 
			       bon + "iores" ] ! c ;
	  Ag Neutr Sg c => table Case [ bon + "ius" ; 
			       bon + "ius" ; 
			       bon + "ioris" ; 
			       bon + "iori" ; 
			       bon + "iore" ; 
			       bon + "ius" ] ! c ;
	  Ag Neutr Pl c => table Case [ bon + "iora" ; 
			       bon + "iora" ; 
			       bon + "iorum" ; 
			       bon + "ioribus" ; 
			       bon + "ioribus" ; 
			       bon + "iora" ] ! c 
	}
    } ;
  
  super : Str -> ( Agr => Str ) = \bonus ->
    let
      prefix : Str = case bonus of {
	ac + "er" => bonus ; -- Bayer-Lindauer 48 2
	faci + "lis" => faci + "l" ; -- Bayer-Lindauer 48 3
	feli + "x" => feli + "c" ; -- Bayer-Lindauer 48 1
	ege + "ns" => ege + "nt" ; -- Bayer-Lindauer 48 1
	bon + ( "us" | "is") => bon -- Bayer-Lindauer 48 1
	};
      suffix : Str = case bonus of {
	ac + "er" => "rim" ; -- Bayer-Lindauer 48 2
	faci + "lis" => "lim" ; -- Bayer-Lindauer 48 3
	_ => "issim" -- Bayer-Lindauer 48 1
	};
    in
    table {
      Ag Fem n c => (noun1 ( prefix + suffix + "a" )).s ! n ! c ;
      Ag Masc n c => (noun2us ( prefix + suffix + "us" )).s ! n ! c;
      Ag Neutr n c => (noun2um ( prefix + suffix + "um" )).s ! n ! c
    } ;

  adj12 : Str -> Adjective = \bonus ->
    let
      bon : Str = case bonus of {
	-- Exceptions Bayer-Lindauer 41 3.2
	("asper" | "liber" | "miser" | "tener" | "frugifer") => bonus ;
	-- Usual cases
	pulch + "er" => pulch + "r" ;
	bon + "us" => bon ;
	_ => Predef.error ("adj12 does not apply to" ++ bonus)
	} ; 
      nbonus = (noun12 bonus) ;
      compsup : ( Agr => Str ) * ( Agr => Str ) = 
	-- Bayer-Lindauer 50 4
	case bonus of {
	  (_ + #vowel + "us" ) |
	    (_ + "r" + "us" ) => 
	    < table { Ag g n c => table Gender [ ( noun12 bonus ).s ! n ! c ; ( noun12 ( bon + "a" ) ).s ! n ! c ; ( noun12 ( bon + "um" ) ).s ! n ! c ] ! g } ,
	    table { Ag g n c => table Gender [ ( noun12 bonus ).s ! n ! c ; ( noun12 ( bon + "a" ) ).s ! n ! c ; ( noun12 ( bon + "um" ) ).s ! n ! c ] ! g } > ;
	  _ => comp_super nbonus
	};
      advs : Str * Str = 
	case bonus of {
	  -- Bayer-Lindauer 50 4
	  idon + #vowel + "us" => < "magis" , "maxime" > ;
	  _ => < "" , "" >
	}
    in
    mkAdjective 
    nbonus 
    (noun1 (bon + "a")) 
    (noun2um (bon + "um")) 
    < compsup.p1 , advs.p1 > 
    < compsup.p2 , advs.p2 > ;

  adj3x : (_,_ : Str) -> Adjective = \acer,acris ->
   let
     ac = Predef.tk 2 acer ;
     acrise : Str * Str = case acer of {
       _ + "er" => <ac + "ris", ac + "re"> ; 
       _ + "is" => <acer      , ac + "e"> ;
       _        => <acer      , acer> 
       } ;
     nacer = (noun3adj acer acris Masc) ;
     compsuper = comp_super nacer;
   in
   mkAdjective 
    nacer
    (noun3adj acrise.p1 acris Fem) 
    (noun3adj acrise.p2 acris Neutr) 
    < compsuper.p1 , "" >
    < compsuper.p2 , "" >
    ;
    
-- smart paradigms

  adj123 : Str -> Str -> Adjective = \bonus,boni ->
    case <bonus,boni> of {
      <_ + ("us" | "er"), _ + "i" > => adj12 bonus ;
      <_ + ("us" | "er"), _ + "is"> => adj3x bonus boni ;
      <_                , _ + "is"> => adj3x bonus boni ;
      <_ + "is"         , _ + "e" > => adj3x bonus boni ;
      _ => Predef.error ("adj123: not applicable to" ++ bonus ++ boni)
    } ;

  adj : Str -> Adjective = \bonus ->
    case bonus of {
      _ + ("us" | "er") => adj12 bonus ;
      facil + "is"      => adj3x bonus bonus ;
      feli  + "x"       => adj3x bonus (feli + "cis") ;
      _                 => adj3x bonus (bonus + "is") ---- any example?
    } ;  
  

----3 Verbs

-- 1./a-conjugation

  verb1 : Str -> Verb = \laudare ->
    let
      lauda = Predef.tk 2 laudare ;
      laud = init lauda ;
      laudav = lauda + "v" ;
      pres_stem = lauda ;
      pres_ind_base = lauda ;
      pres_conj_base = laud + "e" ;
      impf_ind_base = lauda + "ba" ;
      impf_conj_base = lauda + "re" ;
      fut_I_base = lauda + "bi" ;
      imp_base = lauda ;
      perf_stem = laudav ;
      perf_ind_base = laudav ;
      perf_conj_base = laudav + "eri" ;
      pqperf_ind_base = laudav + "era" ;
      pqperf_conj_base = laudav + "isse" ;
      fut_II_base = laudav + "eri" ;
      part_stem = lauda + "t" ;
    in
    mkVerb laudare pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
    perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;

-- 2./e-conjugation

  verb2 : Str -> Verb = \monere ->
    let
      mone = Predef.tk 2 monere ;
      mon = init mone ;
      monu = mon + "u" ;
      pres_stem = mone ;
      pres_ind_base = mone ;
      pres_conj_base = mone + "a" ;
      impf_ind_base = mone + "ba" ;
      impf_conj_base = mone + "re" ;
      fut_I_base = mone + "bi" ;
      imp_base = mone ;
      perf_stem = monu ;
      perf_ind_base = monu ;
      perf_conj_base = monu + "eri" ;
      pqperf_ind_base = monu + "era" ;
      pqperf_conj_base = monu + "isse" ;
      fut_II_base = monu + "eri" ;
      part_stem = mon + "it" ;
    in
    mkVerb monere pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
    perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;

-- 3./Consonant conjugation

  verb3c : ( regere,rexi,rectus : Str ) -> Verb = \regere,rexi,rectus ->
    let
      rege = Predef.tk 2 regere ;
      reg = init rege ;
      rex = init rexi ;
      rect = Predef.tk 2 rectus ;
      pres_stem = reg ;
      pres_ind_base = reg ;
      pres_conj_base = reg + "a" ;
      impf_ind_base = reg + "eba" ;
      impf_conj_base = reg + "ere" ;
      fut_I_base = rege ;
      imp_base = reg ;
      perf_stem = rex ;
      perf_ind_base = rex ;
      perf_conj_base = rex + "eri" ;
      pqperf_ind_base = rex + "era" ;
      pqperf_conj_base = rex + "isse" ;
      fut_II_base = rex + "eri" ;
      part_stem = rect ;
    in
    mkVerb regere pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
    perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;

-- 3./i-conjugation

  verb3i : ( capere,cepi,captus : Str ) -> Verb = \capere,cepi,captus ->
    let
      cape = Predef.tk 2 capere ;
      cap = init cape ;
      capi = cap + "i" ;
      cep = init cepi ;
      capt = Predef.tk 2 captus ;
      pres_stem = capi ;
      pres_ind_base = capi ;
      pres_conj_base = capi + "a" ;
      impf_ind_base = capi + "eba" ;
      impf_conj_base = cape + "re" ;
      fut_I_base = capi + "e" ;
      imp_base = cap ;
      perf_stem = cep ;
      perf_ind_base = cep ;
      perf_conj_base = cep + "eri" ;
      pqperf_ind_base = cep + "era" ;
      pqperf_conj_base = cep + "isse" ;
      fut_II_base = cep + "eri" ;
      part_stem = capt ;
    in
    mkVerb capere pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
    perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;

-- 4./i-conjugation

  verb4 : Str -> Verb = \audire ->
    let
      audi = Predef.tk 2 audire ;
      audiv = audi + "v" ;
      pres_stem = audi ;
      pres_ind_base = audi ;
      pres_conj_base = audi + "a" ;
      impf_ind_base = audi + "eba" ;
      impf_conj_base = audi + "re" ;
      fut_I_base = audi +"e" ;
      imp_base = audi ;
      perf_stem = audiv ;
      perf_ind_base = audiv ;
      perf_conj_base = audiv + "eri" ;
      pqperf_ind_base = audiv + "era" ;
      pqperf_conj_base = audiv + "isse" ;
      fut_II_base = audiv + "eri" ;
      part_stem = audi + "t" ;
    in
    mkVerb audire pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base
    perf_stem perf_ind_base perf_conj_base pqperf_ind_base pqperf_conj_base fut_II_base part_stem ;

-- deponent verb

-- 1./a-conjugation
  deponent1 : Str -> Verb = \hortari ->
    let
      horta = Predef.tk 2 hortari ;
      hort = init horta ;
      pres_stem = horta ;
      pres_ind_base = horta ;
      pres_conj_base = hort + "e" ;
      impf_ind_base = horta + "ba" ;
      impf_conj_base = horta + "re" ;
      fut_I_base = horta + "bi" ;
      imp_base = horta ;
      part_stem = horta + "t" ;
    in
    mkDeponent hortari pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base part_stem ;

-- 2./e-conjugation
  deponent2 : Str -> Verb = \vereri ->
    let
      vere = Predef.tk 2 vereri ;
      ver = init vere ;
      pres_stem = vere ;
      pres_ind_base = vere ;
      pres_conj_base = vere + "a" ;
      impf_ind_base = vere + "ba" ;
      impf_conj_base = vere + "re" ;
      fut_I_base = vere + "bi" ;
      imp_base = vere ;
      part_stem = ver + "it" ;
    in
    mkDeponent vereri pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base part_stem ;

-- 3./Consonant conjugation
  deponent3c : ( sequi,sequor,secutus : Str ) -> Verb = \sequi,sequor,secutus ->
    let
      sequ = Predef.tk 2 sequor ;
      secu = Predef.tk 3 secutus ; 
      pres_stem = sequ ;
      pres_ind_base = sequ ;
      pres_conj_base = sequ + "a" ;
      impf_ind_base = sequ + "eba" ;
      impf_conj_base = sequ + "ere" ;
      fut_I_base = sequ + "e" ;
      imp_base = sequi ;
      part_stem = secu + "t" ;
    in
    mkDeponent sequi pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base part_stem ;

-- 3./i-conjugation
  deponent3i : ( pati,patior,passus : Str ) -> Verb = \pati,patior,passus ->
    let
      pat = init pati ;
      pass = Predef.tk 2 passus ; 
      pres_stem = pati ;
      pres_ind_base = pati ;
      pres_conj_base = pati + "a" ;
      impf_ind_base = pati + "eba" ;
      impf_conj_base = pat + "ere" ;
      fut_I_base = pati + "e" ;
      imp_base = pati ;
      part_stem = pass ;
    in
    mkDeponent pati pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base part_stem ;

-- 4./i-conjugation
  deponent4 : Str -> Verb = \largiri ->
    let
      largi = Predef.tk 2 largiri ; 
      pres_stem = largi ;
      pres_ind_base = largi ;
      pres_conj_base = largi + "a" ;
      impf_ind_base = largi + "eba" ;
      impf_conj_base = largi + "re" ;
      fut_I_base = largi + "e" ;
      imp_base = largi ;
      part_stem = largi + "t" ;
    in
    mkDeponent largiri pres_stem pres_ind_base pres_conj_base impf_ind_base impf_conj_base fut_I_base imp_base part_stem ;

-- smart paradigms

  verb_ippp : (iacere,iacio,ieci,iactus : Str) -> Verb = 
    \iacere,iacio,ieci,iactus ->
    case iacere of {
      _ + "ari" => deponent1 iacere ;
      _ + "eri" => deponent2 iacere ;
      _ + "iri" => deponent4 iacere ;
      _ + "i" => case iacio of {
  	_ + "ior" => deponent3i iacere iacio iactus ;
  	_ => deponent3c iacere iacio iactus
  	} ;
      _ + "are" => verb1 iacere ;
      _ + "ire" => verb4 iacere ; -- ieci iactus ;
      _ + "ere" => case iacio of {
  	_ + #consonant + "o" => verb3c iacere ieci iactus ; -- Bayer-Lindauer 74 1
  	_ + "eo" => verb2 iacere ;
  	_ + ( "i" | "u" ) + "o" => verb3i iacere ieci iactus ; -- Bayer-Linduaer 74 1
  	_ => verb3c iacere ieci iactus
  	} ;
      _ => Predef.error ("verb_ippp: illegal infinitive form" ++ iacere) 
    } ;

  verb : (iacere : Str) -> Verb = 
    \iacere ->
    case iacere of {
      _ + "ari" => deponent1 iacere ;
      _ + "eri" => deponent2 iacere ;
      _ + "iri" => deponent4 iacere ;
      _ + "are" => verb1 iacere ;
      _ + "ire" => let iaci = Predef.tk 2 iacere 
        in verb4 iacere ; -- (iaci + "vi") (iaci + "tus") ;
      _ + "ere" => verb2 iacere ;
      _ => Predef.error ("verb: illegal infinitive form" ++ iacere) 
    } ;
}