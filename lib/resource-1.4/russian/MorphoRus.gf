--# -path=.:../../prelude:../common

--1 A Simple Russian Resource Morphology

-- Aarne Ranta, Janna Khegai 2006

-- This resource morphology contains definitions of the lexical entries
-- needed in the resource syntax.
-- It moreover contains copies of the most usual inflectional patterns.

-- We use the parameter types and word classes defined for morphology.

resource MorphoRus = ResRus ** open Prelude, (Predef=Predef) in {

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


oper pronOn: Pronoun =
  { s = table {
    PF Nom _ NonPoss  => "он" ;
    PF Gen No NonPoss  => "его" ;
    PF Gen Yes NonPoss => "него"  ;
    PF Dat No NonPoss => "ему" ;
    PF Dat Yes NonPoss => "нему" ;
    PF Acc No NonPoss => "его" ;
    PF Acc Yes NonPoss => "него" ;
    PF Inst No NonPoss => "им" ;
    PF Inst Yes NonPoss => "ним" ;
    PF (Prepos _) _ NonPoss => "нём" ;
    PF _ _ (Poss  _) => "его"
    } ;
    g = PGen Masc ;
    n = Sg ;
    p = P3 ;
    pron = True
  } ;

oper pronOna: Pronoun =
  { s = table {
    PF Nom _ NonPoss => "она" ;
    PF Gen No  NonPoss => "её" ;
    PF Gen Yes NonPoss => "неё"  ;
    PF Dat No NonPoss => "ей" ;
    PF Dat Yes NonPoss => "ней" ;
    PF Acc No NonPoss => "её" ;
    PF Acc Yes NonPoss => "неё" ;
    PF Inst No NonPoss => "ей" ;
    PF Inst Yes NonPoss => "ней" ;
    PF (Prepos _) _ NonPoss => "ней" ;
    PF _ _ (Poss  _ ) => "её"
    } ;
    g = PGen Fem ;
    n = Sg ;
    p = P3 ;
    pron = True
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

oper pronOni: Pronoun =
  { s = table {
    PF Nom _ NonPoss => "они" ;
    PF Gen No NonPoss => "их" ;
    PF Gen Yes NonPoss => "них" ;
    PF Dat No NonPoss => "им" ;
    PF Dat Yes NonPoss => "ним" ;
    PF Acc No NonPoss => "их" ;
    PF Acc Yes NonPoss => "них" ;
    PF Inst No NonPoss => "ими" ;
    PF Inst Yes NonPoss => "ними" ;
    PF (Prepos _) _ NonPoss => "них" ;
    PF _ _ (Poss  _) => "их"
    } ;
    g = PNoGen ;
    n = Pl ;
    p = P3 ;
    pron = True
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
oper
    CommNoun = {s : SubstForm => Str ; g : Gender ; anim : Animacy } ;
    SubstFormDecl = SS1 SubstForm ;

oper nullEndInAnimateDeclStul: Str -> CommNoun =  \brat ->
  {s  =  table
      { SF Sg Nom =>  brat ;
        SF Sg Gen => brat+"а" ;
        SF Sg Dat => brat+"у" ;
        SF Sg Acc => brat +"а";
        SF Sg Inst => brat+"ом" ;
        SF Sg (Prepos _) => brat+"е" ;
        SF Pl Nom => brat+"ья" ;
        SF Pl Gen => brat+"ьев" ;
        SF Pl Dat => brat+"ьям" ;
        SF Pl Acc => brat +"ьев";
        SF Pl Inst => brat+"ьями" ;
        SF Pl (Prepos _) => brat+"ьяах"
    } ;
    g = Masc   ; anim = Inanimate
  } ;

oper nullEndAnimateDeclBrat: Str -> CommNoun =  \brat ->
  {s  =  table
      { SF Sg Nom =>  brat ;
        SF Sg Gen => brat+"а" ;
        SF Sg Dat => brat+"у" ;
        SF Sg Acc => brat +"а";
        SF Sg Inst => brat+"ом" ;
       SF Sg (Prepos _) => brat+"е" ;
        SF Pl Nom => brat+"ья" ;
        SF Pl Gen => brat+"ьев" ;
        SF Pl Dat => brat+"ьям" ;
        SF Pl Acc => brat +"ьев";
        SF Pl Inst => brat+"ьями" ;
        SF Pl (Prepos _) => brat+"ьяах"
    } ;
    g = Masc   ; anim = Animate
  } ;

--oper obezbolivauchee : CommNoun = eeEndInAnimateDecl "обезболивающ" ;

oper eeEndInAnimateDecl: Str -> CommNoun =  \obezbolivauch ->
  {  s  =  table
      { SF Sg Nom =>  obezbolivauch +"ее";
        SF Sg Gen => obezbolivauch+"его" ;
        SF Sg Dat => obezbolivauch+"ему" ;
        SF Sg Acc => obezbolivauch +"ее";
        SF Sg Inst => obezbolivauch+"им" ;
        SF Sg (Prepos _) => obezbolivauch+"ем" ;
        SF Pl Nom => obezbolivauch+"ие" ;
        SF Pl Gen => obezbolivauch+"их" ;
        SF Pl Dat => obezbolivauch+"им" ;
        SF Pl Acc => obezbolivauch+"ие" ;
        SF Pl Inst => obezbolivauch+"ими" ;
        SF Pl (Prepos _) => obezbolivauch+"их"
    } ;
    g = Neut  ; anim = Inanimate
  } ;

oper oeEndInAnimateDecl: Str -> CommNoun =  \snotvorn ->
  {  s  =  table
      { SF Sg Nom =>  snotvorn +"ое";
        SF Sg Gen => snotvorn+"ого" ;
        SF Sg Dat => snotvorn+"ому" ;
        SF Sg Acc => snotvorn +"ое";
        SF Sg Inst => snotvorn+"ым" ;
        SF Sg (Prepos _) => snotvorn+"ом" ;
        SF Pl Nom => snotvorn+"ые" ;
        SF Pl Gen => snotvorn+"ых" ;
        SF Pl Dat => snotvorn+"ым" ;
        SF Pl Acc => snotvorn+"ые" ;
        SF Pl Inst => snotvorn+"ыми" ;
        SF Pl (Prepos _) => snotvorn+"ых"
    } ;
    g = Neut  ; anim = Inanimate
  } ;

oper oeEndAnimateDecl: Str -> CommNoun =  \snotvorn ->
  {  s  =  table
      { SF Sg Nom =>  snotvorn +"ое";
        SF Sg Gen => snotvorn+"ого" ;
        SF Sg Dat => snotvorn+"ому" ;
        SF Sg Acc => snotvorn +"ое";
        SF Sg Inst => snotvorn+"ым" ;
        SF Sg (Prepos _) => snotvorn+"ом" ;
        SF Pl Nom => snotvorn+"ые" ;
        SF Pl Gen => snotvorn+"ых" ;
        SF Pl Dat => snotvorn+"ым" ;
        SF Pl Acc => snotvorn+"ые" ;
        SF Pl Inst => snotvorn+"ыми" ;
        SF Pl (Prepos _) => snotvorn+"ых"
    } ;
    g = Neut  ; anim = Animate
  } ;

oper irregPl_StemInAnimateDecl: Str -> CommNoun =  \derev ->
  { s  =  table
      { SF Sg Nom =>  derev+"о" ;
        SF Sg Gen => derev+"а" ;
        SF Sg Dat => derev+"у" ;
        SF Sg Acc => derev +"о";
        SF Sg Inst => derev+"ом" ;
        SF Sg (Prepos _) => derev+"е" ;
        SF Pl Nom => derev+"ья" ;
        SF Pl Gen => derev+"ьев" ;
        SF Pl Dat => derev+"ьям" ;
        SF Pl Acc => derev +"ья" ;
        SF Pl Inst => derev+"ьями" ;
        SF Pl (Prepos _) => derev+"ьяах"
    } ;
    g = Masc   ; anim = Inanimate
  } ;



oper LittleAnimalDecl: Str -> CommNoun =  \reb ->
  {s  =  table
      { SF Sg Nom => reb+"ёноk" ;
        SF Sg Gen => reb+"ёнkа" ;
        SF Sg Dat => reb+"ёнkу" ;
        SF Sg Acc => reb+"ёнkа" ;
        SF Sg Inst => reb+"ёнkом" ;
        SF Sg (Prepos _) => reb+"ёнkе" ;
        SF Pl Nom => reb+"ята" ;
        SF Pl Gen => reb+"ят" ;
        SF Pl Dat => reb+"ятам" ;
        SF Pl Acc => reb+"ят" ;
        SF Pl Inst => reb+"ятами" ;
        SF Pl (Prepos _) => reb+"ятах"
    } ;
    g = Masc   ; anim = Animate
   } ;


oper aEndG_K_KH_Decl: Str -> CommNoun =  \nog ->
{ s  =  table  {
      SF Sg Nom =>  nog+"а" ;
      SF Sg Gen => nog+"и" ;
      SF Sg Dat => nog+"е" ;
      SF Sg Acc => nog+"у" ;
      SF Sg Inst => nog+"ой" ;
      SF Sg (Prepos _) => nog+"е" ;
      SF Pl Nom => nog+"и" ;
      SF Pl Gen => nog ;
      SF Pl Dat => nog+"ам" ;
      SF Pl  Acc => nog+ "и" ;
      SF Pl Inst => nog+"ами" ;
      SF Pl (Prepos _) => nog+"ах"
    } ;
    g = Fem  ; anim = Inanimate
} ;


oper kg_oEnd_SgDecl: Str -> CommNoun =  \mnog ->
{ s  =  table  {
      SF _ Nom =>  mnog+"о" ;
      SF _ Gen => mnog +"их";
      SF _ Dat => mnog+"им" ;
      SF _ Acc => mnog+"о" ;
      SF _ Inst => mnog+"ими" ;
      SF _ (Prepos _) => mnog+"их"
    } ;
    g = Neut   ; anim = Inanimate
} ;

oper oEnd_PlDecl: Str -> CommNoun =  \menshinstv ->
  { s  =  table  {
      SF _ Nom =>  menshinstv+"а" ;
      SF _ Gen => menshinstv;
      SF _ Dat => menshinstv+"ам" ;
      SF _ Acc => menshinstv+"ва" ;
      SF _ Inst => menshinstv+"ами" ;
      SF _ (Prepos _) => menshinstv+"вах"
    } ;
    g = Neut   ; anim = Inanimate
} ;

oper oEnd_SgDecl: Str -> CommNoun =  \bolshinstv ->
 {s  =  table  {
      SF _ Nom =>  bolshinstv+"о" ;
      SF _ Gen => bolshinstv+"а" ;
      SF _ Dat => bolshinstv+"у" ;
      SF _ Acc => bolshinstv+"о" ;
      SF _ Inst => bolshinstv+"ом" ;
      SF _ (Prepos _) => bolshinstv+"е"
    } ;
    g = Neut   ; anim = Inanimate
} ;

-- Note: Now we consider only the plural form of the pronoun "все" (all)
-- treated as an adjective (see AllDetPl definition).
-- The meaning "entire" is not considered, which allows us to form
-- the pronoun-adjective from the substantive form below:

oper eEnd_Decl: Str -> CommNoun =  \vs ->
{ s  =  table  {
      SF Sg Nom =>  vs+"е" ;
      SF Sg Gen => vs+"ех" ;
      SF Sg Dat => vs+"ем" ;
      SF Sg Acc => vs+"ех" ;
      SF Sg Inst => vs+"еми" ;
      SF Sg (Prepos _) => vs+"ех" ;
      SF Pl Nom => vs+"е" ;
      SF Pl Gen => vs +"ех";
      SF Pl Dat => vs+"ем" ;
      SF Pl  Acc => vs+ "ех" ;
      SF Pl Inst => vs+"еми" ;
      SF Pl (Prepos _) => vs+"ех"
    } ;
    g = Neut  ; anim = Inanimate
} ;

--mkAdjCommNounMascInanim: Adjective -> CommNoun =
--\a ->
--{ s = table {
--      SF Sg Nom =>  a.s ! AF Nom Inanimate (ASg Masc) ;
--      SF Sg Gen => a.s ! AF Gen Inanimate (ASg Masc) ;
--      SF Sg Dat => a.s ! AF Dat Inanimate (ASg Masc) ;
--      SF Sg Acc => a.s ! AF Acc Inanimate (ASg Masc) ;
--      SF Sg Inst => a.s ! AF Inst Inanimate (ASg Masc) ;
--      SF Sg (Prepos _) => a.s ! AF Prepos Inanimate (ASg Masc) ;
--      SF Pl Nom => a.s ! AF Nom Inanimate APl ;
--      SF Pl Gen => a.s ! AF Gen Inanimate APl;
--      SF Pl Dat => a.s ! AF Dat Inanimate APl ;
--      SF Pl  Acc => a.s ! AF Acc Inanimate APl ;
--      SF Pl Inst => a.s ! AF Inst Inanimate APl ;
--      SF Pl (Prepos _) => a.s ! AF Prepos Inanimate APl;
--  };
-- g = Masc ;
-- anim = Inanimate
--};
----2 Adjectives
--
---- Type Adjective only has positive degree while AdjDegr type
---- includes also comparative and superlative forms.
---- The later entries can be converted into the former using
---- "extAdjective" operation defined in the syntax module
---- and vice verca using "mkAdjDeg" operation.
--
--oper
--   adjInvar: Str -> Adjective = \s -> { s = \\af => s };
--
   kazhdujDet: Adjective = uy_j_EndDecl "кажд" ;
   samuj: Adjective = uy_j_EndDecl "сам" ;
--   lubojDet: Adjective = uy_oj_EndDecl "люб" ;
--   drugojDet: Adjective = uy_oj_EndDecl "друг" ;
--   glaznoj: Adjective = uy_oj_EndDecl "глазн" ;
   kotorujDet: Adjective = uy_j_EndDecl "котор";
   nekotorujDet: Adjective = uy_j_EndDecl "некотор";
   takoj: Adjective = i_oj_EndDecl "так" [];
--   kakojNibudDet: Adjective = i_oj_EndDecl "как" "-нибудь";
--   kakojDet: Adjective = i_oj_EndDecl "как" [];
--   nikakojDet: Adjective = i_oj_EndDecl "никак" [];
   bolshinstvoSgDet: Adjective  = extAdjFromSubst (oEnd_SgDecl "большинств");
   mnogoSgDet: Adjective  = extAdjFromSubst (kg_oEnd_SgDecl "мног");
   skolkoSgDet: Adjective  = extAdjFromSubst (kg_oEnd_SgDecl "скольк");

  bolshinstvoPlDet: Adjective  = extAdjFromSubst (oEnd_PlDecl "большинств");

   vseDetPl: Adjective   =  extAdjFromSubst (eEnd_Decl "вс") ;
   extAdjFromSubst: CommNoun -> Adjective = \ vse ->
    {s = \\af => vse.s ! SF (numAF af) (caseAF af) } ;

oper
  AdjDegr : Type = {s : Degree => AdjForm => Str} ;

oper mkAdjDeg: Adjective -> Str -> AdjDegr = \adj, s ->
  {  s = table
           {
              Posit => adj.s ;
              Compar => \\af => s ;
              Superl => \\af =>  samuj.s !af ++ adj.s ! af
           }
  };

--oper uzhasnuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "ужасн") "ужаснее";
--oper schastlivyuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "счастлив") "счастливее";
--oper deshevuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "дешев") "дешевле";
--oper staruj: AdjDegr = mkAdjDeg (uy_j_EndDecl "стар") "старше";

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

