--1 A Simple Russian Resource Morphology 
--
-- Aarne Ranta, Janna Khegai 2003
--
-- This resource morphology contains definitions of the lexical entries 
-- needed in the resource syntax. 
-- It moreover contains copies of the most usual inflectional patterns.
--
-- We use the parameter types and word classes defined for morphology.
--
-- Note: mkPassive operation is at the moment incorrect. Low-level ending-analysis
-- is needed to fix the operation. 

resource Morpho = Types ** open (Predef=Predef), Prelude in {
flags  coding=utf8 ;

--2 Personal (together with possesive) pronouns.
oper pronYa: Pronoun = 
  { s = table {
    PF Nom _ NonPoss  => "я"  ; 
    PF Gen _ NonPoss => "меня" ;
    PF Dat _  NonPoss => "мне" ; 
    PF Acc _  NonPoss => "меня" ; 
    PF Inst _ NonPoss => "мной" ;
    PF Prepos _ NonPoss => "мне" ;
    PF Nom _ (Poss  (ASg Masc)) => "мой"  ; 
    PF Gen _ (Poss  (ASg Masc)) => "моего" ;
    PF Dat _  (Poss  (ASg Masc)) => "моему" ; 
    PF Acc _ (Poss  (ASg Masc)) => "моего" ; 
    PF Inst _ (Poss  (ASg Masc)) => "моим" ;
    PF Prepos _ (Poss  (ASg Masc)) => "моём" ; 
    PF Nom _ (Poss  (ASg Fem)) => "моя"  ; 
    PF Gen _ (Poss (ASg Fem)) => "моей" ;
    PF Dat _  (Poss  (ASg Fem)) => "моей" ; 
    PF Acc _ (Poss  (ASg Fem)) => "мою" ; 
    PF Inst _ (Poss (ASg Fem)) => "моею" ;
    PF Prepos _ (Poss (ASg Fem)) => "моей" ; 
    PF Nom _ (Poss  (ASg Neut)) => "моё"  ; 
    PF Gen _ (Poss  (ASg Neut)) => "моего" ;
    PF Dat _  (Poss  (ASg Neut)) => "моему" ; 
    PF Acc _ (Poss  (ASg Neut)) => "моё" ; 
    PF Inst _ (Poss  (ASg Neut)) => "моим" ;
    PF Prepos _ (Poss  (ASg Neut)) => "моём" ; 
    PF Nom _ (Poss APl)  => "мои"  ; 
    PF Gen _ (Poss APl)=> "моих" ;
    PF Dat _  (Poss APl)  => "моим" ; 
    PF Acc _ (Poss APl)  => "моих" ; 
    PF Inst _ (Poss APl) => "моими" ;
    PF Prepos _ (Poss APl) => "моих"  
    } ;
    g = PNoGen ;
    n = Sg ;
    p = P1  ;
    pron = True
  } ;

oper pronTu: Pronoun = 
  { s = table {
    PF Nom _ NonPoss  => "ты" ; 
    PF Gen _ NonPoss  => "тебя" ;
    PF Dat _ NonPoss  => "тебе" ; 
    PF Acc _ NonPoss  => "тебя"  ; 
    PF Inst _ NonPoss  => "тобой" ;
    PF Prepos _ NonPoss  => ["о тебе"]  ;
    PF Nom _ (Poss  (ASg Masc)) => "твой"  ; 
    PF Gen _ (Poss (ASg Masc)) => "твоего" ;
    PF Dat _  (Poss  (ASg Masc)) => "твоему" ; 
    PF Acc _ (Poss  (ASg Masc)) => "твоего" ; 
    PF Inst _ (Poss (ASg Masc)) => "твоим" ;
    PF Prepos _ (Poss (ASg Masc)) => "твоём" ; 
    PF Nom _ (Poss  (ASg Fem)) => "твоя"  ; 
    PF Gen _ (Poss (ASg Fem)) => "твоей" ;
    PF Dat _  (Poss  (ASg Fem)) => "твоей" ; 
    PF Acc _ (Poss  (ASg Fem)) => "твою" ; 
    PF Inst _ (Poss (ASg Fem)) => "твоею" ;
    PF Prepos _ (Poss (ASg Fem)) => "твоей" ; 
    PF Nom _ (Poss  (ASg Neut)) => "твоё"  ; 
    PF Gen _ (Poss  (ASg Neut)) => "твоего" ;
    PF Dat _  (Poss  (ASg Neut)) => "твоему" ; 
    PF Acc _ (Poss  (ASg Neut)) => "твоё" ; 
    PF Inst _ (Poss  (ASg Neut)) => "твоим" ;
    PF Prepos _ (Poss  (ASg Neut)) => "твоём" ; 
    PF Nom _ (Poss APl)  => "твои"  ; 
    PF Gen _ (Poss APl)=> "твоих" ;
    PF Dat _  (Poss APl)  => "твоим" ; 
    PF Acc _ (Poss APl)  => "твоих" ; 
    PF Inst _ (Poss APl) => "твоими" ;
    PF Prepos _ (Poss APl) => "твоих"
    } ;
    g = PNoGen ;
    n = Sg ;
    p = P2 ;
    pron = True 
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
    PF Prepos _ NonPoss => ["о нем"] ;
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
    PF Prepos _ NonPoss => ["о ней"] ;
    PF _ _ (Poss  _ ) => "её"  

    } ;
    g = PGen Fem ;
    n = Sg ;
    p = P3 ;
    pron = True 
  } ;

