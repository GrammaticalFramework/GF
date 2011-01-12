--# -path=.:../abstract:../common

--1 Afrch auxiliary operations.
--
-- (c) 2009 Femke Johansson and Aarne Ranta

resource ResAfr = ParamX ** open Prelude in {

  flags optimize=all ;

--2 For $Noun$

  param
    Case = Nom | Gen ;
    Gender = Utr | Neutr ; --!
--    Gender = Utr | Neutr ; --!

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
        Compar => table {APred => ac ; AAttr => ac + "e" ; AGen => ac + "es"} ; ----
        Superl => table {APred => as ; AAttr => as + "e" ; AGen => as + "es"}   ----
        }
      } ;
    regAdjective : Str -> Adjective = \s ->  ----
      let 
        se : Str = case s of {
          _ + "er"      => s + "e" ; ---- 
          _ + ("i"|"u") => endCons s + "e" ;
          b + v@("aa"|"ee"|"oo"|"uu") + c@?             => b + shortVoc v c + "e" ;
          b + ("ei"|"eu"|"oe"|"ou"|"ie"|"ij"|"ui") + ?  => endCons s + "e" ;
          b + v@("a"|"e"|"i"|"o"|"u" )            + c@? => b + v + c + c + "e" ;
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
    VForm =         --!
       VInf      -- wees
     | VPres     -- is 
     | VPast     -- was  --# notpresent
     | VPerf     -- gewees
     ;

    VPart = VPart_aan | VPart_af | VPart_be ;

  oper
    Verb : Type = {s: VForm => Str};
    
  mkVerb : (_,_,_,_ : Str) -> 
    	Verb = \aai, aaien, aaide, geaaid -> {
    	s = table {
    		VInf        => aaien; -- hij/zij/het/wij aaien
    		VPres       => aai;   -- ik aai
    		VPast       => aaide; -- ik aaide  --# notpresent
    		VPerf       => geaaid -- ik heb geaaid 
    	}
    };
    
  regVerb : Str -> Verb = \s -> irregVerb s ("ge" + s) ;

  irregVerb : (breek, gebreek : Str) -> Verb = \breek,gebreek ->
    mkVerb breek breek breek gebreek ;


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
  zijn_V : VVerb = {
    s = table {
       VInf      => "wees" ;
       VPres     => "is" ; 
       VPast     => "was" ; --# notpresent
       VPerf     => "gewees" 
       } ;
    aux = VZijn ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  hebben_V : VVerb = {
    s = table {
       VInf      => "hê" ;
       VPres     => "het" ; 
       VPast     => "hat" ; --# notpresent
       VPerf     => "gehad" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
    } ;

    Pronoun : Type = {
      unstressed,stressed : {nom, acc, poss : Str} ;
      substposs : Str ;
      a : Agr
      } ; 

  sal_V : VVerb = {
    s = table {
       VInf      => "sal" ;
       VPres     => "sal" ; 
       VPast     => "sou" ; --# notpresent
       VPerf     => "gesou" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
    } ;

  word_V : VVerb = {
    s = table {
       VInf      => "word" ;
       VPres     => "word" ; 
       VPast     => "word" ; --# notpresent
       VPerf     => "geword" 
       } ;
    aux = VHebben ;
    prefix = [] ;
    vtype = VAct ;
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
    vForm : Tense -> VForm = \t -> case t of {
      Pres  => VPres ;
      Fut   => VPres  --# notpresent
     ;  Past | Cond => VPast   -- Fut and Cond affect zullen --# notpresent
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

-- Used in $NounAfr$.

    agrAdj : Gender -> Adjf -> NForm -> AForm = \g,a,n ->
      case <a,g,n> of {
        <Strong,Neutr,NF Sg _> => APred ;
        _ => AAttr
        } ;

  oper VP : Type = {
      s  : VVerb ;
      a1 : Polarity => Str ; -- niet
      n0 : Agr => Str ;      -- je
      n2 : Agr => Str ;      -- je vrouw
      a2 : Str ;             -- vandaag
      isAux : Bool ;         -- is a double infinitive
      inf : Str * Bool ;     -- sagen (True = non-empty)
      ext : Str              -- dass sie kommt
      } ;

  predV : VVerb -> VP = predVGen False ;


  predVGen : Bool -> VVerb -> VP = \isAux, verb -> {
    s = verb ;
    a1  : Polarity => Str = negation ;
    n0  : Agr => Str = \\a => case verb.vtype of {
      VAct  => [] ;
      VRefl => reflPron ! a
      } ;
    n2  : Agr => Str = \\a => [] ;
    a2  : Str = [] ;
    isAux = isAux ; ----
    inf : Str * Bool = <[],False> ;
    ext : Str = []
    } ;

  negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "niet"
      } ;

-- Extending a verb phrase with new constituents.

  insertObj : (Agr => Str) -> VP -> VP = insertObjNP False ;

  insertObjNP : Bool -> (Agr => Str) -> VP -> VP = \isPron, obj,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n0 = \\a => case isPron of {True  => obj ! a ; _ => []} ++ vp.n0 ! a ;
    n2 = \\a => case isPron of {False => obj ! a ; _ => []} ++ vp.n2 ! a ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
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
          vform = vForm t ;
          auxv = (auxVerb vp.s.aux).s ;
          vperf = vp.s.s ! VPerf ;
          verb : Str * Str = case <t,a> of {
            <Fut|Cond,Simul>  => <sal_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <Fut|Cond,Anter>  => <sal_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <_,       Anter>  => <auxv ! vform,       vperf> ; --# notpresent
            <_,       Simul>  => <vp.s.s ! vform,     []>
            } ;
          fin   = verb.p1 ;
          neg   = vp.a1 ! b ;
          obj0  = vp.n0 ! agr ;
          obj   = vp.n2 ! agr ;
          compl = obj0 ++ neg ++ obj ++ vp.a2 ++ vp.s.prefix ;
          inf   = 
            case <vp.isAux, vp.inf.p2, a> of {                  --# notpresent
              <True,True,Anter> => vp.s.s ! VInf ++ vp.inf.p1 ; --# notpresent
              _ =>                                              --# notpresent
                 vp.inf.p1 ++ verb.p2
              }                                                 --# notpresent
              ;
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
     vp.inf.p1 ++ vp.ext
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