--oper shi_j_EndDecl : Str -> Adjective = \s ->{s = table {
--      AF Nom _ (ASg Masc) => s+"ий";
--      AF Nom _ (ASg Fem) => s+"ая";
--      AF Nom _ (ASg Neut) => s+"ое";
--      AF Nom _ APl => s+"ие";
--      AF Acc  Inanimate (ASg Masc) => s+"ий";
--      AF Acc  Animate (ASg Masc) => s+"его";
--      AF Acc  _ (ASg Fem) => s+"ую";
--      AF Acc  _ (ASg Neut) => s+"ое";
--      AF Acc  Inanimate APl => s+"ие";
--      AF Acc  Animate APl => s+"их";
--      AF Gen  _ (ASg Masc) => s+"его";
--      AF Gen  _ (ASg Fem) => s+"ей";
--      AF Gen  _ (ASg Neut) => s+"его";
--      AF Gen  _ APl => s+"их";
--      AF Inst _ (ASg Masc) => s+"им";
--      AF Inst _ (ASg Fem) => s+"ей";
--      AF Inst _ (ASg Neut) => s+"им";
--      AF Inst _ APl => s+"ими";
--      AF Dat  _ (ASg Masc) => s+"ему";
--      AF Dat  _ (ASg Fem) => s+"ей";
--      AF Dat  _ (ASg Neut) => s+"ему";
--      AF Dat  _ APl => s+"им";
--      AF (Prepos _) _ (ASg Masc) => s+"ем";
--      AF (Prepos _) _ (ASg Fem) => s+"ей";
--      AF (Prepos _) _ (ASg Neut) => s+"ем";
--      AF (Prepos _) _ APl => s+"их";
--      AdvF => s +  "о"
--      }
--  } ;

