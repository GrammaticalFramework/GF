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

resource MorphoRus = TypesRus ** open (Predef=Predef), Prelude in {
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
    PF Prepos _ NonPoss => "нём" ;
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
oper pronOno: Pronoun = 
  { s = table {
    PF Nom _ NonPoss => "оно" ; 
    PF Gen No  NonPoss => "его" ; 
    PF Gen Yes NonPoss => "него"  ;
    PF Dat No NonPoss => "ему" ; 
    PF Dat Yes NonPoss => "нему" ; 
    PF Acc No NonPoss => "его" ;
    PF Acc Yes NonPoss => "него" ; 
    PF Inst No NonPoss => "им" ;
    PF Inst Yes NonPoss => "ним" ;
    PF Prepos _ NonPoss => "нём" ;
    PF _ _ (Poss  _ ) => "его"  
    } ;
    g = PGen Neut ;
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

oper pronKtoTo: Pronoun = 
  { s = table {
    PF Nom _ _  => "кто-то"  ; 
    PF Gen _ _ => "кого-то" ;
    PF Dat _  _ => "кому-то" ; 
    PF Acc _  _ => "кого-то" ; 
    PF Inst _ _ => "кем-то" ;
    PF Prepos _ _ => "ком-то" 
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;
oper pronChtoTo: Pronoun = 
  { s = table {
    PF Nom _ _  => "что-то"  ; 
    PF Gen _ _ => "чего-то" ;
    PF Dat _  _ => "чему-то" ; 
    PF Acc _  _ => "что-то" ; 
    PF Inst _ _ => "чем-то" ;
    PF Prepos _ _ => "чём-то" 
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;
oper pronNikto: Pronoun = 
  { s = table {
    PF Nom _ _  => "никто"  ; 
    PF Gen _ _ => "никого" ;
    PF Dat _  _ => "никому" ; 
    PF Acc _  _ => "никого" ; 
    PF Inst _ _ => "никем" ;
    PF Prepos _ _ => ["ни о ком"] -- only together with a preposition 
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;

oper pronNichto: Pronoun = 
  { s = table {
    PF Nom _ _  => "ничто"  ; 
    PF Gen _ _ => "ничего" ;
    PF Dat _  _ => "ничему" ; 
    PF Acc _  _ => "ничего" ; 
    PF Inst _ _ => "ничем" ;
    PF Prepos _ _ => ["ни о чём"] -- only together with preposition  
    } ;
    g = PGen  Masc;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;

oper pronVseInanimate: Pronoun = 
  { s = table {
    PF Nom _ _  => "всё"  ; 
    PF Gen _ _ => "всего" ;
    PF Dat _  _ => "всему" ; 
    PF Acc _  _ => "всё" ; 
    PF Inst _ _ => "всем" ;
    PF Prepos _ _ => "всём" 
    } ;
    g = PGen  Neut;
    n = Sg ;
    p = P3 ;
    pron = False
  } ;
 
--2 Nouns

-- Help type SubstFormDecl is introduced to reduce repetition in 
-- the declination definitions. It allows us to define a declination type,
-- namely, the String component "s" of the CommNoun type
-- without any reference to the Gender parameter "g".

oper SubstFormDecl = SS1 SubstForm ;

oper gorlo : CommNoun = l_oEndInAnimateDecl "горл"  ;
oper koleno : CommNoun = oEndInAnimateDecl "колен"  ;
oper plecho : CommNoun = oEndInAnimateDecl "плеч"  ;
oper ukho : CommNoun = oEnd_KH_InAnimateDecl "у"  ;
oper zhivot : CommNoun = nullEndInAnimateDecl1 "живот" ; 
oper grud : CommNoun = softSignEndDeclFem "груд" ;
oper ruka : CommNoun = aEndG_K_KH_Decl "рук" ;
oper spina : CommNoun = aEndInAnimateDecl "спин" ;
oper stopa : CommNoun = aEndInAnimateDecl "стоп" ;

oper astma : CommNoun = aEndInAnimateDecl "астм" ;
oper angina : CommNoun = aEndInAnimateDecl "ангин" ;
oper revmatizm : CommNoun = nullEndInAnimateDecl1 "ревматизм" ; 
oper zapor : CommNoun = nullEndInAnimateDecl1 "запор" ; 
oper ponos : CommNoun = nullEndInAnimateDecl1 "понос" ; 
oper artrit : CommNoun = nullEndInAnimateDecl1 "артрит" ; 
oper diabet : CommNoun = nullEndInAnimateDecl1 "диабет" ; 
oper tsistit : CommNoun = nullEndInAnimateDecl1 "цистит" ;
oper izzhoga : CommNoun = aEndG_K_KH_Decl "изжог" ;
oper allergiya : CommNoun = i_yaEndDecl "аллерги" ;

oper viagra : CommNoun = aEndInAnimateDecl "виагр" ;
oper antidepressant : CommNoun = nullEndInAnimateDecl1 "антидепрессант" ; 
oper insulin : CommNoun = nullEndInAnimateDecl1 "инсулин" ;
oper vitamin : CommNoun = nullEndInAnimateDecl1 "витамин" ;
oper antibiotik : CommNoun = nullEndInAnimateDecl3 "антибиотик" ; 
oper kaplya : CommNoun = (l_yaEndInAnimateDecl  "кап") ** {g = Fem; anim = Inanimate}  ;
oper snotvornoe : CommNoun = oeEndInAnimateDecl "снотворн" ;
oper uspokoitelnoe : CommNoun = oeEndInAnimateDecl "успокоительн" ;
oper slabitelnoe : CommNoun = oeEndInAnimateDecl "слабительн" ;

oper urolog : CommNoun = nullEndAnimateDecl "уролог" ;
oper ginekolog : CommNoun = nullEndAnimateDecl "гинеколог" ;
oper nevropatolog : CommNoun = nullEndAnimateDecl "невропатолог" ;
oper dermatolog : CommNoun = nullEndAnimateDecl "дерматолог" ;
oper kardiolog : CommNoun = nullEndAnimateDecl "кардиолог" ;
oper terapevt : CommNoun = nullEndAnimateDecl2 "терапевт" ;
oper okulist : CommNoun = nullEndAnimateDecl2 "окулист" ;
oper pediatr : CommNoun = nullEndAnimateDecl2 "педиатр" ;
oper khirurg : CommNoun = nullEndAnimateDecl2 "хирург" ;

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
oper nullEndAnimateDecl2: Str -> CommNoun =  \stomatolog ->
  {s  =  table  
      { SF Sg Nom =>  stomatolog ; 
        SF Sg Gen => stomatolog+"а" ;
        SF Sg Dat => stomatolog+"у" ; 
        SF Sg Acc => stomatolog +"а" ; 
        SF Sg Inst => stomatolog+"ом" ;
        SF Sg Prepos => stomatolog+"е" ; 
        SF Pl  Nom => stomatolog+"ы" ; 
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
oper nullEndInAnimateDecl3: Str -> CommNoun =  \antibiotik ->
  {s  =  table  
      { SF Sg Nom =>  antibiotik ; 
        SF Sg Gen => antibiotik+"а" ;
        SF Sg Dat => antibiotik+"у" ; 
        SF Sg Acc => antibiotik ; 
        SF Sg Inst => antibiotik+"ом" ;
        SF Sg Prepos => antibiotik+"е" ; 
        SF Pl Nom => antibiotik+"и" ; 
        SF Pl Gen => antibiotik+"ов" ;
    
        SF Pl Dat => antibiotik+"ам" ; 
        SF Pl Acc => antibiotik +"и"; 
        SF Pl Inst => antibiotik+"ами" ;
        SF Pl Prepos => antibiotik+"ах"
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

oper oeEndInAnimateDecl: Str -> CommNoun =  \snotvorn ->
  {  s  =  table  
      { SF Sg Nom =>  snotvorn +"ое"; 
        SF Sg Gen => snotvorn+"ого" ;
        SF Sg Dat => snotvorn+"ому" ; 
        SF Sg Acc => snotvorn +"ое"; 
        SF Sg Inst => snotvorn+"ым" ;
        SF Sg Prepos => snotvorn+"ом" ; 
        SF Pl Nom => snotvorn+"ые" ; 
        SF Pl Gen => snotvorn+"ых" ;
        SF Pl Dat => snotvorn+"ым" ; 
        SF Pl Acc => snotvorn+"ые" ; 
        SF Pl Inst => snotvorn+"ыми" ;
        SF Pl Prepos => snotvorn+"ых"
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
oper chislo : CommNoun = l_oEndInAnimateDecl "числ"  ;
oper vino : CommNoun = l_oEndInAnimateDecl "вин"  ;
oper l_oEndInAnimateDecl: Str -> CommNoun = \chisl ->
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

oper oEndInAnimateDecl: Str -> CommNoun =  \plech ->
  { s  =  table  
      { SF Sg Nom =>  plech+"о" ; 
        SF Sg Gen => plech+"а" ;
        SF Sg Dat => plech+"у" ; 
        SF Sg Acc => plech+"о" ; 
        SF Sg Inst => plech+"ом" ;
        SF Sg Prepos => plech+"е" ; 
        SF Pl  Nom => plech+"и" ; 
        SF Pl  Gen => plech;
        SF Pl  Dat => plech+"ам" ; 
        SF Pl  Acc => plech+"и" ; 
        SF Pl  Inst => plech+"ами" ;
        SF Pl  Prepos => plech+"ях"
    } ;
    g = Neut  ; anim = Inanimate 
  } ;
oper oEnd_KH_InAnimateDecl: Str -> CommNoun =  \u ->
  { s  =  table  
      { SF Sg Nom =>  u+"хо" ; 
        SF Sg Gen => u+"ха" ;
        SF Sg Dat => u+"ху" ; 
        SF Sg Acc => u+"хо" ; 
        SF Sg Inst => u+"хом" ;
        SF Sg Prepos => u+"хе" ; 
        SF Pl  Nom => u+"ши" ; 
        SF Pl  Gen => u +"шей";
        SF Pl  Dat => u+"шам" ; 
        SF Pl  Acc => u+"ши" ; 
        SF Pl  Inst => u+"шами" ;
        SF Pl  Prepos => u+"шах"
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
oper doroga : CommNoun = aEndG_K_KH_Decl "дорог" ;
oper dvojka : CommNoun = aEndG_K_KH_Decl "двойк" ;
oper butyulka : CommNoun = aEndG_K_KH_Decl "бутылк" ;
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

oper golova : CommNoun = aEndInAnimateDecl "голов" ; 
oper mashina : CommNoun = aEndInAnimateDecl "машин" ;
oper temperatura : CommNoun = aEndInAnimateDecl "температур" ;
oper  edinica : CommNoun = ej_aEndInAnimateDecl "единиц" ;

oper aEndInAnimateDecl: Str -> CommNoun =  \golov ->
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
oper ej_aEndInAnimateDecl: Str -> CommNoun =  \ediniz ->
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
oper l_yaEndInAnimateDecl: Str -> SubstFormDecl =  \kap ->
{s = table {
    SF Sg Nom => kap + "ля" ;    
    SF Sg Gen => kap + "ли" ;
    SF Sg Dat => kap + "ле" ;
    SF Sg Acc => kap + "лю" ;
    SF Sg Inst => kap + "лей" ;
    SF Sg Prepos => kap + "ле" ;
    SF Pl Nom => kap + "ли" ;
    SF Pl Gen => kap + "ель" ;
    SF Pl Inst => kap + "лями" ;
    SF Pl Prepos => kap + "лях" ;
    SF Pl Dat => kap + "лям" ;
    SF Pl Acc => kap + "ли" 
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

oper kg_oEnd_SgDecl: Str -> CommNoun =  \mnog ->
{ s  =  table  {
      SF _ Nom =>  mnog+"о" ; 
      SF _ Gen => mnog +"их";
      SF _ Dat => mnog+"им" ; 
      SF _ Acc => mnog+"о" ; 
      SF _ Inst => mnog+"ими" ;
      SF _ Prepos => mnog+"их" 
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
      SF _ Prepos => menshinstv+"вах" 
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
   adjInvar: Str -> Adjective = \s -> { s = \\af => s };

   kazhdujDet: Adjective = uy_j_EndDecl "кажд" ;
   samuj: Adjective = uy_j_EndDecl "сам" ;
   lubojDet: Adjective = uy_oj_EndDecl "люб" ;
   glaznoj: Adjective = uy_oj_EndDecl "глазн" ;
   kotorujDet: Adjective = uy_j_EndDecl "котор"; 
   nekotorujDet: Adjective = uy_j_EndDecl "некотор"; 
   takoj: Adjective = i_oj_EndDecl "так" []; 
   kakojNibudDet: Adjective = i_oj_EndDecl "как" "-нибудь";
   kakojDet: Adjective = i_oj_EndDecl "как" []; 
   nikakojDet: Adjective = i_oj_EndDecl "никак" []; 
   bolshinstvoSgDet: Adjective  = extAdjFromSubst (oEnd_SgDecl "большинств");
   mnogoSgDet: Adjective  = extAdjFromSubst (kg_oEnd_SgDecl "мног");
   skolkoSgDet: Adjective  = extAdjFromSubst (kg_oEnd_SgDecl "скольк");

   bolshinstvoPlDet: Adjective  = extAdjFromSubst (oEnd_PlDecl "большинств");
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
oper schastlivyuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "счастлив") "счастливее";     
oper deshevuj: AdjDegr = mkAdjDeg (uy_j_EndDecl "дешев") "дешевле";     
oper staruj: AdjDegr = mkAdjDeg (uy_j_EndDecl "стар") "старше";     
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
      AF Prepos _ (ASg Masc) => "том"; 
      AF Prepos _ (ASg Fem) => "той"; 
      AF Prepos _ (ASg Neut) => "том";
      AF Prepos _ APl => "тех" ;
      AdvF => "то"
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
      AF Prepos _ (ASg Masc) => "этом"; 
      AF Prepos _ (ASg Fem) => "этой"; 
      AF Prepos _ (ASg Neut) => "этом";
      AF Prepos _ APl => "этих";
      AdvF => "это"
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
      AF Prepos _ (ASg Masc) => "всём"; 
      AF Prepos _ (ASg Fem) => "всей"; 
      AF Prepos _ (ASg Neut) => "всём";
      AF Prepos _ APl => "всех" ;
      AdvF => "полностью"
      } 
  } ;
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
      AF Prepos _ APl => s+"ых";
      AdvF => "о"
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
    AF Prepos _ APl => s+"их";
     AdvF => "о"
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
    AF Prepos _ APl => s+"их" + chastica;
     AdvF => "о"
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
    AF Prepos _ APl => s+"ых";
    AdvF => "о"
    }
  } ;
oper prostuzhen: Adjective = shortDecl1 "простужен" ;     
oper beremenen: Adjective = shortDecl "беремен" ;     
oper need: Adjective = shortDecl "нуж" ;
oper shortDecl1 : Str -> Adjective = \s ->{s = table {
    AF _ _ (ASg Masc) => s; 
    AF _ _ (ASg Fem) => s+"а"; 
    AF _ _ (ASg Neut) => s+"о";
    AF _ _ APl => s+"ы" ;
    AdvF => "о"
    }
  } ;
oper shortDecl : Str -> Adjective = \s ->{s = table {
    AF _ _ (ASg Masc) => s +"ен"; 
    AF _ _ (ASg Fem) => s+"на"; 
    AF _ _ (ASg Neut) => s+"но";
    AF _ _ APl => s+"ны" ;
    AdvF => "о"
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

param Conjugation = First | FirstE | Second | Mixed | Dolzhen;

--3 First conjugation (in Present) verbs :

oper verbGulyat : Verbum = verbDecl Imperfective First "гуля" "ю" "гулял" "гуляй" "гулять";
oper verbVkluchat : Verbum = verbDecl Imperfective First "включа" "ю" "включал" "включай" "включать";
oper verbVukluchat : Verbum = verbDecl Imperfective First "выключа" "ю" "выключал" "выключай" "выключать";
oper verbZhdat : Verbum = verbDecl Imperfective First "жд" "у" "ждал" "жди" "ждать" ;
oper verbBegat : Verbum = verbDecl Imperfective First "бега" "ю" "бегал" "бегай" "бегать";
oper verbPrinimat : Verbum = verbDecl Imperfective First "принима" "ю" "принимал" "принимай" "принимать"; 
oper verbDokazuvat : Verbum = verbDecl Imperfective First "доказыва" "ю" "доказывал" "доказывай" "доказывать";
oper verbPredpochitat : Verbum = verbDecl Imperfective First "предпочита" "ю" "предпочитал" "предпочитай" "предпочитать";
oper verbOtpravlyat : Verbum = verbDecl Imperfective First "отправля" "ю" "отправлял" "отправляй" "отправлять";
oper verbSlomat : Verbum = verbDecl Perfective First "слома" "ю" "сломал" "сломай" "сломать";
oper verbByut : Verbum = verbDecl Perfective First "буд" "у" "был" "будь" "быть";
oper verbMoch : Verbum = verbDeclMoch Imperfective First "мог" "у" "мог" "моги" "мочь" "мож";

-- Verbs with vowel "ё": "даёшь" (give), "пьёшь" (drink)  :
oper verbDavat : Verbum = verbDecl Imperfective FirstE "да" "ю" "давал" "давай" "давать";
oper verbPit : Verbum = verbDecl Imperfective FirstE "пь" "ю" "пил" "пей" "пить";

--3 Second conjugation (in Present) verbs :

oper verbLubit : Verbum = verbDecl Imperfective Second "люб" "лю" "любил" "люби" "любить";
oper verbGovorit : Verbum = verbDecl Imperfective Second "говор" "ю" "говорил" "говори" "говорить";
oper verbBolet_2 : Verbum = verbDecl Imperfective Second "бол" "ю" "болел" "боли" "болеть";
oper verbPoranit : Verbum = verbDecl Perfective Second "поран" "ю" "поранил" "порань" "поранить";
-- Irregular Mixed:
oper verbKhotet : Verbum = verbDecl Imperfective Mixed "хоч" "у" "хотел" "хоти" "хотеть";

-- Irregular
oper verbDolzhen : Verbum = verbDecl Imperfective Dolzhen "долж" "ен" "долж" ["будь должен"] ["быть должным"] ;

-- To reduces the redundancies in the definitions
-- we introduce some intermediate types,
-- so that the full type can be described as a combination
-- of the intermediate types. For example "AspectVoice"
-- is a type for defining a pattern for a particular
-- aspect and voice.

oper AspectVoice: Type = { s : VerbConj => Str ;  asp: Aspect } ;     

-- "PresentVerb" takes care of the present  tense conjugation.

param PresentVF = PRF GenNum Person;
oper PresentVerb : Type = PresentVF => Str ;
oper presentConjDolzhen: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF APl _ => del+ "ны" ;
    PRF (ASg Masc) P1 => del+ sgP1End ;
    PRF (ASg Fem) P1 => del+ "на" ;
    PRF (ASg Neut) P1 => del+ "но" ;
    PRF (ASg Masc) P2 => del+ sgP1End ;
    PRF (ASg Fem) P2 => del+ "на" ;
    PRF (ASg Neut) P2 => del+ "но" ;
    PRF (ASg Masc) P3 => del+ sgP1End ;
    PRF (ASg Fem) P3 => del+ "на" ;
    PRF (ASg Neut) P3 => del+ "но"   };

oper presentConjMixed: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF (ASg _) P1 => del+ sgP1End ;
    PRF (ASg _) P2 => del+ "ешь" ;
    PRF (ASg _) P3 => del+ "ет" ;
    PRF APl P1 => del+ "им" ;
    PRF APl P2  => del+ "ите" ;
    PRF APl P3  => del+ "ят"   
  };
oper presentConj2: Str -> Str -> PresentVerb = \del, sgP1End ->
  table {
    PRF (ASg _) P1 => del+ sgP1End ;
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

-- "verbDecl" sorts out verbs according to the aspect and voice parameters.
-- It produces the full conjugation table for a verb entry

oper verbDecl: Aspect -> Conjugation -> Str -> Str -> Str -> Str ->Str -> Verbum = 
   \a, c, del, sgP1End, sgMascPast, imperSgP2, inf -> case a of 
{  Perfective  =>  case c of  {
     First =>    mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj1 del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
     FirstE =>    mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj1E del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
     Second =>    mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj2 del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast);
    Mixed => mkVerb (perfectiveActivePattern inf imperSgP2 (presentConjMixed del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast);
    Dolzhen => mkVerb (perfectiveActivePattern inf imperSgP2 (presentConjDolzhen del sgP1End) (pastConjDolzhen sgMascPast)) (pastConjDolzhen sgMascPast)
} ;
   Imperfective  => case c of { 
     First => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj1 del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
     FirstE => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj1E del sgP1End) (pastConj sgMascPast))  (pastConj sgMascPast);
    Second => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj2 del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast);
    Mixed => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConjMixed del sgP1End) (pastConj sgMascPast)) (pastConj sgMascPast) ;
    Dolzhen => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConjDolzhen del sgP1End) (pastConjDolzhen sgMascPast)) (pastConjDolzhen sgMascPast)
   } 
};

-- for verbs like "мочь" ("can") with changing consonants (first conjugation):
-- "могу - можешь"
oper verbDeclMoch: Aspect -> Conjugation -> Str -> Str -> Str -> Str ->Str -> Str -> Verbum = 
   \a, c, del, sgP1End, sgMascPast, imperSgP2, inf, altRoot -> case a of 
{  Perfective  => mkVerb (perfectiveActivePattern inf imperSgP2 (presentConj1Moch del sgP1End altRoot) (pastConj sgMascPast))  (pastConj sgMascPast);
    Imperfective  => mkVerb (imperfectiveActivePattern inf imperSgP2 (presentConj1Moch del sgP1End altRoot) (pastConj sgMascPast))  (pastConj sgMascPast)
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
    VIND (ASg _) (VPresent P1)  => 
     --           case av.asp of { Imperfective =>
                       av.s ! (VIND (ASg Masc) (VPresent P1)) + "сь" ;
     --                  Perfective = > nonExist
     --            }  ;
    VIND (ASg _) (VPresent  P2) => av.s ! (VIND (ASg Masc) (VPresent P2))+ "ся" ;
    VIND (ASg _) (VPresent  P3) => av.s ! (VIND (ASg Masc) (VPresent  P3))+ "ся" ;
    VIND APl (VPresent P1) =>  av.s !( VIND APl (VPresent P1)) + "ся" ;
    VIND APl (VPresent P2) => av.s !( VIND APl (VPresent P2)) + "сь" ;
    VIND APl (VPresent P3) => av.s !( VIND APl (VPresent P3)) + "ся" ;
    VIND (ASg _) (VFuture P1) => av.s ! (VIND (ASg Masc) (VFuture P1)) + "сь";
    VIND (ASg _) (VFuture P2) => av.s! (VIND (ASg Masc) (VFuture P2) )+ "ся";
    VIND (ASg  _) (VFuture P3) => av.s! (VIND (ASg Masc) (VFuture  P3)) + "ся";
    VIND APl (VFuture P1) => av.s! (VIND APl (VFuture P1) )+ "ся";
    VIND APl (VFuture P2) => av.s! (VIND APl (VFuture P2) )+ "сь";
    VIND APl (VFuture P3) => av.s! (VIND APl (VFuture P3)) + "ся";
    VIND  (ASg Masc) VPast => av.s ! (VIND  (ASg Masc) VPast ) + "ся";
    VIND (ASg Fem) VPast    => av.s ! (VIND (ASg Fem) VPast ) + "сь";
    VIND (ASg Neut) VPast    => av.s ! (VIND (ASg Neut) VPast) + "сь";
    VIND APl VPast   => av.s ! (VIND APl VPast ) + "сь"
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
    VIMP Sg P3 => ["пускай "]  + presentFuture ! (PRF (ASg Masc) P3) ;
    VIMP Pl P3 => ["пускай "] + presentFuture ! (PRF APl P3) ;
    VSUB (ASg Masc) => past ! (PSF (ASg Masc)) +[" бы"];
    VSUB (ASg Fem) => past ! (PSF (ASg Fem)) +[" бы"];

    VSUB (ASg Neut)  => past ! (PSF (ASg Neut) )+[" бы"];
    VSUB APl  => past ! (PSF APl) +[" бы"];
    VIND (ASg _) (VPresent P1) => presentFuture ! ( PRF (ASg Masc) P1);
    VIND (ASg _) (VPresent P2) => presentFuture! (PRF (ASg Masc) P2) ;
    VIND (ASg _) (VPresent P3) => presentFuture ! (PRF (ASg Masc) P3) ;
    VIND APl (VPresent P1) => presentFuture ! (PRF APl P1);
    VIND APl (VPresent P2) => presentFuture ! (PRF APl P2);
    VIND APl (VPresent P3) => presentFuture ! (PRF APl P3);
    VIND (ASg _) (VFuture P1) => ["буду "] + presentFuture ! (PRF (ASg Masc) P1) ;
    VIND (ASg _) (VFuture P2) => ["будешь"] + presentFuture ! (PRF (ASg Masc) P2) ;
    VIND (ASg _) (VFuture P3) => ["будет "] + presentFuture ! (PRF (ASg Masc) P3) ;
    VIND APl (VFuture P1) => ["будем "] + presentFuture ! (PRF APl P1) ;
    VIND APl (VFuture P2) => ["будете "] + presentFuture ! (PRF APl P2) ;
    VIND APl (VFuture P3) => ["будут "] + presentFuture ! (PRF APl P3) ;
    
    VIND (ASg Masc) VPast   => past ! (PSF (ASg Masc)) ;
    VIND (ASg Fem) VPast  => past ! (PSF (ASg Fem) ) ;
    VIND (ASg Neut) VPast  => past ! (PSF (ASg Neut))  ;
    VIND APl VPast  => past ! (PSF APl)
  } ;
  asp = Imperfective 
} ;

 oper perfectiveActivePattern: Str -> Str -> PresentVerb -> PastVerb -> AspectVoice = 
     \inf, imper, presentFuture, past -> { s=  table {
    VINF  => inf ;
    VIMP Sg P1 => ["давайте "]+ presentFuture ! (PRF (ASg Masc) P1);
    VIMP Pl P1 => ["давайте "] + presentFuture ! (PRF APl P1);
    VIMP Sg P2 => imper ;
    VIMP Pl P2 => imper+"те" ;
    VIMP Sg P3 => ["пускай "]  + presentFuture ! (PRF (ASg Masc) P3) ;
    VIMP Pl P3 => ["пускай "] + presentFuture ! (PRF APl P3) ;
    VSUB (ASg Masc) => past ! (PSF (ASg Masc)) +[" бы"];
    VSUB (ASg Fem) => past ! (PSF (ASg Fem)) +[" бы"];

    VSUB (ASg Neut)  => past ! (PSF (ASg Neut) )+[" бы"];
    VSUB APl  => past ! (PSF APl) +[" бы"];
    VIND (ASg _) (VPresent _) => [] ;
    VIND APl (VPresent P1) => nonExist ;
    VIND APl (VPresent P2) => nonExist ;
    VIND APl (VPresent P3) => [] ;
    VIND (ASg _) (VFuture P1) => presentFuture ! (PRF (ASg Masc) P1) ;
    VIND (ASg _) (VFuture P2) => presentFuture ! (PRF (ASg Masc) P2) ;
    VIND (ASg _) (VFuture P3) => presentFuture ! (PRF (ASg Masc) P3) ;
    VIND APl (VFuture P1) => presentFuture ! (PRF APl P1) ;
    VIND APl (VFuture P2) => presentFuture ! (PRF APl P2) ;
    VIND APl (VFuture P3) => presentFuture ! (PRF APl P3) ;
    VIND (ASg Masc) VPast => past ! (PSF (ASg Masc)) ;
    VIND (ASg Fem) VPast   => past ! (PSF (ASg Fem) ) ;
    VIND (ASg Neut) VPast   => past ! (PSF (ASg Neut))  ;
    VIND APl VPast => past ! (PSF APl)
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

-- For Numerals:
param DForm = unit  | teen  | ten | hund ;
param Place = attr  | indep  ;
param Size  = nom | sgg | plg ;
--param Gend = masc | fem | neut ;
oper mille : Size => Str = table {
  {nom} => "тысяча" ;
  {sgg} => "тысячи" ;
  _     => "тысяч"} ;

oper gg : Str -> Gender => Str = \s -> table {_ => s} ;


   };

