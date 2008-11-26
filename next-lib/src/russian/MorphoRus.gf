--# -path=.:../../prelude:../common

--1 A Simple Russian Resource Morphology

-- Aarne Ranta, Janna Khegai 2006

-- This resource morphology contains definitions of the lexical entries
-- needed in the resource syntax.
-- It moreover contains copies of the most usual inflectional patterns.

-- We use the parameter types and word classes defined for morphology.

resource MorphoRus = ResRus ** open Prelude in {

flags  coding=utf8 ;

----2 Personal (together with possesive) pronouns.

oper pronYa : Pronoun = 
  let nonPoss = { s = table { Nom      => "я" ;
			      Gen      => "меня" ;
			      Dat      => "мне" ;
			      Acc      => "меня" ;
			      Inst     => "мной" ;
			      Prepos _ => "мне" } }
   in pronYaTu nonPoss "мо" P1 ;

oper pronTu : Pronoun = 
  let nonPoss = { s = table { Nom      => "ты" ;
			      Gen      => "тебя" ;
			      Dat      => "тебе" ;
			      Acc      => "тебя" ;
			      Inst     => "тобой" ;
			      Prepos _ => "тебе" } }
   in pronYaTu nonPoss "тво" P2 ;

-- Pronouns ya, tu, svoj
oper pronYaTu : { s : Case => Str } -> Str -> Person -> Pronoun =
  \nonPoss, mo, pers ->
  { s = table {
    PF c _ NonPoss   => nonPoss.s!c ;
    PF c _ (Poss gn) => case <c, gn> of {
        <Nom,      ASg Neut         > => mo + "ё" ;
        <Nom,      ASg Masc         > => mo + "й" ;
        <Gen,      ASg (Masc | Neut)> => mo + "его" ;
        <Dat,      ASg (Masc | Neut)> => mo + "ему" ;
        <Acc,      ASg (Masc | Neut)> => mo + "его" ;
        <Inst,     ASg (Masc | Neut)> => mo + "им" ;
        <Prepos _, ASg (Masc | Neut)> => mo + "ём" ;

        <Nom,      ASg Fem> => mo + "я" ;
        <Gen,      ASg Fem> => mo + "ей" ;
        <Dat,      ASg Fem> => mo + "ей" ;
        <Acc,      ASg Fem> => mo + "ю" ;
        <Inst,     ASg Fem> => mo + "ей" ;
        <Prepos _, ASg Fem> => mo + "ей" ;

        <Nom,      APl> => mo + "и" ;
        <Gen,      APl> => mo + "их" ;
        <Dat,      APl> => mo + "им" ;
        <Acc,      APl> => mo + "их" ;
        <Inst,     APl> => mo + "им" ;
        <Prepos _, APl> => mo + "их" 
	
      }
    } ;
    g = PNoGen ; n = Sg ; p = pers ; pron = True
  } ;

oper pronNAfterPrep : Pronoun -> Pronoun = \p ->
  { s = table {
    PF c Yes NonPoss  => case p.s!(PF c No NonPoss) of {
                        x@(("е"|"ё"|"и")+_) => "н"+x;
                        x => x };
    pf => p.s!pf };
    g = p.g ; n = p.n ; p = p.p ; pron = p.pron
  } ;

oper pronOn : Pronoun = pronNAfterPrep
  { s = table {
    PF _ _  (Poss  _) => "его" ;
    PF Nom        _ _ => "он" ;
    PF (Gen|Acc)  _ _ => "его" ;
    PF Dat        _ _ => "ему" ;
    PF Inst       _ _ => "им" ;
    PF (Prepos _) _ _ => "ём"
    } ;
    g = PGen Masc ; n = Sg ; p = P3 ; pron = True
  } ;

oper pronOna : Pronoun = pronNAfterPrep
  { s = table {
    PF _ _ (Poss  _ )          => "её" ;
    PF Nom _ NonPoss           => "она" ;
    PF (Gen|Acc) _ _           => "её" ;
    PF (Dat|Inst|Prepos _) _ _ => "ей"
    } ;
    g = PGen Fem ; n = Sg ; p = P3 ; pron = True
  } ;

oper pronOno: Pronoun =
  { s = table {
    PF Nom _ NonPoss => "оно" ;
    pf => pronOn.s!pf
    } ;
    g = PGen Neut ; n = Sg ; p = P3 ; pron = True
  } ;

oper pronMuVu : Str -> Str -> Person -> Pronoun =
  \mu,na,pers -> 
  { s = table {
    PF Nom        _ NonPoss => mu ;
    PF Gen        _ NonPoss => na + "с" ;
    PF Dat        _ NonPoss => na + "м" ;
    PF Acc        _ NonPoss => na + "с" ;
    PF Inst       _ NonPoss => na + "ми" ;
    PF (Prepos _) _ NonPoss => na + "с" ;

    PF Nom        _ (Poss (ASg Masc))          => na + "ш" ;
    PF Nom        _ (Poss (ASg Neut))          => na + "ше" ;
    PF Gen        _ (Poss (ASg (Masc | Neut))) => na + "шего" ;
    PF Dat        _ (Poss (ASg (Masc | Neut))) => na + "шему" ;
    PF Acc        _ (Poss (ASg (Masc | Neut))) => na + "шего" ;
    PF Inst       _ (Poss (ASg (Masc | Neut))) => na + "шим" ;
    PF (Prepos _) _ (Poss (ASg (Masc | Neut))) => na + "шем" ;

    PF Nom        _ (Poss (ASg Fem)) => na + "ша" ;
    PF Gen        _ (Poss (ASg Fem)) => na + "шей" ;
    PF Dat        _ (Poss (ASg Fem)) => na + "шей" ;
    PF Acc        _ (Poss (ASg Fem)) => na + "шу" ;
    PF Inst       _ (Poss (ASg Fem)) => na + "шею" ;
    PF (Prepos _) _ (Poss (ASg Fem)) => na + "шей" ;

    PF Nom        _ (Poss APl) => na + "ши" ;
    PF Gen        _ (Poss APl) => na + "ших" ;
    PF Dat        _ (Poss APl) => na + "шим" ;
    PF Acc        _ (Poss APl) => na + "ших" ;
    PF Inst       _ (Poss APl) => na + "шими" ;
    PF (Prepos _) _ (Poss APl) => na + "ших"
    };
    g = PNoGen ; n = Pl ; p = pers ; pron = True
  } ;

oper pronMu: Pronoun = pronMuVu "мы" "на" P1;

oper pronVu: Pronoun = pronMuVu "вы" "ва" P2;

oper pronOni: Pronoun = pronNAfterPrep
  { s = table {
    PF _ _ (Poss  _)          => "их" ;
    PF Nom _ _                => "они" ;
    PF Dat _ _                => "им" ;
    PF (Gen|Acc|Prepos _) _ _ => "их" ;
    PF Inst _ _               => "ими"
    } ;
    g = PNoGen ; n = Pl ; p = P3 ; pron = True
  } ;

oper pronKto: Pronoun =
  { s = table {
    PF Nom _ _  => "кто"  ;
    PF Gen _ _ => "кого" ;
    PF Dat _  _ => "кому" ;
    PF Acc _  _ => "кого" ;
    PF Inst _ _ => "кем" ;
    PF (Prepos _) _ _ => "ком"
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;

oper pronChto: Pronoun =
  { s = table {
    PF Nom _ _  => "что"  ;
    PF Gen _ _ => "чего" ;
    PF Dat _  _ => "чему" ;
    PF Acc _  _ => "что" ;
    PF Inst _ _ => "чем" ;
    PF (Prepos _) _ _ => "чём"
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;

oper pron_add_to : Pronoun -> Pronoun = \p -> 
  { s = \\pf => (p.s!pf) + "-то" ;
    g = p.g ;
    n = p.n ;
    p = p.p ;
    pron = p.pron
  } ;

oper pronKtoTo : Pronoun = pron_add_to pronKto ;

oper pronChtoTo: Pronoun = pron_add_to pronChto ;

oper pronEti: Pronoun =
  { s = table {
    PF Nom _ _  => "эти"  ;
    PF Gen _ _ => "этих" ;
    PF Dat _  _ => "этим" ;
    PF Acc _  _ => "этих" ;
    PF Inst _ _ => "этими" ;
    PF (Prepos _) _ _ => "этих"
    } ;
    n = Pl;
    p = P3;
    g= PGen Fem ;
    anim = Animate ;
    pron = False
  } ;

oper pronTe: Pronoun =
  { s = table {
    PF Nom _ _  => "те"  ;
    PF Gen _ _ => "тех" ;
    PF Dat _  _ => "тем" ;
    PF Acc _  _ => "тех" ;
    PF Inst _ _ => "теми" ;
    PF (Prepos _) _ _ => "тех"
    } ;
     n = Pl;
     p = P3;
     g=PGen Fem ;
     anim = Animate ;
     pron = False
  } ;


--oper pronNikto: Pronoun =
--  { s = table {
--    PF Nom _ _  => "никто"  ;
--    PF Gen _ _ => "никого" ;
--    PF Dat _  _ => "никому" ;
--    PF Acc _  _ => "никого" ;
--    PF Inst _ _ => "никем" ;
--    PF (Prepos _) _ _ => ["ни о ком"] -- only together with a preposition;
--    } ;
--    g = PGen  Masc;
--    n = Sg ;
--    p = P3 ;
--    pron = False
--  } ;
--
--oper pronNichto: Pronoun =
--  { s = table {
--    PF Nom _ _  => "ничто"  ;
--    PF Gen _ _ => "ничего" ;
--    PF Dat _  _ => "ничему" ;
--    PF Acc _  _ => "ничего" ;
--    PF Inst _ _ => "ничем" ;
--    PF (Prepos _) _ _ => ["ни о чём"] -- only together with preposition;
--    } ;
--    g = PGen  Masc;
--    n = Sg ;
--    p = P3 ;
--    pron = False
--  } ;
--

oper pronVseInanimate: Pronoun =
  { s = table {
    PF Nom _ _  => "всё"  ;
    PF Gen _ _ => "всего" ;
    PF Dat _  _ => "всему" ;
    PF Acc _  _ => "всё" ;
    PF Inst _ _ => "всем" ;
    PF (Prepos _) _ _ => "всём"
    } ;
    g = PGen  Neut;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;



----2 Nouns
--
---- Help type SubstFormDecl is introduced to reduce repetition in
---- the declination definitions. It allows us to define a declination type,
---- namely, the String component "s" of the CommNoun type
---- without any reference to the Gender parameter "g".
--

{-

Paradigms:
1.  hard regular
    Masc  -Consonant
    Neut -o
    Fem   -a
1*. with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
2.  soft regular:
    Masc -ь
    Neut -е
    Fem -я
2*. with vowel changes, Masc in Gen Sg, Fem in Gen Pl (no Neut)
3.  stem ending in г, к, х 
    - Masc, Fem same as 1 but use и instead of ы (Nom/Acc Pl, Gen Sg)
    - Neut -кo has Nom Pl -ки instead of -кa
3*  with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
4.  stem ending in ш, ж, ч, щ, hard endings,
    use и instead of ы, and use е instead of unstressed o
5.  stem ending in ц, hard endings, use е instead of unstressed o
5*. with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
6.  Masc ending in -й, Fem stem ending in vowel, Neut ending in ь?
6*  with vowel changes
7.  stem ending in и
8.  F2, Fem ending in -ь
    all -чь, -щь, -шь, -жь
    all -пь, -энь, -мь, -фь, 
    most -дь, -ть, -сть, -сь, -вь, -бь, 
8*. with vowel changes in Ins Sg, Gen Sg
9.  Neut ending in -мя
10. Masc in -oнoк
11. Masc in -aнин
12. Nom Pl in -ья

-}


  oper iAfter : Str -> Str = \stem -> 
	 case stem of { 
	           _ + ("г"|"к"|"х")     => "и" ;
		   _ + ("ш"|"ж"|"ч"|"щ") => "и" ;
		   _                     => "ы"
	       };

  oper oAfter : Str -> Str = \stem -> 
	 case stem of { 
		   _ + ("ш"|"ж"|"ч"|"щ") => "е" ;
		   _ + "ц"               => "е" ;
		   _                     => "о"
	       };

  -- 1.  Hard regular masculine inanimate, e.g. spor.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper nRegHardMasc : Str ->CommNoun= \stem -> 
	 let i = iAfter stem in
	 let o = oAfter stem in
  { s = table {
	NF Sg Nom        => stem ;
	NF Sg Gen        => stem+"а" ;
	NF Sg Dat        => stem+"у" ;
	NF Sg Acc        => stem ;
	NF Sg Inst       => stem+o+"м" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+i ;
	NF Pl Gen        => stem+case stem of { _+("ш"|"ж"|"ч"|"щ") => "ей"; _ => "ов" } ;
	NF Pl Dat        => stem+"ам" ;
	NF Pl Acc        => stem+i ;
	NF Pl Inst       => stem+"ами" ;
	NF Pl (Prepos _) => stem+"ах" };
      g = Masc; anim = Inanimate };

  -- 1. Hard regular neuter inanimate, e.g. pravilo.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper nRegHardNeut : Str ->CommNoun= \stem -> 
	 let o = oAfter stem in
    { s = table {
	NF Sg Nom        => stem+o ;
	NF Sg Gen        => stem+"а" ;
	NF Sg Dat        => stem+"у" ;
	NF Sg Acc        => stem+o ;
	NF Sg Inst       => stem+o+"м" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+case stem of { _+"к" => "и" ; _ => "а" } ;
	NF Pl Gen        => stem ;
	NF Pl Dat        => stem+"ам" ;
	NF Pl Acc        => stem+"а" ;
	NF Pl Inst       => stem+"ами" ;
	NF Pl (Prepos _) => stem+"ах" };
      g = Neut; anim = Inanimate };

  -- 1. Hard regular feminine inanimate, e.g. karta.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper nRegHardFem : Str ->CommNoun= \stem -> 
	 let i = iAfter stem in
	 let o = oAfter stem in
    { s = table {
	NF Sg Nom        => stem+"а" ;
	NF Sg Gen        => stem+i ;
	NF Sg Dat        => stem+"е" ;
	NF Sg Acc        => stem+"у" ;
	NF Sg Inst       => stem+o+"й" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+i ;
	NF Pl Gen        => stem ;
	NF Pl Dat        => stem+"ам" ;
	NF Pl Acc        => stem+i ;
	NF Pl Inst       => stem+"ами" ;
	NF Pl (Prepos _) => stem+"ах" };
      g = Fem; anim = Inanimate };

  -- 2. Soft regular masculine inanimate, e.g. vichr'
  oper nRegSoftMasc : Str ->CommNoun= \stem -> 
    { s = table {
	NF Sg Nom        => stem+"ь";
	NF Sg Gen        => stem+"я" ;
	NF Sg Dat        => stem+"ю" ;
	NF Sg Acc        => stem+"ь" ;
	NF Sg Inst       => stem+"ем" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+"и" ;
	NF Pl Gen        => stem+"ей" ;
	NF Pl Dat        => stem+"ям" ;
	NF Pl Acc        => stem+"и" ;
	NF Pl Inst       => stem+"ями" ;
	NF Pl (Prepos _) => stem+"ях" };
      g = Masc; anim = Inanimate };

  -- 2. Soft regular neuter inanimate, e.g. more
  oper nRegSoftNeut : Str ->CommNoun= \stem -> 
    { s = table {
	NF Sg Nom        => stem+"е";
	NF Sg Gen        => stem+"я" ;
	NF Sg Dat        => stem+"ю" ;
	NF Sg Acc        => stem+"е" ;
	NF Sg Inst       => stem+"ем" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+"я" ;
	NF Pl Gen        => stem+"ей" ;
	NF Pl Dat        => stem+"ям" ;
	NF Pl Acc        => stem+"я" ;
	NF Pl Inst       => stem+"ями" ;
	NF Pl (Prepos _) => stem+"ях" };
      g = Neut; anim = Inanimate };

  -- 2. Soft regular feminine inanimate, e.g. burya
  oper nRegSoftFem : Str ->CommNoun= \stem -> 
    { s = table {
	NF Sg Nom        => stem+"я";
	NF Sg Gen        => stem+"и" ;
	NF Sg Dat        => stem+"е" ;
	NF Sg Acc        => stem+"ю" ;
	NF Sg Inst       => stem+"ей" ;
	NF Sg (Prepos _) => stem+"е" ;
	NF Pl Nom        => stem+"и" ;
	NF Pl Gen        => stem+"ь" ;
	NF Pl Dat        => stem+"ям" ;
	NF Pl Acc        => stem+"и" ;
	NF Pl Inst       => stem+"ями" ;
	NF Pl (Prepos _) => stem+"ях" };
      g = Fem; anim = Inanimate };

  -- 6.  Masc ending in -Vй (V = vowel)
  oper nDecl6Masc : Str ->CommNoun= \stem -> 
     let n = nRegSoftMasc stem in
    { s = table {
	NF Sg (Nom|Acc)  => stem+"й";
	NF Pl Gen        => stem+"ев" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim };

  -- 6.  Neut ending in -Ve (V = vowel) (not adjectives)
  oper nDecl6Neut : Str ->CommNoun= \stem -> 
     let n = nRegSoftNeut stem in
    { s = table {
	NF Pl Gen        => stem+"й" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim };

  -- 6.  Fem ending in -Vя (V = vowel)
  oper nDecl6Fem : Str ->CommNoun= \stem -> 
     let n = nRegSoftFem stem in
    { s = table {
	NF Pl Gen        => stem+"й" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim };

  -- 7.  stem ending in и
  oper nDecl7Masc : Str ->CommNoun= \stem -> 
    let n = nDecl6Masc stem in
    { s = table {
	NF Sg (Prepos _) => stem+"и" ;
	sf               => n.s!sf };
      g = n.g; anim = n.anim };

  -- 7.  stem ending in и
  oper nDecl7Neut : Str ->CommNoun= \stem -> 
    let n = nDecl6Neut stem in
    { s = table {
	NF Sg (Prepos _) => stem+"и" ;
	sf               => n.s!sf };
      g = n.g; anim = n.anim };

  -- 7.  stem ending in и
  oper nDecl7Fem : Str ->CommNoun= \stem -> 
    let n = nDecl6Fem stem in
    { s = table {
	NF Sg (Dat|Prepos _) => stem+"и" ;
	sf                   => n.s!sf };
      g = n.g; anim = n.anim };


  -- 8. Feminine ending in soft consonant
  oper nDecl8 : Str ->CommNoun= \stem -> 
      let a : Str = case stem of { _+("ч"|"щ"|"ш"|"ж") => "а"; _ => "я" } in
    { s = table {
	NF Sg Nom        => stem+"ь";
	NF Sg Gen        => stem+"и" ;
	NF Sg Dat        => stem+"и" ;
	NF Sg Acc        => stem+"ь" ;
	NF Sg Inst       => stem+"ью" ;
	NF Sg (Prepos _) => stem+"и" ;
	NF Pl Nom        => stem+"и" ;
	NF Pl Gen        => stem+"ей" ;
	NF Pl Dat        => stem+a+"м" ;
	NF Pl Acc        => stem+"и" ;
	NF Pl Inst       => stem+a+"ми" ;
	NF Pl (Prepos _) => stem+a+"х" };
      g = Fem; anim = Inanimate };

  -- 9.  Neut ending in -мя
  oper nDecl9 : Str ->CommNoun= \stem ->
    { s = table {
	NF Sg Nom        => stem+"мя";
	NF Sg Gen        => stem+"мени" ;
	NF Sg Dat        => stem+"мени" ;
	NF Sg Acc        => stem+"мя" ;
	NF Sg Inst       => stem+"менем" ;
	NF Sg (Prepos _) => stem+"мени" ;
	NF Pl Nom        => stem+"мена" ;
	NF Pl Gen        => stem+"мён" ;
	NF Pl Dat        => stem+"менам" ;
	NF Pl Acc        => stem+"мена" ;
	NF Pl Inst       => stem+"менами" ;
	NF Pl (Prepos _) => stem+"менах" };
      g = Fem; anim = Inanimate };

   -- 10. Masc in -oнoк
  oper nDecl10Hard : Str -> CommNoun = \stem -> 
	 nAnimate (nSplitSgPl (nRegHardMasc (stem+"онок")) -- FIXME: vowel change in sg
	                      (nRegHardNeut (stem+"ат"))) ; 

   -- 10. Masc in -ёнoк
  oper nDecl10Soft : Str -> CommNoun = \stem -> 
	 nAnimate (nSplitSgPl (nRegHardMasc (stem+"ёнок")) -- FIXME: vowel change in sg
	                      (nRegHardNeut (stem+"ят"))) ; 

  oper nSplitSgPl : CommNoun -> CommNoun -> CommNoun = \x, y -> 
  {s  = table {
        NF Sg c => x.s!(NF Sg c) ;
        NF Pl c => y.s!(NF Pl c)
    } ;
    g = x.g ; anim = y.anim
   } ;

  -- Nouns inflected as adjectives.
  oper nAdj : Adjective -> Gender ->CommNoun= \a,g -> 
    { s = table {
	NF Sg c           => a.s!AF c Inanimate (ASg g) ;
	NF Pl c           => a.s!AF c Inanimate APl };
      g = g; anim = Inanimate } ;

-- Makes a noun animate.
  oper nAnimate : CommNoun -> CommNoun = \n -> 
   { s = table { 
       NF Sg Acc => case n.g of {
                       Masc => n.s!(NF Sg Gen);
		       _    => n.s!(NF Sg Acc)
	            };
       NF Pl Acc => n.s!(NF Pl Gen);
       sf        => n.s!sf } ;
     g = n.g ;
     anim = Animate 
   } ;

oper
    SubstFormDecl = SS1 NForm ;

oper nullEndInAnimateDeclStul: Str -> CommNoun =  \brat ->
  {s  =  table
      { NF Sg Nom =>  brat ;
        NF Sg Gen => brat+"а" ;
        NF Sg Dat => brat+"у" ;
        NF Sg Acc => brat +"а";
        NF Sg Inst => brat+"ом" ;
        NF Sg (Prepos _) => brat+"е" ;
        NF Pl Nom => brat+"ья" ;
        NF Pl Gen => brat+"ьев" ;
        NF Pl Dat => brat+"ьям" ;
        NF Pl Acc => brat +"ьев";
        NF Pl Inst => brat+"ьями" ;
        NF Pl (Prepos _) => brat+"ьяах"
    } ;
    g = Masc   ; anim = Inanimate
  } ;

oper nullEndAnimateDeclBrat: Str -> CommNoun =  \brat ->
  {s  =  table
      { NF Sg Nom =>  brat ;
        NF Sg Gen => brat+"а" ;
        NF Sg Dat => brat+"у" ;
        NF Sg Acc => brat +"а";
        NF Sg Inst => brat+"ом" ;
       NF Sg (Prepos _) => brat+"е" ;
        NF Pl Nom => brat+"ья" ;
        NF Pl Gen => brat+"ьев" ;
        NF Pl Dat => brat+"ьям" ;
        NF Pl Acc => brat +"ьев";
        NF Pl Inst => brat+"ьями" ;
        NF Pl (Prepos _) => brat+"ьяах"
    } ;
    g = Masc   ; anim = Animate
  } ;

oper irregPl_StemInAnimateDecl: Str -> CommNoun =  \derev ->
  { s  =  table
      { NF Sg Nom =>  derev+"о" ;
        NF Sg Gen => derev+"а" ;
        NF Sg Dat => derev+"у" ;
        NF Sg Acc => derev +"о";
        NF Sg Inst => derev+"ом" ;
        NF Sg (Prepos _) => derev+"е" ;
        NF Pl Nom => derev+"ья" ;
        NF Pl Gen => derev+"ьев" ;
        NF Pl Dat => derev+"ьям" ;
        NF Pl Acc => derev +"ья" ;
        NF Pl Inst => derev+"ьями" ;
        NF Pl (Prepos _) => derev+"ьяах"
    } ;
    g = Masc   ; anim = Inanimate
  } ;

oper kg_oEnd_SgDecl: Str -> CommNoun =  \mnog ->
{ s  =  table  {
      NF _ Nom =>  mnog+"о" ;
      NF _ Gen => mnog +"их";
      NF _ Dat => mnog+"им" ;
      NF _ Acc => mnog+"о" ;
      NF _ Inst => mnog+"ими" ;
      NF _ (Prepos _) => mnog+"их"
    } ;
    g = Neut   ; anim = Inanimate
} ;

oper oEnd_PlDecl: Str -> CommNoun =  \menshinstv ->
  { s  =  table  {
      NF _ Nom =>  menshinstv+"а" ;
      NF _ Gen => menshinstv;
      NF _ Dat => menshinstv+"ам" ;
      NF _ Acc => menshinstv+"ва" ;
      NF _ Inst => menshinstv+"ами" ;
      NF _ (Prepos _) => menshinstv+"вах"
    } ;
    g = Neut   ; anim = Inanimate
} ;

oper oEnd_SgDecl: Str -> CommNoun =  \bolshinstv ->
 {s  =  table  {
      NF _ Nom =>  bolshinstv+"о" ;
      NF _ Gen => bolshinstv+"а" ;
      NF _ Dat => bolshinstv+"у" ;
      NF _ Acc => bolshinstv+"о" ;
      NF _ Inst => bolshinstv+"ом" ;
      NF _ (Prepos _) => bolshinstv+"е"
    } ;
    g = Neut   ; anim = Inanimate
} ;

-- Note: Now we consider only the plural form of the pronoun "все" (all)
-- treated as an adjective (see AllDetPl definition).
-- The meaning "entire" is not considered, which allows us to form
-- the pronoun-adjective from the substantive form below:

oper eEnd_Decl: Str -> CommNoun =  \vs ->
{ s  =  table  {
      NF Sg Nom =>  vs+"е" ;
      NF Sg Gen => vs+"ех" ;
      NF Sg Dat => vs+"ем" ;
      NF Sg Acc => vs+"ех" ;
      NF Sg Inst => vs+"еми" ;
      NF Sg (Prepos _) => vs+"ех" ;
      NF Pl Nom => vs+"е" ;
      NF Pl Gen => vs +"ех";
      NF Pl Dat => vs+"ем" ;
      NF Pl  Acc => vs+ "ех" ;
      NF Pl Inst => vs+"еми" ;
      NF Pl (Prepos _) => vs+"ех"
    } ;
    g = Neut  ; anim = Inanimate
} ;


----2 Adjectives
--
---- Type Adjective only has positive degree while AdjDegr type
---- includes also comparative and superlative forms.
--
   kazhdujDet: Adjective = aRegHardStemStress "кажд" ;
   samuj : Adjective = aRegHardStemStress "сам" ;

--   lubojDet: Adjective = uy_oj_EndDecl "люб" ;
--   drugojDet: Adjective = uy_oj_EndDecl "друг" ;
--   glaznoj: Adjective = uy_oj_EndDecl "глазн" ;
   kotorujDet: Adjective = aRegHardStemStress "котор";
   nekotorujDet: Adjective = aRegHardStemStress "некотор";
   takoj: Adjective = aRegHardEndStress "так";
--   kakojNibudDet: Adjective = i_oj_EndDecl "как" "-нибудь";
--   kakojDet: Adjective = i_oj_EndDecl "как" [];
--   nikakojDet: Adjective = i_oj_EndDecl "никак" [];
   bolshinstvoSgDet: Adjective  = extAdjFromSubst (nRegHardNeut "большинств");
   mnogoSgDet: Adjective  = extAdjFromSubst (nRegHardNeut "мног");
   nemnogoSgDet: Adjective  = extAdjFromSubst (nRegHardNeut "немног");
   skolkoSgDet: Adjective  = extAdjFromSubst (nRegHardNeut "скольк");

--  bolshinstvoPlDet: Adjective  = extAdjFromSubst (oEnd_PlDecl "большинств");



  oper aRegHardStemStress : Str -> Adjective = \stem -> aRegHard stem False ;

  oper aRegHardEndStress : Str -> Adjective = \stem -> aRegHard stem True;

  -- 1. regular hard adjective
  -- 3. stem ending with г, к, х
  -- 4. stem ending with ш, ж, ч, щ
  -- 5. stem ending with ц
  oper aRegHard : Str -> Bool -> Adjective = \stem, endStress ->
    let i = iAfter stem in
    let o = case endStress of {
	       True  => "о" ;
	       False => oAfter stem } in
    { s = table {
	 AF Nom _ (ASg Masc)               => stem + case endStress of {
                                                        True => "ой";
							False => iAfter stem + "й" } ;
	 AF Nom _ (ASg Neut)               => stem + o+"е";
	 AF Gen _ (ASg (Masc|Neut))        => stem + o+"го";
	 AF Dat _ (ASg (Masc|Neut))        => stem + o+"му";
	 AF Acc Inanimate (ASg Masc)       => stem + i+"й";
	 AF Acc Animate (ASg Masc)         => stem + o+"го";
	 AF Acc _ (ASg Neut)               => stem + o+"е";
	 AF Inst _ (ASg (Masc|Neut))       => stem + i+"м";
	 AF (Prepos _) _ (ASg (Masc|Neut)) => stem + o+"м";

	 AF Nom  _ (ASg Fem) => stem + "ая";
	 AF Acc  _ (ASg Fem) => stem + "ую";
	 AF _    _ (ASg Fem) => stem + o+"й";

	 AF Nom _ APl          => stem + i+"е";
	 AF Acc  Inanimate APl => stem + i+"е";
	 AF Acc  Animate APl   => stem + i+"х";
	 AF Gen  _ APl         => stem + i+"х";
	 AF Inst _ APl         => stem + i+"ми";
	 AF Dat  _ APl         => stem + i+"м";
	 AF (Prepos _) _ APl   => stem + i+"х";

	 AFShort (ASg Masc) => stem;
	 AFShort (ASg Fem)  => stem + "а";
	 AFShort (ASg Neut) => stem + o ;
	 AFShort APl        => stem + i;

	 AdvF => stem + o
     } } ;

  oper aRegSoft : Str -> Adjective = \stem ->
    { s = table {
	 AF Nom _ (ASg Masc)               => stem + "ий" ;
	 AF Nom _ (ASg Neut)               => stem + "ее";
	 AF Gen _ (ASg (Masc|Neut))        => stem + "его";
	 AF Dat _ (ASg (Masc|Neut))        => stem + "ему";
	 AF Acc Inanimate (ASg Masc)       => stem + "ий";
	 AF Acc Animate (ASg Masc)         => stem + "его";
	 AF Acc _ (ASg Neut)               => stem + "ее";
	 AF Inst _ (ASg (Masc|Neut))       => stem + "им";
	 AF (Prepos _) _ (ASg (Masc|Neut)) => stem + "ем";

	 AF Nom  _ (ASg Fem) => stem + "яя";
	 AF Acc  _ (ASg Fem) => stem + "юю";
	 AF _    _ (ASg Fem) => stem + "ей";

	 AF Nom _ APl          => stem + "ие";
	 AF Acc  Inanimate APl => stem + "ие";
	 AF Acc  Animate APl   => stem + "их";
	 AF Gen  _ APl         => stem + "их";
	 AF Inst _ APl         => stem + "ими";
	 AF Dat  _ APl         => stem + "им";
	 AF (Prepos _) _ APl   => stem + "их";

	 AFShort (ASg Masc) => stem; -- FIXME: add e if stem ends in consonant + n
	 AFShort (ASg Fem)  => stem + "я";
	 AFShort (ASg Neut) => stem + "е" ;
	 AFShort APl        => stem + "и" ;

	 AdvF => stem + "е"
     } } ;




   vseDetPl: Adjective   =  extAdjFromSubst (eEnd_Decl "вс") ;
   extAdjFromSubst: CommNoun -> Adjective = \ vse ->
    {s = \\af => vse.s ! NF (numAF af) (caseAF af) } ;


oper totDet: Adjective = {s = table {
      AF Nom _ (ASg Masc) => "тот";
      AF Nom _ (ASg Fem) => "та";
      AF Nom _ (ASg Neut) => "то";
      AF Nom _ APl => "те";
      AF Acc Inanimate (ASg Masc) => "тот";
      AF Acc Animate (ASg Masc) => "того";
      AF Acc  _ (ASg Fem) => "ту";
      AF Acc  _ (ASg Neut) => "то";
      AF Acc  Inanimate APl => "те";
      AF Acc  Animate APl => "тех";
      AF Gen  _ (ASg Masc) => "того";
      AF Gen  _ (ASg Fem) => "той";
      AF Gen  _ (ASg Neut) => "того";
      AF Gen  _ APl => "тех";
      AF Inst _ (ASg Masc) => "тем";
      AF Inst _ (ASg Fem) => "той";
      AF Inst _ (ASg Neut) => "тем";
      AF Inst _ APl => "теми";
      AF Dat  _ (ASg Masc) => "тому";
      AF Dat  _ (ASg Fem) => "той";
      AF Dat  _ (ASg Neut) => "тому";
      AF Dat  _ APl => "тем";
      AF (Prepos _) _ (ASg Masc) => "том";
      AF (Prepos _) _ (ASg Fem) => "той";
      AF (Prepos _) _ (ASg Neut) => "том";
      AF (Prepos _) _ APl => "тех" ;
      AFShort (ASg Masc) => "тот";
      AFShort (ASg Fem) => "та";
      AFShort (ASg Neut) => "то";
      AFShort APl => "те";
      AdvF => "то" 
      }
  } ;

oper odinDet: Adjective = {s = table {
      AF Nom _ (ASg Masc) => "один";
      AF Nom _ (ASg Fem) => "одна";
      AF Nom _ (ASg Neut) => "одно";
      AF Nom _ APl => "одни";
      AF Acc Inanimate (ASg Masc) => "один";
      AF Acc Animate (ASg Masc) => "одного";
      AF Acc  _ (ASg Fem) => "одну";
      AF Acc  _ (ASg Neut) => "одно";
      AF Acc  Inanimate APl => "одни";
      AF Acc  Animate APl => "одних";
      AF Gen  _ (ASg Masc) => "одного";
      AF Gen  _ (ASg Fem) => "одной";
      AF Gen  _ (ASg Neut) => "одного";
      AF Gen  _ APl => "одних";
      AF Inst _ (ASg Masc) => "одним";
      AF Inst _ (ASg Fem) => "одной";
      AF Inst _ (ASg Neut) => "одним";
      AF Inst _ APl => "одними";
      AF Dat  _ (ASg Masc) => "одному";
      AF Dat  _ (ASg Fem) => "одной";
      AF Dat  _ (ASg Neut) => "одному";
      AF Dat  _ APl => "одним";
      AF (Prepos _) _ (ASg Masc) => "одном";
      AF (Prepos _) _ (ASg Fem) => "одной";
      AF (Prepos _) _ (ASg Neut) => "одном";
      AF (Prepos _) _ APl => "одних";
      AFShort (ASg Masc) => "один";
      AFShort (ASg Fem) => "одна";
      AFShort (ASg Neut) => "одно";
      AFShort APl => "одни";
      AdvF =>  "одно"
       }
  } ;

oper etotDet: Adjective = {s = table {
      AF Nom _ (ASg Masc) => "этот";
      AF Nom _ (ASg Fem) => "эта";
      AF Nom _ (ASg Neut) => "это";
      AF Nom _ APl => "эти";
      AF Acc Inanimate (ASg Masc) => "этот";
      AF Acc Animate (ASg Masc) => "этого";
      AF Acc  _ (ASg Fem) => "эту";
      AF Acc  _ (ASg Neut) => "это";
      AF Acc  Inanimate APl => "эти";
      AF Acc  Animate APl => "этих";
      AF Gen  _ (ASg Masc) => "этого";
      AF Gen  _ (ASg Fem) => "этой";
      AF Gen  _ (ASg Neut) => "этого";
      AF Gen  _ APl => "этих";
      AF Inst _ (ASg Masc) => "этим";
      AF Inst _ (ASg Fem) => "этой";
      AF Inst _ (ASg Neut) => "этим";
      AF Inst _ APl => "этими";
      AF Dat  _ (ASg Masc) => "этому";
      AF Dat  _ (ASg Fem) => "этой";
      AF Dat  _ (ASg Neut) => "этому";
      AF Dat  _ APl => "этим";
      AF (Prepos _) _ (ASg Masc) => "этом";
      AF (Prepos _) _ (ASg Fem) => "этой";
      AF (Prepos _) _ (ASg Neut) => "этом";
      AF (Prepos _) _ APl => "этих";
      AFShort (ASg Masc) => "этот";
      AFShort (ASg Fem) => "эта";
      AFShort (ASg Neut) => "это";
      AFShort APl => "эти";
      AdvF =>   "это"
       }
  } ;

oper vesDet: Adjective = {s = table {
      AF Nom _ (ASg Masc) => "весь";
      AF Nom _ (ASg Fem) => "вся";
      AF Nom _ (ASg Neut) => "всё";
      AF Nom _ APl => "все";
      AF Acc  Animate (ASg Masc) => "весь";
      AF Acc  Inanimate (ASg Masc) => "всего";
      AF Acc  _ (ASg Fem) => "всю";
      AF Acc  _ (ASg Neut) => "всё";
      AF Acc  Inanimate APl => "все";
      AF Acc  Animate APl => "всех";
      AF Gen  _ (ASg Masc) => "всего";
      AF Gen  _ (ASg Fem) => "всей";
      AF Gen  _ (ASg Neut) => "всего";
      AF Gen  _ APl => "всех";
      AF Inst _ (ASg Masc) => "всем";
      AF Inst _ (ASg Fem) => "всей";
      AF Inst _ (ASg Neut) => "всем";
      AF Inst _ APl => "всеми";
      AF Dat  _ (ASg Masc) => "ему";
      AF Dat  _ (ASg Fem) => "ей";
      AF Dat  _ (ASg Neut) => "ему";
      AF Dat  _ APl => "всем";
      AF (Prepos _) _ (ASg Masc) => "всём";
      AF (Prepos _) _ (ASg Fem) => "всей";
      AF (Prepos _) _ (ASg Neut) => "всём";
      AF (Prepos _) _ APl => "всех" ;
      AFShort (ASg Masc) => "весь";
      AFShort (ASg Fem) => "вся";
      AFShort (ASg Neut) => "всё";
      AFShort APl => "все";
      AdvF =>  "полностью"
      }
  } ;

oper uy_j_EndDecl : Str -> Adjective = \s ->{s = table {
      AF Nom _ (ASg Masc) => s+ "ый";
      AF Nom _ (ASg Fem) =>  s + "ая";
      AF Nom _ (ASg Neut) => s + "ое";
      AF Nom _ APl => s + "ые";
      AF Acc  Inanimate (ASg Masc) => s + "ый";
      AF Acc  Animate (ASg Masc) => s + "ого";
      AF Acc  _ (ASg Fem) => s + "ую";
      AF Acc  _ (ASg Neut) => s + "ое";
      AF Acc  Inanimate APl => s + "ые";
      AF Acc  Animate APl => s + "ых";
      AF Gen  _ (ASg Masc) => s + "ого";
      AF Gen  _ (ASg Fem) => s + "ой";
      AF Gen  _ (ASg Neut) => s + "ого";
      AF Gen  _ APl => s + "ых";
      AF Inst _ (ASg Masc) => s + "ым";
      AF Inst _ (ASg Fem) => s + "ой";
      AF Inst _ (ASg Neut) => s + "ым";
      AF Inst _ APl => s + "ыми";
      AF Dat  _ (ASg Masc) => s + "ому";
      AF Dat  _ (ASg Fem) => s + "ой";
      AF Dat  _ (ASg Neut) => s + "ому";
      AF Dat  _ APl => s + "ым";
      AF (Prepos _) _ (ASg Masc) => s + "ом";
      AF (Prepos _) _ (ASg Fem) => s + "ой";
      AF (Prepos _) _ (ASg Neut) => s + "ом";
      AF (Prepos _) _ APl => s + "ых";
      AFShort (ASg Masc) => s;
      AFShort (ASg Fem)  => s + "а";
      AFShort (ASg Neut) => s + "о" ;
      AFShort APl        => s + "ы";
      AdvF => s +"о"
      }
  } ;

{-
-- Commented out since I don't know what the short forms are
oper ti_j_EndDecl : Str -> Adjective = \s ->{s = table {
      AF Nom _ (ASg Masc) => s+"ий";
      AF Nom _ (ASg Fem) => s+"ья";
      AF Nom _ (ASg Neut) => s+"ье";
      AF Nom _ APl => s+"ьи";
      AF Acc  Inanimate (ASg Masc) => s+"ий";
      AF Acc  Animate (ASg Masc) => s+"ьего";
      AF Acc  _ (ASg Fem) => s+"ью";
      AF Acc  _ (ASg Neut) => s+"ье";
      AF Acc  Inanimate APl => s+"ьи";
      AF Acc  Animate APl => s+"ьих";
      AF Gen  _ (ASg Masc) => s+"ьего";
      AF Gen  _ (ASg Fem) => s+"ьей";
      AF Gen  _ (ASg Neut) => s+"ьего";
      AF Gen  _ APl => s+"ьих";
      AF Inst _ (ASg Masc) => s+"ьим";
      AF Inst _ (ASg Fem) => s+"ьей";
      AF Inst _ (ASg Neut) => s+"ьим";
      AF Inst _ APl => s+"ьими";
      AF Dat  _ (ASg Masc) => s+"ьему";
      AF Dat  _ (ASg Fem) => s+"ьей";
      AF Dat  _ (ASg Neut) => s+"ьему";
      AF Dat  _ APl => s+"ьим";
      AF (Prepos _) _ (ASg Masc) => s+"ьем";
      AF (Prepos _) _ (ASg Fem) => s+"ьей";
      AF (Prepos _) _ (ASg Neut) => s+"ьем";
      AF (Prepos _) _ APl => s+"ьих";
      AdvF => s +  "ье"
      }
  } ;
-}



---- 2 Adverbs
--
--oper vsegda: Adverb = { s = "всегда" } ;
--oper chorosho: Adverb =  { s = "хорошо" } ;
--
----  2 Verbs
--
---- Dummy verbum "have" that corresponds to the phrases like
---- "I have a headache" in English. The corresponding sentence
---- in Russian doesn't contain a verb:
--
--oper have: Verbum = {s=\\ vf => "-" ; asp = Imperfective} ;
--
---- There are two common conjugations
---- (according to the number and the person of the subject)
---- patterns in the present tense in the indicative mood.

-- +++ MG_UR: new conjugation class 'Foreign' introduced +++
param Conjugation = First | FirstE | Second | SecondA | Mixed | Dolzhen | Foreign ;


--3 First conjugation (in Present) verbs :
oper verbIdti : Verbum = verbDecl Imperfective First "ид" "у" "шел" "иди" "идти";

--oper verbGulyat : Verbum = verbDecl Imperfective First "гуля" "ю" "гулял" "гуляй" "гулять";
--oper verbVkluchat : Verbum = verbDecl Imperfective First "включа" "ю" "включал" "включай" "включать";
oper verbSuchestvovat : Verbum = verbDecl Imperfective First "существу" "ю" "существовал" "существуй" "существовать";
--oper verbVukluchat : Verbum = verbDecl Imperfective First "выключа" "ю" "выключал" "выключай" "выключать";
--oper verbZhdat : Verbum = verbDecl Imperfective First "жд" "у" "ждал" "жди" "ждать" ;
--oper verbBegat : Verbum = verbDecl Imperfective First "бега" "ю" "бегал" "бегай" "бегать";
--oper verbPrinimat : Verbum = verbDecl Imperfective First "принима" "ю" "принимал" "принимай" "принимать";
--oper verbDokazuvat : Verbum = verbDecl Imperfective First "доказыва" "ю" "доказывал" "доказывай" "доказывать";
--oper verbPredpochitat : Verbum = verbDecl Imperfective First "предпочита" "ю" "предпочитал" "предпочитай" "предпочитать";
--oper verbOtpravlyat : Verbum = verbDecl Imperfective First "отправля" "ю" "отправлял" "отправляй" "отправлять";
--oper verbSlomat : Verbum = verbDecl Perfective First "слома" "ю" "сломал" "сломай" "сломать";


---- Verbs with vowel "ё": "даёшь" (give), "пьёшь" (drink)  :
--oper verbDavat : Verbum = verbDecl Imperfective FirstE "да" "ю" "давал" "давай" "давать";
--oper verbPit : Verbum = verbDecl Imperfective FirstE "пь" "ю" "пил" "пей" "пить";
--


oper verbByut : Verbum = verbDecl Perfective First "буд" "у" "был" "будь" "быть";

oper verbMoch : Verbum = verbDeclMoch Imperfective First "мог" "у" "мог" "моги" "мочь" "мож";

----3 Second conjugation (in Present) verbs :
--
--oper verbLubit : Verbum = verbDecl Imperfective Second "люб" "лю" "любил" "люби" "любить";
--oper verbGovorit : Verbum = verbDecl Imperfective Second "говор" "ю" "говорил" "говори" "говорить";
--
--oper verbBolet_2 : Verbum = verbDecl Imperfective Second "бол" "ю" "болел" "боли" "болеть";
--oper verbPoranit : Verbum = verbDecl Perfective Second "поран" "ю" "поранил" "порань" "поранить";
--
-- Irregular Mixed:
oper verbKhotet : Verbum = verbDecl Imperfective Mixed "хоч" "у" "хотел" "хоти" "хотеть";

-- Irregular
oper verbDolzhen : Verbum = verbDecl Imperfective Dolzhen "долж" "ен" "долж" ["будь должен"] ["быть должным"] ;


-- further conjugation class added by Magda Gerritsen and Ulrich Real:
-- foreign words introduced in Russian

oper verbOrganisuet : Verbum = verbDecl Imperfective Foreign "организу" "ю" "организовал" "организуй" "организовать";


oper idetDozhd: Verbum -> Verbum = \idet -> {s = \\vf=>idet.s!vf ++ "дождь"; asp = Imperfective};

-- "PresentVerb" takes care of the present  tense conjugation.

param PresentVF = PRF GenNum Person;
oper PresentVerb : Type = PresentVF => Str ;

oper presentConjDolzhen: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF APl _        => del + "ны" ;
    PRF (ASg Masc) _ => del + sgP1End ;
    PRF (ASg Fem)  _ => del + "на" ;
    PRF (ASg Neut) _ => del + "но"
  };

-- +++ MG_UR: changed! +++
oper presentConjMixed: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF (ASg _) P1 => del+ sgP1End ; -- sgP1End "чу"
    PRF (ASg _) P2 => del+ "чешь" ;
    PRF (ASg _) P3 => del+ "чет" ;
    PRF APl P1 => del+ "тим" ;
    PRF APl P2  => del+ "тите" ;
    PRF APl P3  => del+ "тят"
  };
  
-- +++ MG_UR: changed! (+ д) +++ 
oper presentConj2: Str -> Str -> PresentVerb = \del, sgP1End ->
table {
    PRF (ASg _) P1 => del+ sgP1End ; -- sgP1End "жу"
    PRF (ASg _) P2 => del+ "дишь" ;
    PRF (ASg _) P3  => del+ "дит" ;
    PRF APl P1 => del+ "дим" ;
    PRF APl P2 => del+ "дите" ;
    PRF APl P3 => del+ "дят"
  };

oper presentConj2a: Str -> Str -> PresentVerb = \del, sgP1End ->
table {
    PRF (ASg _) P1 => del+ sgP1End ; -- sgP1End "жу"
    PRF (ASg _) P2 => del+ "ишь" ;
    PRF (ASg _) P3  => del+ "ит" ;
    PRF APl P1 => del+ "им" ;
    PRF APl P2 => del+ "ите" ;
    PRF APl P3 => del+ "ят"
  };

oper presentConj1E: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF (ASg _) P1 => del+ sgP1End ;
    PRF (ASg _) P2 => del+ "ёшь" ;
    PRF (ASg _) P3  => del+ "ёт" ;
    PRF APl P1 => del+ "ём" ;
    PRF APl P2 => del+ "ёте" ;
    PRF APl P3 => del+ sgP1End + "т"
  };
  
oper presentConj1: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF (ASg _) P1 => del+ sgP1End ;
    PRF (ASg _) P2 => del+ "ешь" ;
    PRF (ASg _) P3 => del+ "ет" ;
    PRF APl P1 => del+ "ем" ;
    PRF APl P2 => del+ "ете" ;
    PRF APl P3 => del+ sgP1End + "т"
  };
  
oper presentConj1Moch: Str -> Str -> Str -> PresentVerb = \del, sgP1End, altRoot ->
 table {
    PRF (ASg _) P1 => del + sgP1End ;
    PRF (ASg _) P2 => altRoot + "ешь" ;
    PRF (ASg _) P3 => altRoot + "ет" ;
    PRF APl P1 => altRoot + "ем" ;
    PRF APl P2 => altRoot + "ете" ;
    PRF APl P3 => del+ sgP1End + "т"
  };

-- "PastVerb" takes care of the past tense conjugation.

param PastVF = PSF GenNum ;
oper PastVerb : Type = PastVF => Str ;
oper pastConj: Str -> PastVerb = \del ->
  table {
    PSF  (ASg Masc) => del ;
    PSF  (ASg Fem)  => del +"а" ;
    PSF  (ASg Neut)  => del+"о" ;
    PSF  APl => del+ "и"
  };

oper pastConjDolzhen: Str -> PastVerb = \del ->
  table {
    PSF  (ASg Masc) => ["был "] + del + "ен" ;
    PSF  (ASg Fem)  => ["была "] + del + "на" ;
    PSF  (ASg Neut)  => ["было "] + del + "но" ;
    PSF  APl => ["были "] + del + "ны"
  };

-- further class added by Magda Gerritsen and Ulrich Real
oper presentConjForeign: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
  PRF (ASg _) P1 => del+ sgP1End ; -- sgP1End "ю"
  PRF (ASg _) P2 => del+ "ешь" ;
  PRF (ASg _) P3 => del+ "ет" ;
  PRF APl P1 => del+ "ем" ;
  PRF APl P2  => del+ "ете" ;
  PRF APl P3  => del+ "ют"
};

-- "verbDecl" sorts out verbs according to the aspect and voice parameters.
-- It produces the full conjugation table for a verb entry

-- +++ MG_UR: new conjugation class 'Foreign' introduced +++
oper verbDecl: Aspect -> Conjugation -> Str -> Str -> Str -> Str -> Str -> Verbum =
   \a, c, del, sgP1End, sgMascPast, imperSgP2, inf -> 
       let conj = case c of {
	                   First   => <presentConj1,pastConj> ;
			   FirstE  => <presentConj1E,pastConj> ;
			   Second  => <presentConj2,pastConj> ;
			   SecondA => <presentConj2a,pastConj> ;
			   Mixed   => <presentConjMixed,pastConj> ;
			   Dolzhen => <presentConjDolzhen,pastConjDolzhen> ;
			   Foreign => <presentConjForeign,pastConj> } in 
       let patt = case a of {
	            Perfective   => mkVerbImperfective;
		    Imperfective => mkVerbImperfective } in
       patt inf imperSgP2 (conj.p1 del sgP1End) (conj.p2 sgMascPast) ;

-- for verbs like "мочь" ("can") with changing consonants (first conjugation):
-- "могу - можешь"
oper verbDeclMoch: Aspect -> Conjugation -> Str -> Str -> Str -> Str ->Str -> Str -> Verbum =
   \a, c, del, sgP1End, sgMascPast, imperSgP2, inf, altRoot -> 
       let patt = case a of {
	            Perfective   => mkVerbImperfective;
		    Imperfective => mkVerbImperfective } in
        patt inf imperSgP2 (presentConj1Moch del sgP1End altRoot) (pastConj sgMascPast);

oper add_sya : Voice -> Str -> Str = \v,x ->
       case v of {
	 Act => x ;
	 Pas => case Predef.dp 2 x of {
                  "а" | "е" | "ё" | "и" | "о" | "у" | "ы" | "э" | "ю" | "я" => x + "сь" ;
		  _ => x + "ся"
	   }
       };


-- Generation the imperfective active pattern given
-- a number of basic conjugation forms.

oper mkVerbImperfective : Str -> Str -> PresentVerb -> PastVerb -> Verbum =
     \inf, imper, presentFuture, past -> { s = table { VFORM vox vf => 
       case vf of {
	 VINF => add_sya vox inf ;

	 VIMP _  P1 => "давайте" ++ add_sya vox inf ;
	 VIMP Sg P2 => add_sya vox imper ;
	 VIMP Pl P2 => add_sya vox (imper+"те") ;
	 VIMP Sg P3 => "пусть" ++ add_sya vox (presentFuture ! (PRF (ASg Masc) P3)) ;
	 VIMP Pl P3 => "пусть" ++ add_sya vox (presentFuture ! (PRF APl P3)) ;

	 VSUB gn => add_sya vox (past ! (PSF gn)) ++ "бы";

	 VIND (ASg _) (VPresent p) => add_sya vox (presentFuture ! (PRF (ASg Masc) p));
	 VIND APl (VPresent p)     => add_sya vox (presentFuture ! (PRF APl p));
	 VIND (ASg _) (VFuture P1) => "буду"   ++ add_sya vox inf ;
	 VIND (ASg _) (VFuture P2) => "будешь" ++ add_sya vox  inf ;
	 VIND (ASg _) (VFuture P3) => "будет"  ++ add_sya vox inf ;
	 VIND APl     (VFuture P1) => "будем"  ++ add_sya vox inf ;
	 VIND APl     (VFuture P2) => "будете" ++ add_sya vox inf ;
	 VIND APl     (VFuture P3) => "будут"  ++ add_sya vox inf ;
	 VIND gn      VPast        => add_sya vox (past ! (PSF gn))
     } } ;
     asp = Imperfective
    } ;

oper mkVerbPerfective: Str -> Str -> PresentVerb -> PastVerb -> Verbum =
     \inf, imper, presentFuture, past -> { s = table { VFORM vox vf => 
       case vf of {
	 VINF  =>  add_sya vox inf ;
	 VIMP Sg P1 => "давайте" ++ add_sya vox (presentFuture ! (PRF (ASg Masc) P1));
	 VIMP Pl P1 => "давайте" ++ add_sya vox (presentFuture ! (PRF APl P1));
	 VIMP Sg P2 => add_sya vox imper ;
	 VIMP Pl P2 => add_sya vox (imper+"те") ;
	 VIMP Sg P3 => "пусть" ++ add_sya vox (presentFuture ! (PRF (ASg Masc) P3)) ;
	 VIMP Pl P3 => "пусть" ++ add_sya vox (presentFuture ! (PRF APl P3)) ;

	 VSUB gn => add_sya vox (past ! (PSF gn)) ++ "бы" ;

	 VIND (ASg _) (VPresent _)  => nonExist ;
	 VIND APl     (VPresent P1) => nonExist ;
	 VIND APl     (VPresent P2) => nonExist ;
	 VIND APl     (VPresent P3) => nonExist ;
	 VIND gn      (VFuture p)   => add_sya vox (presentFuture ! (PRF gn p)) ;
	 VIND gn      VPast         => add_sya vox (past ! (PSF gn))
     } } ;
     asp = Perfective
   } ;

----2 Proper names are a simple kind of noun phrases.
--
oper ProperName : Type = {s :  Case => Str ; g : Gender ; anim : Animacy} ;
--
--  mkCNProperName : CommNoun -> ProperName = \cn ->
--{s = \\c => cn.s! (NF Sg c); g=cn.g; anim = cn.anim };
--
  mkProperNameMasc : Str -> Animacy -> ProperName = \ivan, anim ->
       { s =  table { Nom => ivan ;
                      Gen => ivan + "а";
                      Dat => ivan + "у";
                      Acc => case anim of
                             { Animate => ivan + "а";
                               Inanimate => ivan
                             };
                      Inst => ivan + "ом";
                      (Prepos _) => ivan + "е" } ;
         g = Masc;  anim = anim };

  mkProperNameFem : Str -> Animacy -> ProperName = \masha, anim ->
       { s = table { Nom => masha + "а";
                     Gen => masha + "и";
                     Dat => masha + "е";
                     Acc => masha + "у";
                     Inst => masha + "ей";
                     (Prepos _) => masha + "е" };
          g = Fem ; anim = anim };

};