--oper indijskij: Adjective = ij_EndK_G_KH_Decl "индийск" ;
--oper francuzskij: Adjective = ij_EndK_G_KH_Decl "французск" ;
--oper anglijskij: Adjective = ij_EndK_G_KH_Decl "английск" ;
--oper datskij: Adjective = ij_EndK_G_KH_Decl "датск" ;
--oper russkij: Adjective = ij_EndK_G_KH_Decl "русск" ;
--oper italyanskij: Adjective = ij_EndK_G_KH_Decl "итальянск" ;
--oper yaponskij: Adjective = ij_EndK_G_KH_Decl "японск" ;
--oper malenkij: AdjDegr = mkAdjDeg  (ij_EndK_G_KH_Decl "маленьк") "меньше" ;
--oper vusokij: AdjDegr = mkAdjDeg (ij_EndK_G_KH_Decl "высок") "выше";

oper ij_EndK_G_KH_Decl : Str -> Adjective = \s ->{s = table {
    AF Nom _ (ASg Masc) => s+"ий";
    AF Nom _ (ASg Fem) => s+"ая";
    AF Nom _ (ASg Neut) => s+"ое";
    AF Nom _ APl => s+"ие";
    AF Acc Animate (ASg Masc) => s+"ого";
    AF Acc Inanimate (ASg Masc) => s+"ий";
    AF Acc  _ (ASg Fem) => s+"ую";
    AF Acc  _ (ASg Neut) => s+"ое";
    AF Acc  Animate APl => s+"их";
    AF Acc  Inanimate APl => s+"ие";
    AF Gen  _ (ASg Masc) => s+"ого";
    AF Gen  _ (ASg Fem) => s+"ой";
    AF Gen  _ (ASg Neut) => s+"ого";
    AF Gen  _ APl => s+"их";
    AF Inst _ (ASg Masc) => s+"им";
    AF Inst _ (ASg Fem) => s+"ой";
    AF Inst _ (ASg Neut) => s+"им";
    AF Inst _ APl => s+"ими";
    AF Dat  _ (ASg Masc) => s+"ому";
    AF Dat  _ (ASg Fem) => s+"ой";
    AF Dat  _ (ASg Neut) => s+"ому";
    AF Dat  _ APl => s+"им";
    AF (Prepos _) _ (ASg Masc) => s+"ом";
    AF (Prepos _) _ (ASg Fem) => s+"ой";
    AF (Prepos _) _ (ASg Neut) => s+"ом";
    AF (Prepos _) _ APl => s+"их";
    AFShort (ASg Masc) => s;
    AFShort (ASg Fem)  => s + "а";
    AFShort (ASg Neut) => s + "о" ;
    AFShort APl        => s + "и";
     AdvF => s +  "о"
    }
  } ;