oper pronMu: Pronoun = 
  { s = table {
    PF Nom _ NonPoss => "мы"  ; 
    PF Gen _ NonPoss => "нас" ;
    PF Dat _ NonPoss => "нам" ; 
    PF Acc _ NonPoss => "нас" ; 
    PF Inst _ NonPoss => "нами" ;
    PF Prepos _ NonPoss => ["о нас"] ;
    PF Nom _ ((Poss  (ASg Masc))) => "наш"  ; 
    PF Gen _ (Poss (ASg Masc)) => "нашего" ;
    PF Dat _  ((Poss  (ASg Masc))) => "нашему" ; 
    PF Acc _ ((Poss  (ASg Masc))) => "нашего" ; 
    PF Inst _ (Poss (ASg Masc)) => "нашим" ;
    PF Prepos _ (Poss (ASg Masc)) => "нашем" ; 
    PF Nom _ (Poss  (ASg Fem)) => "наша"  ; 
    PF Gen _ (Poss (ASg Fem)) => "нашей" ;
    PF Dat _  (Poss  (ASg Fem)) => "нашей" ; 
    PF Acc _ (Poss  (ASg Fem)) => "нашу" ; 
    PF Inst _ (Poss (ASg Fem)) => "нашею" ;
    PF Prepos _ (Poss (ASg Fem)) => "нашей" ; 
    PF Nom _ (Poss  (ASg Neut)) => "наше"  ; 
    PF Gen _ (Poss  (ASg Neut)) => "нашего" ;
    PF Dat _  (Poss  (ASg Neut)) => "нашему" ; 
    PF Acc _ (Poss  (ASg Neut)) => "наше" ; 
    PF Inst _ (Poss  (ASg Neut)) => "нашим" ;
    PF Prepos _ (Poss  (ASg Neut)) => "нашем" ; 
    PF Nom _ (Poss APl)  => "наши"  ; 
    PF Gen _ (Poss APl)=> "наших" ;
    PF Dat _  (Poss APl)  => "нашим" ; 
    PF Acc _ (Poss APl)  => "наших" ; 
    PF Inst _ (Poss APl) => "нашими" ;
    PF Prepos _ (Poss APl) => "наших"
    };
    g = PNoGen ;
    n = Pl ;
    p = P1 ;
    pron = True 
  } ;

oper pronVu: Pronoun = 
  { s = table {
    PF Nom _ NonPoss => "вы" ; 
    PF Gen _ NonPoss => "вас" ;
    PF Dat _ NonPoss => "вам" ; 
    PF Acc _ NonPoss => "вас" ; 
    PF Inst _ NonPoss => "вами" ;
    PF Prepos _ NonPoss => "вас" ;
    PF Nom _ (Poss  (ASg Masc)) => "ваш"  ; 
    PF Gen _ (Poss  (ASg Masc)) => "вашего" ;
    PF Dat _  (Poss  (ASg Masc)) => "вашему" ; 
    PF Acc _ (Poss  (ASg Masc)) => "вашего" ; 
    PF Inst _ (Poss  (ASg Masc)) => "вашим" ;
    PF Prepos _ (Poss  (ASg Masc)) => "вашем" ; 
    PF Nom _ (Poss  (ASg Fem)) => "ваша"  ; 
    PF Gen _ (Poss (ASg Fem)) => "вашей" ;
    PF Dat _  (Poss  (ASg Fem)) => "вашей" ; 
    PF Acc _ (Poss  (ASg Fem)) => "вашу" ; 
    PF Inst _ (Poss (ASg Fem)) => "вашею" ;
    PF Prepos _ (Poss (ASg Fem)) => "вашей" ; 
    PF Nom _ (Poss  (ASg Neut)) => "ваше"  ; 
    PF Gen _ (Poss  (ASg Neut)) => "вашего" ;
    PF Dat _  (Poss  (ASg Neut)) => "вашему" ; 
    PF Acc _ (Poss  (ASg Neut)) => "ваше" ; 
    PF Inst _ (Poss  (ASg Neut)) => "вашим" ;
    PF Prepos _ (Poss  (ASg Neut)) => "вашем" ; 
    PF Nom _ (Poss APl)  => "ваши"  ; 
    PF Gen _ (Poss APl)=> "ваших" ;
    PF Dat _  (Poss APl)  => "вашим" ; 
    PF Acc _ (Poss APl)  => "ваших" ; 
    PF Inst _ (Poss APl) => "вашими" ;
    PF Prepos _ (Poss APl) => "ваших"
    };
    g = PNoGen ;
    n = Pl ;
    p = P2 ;
    pron = True 
  } ;

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
    PF Prepos _ NonPoss => ["о них"]  ;
    PF _ _ (Poss  _) => "их"
    } ;
    g = PNoGen ;
    n = Pl ;
    p = P3 ;
    pron = True 
  } ;

--2 Nouns

-- Help type SubstFormDecl is introduced to reduce repetition in 
-- the declination definitions. It allows us to define a declination type,
-- namely, the String component "s" of the CommNoun type
-- without any reference to the Gender parameter "g".

oper SubstFormDecl = SS1 SubstForm ;

oper muzhchina : CommNoun = (aEndAnimateDecl "мужчин") ** { g = Masc ; anim = Animate } ;
oper zhenchina : CommNoun = (aEndAnimateDecl "женщин") ** { g = Fem ; anim = Animate } ;
oper mama : CommNoun = (aEndAnimateDecl "мам")**{ g = Fem ; anim = Animate } ;
oper cena : CommNoun = (aEndAnimateDecl "цен") ** { g = Fem ; anim = Inanimate } ;

oper aEndAnimateDecl: Str -> SubstFormDecl =  \muzhchin ->
{s = table {
    SF Sg Nom =>  muzhchin+"а" ;
    SF Sg Gen => muzhchin+"ы" ;
    SF Sg Dat => muzhchin+"е" ;
    SF Sg Acc => muzhchin+"у" ;
    SF Sg Inst => muzhchin+"ой" ;
    SF Sg Prepos => muzhchin +"е" ;
    SF Pl Nom => muzhchin +"ы" ;
    SF Pl Gen => muzhchin ;
    SF Pl Dat => muzhchin+"ам" ;
    SF Pl Acc => muzhchin ;
    SF Pl Inst => muzhchin+"ами" ;
    SF Pl Prepos => muzhchin+"ах" } 
  } ;

