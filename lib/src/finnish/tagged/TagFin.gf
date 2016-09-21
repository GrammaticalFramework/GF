resource TagFin = open ResFin, Prelude in {

oper
  Tag : Type = Str ;

  tagWord : Tag -> Str -> Str = \tag,lemma -> "[" ++ lemma ++ tag ++ "]" ;

  mkTag = overload {
    mkTag : Str -> Tag = \t -> "+" + t ;
    mkTag : Str -> Str -> Tag = \t,v -> t + "=" + v ;
    } ;

  consTag = overload {
    consTag : (_,_ : Str) -> Tag = \t,u -> t + "|" + u ;
    consTag : (_,_,_ : Str) -> Tag = \t,u,v -> t + "|" + u + "|" + v  ;
    consTag : (_,_,_,_ : Str) -> Tag = \t,u,v,x -> t + "|" + u + "|" + v + "|" + x ;
    consTag : (_,_,_,_,_ : Str) -> Tag = \t,u,v,x,y -> t + "|" + u + "|" + v + "|" + x + "|" + y ;
    consTag : (_,_,_,_,_,_ : Str) -> Tag = \t,u,v,x,y,z -> t + "|" + u + "|" + v + "|" + x + "|" + y + "|" + z ;
    } ;

  tagNForm : NForm -> Str = \nf -> case nf of {
    NCase n c     => consTag (tagCase c) (tagNumber n) ;
    NComit        => consTag (mkTag "Case" "Com") (tagNumber Pl) ; 
    NInstruct     => consTag (mkTag "Case" "Ins") (tagNumber Pl) ; 
    NPossNom n    => consTag (tagCase Nom) (tagNumber n) ; 
    NPossGen n    => consTag (tagCase Gen) (tagNumber n) ; 
    NPossTransl n => consTag (tagCase Transl) (tagNumber n) ; 
    NPossIllat n  => consTag (tagCase Illat) (tagNumber n) ; 
    NCompound     => mkTag "Comp" ----
    } ;

  tagAForm : AForm -> Str = \af -> case af of {
    AN nf => tagNForm nf ;
    AAdv => adverbTag
    } ;

  tagVForm : VForm -> Str = \vf -> case vf of {
    Inf    infform  => tagInfForm infform ;
    Presn  num pers => consTag indicativeTag  (tagNumber num) (tagPerson pers) presentTag finiteTag activeTag ;
    Impf   num pers => consTag indicativeTag  (tagNumber num) (tagPerson pers) pastTag    finiteTag activeTag ;
    Condit num pers => consTag conditionalTag (tagNumber num) (tagPerson pers)            finiteTag activeTag ;
    Potent num pers => consTag potentialTag   (tagNumber num) (tagPerson pers)            finiteTag activeTag ;
    PotentNeg       => consTag connegativeTag potentialTag                                finiteTag activeTag ;
    Imper  num      => consTag imperativeTag  (tagNumber num) (tagPerson P2)              finiteTag activeTag ;
    ImperP3 num     => consTag imperativeTag  (tagNumber num) (tagPerson P3)              finiteTag activeTag ;
    ImperP1Pl       => consTag imperativeTag  (tagNumber Pl)  (tagPerson P3)              finiteTag activeTag ;
    ImpNegPl        => consTag connegativeTag imperativeTag                               finiteTag ; ---- Active not in UD??
    PassPresn True  => consTag                indicativeTag  presentTag finiteTag passiveTag ;
    PassPresn False => consTag connegativeTag indicativeTag  presentTag finiteTag passiveTag ;
    PassImpf  True  => consTag                indicativeTag  pastTag    finiteTag passiveTag ;
    PassImpf  False => consTag connegativeTag indicativeTag  pastTag    finiteTag passiveTag ;
    PassCondit True => consTag                conditionalTag            finiteTag passiveTag ;
    PassCondit False => consTag connegativeTag conditionalTag           finiteTag passiveTag ;
    PassPotent True => consTag                potentialTag              finiteTag passiveTag ;
    PassPotent False => consTag connegativeTag potentialTag             finiteTag passiveTag ;
    PassImper True  => consTag                imperativeTag             finiteTag passiveTag ;
    PassImper False => consTag connegativeTag imperativeTag             finiteTag passiveTag ;
    PastPartAct af  => participleTag ++ activeTag ++ pastTag ++ tagAForm af ;
    PastPartPass af => participleTag ++ activeTag ++ pastTag ++ tagAForm af ;
    PresPartAct af  => participleTag ++ activeTag ++ presentTag ++ tagAForm af ;
    PresPartPass af => participleTag ++ activeTag ++ presentTag ++ tagAForm af ;
    AgentPart af    => participleTag ++ agentTag  ++ tagAForm af
    } ;

  tagInfForm : InfForm -> Str = \vf -> case vf of {
    Inf1           => infinitiveTag ;
    Inf1Long       => infinitiveTag ;
    Inf2Iness      => infinitiveTag ;
    Inf2Instr      => infinitiveTag ;
    Inf2InessPass  => infinitiveTag ;
    Inf3Iness      => infinitiveTag ;
    Inf3Elat       => infinitiveTag ;
    Inf3Illat      => infinitiveTag ;
    Inf3Adess      => infinitiveTag ;
    Inf3Abess      => infinitiveTag ;
    Inf3Instr      => infinitiveTag ;
    Inf3InstrPass  => infinitiveTag ;
    Inf4Nom        => infinitiveTag ;
    Inf4Part       => infinitiveTag ;
    Inf5           => infinitiveTag ;
    InfPresPart    => infinitiveTag ;
    InfPresPartAgr => infinitiveTag 
    } ;


  nounTag = mkTag "NOUN" ;
  adjectiveTag = mkTag "ADJ" ;
  verbTag = mkTag "VERB" ;
  adverbTag = mkTag "ADV" ;

  activeTag = mkTag "Voice" "Act" ;
  passiveTag = mkTag "Voice" "Pass" ;
  
  imperativeTag = mkTag "Mood" "Imp" ;
  indicativeTag = mkTag "Mood" "Ind" ;
  participleTag = mkTag "Part" ;
  agentTag = mkTag "Agent" ;
  infinitiveTag = mkTag "Inf" ;
  finiteTag = mkTag "VerbForm" "Fin" ;
  
  connegativeTag = mkTag "Connegative" "Yes" ;
  
  presentTag = mkTag "Tense" "Pres" ;
  conditionalTag = mkTag "Mood" "Cnd" ;
  potentialTag = mkTag "Mood" "Pot" ;
  pastTag = mkTag "Tense" "Past" ;

  tagCase : Case -> Tag = \c -> let k = "Case" in case c of {
    Nom => mkTag k "Nom" ;
    Gen => mkTag k "Gen" ;
    Part => mkTag k "Par" ;
    Transl => mkTag k "Tra" ;
    Ess => mkTag k "Ess" ;
    Iness => mkTag k "Ine" ;
    Elat => mkTag k "Ela" ;
    Illat => mkTag k "Ill" ;
    Adess => mkTag k "Ade" ;
    Ablat => mkTag k "Abl" ;
    Allat => mkTag k "All" ;
    Abess => mkTag k "Abe" 
    } ;
    
  tagNumber : Number -> Tag = \n -> let k = "Number" in case n of {
    Sg => mkTag k "Sing" ;
    Pl => mkTag k "Plur"
    } ;
    
  tagDegree : Degree -> Tag = \n -> let d = "Degree" in case n of {
    Posit  => mkTag d "Pos" ;
    Compar => mkTag d "Cmp" ;
    Superl => mkTag d "Sup"
    } ;

  tagPerson : Person -> Tag = \p -> let k = "Person" in case p of {
    P1 => mkTag k "1" ;
    P2 => mkTag k "2" ;
    P3 => mkTag k "3"
    } ;

  tagBool : Bool -> Tag = \b -> case b of {
    True => "Pos" ;
    False => "Neg"
    } ;

}