oper shij_End_Decl : Str -> Adjective = \s ->{s = table {
    AF Nom _ (ASg Masc) => s+"ий";
    AF Nom _ (ASg Fem) => s+"ая";
    AF Nom _ (ASg Neut) => s+"ее";
    AF Nom _ APl => s+"ие";
    AF Acc Animate (ASg Masc) => s+"его";
    AF Acc Inanimate (ASg Masc) => s+"ий";
    AF Acc  _ (ASg Fem) => s+"ую";
    AF Acc  _ (ASg Neut) => s+"ее";
    AF Acc  Animate APl => s+"их";
    AF Acc  Inanimate APl => s+"ие";
    AF Gen  _ (ASg Masc) => s+"его";
    AF Gen  _ (ASg Fem) => s+"ей";
    AF Gen  _ (ASg Neut) => s+"его";
    AF Gen  _ APl => s+"их";
    AF Inst _ (ASg Masc) => s+"им";
    AF Inst _ (ASg Fem) => s+"ей";
    AF Inst _ (ASg Neut) => s+"им";
    AF Inst _ APl => s+"ими";
    AF Dat  _ (ASg Masc) => s+"ему";
    AF Dat  _ (ASg Fem) => s+"ей";
    AF Dat  _ (ASg Neut) => s+"ему";
    AF Dat  _ APl => s+"им";
    AF (Prepos _) _ (ASg Masc) => s+"ем";
    AF (Prepos _) _ (ASg Fem) => s+"ей";
    AF (Prepos _) _ (ASg Neut) => s+"ем";
    AF (Prepos _) _ APl => s+"их";
    AFShort (ASg Masc) => s;
    AFShort (ASg Fem)  => s + "а";
    AFShort (ASg Neut) => s + "е" ;
    AFShort APl        => s + "и";
     AdvF => s +  "о"
    }
  } ;