oper stomatolog : CommNoun = nullEndAnimateDecl "стоматолог" ;
oper nullEndAnimateDecl: Str -> CommNoun =  \stomatolog ->
  {s  =  table  
      { SF Sg Nom =>  stomatolog ; 
        SF Sg Gen => stomatolog+"а" ;
        SF Sg Dat => stomatolog+"у" ; 
        SF Sg Acc => stomatolog +"а" ; 
        SF Sg Inst => stomatolog+"ом" ;
        SF Sg Prepos => stomatolog+"е" ; 
        SF Pl  Nom => stomatolog+"и" ; 
        SF Pl Gen => stomatolog+"ов" ;
        SF Pl Dat => stomatolog+"ам" ; 
        SF Pl Acc => stomatolog+"ов" ; 
        SF Pl Inst => stomatolog+"ами" ;
        SF Pl Prepos => stomatolog+"ах"    } ;
    g = Masc  ; anim = Animate 
  } ;

oper gripp : CommNoun = nullEndInAnimateDecl1 "грипп" ; 
oper bar : CommNoun = nullEndInAnimateDecl1 "бар" ;
oper telefon: CommNoun = nullEndInAnimateDecl1 "телефон" ;
oper restoran : CommNoun = nullEndInAnimateDecl1 "ресторан" ;

-- Note: Plural form of the "грипп" (influenza) is a bit doubious
-- However, according to http://starling.rinet.ru/morph.htm it exists.
-- so we also keep it.
oper nullEndInAnimateDecl1: Str -> CommNoun =  \gripp ->
  {s  =  table  
      { SF Sg Nom =>  gripp ; 
        SF Sg Gen => gripp+"а" ;
        SF Sg Dat => gripp+"у" ; 
        SF Sg Acc => gripp ; 
        SF Sg Inst => gripp+"ом" ;
        SF Sg Prepos => gripp+"е" ; 
        SF Pl Nom => gripp+"ы" ; 
        SF Pl Gen => gripp+"ов" ;
        SF Pl Dat => gripp+"ам" ; 
        SF Pl Acc => gripp +"ы"; 
        SF Pl Inst => gripp+"ами" ;
        SF Pl Prepos => gripp+"ах"
    } ;
    g = Masc   ; anim = Inanimate 

  } ;

oper adres: CommNoun = nullEndInAnimateDecl2 "адрес" ;
oper  dom : CommNoun = nullEndInAnimateDecl2 "дом" ;
oper  svet : CommNoun = nullEndInAnimateDecl2 "свет" ;
oper nullEndInAnimateDecl2: Str -> CommNoun =  \gripp ->
  {s  =  table  
      { SF Sg Nom =>  gripp ; 
        SF Sg Gen => gripp+"а" ;
        SF Sg Dat => gripp+"у" ; 
        SF Sg Acc => gripp ; 
        SF Sg Inst => gripp+"ом" ;
        SF Sg Prepos => gripp+"е" ; 
        SF Pl Nom => gripp+"а" ; 
        SF Pl Gen => gripp+"ов" ;
        SF Pl Dat => gripp+"ам" ; 
        SF Pl Acc => gripp +"а"; 
        SF Pl Inst => gripp+"ами" ;
        SF Pl Prepos => gripp+"ах"
    } ;
    g = Masc   ; anim = Inanimate 
  } ;

oper obezbolivauchee : CommNoun = eeEndInAnimateDecl "обезболивающ" ;
oper eeEndInAnimateDecl: Str -> CommNoun =  \obezbolivauch ->
  {  s  =  table  
      { SF Sg Nom =>  obezbolivauch +"ее"; 
        SF Sg Gen => obezbolivauch+"его" ;
        SF Sg Dat => obezbolivauch+"ему" ; 
        SF Sg Acc => obezbolivauch +"ее"; 
        SF Sg Inst => obezbolivauch+"им" ;
        SF Sg Prepos => obezbolivauch+"ем" ; 
        SF Pl Nom => obezbolivauch+"ие" ; 
        SF Pl Gen => obezbolivauch+"их" ;
        SF Pl Dat => obezbolivauch+"им" ; 
        SF Pl Acc => obezbolivauch+"ие" ; 
        SF Pl Inst => obezbolivauch+"ими" ;
        SF Pl Prepos => obezbolivauch+"их"
    } ;
    g = Neut  ; anim = Inanimate 
  } ; 

oper proizvedenie : CommNoun = eEndInAnimateDecl "произведени" ;
oper eEndInAnimateDecl: Str -> CommNoun =  \proizvedeni ->
  {  s  =  table  
      { SF Sg Nom =>  proizvedeni +"е"; 
        SF Sg Gen => proizvedeni+"я" ;
        SF Sg Dat => proizvedeni+"ю" ; 
        SF Sg Acc => proizvedeni +"е"; 
        SF Sg Inst => proizvedeni+"ем" ;
        SF Sg Prepos => proizvedeni+"и" ; 
        SF Pl Nom => proizvedeni+"я" ; 
        SF Pl Gen => proizvedeni+"й" ;
        SF Pl Dat => proizvedeni+"ям" ; 
        SF Pl Acc => proizvedeni+"я" ; 
        SF Pl Inst => proizvedeni+"ями" ;
        SF Pl Prepos => proizvedeni+"ях"
    } ;
    g = Neut  ; anim = Inanimate 
  } ;
oper chislo : CommNoun = oEndInAnimateDecl "числ"  ;
oper oEndInAnimateDecl: Str -> CommNoun = \chisl ->
  let { chis = Predef.tk 1 chisl ; ending = Predef.dp 3 chisl } in 
    oEndInAnimateDecl3  chisl (chis+"e"+ending) ;
