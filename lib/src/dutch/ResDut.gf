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
    consonant : pattern Str = #("b"|"c"|"d"|"f"|"g"|"h"|"j"|"k"|"l"|"m"|"n"|"p"|"q"|"r"|"s"|"t"|"v"|"w"|"x"|"y"|"z") ;
    vowel : pattern Str = #("a"|"e"|"i"|"o"|"u") ;

    dupCons : pattern Str = #("b"|"d"|"f"|"g"|"k"|"l"|"m"|"n"|"p"|"r"|"s"|"t") ; -- duplicable consonant
    dupVow  : pattern Str = #("aa"|"ee"|"oo"|"uu") ; -- actually duplicated vowel
    diphthong : pattern Str = #("ei"|"eu"|"oe"|"ou"|"ie"|"ij"|"ui") ;

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
      _ + ("a"|"o"|"y"|"u"|"oe"|"é") => mkNoun s (s + "'s") Utr ;
      _ + ("oir"|"ion"|"je"|"c")     => mkNoun s (s + "s") Neutr ;
      ? + ? + ? + _ + ("el" | "em" | "en" | "er" | "erd" | "aar" | "aard" | "ie")  -- unstressed
                                     => mkNoun s (s + "s") Utr ;
      _ + ("ie"|"ee") => mkNoun s (s + "ën") Utr ; -- zee→zeeën, knie→knieën. 
                                                   -- olie→oliën, industrie→industrieën with 2-arg constructor.
      _ + ("i"|"u")   => mkNoun s (endCons s + "en") Utr ;

      b + #diphthong + ?         => mkNoun s (endCons s + "en") Utr ; -- boek→boeken
      b + v@#dupVow + c@?        => mkNoun s (b + shortVoc v c + "en") Utr ;
      b + v@#vowel + c@#dupCons  => mkNoun s (b + v + c + c + "en") Utr ;
      _ + "e" => mkNoun s (s + "s") Utr ; -- vrede→vredes. Might not be a good generalisation though. /IL2018
      _       => mkNoun s (endCons s + "en") Utr
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


    add_s : Str -> Str = \s -> case s of {
      _ + "s" => s ;
      _       => s + "s"
      } ; 

  param 
    AForm = APred | AAttr Gender | AGen ;
    
  oper
    Adjective = {s : Degree => AForm => Str} ;

    mkAdjective : (_,_,_,_,_ : Str) -> Adjective = \ap,aa,ag,ac,as -> {
      s = table {
        Posit  => table {AAttr Utr => aa ; AGen => ag ; _ => ap } ;
        Compar => table {AAttr Utr => ac + "e" ; AGen => ac + "s" ; _ => ac } ; ----
        Superl => table {AAttr Utr => as + "e" ; AGen => as + "s" ; _ => as }   ----
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
          _ + ("er"|"en"|"ig") => s + "e" ; --- for unstressed adjective suffixes 
          _ + ("i"|"u"|"ij")   => endCons s + "e" ; -- ambigu-ambigue
          _ + ("a"|"e"|"o")    => s ; -- no e: lila-lila ; beige-beige ; indigo-indigo

          b + v@#dupVow + c@?  => b + shortVoc v c + "e" ;
          b + #diphthong + ?   => endCons s + "e" ;
          b + v@#vowel + c@#dupCons  => b + v + c + c + "e" ;
          _ => endCons s + "e"
          } ;
      in reg2Adjective s se ;

  addHetPred : (AForm => Str) -> (AForm => Str) = \tiend_warmst ->
     table {APred => "het" ++ tiend_warmst ! APred ;
            af    => tiend_warmst ! af } ;

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
     | VPerf AForm -- geweest / geweeste / geweests (e.g. "iets verdwaalds")
     | VPresPart -- zijnde
     | VGer      -- zijnde
     ;

    VPart = VPart_aan | VPart_af | VPart_be ;

  oper
    Verb : Type = {s: VForm => Str};
    
  mkVerb : (x1,_,_,_,_,_,x7 : Str) -> Verb =
    \aai, aait, aaien, aaide, aaidet, aaiden, geaaid ->
          mkVerb8 aai aait aait aaien aaide aaidet aaiden geaaid ;

  mkVerb8 : (_,_,_,_,_,_,_,_ : Str) -> Verb =
    \aai, aaitt, aait, aaien, aaide, _, aaiden, geaaid ->
     let geaaide = inflParticiple geaaid
      in { s = table {
                 VInf | VInfFull |
                 VImpPl | VPresPl => aaien; -- hij/zij/het/wij aaien
                 VPresSg1 | VImp2 => aai; -- ik aai
                 VPresSg2         => aaitt ; -- jij aait
                 VPresSg3 | VImp3 => aait; -- hij/zij aait
                 VPastSg          => aaide; -- ik aaide  --# notpresent
                 VPastPl          => aaiden; -- hij/zij/het/wij aaiden --# notpresent
                 VPerf (AAttr Utr)=> geaaide ; -- geaaide X
                 VPerf AGen       => geaaid + "s" ; -- iets geaaids
                 VPerf (APred|_)  => geaaid ; -- ik heb geaaid
                 VPresPart        => aaien + "de" ;
                 VGer             => aaien + "d"
              }
    };

  inflParticiple : Str -> Str = \gezien ->
    case gezien of {
      _ + "ien"      => gezien + "e" ; -- gezien/geziene
      _ + "en"       => gezien ;       -- geboren/geboren
      x + "aa" + n@? => x + "a" + n + "e" ;  -- gegaan/gegane ; gepraat/geprate
          -- not sure if these even exist, remove if wrong
          x + "ee" + n@? => x + "e" + n + "e" ;
          x + "oo" + n@? => x + "o" + n + "e" ;
      _              => gezien + "e"   -- betaald/betaalde ; gemaakt/gemaakte
    } ;

  regVerb : Str -> Verb = \s -> smartVerb s (mkStem s) ;

  irregVerb : (breken,brak,gebroken : Str) -> Verb = \breken,brak,gebroken ->
    let brek = (regVerb breken).s 
    in
    mkVerb (brek ! VPresSg1) (brek ! VPresSg3) (brek ! VInf) brak brak (brak + "en") gebroken ; 

  irregVerb2 : (breken,brak,braken,gebroken : Str) -> Verb = \breken,brak,braken,gebroken ->
    let brek = (regVerb breken).s 
    in
    mkVerb (brek ! VPresSg1) (brek ! VPresSg3) (brek ! VInf) brak brak braken gebroken ;

-- To add a prefix (like "ein") to an already existing verb.

  prefixV : Str -> VVerb -> VVerb = \ein,verb ->
    let
      vs = verb.s ;
      -- einb : Bool -> Str -> Str = \b,geb -> 
      --  if_then_Str b (ein + geb) geb ;
    in
    {s = table {
      f@(VInfFull | VPerf _) => ein + vs ! f;
      f => vs ! f
      } ;
     prefix = ein ;
     aux = verb.aux ;
     particle = verb.particle ;
     vtype = verb.vtype 
     } ;

    -- Pattern matching verbs
    -- Checking if the verb starts with "ver" is due to a bugfix in mkStem regarding ≥2-syllable verbs. /IL2018
    smartVerb : (_,_:Str) -> Verb = \verb,stem ->
        let raw = Predef.tk 2 verb;
          vg : {ver : Str ; geet : Str } = case verb of { 
            "ver" + geten => {ver = "ver" ; geet = mkStem geten } ;
            _             => {ver = []    ; geet = stem } } ;
          vergeten : Str = verb ;
          vergeet : Str = vg.ver + vg.geet ;
        in
        case raw of {
         _+ ("k"|"f"|"s"|"c"|"h"|"p") => t_regVerb vergeten vergeet ;
         _+ "v" => v_regVerb vergeten vergeet ;
         _+ "z" => z_regVerb vergeten vergeet ;
         _+ ("t" | "tt") => t_end_regVerb vergeten vergeet ;
         _+ "d" => d_end_regVerb vergeten vergeet ;
         _ => d_regVerb vergeten vergeet
        };

    -- To make a stem out of a verb
    -- If a stem ends in a 'v' then the 'v' changes into a 'f'
    -- If a stem ends in a 'z' then the 'z' changes into an 's'
    -- If a stem ends on a double consonant then one of them disappears
    -- If a stem ends on a consonant but that consonant has exactly 1 vowel before it
    -- then we have to double this vowel (but only if it's a monosyllable stem!)
    mkStem : Str -> Str = \lopen -> 
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
                                                    -- Penultimate is vowel, but it doesn't double: either because
      _+ #vowel + _ + #vowel + #consonant => kerf ; -- a) ≥2 syllables, e.g. ademen, rekenen, schakelen
                                                    -- b) diphthong, e.g. vriezen  (ij + #consonant falls into the default case!)
                                                    -- NB. this will do the wrong thing, if you use it on prefix verbs

      _ + #vowel + ("w"|"j")  => werk ; -- Don't double a vowel before a w or j (are there other consonants?)

      _ + #vowel + #consonant => loop ; -- In other cases, a single penultimate vowel doubles.
      _+ ("bb" | "dd" | "ff" | "gg" | "kk" | "ll" | "mm" | "nn" | "pp" |
          "rr" | "ss" | "tt")    => zeg ;
      _+ #consonant + ("v"|"z")  => kerf ;
      _                          => werk --default case, #consonant + #consonant
    };
    
    
    -- To add a particle to a verb
    --  addPartVerb : Str -> Verb -> Verb = \aanmoedigen ->
    --  let verbpiece = Predef.drop 3 aanmoedigen;
    --    part = Predef.take 3 aanmoedigen;
    --    in
    --    mkVerb (smartVerb verbpiece) part;
    
    -- For regular verbs with past tense 'd'
    d_regVerb : (_,_ :Str) -> Verb = \geeuwen,geeuw ->
      mkVerb geeuw (geeuw + "t") geeuwen 
            (geeuw + "de") (geeuw + "de") (geeuw + "den")
            ("ge" + geeuw + "d");

        -- For regular verbs with past tense 't'
    t_regVerb : (_,_ :Str) -> Verb = \botsen,bots ->
      mkVerb bots (bots + "t") botsen (bots + "te")
            (bots + "te") (bots + "ten") ("ge" + bots + "t");

         -- For verbs that dont need an extra 't' at the end
    t_end_regVerb : (_,_ : Str) -> Verb = \achten,acht ->
      mkVerb acht (acht) achten (acht + "te")
            (acht +"te") (acht+"ten") ("ge"+acht);
    
    -- For verbs that dont need an extra 'd' at the end
    d_end_regVerb : (_,_ : Str) -> Verb = \aarden,aard ->
      mkVerb aard (aard+"t") aarden (aard + "de")
            (aard +"de") (aard+"den") ("ge"+aard);
  
    -- For verbs that need a vowel doubled in singular
    add_vowel_regVerb : (_,_ : Str) -> Verb = \absorberen,stem ->
      case stem of {
        _+ ("t"|"k"|"f"|"s"|"c"|"h"|"p") => t_regVerb absorberen stem;
        _ => d_regVerb absorberen stem };

    -- For verbs that have their stem ending with a 'z'
    z_regVerb : (_,_ : Str) -> Verb = \omhelzen,stem ->
      d_regVerb omhelzen stem;

        -- For verbs that have their stem ending with a 'v'
    v_regVerb : (_,_ : Str) -> Verb = \hoeven,hoef ->
      mkVerb hoef (hoef +"t") hoeven (hoef+"de")
            (hoef+"de") (hoef+"den") ("ge"+hoef+"d");

  zijn_V : VVerb = {
    s = table {
       VInf        => "zijn" ;
       VInfFull    => "zijn" ;
       VPresSg1    => "ben" ;
       VPresSg2    => "bent" ;
       VPresSg3    => "is" ;
       VPresPl     => "zijn" ;
       VPastSg     => "was" ; --# notpresent
       VPastPl     => "waren" ; --# notpresent
       VImp2       => "wees" ;
       VImp3       => "weest" ;
       VImpPl      => "wezen" ;
       VPerf (AAttr Utr) => "geweeste" ;
       VPerf AGen  => "geweests" ;
       VPerf (APred|_) => "geweest" ;
       VPresPart   => "zijnde" ;
       VGer        => "wezend"
       } ;
    aux = VZijn ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  hebben_V : VVerb = {
    s = table {
       VInf        => "hebben" ;
       VInfFull    => "hebben" ;
       VPresSg1    => "heb" ;
       VPresSg2    => "hebt" ;
       VPresSg3    => "heeft" ;
       VPresPl     => "hebben" ;
       VPastSg     => "had" ; --# notpresent
       VPastPl     => "hadden" ; --# notpresent
       VImp2       => "heb" ;
       VImp3       => "heeft" ;
       VImpPl      => "hebben" ;
       VPerf (AAttr Utr) => "gehadde" ;
       VPerf AGen  => "gehads" ;
       VPerf (APred|_) => "gehad" ;
       VPresPart   => "hebbende" ;
       VGer        => "hebbend"
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  zullen_V : VVerb = {
    s = table {
       VInf        => "zullen" ;
       VInfFull    => "zullen" ;
       VPresSg1    => "zal" ;
       VPresSg2    => "zal" ;
       VPresSg3    => "zal" ;
       VPresPl     => "zullen" ;
       VPastSg     => "zou" ; --# notpresent
       VPastPl     => "zouden" ; --# notpresent
       VImp2       => "zoud" ;  ---- not used
       VImp3       => "zoudt" ;
       VImpPl      => "zouden" ; ----
       VPerf (AAttr Utr) => "gezoude" ;
       VPerf AGen  => "gezouds" ;
       VPerf (APred|_) => "gezoudt" ;
       VPresPart   => "zullende" ;
       VGer        => "zullend"
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  kunnen_V : VVerb = {
    s = table {
       VInf        => "kunnen" ;
       VInfFull    => "kunnen" ;
       VPresSg1    => "kan" ;
       VPresSg2    => "kan" ;
       VPresSg3    => "kan" ; ---- kun je
       VPresPl     => "kunnen" ;
       VPastSg     => "kon" ; --# notpresent
       VPastPl     => "konden" ; --# notpresent
       VImp2       => "kan" ;  ---- not used
       VImp3       => "kan" ;
       VImpPl      => "kunnen" ; ----
       VPerf (AAttr Utr) => "gekunde" ;
       VPerf AGen  => "gekunds" ;
       VPerf (APred|_) => "gekund" ;
       VPresPart   => "kunnende" ;
       VGer        => "kunnend"
       } ;
    aux = VHebben ;
    prefix = [] ;
    particle = [] ;
    vtype = VAct ;
    } ;

  worden_V = irregVerb2 "worden" "werd" "werden" "geworden" ** {
    aux = VZijn ; prefix = [] ; particle = [] ; vtype = VAct} ; 

    Pronoun : Type = MergesWithPrep ** {
      unstressed,stressed : {nom, acc, poss : Str} ;
      substposs : Number => Str ;
      a : Agr ;
      } ; 

    mkPronoun : (x1,_,_,_,_,x6,x7 : Str) -> Gender -> Number -> Person -> Pronoun = 
      \ik,me,mn,Ik,mij,mijn,mijne,g,n,p -> noMerge ** {
         unstressed = {nom = ik ; acc = me  ; poss = mn} ;
         stressed   = {nom = Ik ; acc = mij ; poss = mijn} ;
         substposs  = table {Sg => mijne ; Pl => mijne + "n" } ; --overgenerates *jullien /IL2018
         a = {g = g ; n = n ; p = p}
         } ;

    het_Pron : Pronoun = mkPronoun "het" "het" "ze" "hij" "hem" "zijn" "zijne" Neutr Sg P3 ; -- cunger: 't -> het 


    MergesWithPrep : Type = { mergesWithPrep : Bool ; mergeForm : Str } ;
    noMerge : MergesWithPrep = { mergesWithPrep = False ; mergeForm = [] } ;
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
    Preposition : Type = MergesWithPrep ** { s : Str } ;

    -- This is a hack for appPrep: sometimes we don't really need a full NP
    NPLite : Type = MergesWithPrep ** { s : NPCase => Str } ;
    npLite : (NPCase => Str) -> NPLite = \nplite -> noMerge ** {s = nplite} ;

    -- Applying a preposition to a noun phrase
    -- In order to decide whether to merge, have to check both NP and Prep:
    -- e.g. met + deze -> hiermee , but zonder + deze -> "zonder deze"
    appPrep : Preposition -> NPLite -> Str 
     = \prep,np -> 
          case <np.mergesWithPrep,prep.mergesWithPrep> of {
            <True,True> => glue np.mergeForm prep.mergeForm ;
            _           => prep.s ++ np.s ! NPAcc } ;


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

  -- IL2018-02: a whole lot of times we only need number and person, not gender
  -- maybe switch to PersAgr at some point and halve the number of fields
  oper PersAgr : Type = {n : Number ; p : Person} ;
  oper Agr : Type = PersAgr ** {g : Gender} ; 

  oper
    pagr : Agr -> PersAgr = \agr -> { p = agr.p ; n = agr.n } ;
    pagrP3 : Number -> PersAgr = \num -> {p = P3; n = num } ;

    agrP3 : Number -> Agr = agrgP3 Neutr ;
    agrgP3 : Gender -> Number -> Agr = \g,n -> 
      {g = g ; n = n ; p = P3} ;

-- Used in $NounDut$.

    agrAdj : Gender -> Adjf -> NForm -> AForm = \g,a,n ->
      case <a,g,n> of {
        <Strong,Neutr,NF Sg _> => AAttr Neutr ;
        _ => AAttr Utr
        } ;

  param NegPosition = BeforeObjs | AfterObjs | BetweenObjs;

  oper VP : Type = {
      s  : VVerb ;
      a1 : Polarity => Str ; -- niet: negation or AdV
      n0 : Agr => Str ;      -- je: pronoun complement (agr for reflexive)
      n2 : Agr => Str ;      -- je vrouw: non-pronoun complement (agr for CompCN)
      a2 : Str ;             -- vandaag: adverb
      isAux : Bool ;         -- is a double infinitive
      negPos : NegPosition ; -- ik schoop X niet ; ik houd niet van X ; dat is niet leuk
      inf : Str * Bool ;     -- zeggen (True = non-empty)
      ext : Str ;            -- dat je komt
      isHeavy : Bool ;       -- has any other field than s. Affects any VP* -> AP function.
      } ;

  predV : VVerb -> VP = predVGen False AfterObjs ;

  compV : VVerb -> VP = predVGen False BeforeObjs ;

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
    ext : Str = [] ;
    isHeavy = False ;
    } ;

  negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "niet"
      } ;

-- Extending a verb phrase with new constituents.

  --when we call it with a normal VP, just copy the negPos field of the vp
  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> insertObjNP False vp.negPos obj vp;

  --this is needed when we call insertObjNP in ComplSlash: VPSlash is a subtype of VP so it works
  insertObjNP : Bool -> NegPosition -> (Agr => Str) -> VP -> VP = \isPron,negPos,obj,vp -> vp ** {
    n0 = \\a => case isPron of {True  => obj ! a ; _ => []} ++ vp.n0 ! a ;
    n2 = \\a => case isPron of {False => obj ! a ; _ => []} ++ vp.n2 ! a ;
    negPos = negPos ;
    isHeavy = True ;
    } ;

  insertAdV : Str -> VP -> VP = \adv,vp -> vp ** {
    a1 = \\a => adv ++ vp.a1 ! a ; -- immer nicht
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> vp ** {
    a2 = vp.a2 ++ adv ;
    } ;

  insertExtrapos : Str -> VP -> VP = \ext,vp -> vp ** {
    ext = vp.ext ++ ext ;
    isHeavy = True ;
    } ;

  insertInf : Str -> VP -> VP = \inf,vp -> vp ** {
    inf = <inf ++ vp.inf.p1, True> ;
    isHeavy = True ;
    } ;

-- For $Sentence$.

  param
    ClType = Inf | Fin ;
  oper

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  -- To be used for normal clauses. APred chooses the noninflected past participle.
  mkClause : Str -> Agr -> VP -> Clause = \subj,agr,vp ->
    mkClause' subj agr vp APred Fin ;

  -- To be used for ExtendDut.PastPartAP
  -- If we need more variants, extend mkClause'
  infClause : Str -> Agr -> VP -> AForm -> Clause = \subj,agr,vp,af ->
    mkClause' subj agr vp af Inf ;

  -- Added a possibility to choose a participle verb form.
  -- This is so far only used in ExtendDut.PastPartAP. /IL2018
  mkClause' : Str -> Agr -> VP -> AForm -> ClType -> Clause = \subj,agr,vp,af,isPart -> {
      s = \\t,a,b,o =>
        let
          vform = vForm t agr.g agr.n agr.p o ;
          auxv = (auxVerb vp.s.aux).s ;
          vperf = vp.s.s ! VPerf af ;
          verb : Str * Str = case <isPart,t,a> of {

            -- <Experimental: only used in ExtendDut.PastPartAP>
            <Inf,Pres, _>  => <vp.s.s ! VPresPart, []> ;
            <Inf,_,    _>  => <vperf,[]> ;
            -- </Experimental>

            <_,Fut|Cond,Simul> => <zullen_V.s ! vform, vp.s.s ! VInf> ; --# notpresent
            <_,Fut|Cond,Anter> => <zullen_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <_,_,       Anter> => <auxv ! vform,       vperf> ; --# notpresent
            <_,_,       Simul> => <vp.s.s ! vform,     []>
            } ;
          fin   = verb.p1 ;
          neg   = vp.a1 ! b ;
          obj0  = vp.n0 ! agr ;
          obj   = vp.n2 ! agr ;
          part  = vp.s.particle ;
          pref  = case <a : Anteriority> of {
                    Anter => [] ;        -- prefix is part of participle: toegevoegd  --# notpresent
                    _     => vp.s.prefix -- prefix not present in verb form
                    } ;
          compl = case vp.negPos of {
            BeforeObjs  => neg ++ obj0 ++ obj ++ part ++ vp.a2 ++ pref ;
            AfterObjs   => obj0 ++ obj ++ neg ++ part ++ vp.a2 ++ pref ;
            BetweenObjs => obj0 ++ neg ++ obj ++ part ++ vp.a2 ++ pref
          } ;
          inf : Str =
            case <vp.isAux, vp.inf.p2, a> of {                  
              <True,True,Anter> => vp.s.s ! VInf ++ vp.inf.p1 ; --# notpresent
              _                 => verb.p2 ++ vp.inf.p1 } ; -- cunger: changed from vp.inf.p1 ++ verb.p2 
          extra = vp.ext ;

          --for the Sub word order 
          inffin : Str =                                           
            case <t,a,vp.isAux> of {                          
            -- gezien zou/zal hebben  
               <Fut|Cond,Anter,False> => vperf ++ fin ++ auxv ! VInf ++ vp.inf.p1 ; --# notpresent
            -- zou/zal zien
               <Fut|Cond,Simul,False> => fin ++ verb.p2 ++ vp.inf.p1  ; --# notpresent

            -- wil kunnen zien (first line in inf)
               _                      => fin ++ inf  -- double inf   
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

  infVP : Bool -> VP -> {obj : (Agr => Str) ; inf : Str ; ext : Str} = \isAux,vp ->
    let vverb = vp.s in {
      obj = \\agr => vp.n0 ! agr ++ vp.n2 ! agr ++ vp.a2 ;
      inf = vp.a1 ! Pos ++     -- altijd
            vverb.particle ++  -- leuk
            if_then_Str isAux
              (vverb.s ! VInfFull)                       -- toevoegen
              (vverb.prefix ++ "te" ++ vverb.s ! VInf) ; -- te vinden
      ext = vp.inf.p1 ++ vp.ext } ;

  insertInfVP : Bool -> VP -> (VP -> VP) = \isAux,vp ->
    let
      vpi = infVP isAux vp
    in
      \vps -> insertExtrapos vpi.ext
                (insertInf vpi.inf
                  (insertObj vpi.obj (vps ** {isHeavy=True}))) ;

  useInfVP : Bool -> VP -> Agr => Str = \isAux,vp ->
    let vpi = infVP isAux vp in
    \\agr => vpi.obj ! agr ++ vpi.inf ++ vpi.ext ;

  reflPron : Agr => Str = table {
    {n = Sg ; p = P1} => "mijzelf" ;
    {n = Sg ; p = P2} => "jezelf" ;
    {n = Sg ; p = P3} => "zichzelf" ;
    {n = Pl ; p = P1} => "onszelf" ;
    {n = Pl ; p = P2} => "jezelf" ;
    {n = Pl ; p = P3} => "zichzelf"
    } ;

  conjThat : Str = "dat" ;

  conjThan : Str = "dan" ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> {
      g = Utr ; ----
      n = conjNumber a.n b.n ;
      p = conjPerson' a.p b.p
      } ;

  conjPerson' : Person -> Person -> Person = \a,b -> case <a,b> of {
    <P1,x> => x ;
    <P3,x> => P3 ;
    <P2,x> => case x of {P3 => P3 ; _ => P2} } ;

-- The infinitive particle "te" is used if and only if $vv.isAux = False$.
 
  infPart : Bool -> Str = \b -> if_then_Str b [] "te" ;

  Determiner : Type = MergesWithPrep ** {s,sp : Gender => Str ; n : Number ; a : Adjf} ;

  mkDet2 : Str -> Str -> Number -> Determiner =
    \deze,dit,n -> noMerge ** {
        s  = \\g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
        sp = \\g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
        n = n ;
        a = Weak } ;

  mkDet = overload {
    mkDet : Str -> Str -> Number -> Determiner = mkDet2 ;

       -- NB: this function has 3 arguments to separate it from the previous one
       -- where the independent NP form is the same as the attribute form
       -- ("deze mensen" and "deze").
       -- In contrast, here we have a different NP form: 
       -- "er zijn veel/weinig mensen" 
       -- "velen zijn geroepen, maar weinigen uitverkoren."
    mkDet : Str -> Str -> Str -> Number -> Determiner =
      \weinig,_,weinigen,n -> 
        mkDet2 weinig weinig n ** { sp = \\g => weinigen } 
   } ;
  Quantifier : Type = MergesWithPrep ** {
      s  : Bool => Number => Gender => Str ; 
      sp : Number => Gender => Str ; 
      a  : Adjf
      } ;
  mkQuant : Str -> Str -> Quantifier = 
    \deze,dit -> noMerge ** {
      s  = \\_ ,n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      sp = \\   n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze} ;
      a = Weak
      } ;

  mkPredet : Str -> Str -> {s : Number => Gender => Str} = 
    \deze,dit -> {
      s  = \\n,g => case <n,g> of {<Sg,Neutr> => dit ; _ => deze}
      } ;

  NounPhrase : Type = MergesWithPrep ** {s : NPCase => Str ; a : Agr ; isPron : Bool } ;

  mkNP : Str -> Gender -> Number -> NounPhrase = 
    \s,g,n -> heavyNP { s = \\_ => s ;
                        a = agrgP3 g n } ;

  auxVV : VVerb -> VVerb ** {isAux : Bool} = \v -> v ** {isAux = True} ;

  heavyNP : {s : NPCase => Str ; a : Agr} -> NounPhrase = \np ->
    noMerge ** { isPron = False ; s = np.s ; a = np.a } ;

}