--oper bolshoj: AdjDegr = mkAdjDeg  (i_oj_EndDecl "больш" []) "больше";
--oper dorogoj: AdjDegr = mkAdjDeg  (i_oj_EndDecl "дорог" []) "дороже";

oper i_oj_EndDecl : Str -> Str -> Adjective = \s, chastica ->{s = table {
    AF Nom _ (ASg Masc) => s+"ой" + chastica ;
    AF Nom _ (ASg Fem) => s+"ая"+ chastica ;
    AF Nom _ (ASg Neut) => s+"ое"+ chastica ;
    AF Nom _ APl => s+"ие"+ chastica ;
    AF Acc  Animate (ASg Masc) => s+"ого"+ chastica ;
    AF Acc  Inanimate (ASg Masc) => s+"ой"+ chastica ;
    AF Acc  _ (ASg Fem) => s+"ую"+ chastica ;
    AF Acc  _ (ASg Neut) => s+"ое"+ chastica ;
    AF Acc Animate APl => s+"их"+ chastica ;
    AF Acc Inanimate APl => s+"ие"+ chastica ;
    AF Gen _ (ASg Masc) => s+"ого"+ chastica ;
    AF Gen _ (ASg Fem) => s+"ой"+ chastica ;
    AF Gen _ (ASg Neut) => s+"ого"+ chastica ;
    AF Gen _ APl => s+"их"+ chastica ;
    AF Inst _ (ASg Masc) => s+"им"+ chastica ;
     AF Inst _ (ASg Fem) => s+"ой"+ chastica ;
    AF Inst _ (ASg Neut) => s+"им"+ chastica ;
    AF Inst _ APl => s+"ими"+ chastica ;
    AF Dat _ (ASg Masc) => s+"ому"+ chastica ;
    AF Dat _ (ASg Fem) => s+"ой"+ chastica ;
    AF Dat _ (ASg Neut) => s+"ому"+ chastica ;
    AF Dat _ APl => s+"им"+ chastica ;
    AF (Prepos _) _ (ASg Masc) => s+"ом"+ chastica ;
    AF (Prepos _) _ (ASg Fem) => s+"ой"+ chastica ;
    AF (Prepos _) _ (ASg Neut) => s+"ом"+ chastica ;
    AF (Prepos _) _ APl => s+"их" + chastica;
    AFShort (ASg Masc) => s;
    AFShort (ASg Fem)  => s + "а";
    AFShort (ASg Neut) => s + "о" ;
    AFShort APl        => s + "и";
     AdvF => s +  "о"
    }
  } ;