oper oEndInAnimateDecl3: Str -> Str -> CommNoun =  \chisl, chisel ->
  {  s  =  table  
      { SF Sg Nom =>  chisl +"о"; 
        SF Sg Gen => chisl+"а" ;
        SF Sg Dat => chisl+"у" ; 
        SF Sg Acc => chisl +"о"; 
        SF Sg Inst => chisl+"ом" ;
        SF Sg Prepos => chisl+"е" ; 
        SF Pl Nom => chisl+"а" ; 
        SF Pl Gen => chisel;
        SF Pl Dat => chisl+"ам" ; 
        SF Pl Acc => chisl+"а" ; 
        SF Pl Inst => chisl+"ами" ;
        SF Pl Prepos => chisl+"ах"
    } ;
    g = Neut  ; anim = Inanimate 
  } ;

oper malaria : CommNoun = i_yaEndDecl "маляри" ;
oper i_yaEndDecl: Str -> CommNoun =  \malar ->
  { s  =  table  
      { SF Sg Nom =>  malar+"я" ; 
        SF Sg Gen => malar+"и" ;
        SF Sg Dat => malar+"и" ; 
        SF Sg Acc => malar+"ю" ; 
        SF Sg Inst => malar+"ей" ;
        SF Sg Prepos => malar+"и" ; 
        SF Pl  Nom => malar+"и" ; 
        SF Pl  Gen => malar+"й" ;
        SF Pl  Dat => malar+"ям" ; 
        SF Pl  Acc => malar+"и" ; 
        SF Pl  Inst => malar+"ями" ;
        SF Pl  Prepos => malar+"ях"
    } ;
    g = Fem   ; anim = Inanimate 
  } ;

oper bol : CommNoun = softSignEndDeclFem "бол" ;
oper nol : CommNoun = softSignEndDeclMasc "нол" ;
oper uroven : CommNoun = EN_softSignEndDeclMasc "уровен" ;
oper softSignEndDeclFem: Str -> CommNoun =  \bol ->
  {s  =  table  
      { SF Sg  Nom =>  bol+"ь" ; 
        SF Sg Gen => bol+"и" ;
        SF Sg Dat => bol+"и" ; 
        SF Sg Acc => bol+"ь" ;

        SF Sg Inst => bol+"ью" ;
        SF Sg Prepos => bol+"и" ; 
        SF Pl  Nom => bol+"и" ; 
        SF Pl Gen => bol+"ей" ;
        SF Pl Dat => bol+"ям" ; 
        SF Pl Acc => bol+"и" ; 
        SF Pl Inst => bol+"ями" ;
        SF Pl Prepos => bol+"ях"           
       } ;
    g = Fem   ; anim = Inanimate 
  } ;
oper softSignEndDeclMasc: Str -> CommNoun =  \nol ->
  {s  =  table  
      { SF Sg  Nom =>  nol+"ь" ; 
        SF Sg Gen => nol+"я" ;
        SF Sg Dat => nol+"ю" ; 
        SF Sg Acc => nol+"ь" ; 
        SF Sg Inst => nol+"ем" ;
        SF Sg Prepos => nol+"е" ; 
        SF Pl  Nom => nol+"и" ; 
        SF Pl Gen => nol+"ей" ;
        SF Pl Dat => nol+"ям" ; 
        SF Pl Acc => nol+"и" ; 
        SF Pl Inst => nol+"ями" ;
        SF Pl Prepos => nol+"ях"           
       } ;
    g = Masc ; anim = Inanimate 
  } ;

oper EN_softSignEndDeclMasc: Str -> CommNoun =  \rem ->
  {s  =  table  
      { SF Sg  Nom =>  rem+"ень" ; 
        SF Sg Gen => rem+"ня" ;
        SF Sg Dat => rem+"ню" ; 
        SF Sg Acc => rem+"ень" ; 
        SF Sg Inst => rem+"нем" ;
        SF Sg Prepos => rem+"не" ; 
        SF Pl  Nom => rem+"ни" ; 
        SF Pl Gen => rem+"ней" ;
        SF Pl Dat => rem+"ням" ; 
        SF Pl Acc => rem+"ни" ; 
        SF Pl Inst => rem+"нями" ;
        SF Pl Prepos => rem+"нях"           
       } ;
    g = Masc ; anim = Inanimate
  } ;

oper noga : CommNoun = aEndG_K_KH_Decl "ног" ;
oper dvojka : CommNoun = aEndG_K_KH_Decl "двойк" ;
oper aEndG_K_KH_Decl: Str -> CommNoun =  \nog ->
{ s  =  table  {
      SF Sg Nom =>  nog+"а" ; 
      SF Sg Gen => nog+"и" ;
      SF Sg Dat => nog+"е" ; 
      SF Sg Acc => nog+"у" ; 
      SF Sg Inst => nog+"ой" ;
      SF Sg Prepos => nog+"е" ;
      SF Pl Nom => nog+"и" ; 
      SF Pl Gen => nog ;
      SF Pl Dat => nog+"ам" ; 
      SF Pl  Acc => nog+ "и" ; 
      SF Pl Inst => nog+"ами" ;
      SF Pl Prepos => nog+"ах"
    } ;
    g = Fem  ; anim = Inanimate 
} ;

oper golova : CommNoun = aEndInanimateDecl "голов" ; 
oper mashina : CommNoun = aEndInanimateDecl "машин" ;
oper temperatura : CommNoun = aEndInanimateDecl "температур" ;
oper  edinica : CommNoun = ej_aEndInanimateDecl "единиц" ;

oper aEndInanimateDecl: Str -> CommNoun =  \golov ->
  { s  =  table  
      { SF Sg Nom =>  golov+"а" ; 
        SF Sg Gen => golov+"ы" ;
        SF Sg Dat => golov+"е" ; 
        SF Sg Acc => golov+"у" ; 
        SF Sg Inst => golov+"ой" ;
        SF Sg Prepos => golov+"е" ;
        SF Pl Nom => golov+"ы" ; 
        SF Pl Gen => golov ;
        SF Pl Dat => golov+"ам" ; 
        SF Pl Acc => golov+ "ы" ; 
        SF Pl Inst => golov+"ами" ;
        SF Pl Prepos => golov+"ах"
      } ;
    g = Fem    ; anim = Inanimate
  } ;
oper ej_aEndInanimateDecl: Str -> CommNoun =  \ediniz ->
  { s  =  table  
      { SF Sg Nom =>  ediniz+"а" ; 
        SF Sg Gen => ediniz+"ы" ;
        SF Sg Dat => ediniz+"е" ; 
        SF Sg Acc => ediniz+"у" ; 
        SF Sg Inst => ediniz+"ей" ;
        SF Sg Prepos => ediniz+"е" ;
        SF Pl Nom => ediniz+"ы" ; 
        SF Pl Gen => ediniz ;
        SF Pl Dat => ediniz+"ам" ; 
        SF Pl Acc => ediniz+ "ы" ; 
        SF Pl Inst => ediniz+"ами" ;
        SF Pl Prepos => ediniz+"ах"
      } ;
    g = Fem    ; anim = Inanimate
  } ;


oper dyadya : CommNoun = (yaEndAnimateDecl "дяд") ** {g = Masc; anim = Animate}  ;
oper yaEndAnimateDecl: Str -> SubstFormDecl =  \nyan ->
{s = table {
    SF Sg Nom => nyan + "я" ;    
    SF Sg Gen => nyan + "и" ;
    SF Sg Dat => nyan + "е" ;
    SF Sg Acc => nyan + "ю" ;
    SF Sg Inst => nyan + "ей" ;
    SF Sg Prepos => nyan + "е" ;
    SF Pl Nom => nyan + "и" ;
    SF Pl Gen => nyan + "ей" ;
    SF Pl Inst => nyan + "ями" ;
    SF Pl Prepos => nyan + "ях" ;
    SF Pl Dat => nyan + "ям" ;
    SF Pl Acc => nyan + "ей" 
    } 
  } ;

oper oEnd_Decl: Str -> CommNoun =  \bolshinstv ->
{ s  =  table  {
      SF Sg Nom =>  bolshinstv+"о" ; 
      SF Sg Gen => bolshinstv+"а" ;
      SF Sg Dat => bolshinstv+"у" ; 
      SF Sg Acc => bolshinstv+"о" ; 
      SF Sg Inst => bolshinstv+"ом" ;
      SF Sg Prepos => bolshinstv+"е" ;
      SF Pl Nom => bolshinstv+"а" ; 
      SF Pl Gen => bolshinstv ;
      SF Pl Dat => bolshinstv+"ам" ; 
      SF Pl  Acc => bolshinstv+ "а" ; 
      SF Pl Inst => bolshinstv+"ами" ;
      SF Pl Prepos => bolshinstv+"ах"
    } ;
    g = Neut   ; anim = Inanimate
} ;

oper oEnd_SgDecl: Str -> CommNoun =  \bolshinstv ->
{ s  =  table  {
      SF _ Nom =>  bolshinstv+"о" ; 
      SF _ Gen => bolshinstv+"а" ;
      SF _ Dat => bolshinstv+"у" ; 
      SF _ Acc => bolshinstv+"о" ; 
      SF _ Inst => bolshinstv+"ом" ;
      SF _ Prepos => bolshinstv+"е" 
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
      SF Sg Prepos => vs+"ех" ;
      SF Pl Nom => vs+"е" ; 
      SF Pl Gen => vs +"ех";
      SF Pl Dat => vs+"ем" ; 
      SF Pl  Acc => vs+ "ех" ; 
      SF Pl Inst => vs+"еми" ;
      SF Pl Prepos => vs+"ех"
    } ;
    g = Neut  ; anim = Inanimate 
} ;
  
--2 Adjectives

-- Type Adjective only has positive degree while AdjDegr type 
-- includes also comparative and superlative forms.
-- The later entries can be converted into the former using 
-- "extAdjective" operation defined in the syntax module
-- and vice verca using "mkAdjDeg" operation.
 
oper 
   kazhdujDet: Adjective = uy_j_EndDecl "кажд" ;
   samuj: Adjective = uy_j_EndDecl "сам" ;
   lubojDet: Adjective = uy_oj_EndDecl "люб" ;
   kotorujDet: Adjective = uy_j_EndDecl "котор"; 
   takoj: Adjective = i_oj_EndDecl "так" []; 
   kakojNibudDet: Adjective = i_oj_EndDecl "как" "-нибудь";
   kakojDet: Adjective = i_oj_EndDecl "как" []; 
   bolshinstvoDet: Adjective  = extAdjFromSubst (oEnd_SgDecl "большинств");
   vseDetPl: Adjective   =  extAdjFromSubst (eEnd_Decl "вс") ;
   extAdjFromSubst: CommNoun -> Adjective = \ vse ->
    {s = \\af => vse.s ! SF (numAF af) (caseAF af) } ;

                                     
oper mkAdjDeg: Adjective -> Str -> AdjDegr = \adj, s -> 
  {  s = table 
           { 
              Pos => adj.s ;
              Comp => \\af => s ;
              Super => \\af =>  samuj.s !af ++ adj.s ! af 
           }
  }; 
oper uzhasnuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "ужасн") "ужаснее";     
oper deshevuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "дешев") "дешевле";     
oper staruj: AdjDegr = mkAdjDeg (uy_j_EndDecl "стар") "старше";     
oper uy_j_EndDecl : Str -> Adjective = \s ->{s = table {
      AF Nom _ (ASg Masc) => s+"ый"; 
      AF Nom _ (ASg Fem) => s+"ая"; 
      AF Nom _ (ASg Neut) => s+"ое";
      AF Nom _ APl => s+"ые";
      AF Acc  Inanimate (ASg Masc) => s+"ый"; 
      AF Acc  Animate (ASg Masc) => s+"ого"; 
      AF Acc  _ (ASg Fem) => s+"ую"; 
      AF Acc  _ (ASg Neut) => s+"ое";
      AF Acc  Inanimate APl => s+"ые";
      AF Acc  Animate APl => s+"ых";
      AF Gen  _ (ASg Masc) => s+"ого"; 
      AF Gen  _ (ASg Fem) => s+"ой"; 
      AF Gen  _ (ASg Neut) => s+"ого";
      AF Gen  _ APl => s+"ых";
      AF Inst _ (ASg Masc) => s+"ым"; 
      AF Inst _ (ASg Fem) => s+"ой"; 
      AF Inst _ (ASg Neut) => s+"ым";
      AF Inst _ APl => s+"ыми";
      AF Dat  _ (ASg Masc) => s+"ому"; 
      AF Dat  _ (ASg Fem) => s+"ой"; 
      AF Dat  _ (ASg Neut) => s+"ому";
      AF Dat  _ APl => s+"ым";
      AF Prepos _ (ASg Masc) => s+"ом"; 
      AF Prepos _ (ASg Fem) => s+"ой"; 
      AF Prepos _ (ASg Neut) => s+"ом";
      AF Prepos _ APl => s+"ых" 
      } 
  } ;