--oper molodoj: AdjDegr = mkAdjDeg (uy_oj_EndDecl "молод") "моложе";

oper uy_oj_EndDecl : Str -> Adjective = \s ->{s = table {
    AF Nom _ (ASg Masc) => s+"ой";
    AF Nom _ (ASg Fem) => s+"ая";
    AF Nom _ (ASg Neut) => s+"ое";
    AF Nom _ APl => s+"ые";
    AF Acc Animate (ASg Masc) => s+"ого";
    AF Acc Inanimate (ASg Masc) => s+"ой";
    AF Acc _ (ASg Fem) => s+"ую";
    AF Acc _ (ASg Neut) => s+"ое";
    AF Acc Animate APl => s+"ых";
    AF Acc Inanimate APl => s+"ые";
    AF Gen _ (ASg Masc) => s+"ого";
    AF Gen _ (ASg Fem) => s+"ой";
    AF Gen _ (ASg Neut) => s+"ого";
    AF Gen _ APl => s+"ых";
    AF Inst _ (ASg Masc) => s+"ым";
    AF Inst _ (ASg Fem) => s+"ой";
    AF Inst _ (ASg Neut) => s+"ым";
    AF Inst _ APl => s+"ыми";
    AF Dat _ (ASg Masc) => s+"ому";
    AF Dat _ (ASg Fem) => s+"ой";
    AF Dat _ (ASg Neut) => s+"ому";
    AF Dat _ APl => s+"ым";
    AF (Prepos _) _ (ASg Masc) => s+"ом";
    AF (Prepos _) _ (ASg Fem) => s+"ой";
    AF (Prepos _) _ (ASg Neut) => s+"ом";
    AF (Prepos _) _ APl => s+"ых";
    AFShort (ASg Masc) => s;
    AFShort (ASg Fem)  => s + "а";
    AFShort (ASg Neut) => s + "о" ;
    AFShort APl        => s + "ы";
    AdvF => s +  "о"
    }
  } ;

--oper prostuzhen: Adjective = shortDecl1 "простужен" ;
--oper beremenen: Adjective = shortDecl "беремен" ;
--oper need: Adjective = shortDecl "нуж" ;
--oper shortDecl1 : Str -> Adjective = \s ->{s = table {
--    AF _ _ (ASg Masc) => s;
--    AF _ _ (ASg Fem) => s+"а";
--    AF _ _ (ASg Neut) => s+"о";
--    AF _ _ APl => s+"ы" ;
--    AdvF => s +  "о"
--    }
--  } ;
--oper shortDecl : Str -> Adjective = \s ->{s = table {
--    AF _ _ (ASg Masc) => s +"ен";
--    AF _ _ (ASg Fem) => s+"на";
--    AF _ _ (ASg Neut) => s+"но";
--    AF _ _ APl => s+"ны" ;
--    AdvF => s +  "о"
--    }--  } ;
--
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
--{s = \\c => cn.s! (SF Sg c); g=cn.g; anim = cn.anim };
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