oper indijskij: Adjective = ij_EndK_G_KH_Decl "индийск" ;
oper francuzskij: Adjective = ij_EndK_G_KH_Decl "французск" ;
oper russkij: Adjective = ij_EndK_G_KH_Decl "русск" ;
oper italyanskij: Adjective = ij_EndK_G_KH_Decl "итальянск" ;
oper yaponskij: Adjective = ij_EndK_G_KH_Decl "японск" ;
oper malenkij: AdjDegr = mkAdjDeg  (ij_EndK_G_KH_Decl "маленьк") "меньше" ;
oper vusokij: AdjDegr = mkAdjDeg (ij_EndK_G_KH_Decl "высок") "выше";
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
    AF Prepos _ (ASg Masc) => s+"ом"; 
    AF Prepos _ (ASg Fem) => s+"ой"; 
    AF Prepos _ (ASg Neut) => s+"ом";
    AF Prepos _ APl => s+"их" 
    }
  } ;

oper bolshoj: AdjDegr = mkAdjDeg  (i_oj_EndDecl "больш" []) "больше";
oper dorogoj: AdjDegr = mkAdjDeg  (i_oj_EndDecl "дорог" []) "дороже";
oper i_oj_EndDecl : Str -> Str -> Adjective = \s, chastica ->{s = table {
    AF Nom _ (ASg Masc) => s+"ой" + chastica ;
    AF Nom _ (ASg Fem) => s+"ая"+ chastica ; 
    AF Nom _ (ASg Neut) => s+"ое"+ chastica ;
    AF Nom _ APl => s+"ие"+ chastica ;
    AF Acc  Animate (ASg Masc) => s+"ого"+ chastica ; 
    AF Acc  Inanimate (ASg Masc) => s+"ое"+ chastica ; 
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
    AF Prepos _ (ASg Masc) => s+"ом"+ chastica ; 
    AF Prepos _ (ASg Fem) => s+"ой"+ chastica ; 
    AF Prepos _ (ASg Neut) => s+"ом"+ chastica ;
    AF Prepos _ APl => s+"их" + chastica
    }
  } ;
oper molodoj: AdjDegr = mkAdjDeg (uy_oj_EndDecl "молод") "моложе";
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
    AF Prepos _ (ASg Masc) => s+"ом"; 
    AF Prepos _ (ASg Fem) => s+"ой"; 
    AF Prepos _ (ASg Neut) => s+"ом";
    AF Prepos _ APl => s+"ых"
    }
  } ;
oper prostuzhen: Adjective = shortDecl1 "простужен" ;     
oper beremenen: Adjective = shortDecl "беремен" ;     
oper need: Adjective = shortDecl "нуж" ;
oper shortDecl1 : Str -> Adjective = \s ->{s = table {
    AF _ _ (ASg Masc) => s; 
    AF _ _ (ASg Fem) => s+"а"; 
    AF _ _ (ASg Neut) => s+"о";
    AF _ _ APl => s+"ы" 
    }
  } ;
oper shortDecl : Str -> Adjective = \s ->{s = table {
    AF _ _ (ASg Masc) => s +"ен"; 
    AF _ _ (ASg Fem) => s+"на"; 
    AF _ _ (ASg Neut) => s+"но";
    AF _ _ APl => s+"ны" 
    }  } ;

-- 2 Adverbs

oper vsegda: Adverb = { s = "всегда" } ;
oper chorosho: Adverb =  { s = "хорошо" } ;

--  2 Verbs

-- Dummy verbum "have" that corresponds to the phrases like
-- "I have a headache" in English. The corresponding sentence
-- in Russian doesn't contain a verb:

oper have: Verbum = {s=\\ vf => "-" ; asp = Imperfective} ;

-- There are two common conjugations
-- (according to the number and the person of the subject)
-- patterns in the present tense in the indicative mood.

param Conjugation = First | Second ;

--3 First conjugation (in Present) verbs :

oper verbGulyat : Verbum = verbDecl Imperfective First "гуля" "ю" "гулял" "гуляй" "гулять";
oper verbVkluchat : Verbum = verbDecl Imperfective First "включа" "ю" "включал" "включай" "включать";
oper verbVukluchat : Verbum = verbDecl Imperfective First "выключа" "ю" "выключал" "выключай" "выключать";
oper verbZhdat : Verbum = verbDecl Imperfective First "жд" "у" "ждал" "жди" "ждать" ;
oper verbBegat : Verbum = verbDecl Imperfective First "бега" "ю" "бегал" "бегай" "бегать";
oper verbPrinimat : Verbum = verbDecl Imperfective First "принима" "ю" "принимал" "принимай" "принимать"; 
oper verbDokazuvat : Verbum = verbDecl Imperfective First "доказыва" "ю" "доказывал" "доказывай" "доказывать";
oper verbOtpravlyat : Verbum = verbDecl Imperfective First "отправля" "ю" "отправлял" "отправляй" "отправлять";
oper verbSlomat : Verbum = verbDecl Perfective First "слома" "ю" "сломал" "сломай" "сломать";
oper verbByut : Verbum = verbDecl Perfective First "буд" "у" "был" "будь" "быть";

--3 Second conjugation (in Present) verbs :

oper verbLubit : Verbum = verbDecl Imperfective Second "люб" "лю" "любил" "люби" "любить";
oper verbGovorit : Verbum = verbDecl Imperfective Second "говор" "ю" "говорил" "говори" "говорить";
oper verbBolet_2 : Verbum = verbDecl Imperfective Second "бол" "ю" "болел" "боли" "болеть";
oper verbPoranit : Verbum = verbDecl Perfective Second "поран" "ю" "поранил" "порань" "поранить";

-- To reduces the redundancies in the definitions
-- we introduce some intermediate types,
-- so that the full type can be described as a combination
-- of the intermediate types. For example "AspectVoice"
-- is a type for defining a pattern for a particular
-- aspect and voice.

oper AspectVoice: Type = { s : VerbConj => Str ;  asp: Aspect } ;     

-- "PresentVerb" takes care of the present  tense conjugation.

param PresentVF = PRF Number Person ;
oper PresentVerb : Type = PresentVF => Str ;

oper presentConj2: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF Sg P1 => del+ sgP1End ;
    PRF Sg P2 => del+ "ишь" ;
    PRF Sg P3 => del+ "ит" ;
    PRF Pl P1 => del+ "им" ;
    PRF Pl P2 => del+ "ите'" ;
    PRF Pl P3 => del+ "ят"   
  };
oper presentConj1: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF Sg P1 => del+ sgP1End ;
    PRF Sg P2 => del+ "ешь" ;
    PRF Sg P3 => del+ "ет" ;
    PRF Pl P1 => del+ "ем" ;
    PRF Pl P2 => del+ "ете'" ;
    PRF Pl P3 => del+ sgP1End + "т"   
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

-- "verbDecl" sorts out verbs according to the aspect and voice parameters.
-- It produces the full conjugation table for a verb entry

oper verbDecl: Aspect -> Conjugation -> Str -> Str -> Str -> Str ->Str -> Verbum = 
   \a, c, del, sgP1End, sgMascPast, imperSgP2, inf -> case a of 
{  Perfective  =>  case c of  {
     First =>    mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj1 del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
     Second =>    mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj2 del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast)
} ;
   Imperfective  => case c of { 
     First => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj1 del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
    Second => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj2 del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast)
   } 
};

-- "mkVerb" produce the passive forms from 
-- the active forms using the "mkPassive" method.
-- Passive is expressed in Russian by so called reflexive verbs,
-- which are formed from the active form by suffixation.

oper mkVerb : AspectVoice -> PastVerb -> Verbum = \av1, pv ->
 { s =   table { 
      VFORM Act vf => av1.s !vf;
      VFORM Pass vf => (mkPassive av1 pv ).s ! vf 
   } ;
   asp = av1.asp
};

  vowels : Strs = strs {
    "а" ; "е" ; "ё" ; "и" ; "о" ; "у" ; 
    "ы" ; "э" ; "ю" ; "я" 
    } ; 

oper mkPassive: AspectVoice -> PastVerb -> AspectVoice =  \av, pv ->
  { s =    table {
    VINF  => av.s ! VINF + "ся";
    VIMP  Sg P1 =>  av.s ! (VIMP  Sg P1) +"сь" ;
    VIMP  Pl  P1 => av.s ! (VIMP  Pl  P1) +"ся";
    VIMP  Sg P2 => av.s ! (VIMP  Sg P2 ) +"сь";
    VIMP  Pl  P2 => av.s! (VIMP  Pl P2) +"сь";
    VIMP  Sg P3 => av.s ! (VIMP Sg P3)  +"ся";
    VIMP  Pl  P3 => av.s ! (VIMP Pl P3) +"ся";
    VSUB (ASg Masc) => pv !  (PSF (ASg Masc)) + "ся"+[" бы"];
    VSUB (ASg Fem) => pv  ! (PSF (ASg Fem)) + "сь"+[" бы"];
    VSUB (ASg Neut)  => pv ! (PSF (ASg Neut)) + "сь"+[" бы"];
    VSUB APl  => pv ! (PSF APl) + "сь"+[" бы"] ;
    VIND (VPresent Sg P1)  => 
     --           case av.asp of { Imperfective =>
                       av.s ! (VIND (VPresent Sg P1)) + "сь" ;
     --                  Perfective = > nonExist
     --            }  ;
    VIND (VPresent Sg P2) => av.s ! (VIND (VPresent Sg P2))+ "ся" ;
    VIND (VPresent Sg P3) => av.s ! (VIND (VPresent Sg P3))+ "ся" ;
    VIND (VPresent Pl P1) =>  av.s !( VIND (VPresent Pl P1)) + "ся" ;
    VIND (VPresent Pl P2) => av.s !( VIND (VPresent Pl P2)) + "сь'" ;
    VIND (VPresent Pl P3) => av.s !( VIND (VPresent Pl P3)) + "ся" ;
    VIND (VFuture Sg P1) => av.s ! (VIND (VFuture Sg P1)) + "сь";
    VIND (VFuture Sg P2) => av.s! (VIND (VFuture  Sg P2) )+ "ся";
    VIND (VFuture Sg P3) => av.s! (VIND (VFuture  Sg P3)) + "ся";
    VIND (VFuture Pl P1) => av.s! (VIND (VFuture  Pl P1) )+ "ся";
    VIND (VFuture Pl P2) => av.s! (VIND (VFuture  Pl P2) )+ "сь";
    VIND (VFuture Pl P3) => av.s! (VIND (VFuture  Pl P3)) + "ся";
    VIND (VPast  (ASg Masc)) => av.s ! (VIND (VPast  (ASg Masc) )) + "ся";
    VIND (VPast  (ASg Fem))  => av.s ! (VIND (VPast  (ASg Fem) )) + "сь";
    VIND (VPast  (ASg Neut))  => av.s ! (VIND (VPast  (ASg Neut)) ) + "сь";
    VIND (VPast  APl) => av.s ! (VIND (VPast  APl)) + "сь"
  } ;
  asp = av.asp
};

-- Generation the imperfective active pattern given
-- a number of basic conjugation forms.

oper 
  imperfectiveActivePattern : Str -> Str -> PresentVerb -> PastVerb -> AspectVoice = 
     \inf, imper, presentFuture, past -> { s=  table {
    VINF  => inf ;
    VIMP Sg P1 => ["давайте "]+ inf ;
    VIMP Pl P1 => ["давайте "] + inf ;
    VIMP Sg P2 => imper ;
    VIMP Pl P2 => imper+"те" ;
    VIMP Sg P3 => ["пускай "]  + presentFuture ! (PRF Sg P3) ;
    VIMP Pl P3 => ["пускай "] + presentFuture ! (PRF Pl P3) ;
    VSUB (ASg Masc) => past ! (PSF (ASg Masc)) +[" бы"];
    VSUB (ASg Fem) => past ! (PSF (ASg Fem)) +[" бы"];

    VSUB (ASg Neut)  => past ! (PSF (ASg Neut) )+[" бы"];
    VSUB APl  => past ! (PSF APl) +[" бы"];
    VIND (VPresent Sg P1) => presentFuture ! ( PRF Sg P1);
    VIND (VPresent Sg P2) => presentFuture! (PRF Sg P2) ;
    VIND (VPresent Sg P3) => presentFuture ! (PRF Sg P3) ;
    VIND (VPresent Pl P1) => presentFuture ! (PRF Pl P1);
    VIND (VPresent Pl P2) => presentFuture ! (PRF Pl P2);
    VIND (VPresent Pl P3) => presentFuture ! (PRF Pl P3);
    VIND (VFuture Sg P1) => ["буду "] + presentFuture ! (PRF Sg P1) ;
    VIND (VFuture Sg P2) => ["будешь"] + presentFuture ! (PRF Sg P2) ;
    VIND (VFuture Sg P3) => ["будет "] + presentFuture ! (PRF Sg P3) ;
    VIND (VFuture Pl P1) => ["будем "] + presentFuture ! (PRF Pl P1) ;
    VIND (VFuture Pl P2) => ["будете "] + presentFuture ! (PRF Pl P2) ;
    VIND (VFuture Pl P3) => ["будут "] + presentFuture ! (PRF Pl P3) ;
    
    VIND (VPast     (ASg Masc)) => past ! (PSF (ASg Masc)) ;
    VIND (VPast  (ASg Fem))  => past ! (PSF (ASg Fem) ) ;
    VIND (VPast  (ASg Neut) ) => past ! (PSF (ASg Neut))  ;
    VIND (VPast  APl) => past ! (PSF APl)
  } ;
  asp = Imperfective 
} ;

 oper perfectiveActivePattern: Str -> Str -> PresentVerb -> PastVerb -> AspectVoice = 
     \inf, imper, presentFuture, past -> { s=  table {
    VINF  => inf ;
    VIMP Sg P1 => ["давайте "]+ presentFuture ! (PRF Sg P1);
    VIMP Pl P1 => ["давайте "] + presentFuture ! (PRF Pl P1);
    VIMP Sg P2 => imper ;
    VIMP Pl P2 => imper+"те" ;
    VIMP Sg P3 => ["пускай "]  + presentFuture ! (PRF Sg P3) ;
    VIMP Pl P3 => ["пускай "] + presentFuture ! (PRF Pl P3) ;
    VSUB (ASg Masc) => past ! (PSF (ASg Masc)) +[" бы"];
    VSUB (ASg Fem) => past ! (PSF (ASg Fem)) +[" бы"];

    VSUB (ASg Neut)  => past ! (PSF (ASg Neut) )+[" бы"];
    VSUB APl  => past ! (PSF APl) +[" бы"];
    VIND (VPresent Sg P1) => [] ;
    VIND (VPresent Sg P2) => [] ;
    VIND (VPresent Sg P3) => [] ;
    VIND (VPresent Pl P1) => nonExist ;
    VIND (VPresent Pl P2) => nonExist ;
    VIND (VPresent Pl P3) => [] ;
    VIND (VFuture Sg P1) => presentFuture ! (PRF Sg P1) ;
    VIND (VFuture Sg P2) => presentFuture ! (PRF Sg P2) ;
    VIND (VFuture Sg P3) => presentFuture ! (PRF Sg P3) ;
    VIND (VFuture Pl P1) => presentFuture ! (PRF Pl P1) ;
    VIND (VFuture Pl P2) => presentFuture ! (PRF Pl P2) ;
    VIND (VFuture Pl P3) => presentFuture ! (PRF Pl P3) ;
    VIND (VPast  (ASg Masc)) => past ! (PSF (ASg Masc)) ;
    VIND (VPast  (ASg Fem))  => past ! (PSF (ASg Fem) ) ;
    VIND (VPast  (ASg Neut) ) => past ! (PSF (ASg Neut))  ;
    VIND (VPast  APl) => past ! (PSF APl)
  } ;
  asp = Perfective 
} ; 

--2 Proper names are a simple kind of noun phrases. 

  ProperName : Type = {s :  Case => Str ; g : Gender ; anim : Animacy} ;

  mkProperNameMasc : Str -> Animacy -> ProperName = \ivan, anim -> 
       { s =  table { Nom => ivan ; 
                      Gen => ivan + "а";
                      Dat => ivan + "у";
                      Acc => case anim of 
                             { Animate => ivan + "а"; 
                               Inanimate => ivan
                             };
                      Inst => ivan + "ом";
                      Prepos => ivan + "е" } ; 
         g = Masc;  anim = anim };

  mkProperNameFem : Str -> Animacy -> ProperName = \masha, anim -> 
       { s = table { Nom => masha + "а"; 
                     Gen => masha + "и";
                     Dat => masha + "е";
                     Acc => masha + "у";
                     Inst => masha + "ей";
                     Prepos => masha + "е" } ;
          g = Fem ; anim = anim };
   };

