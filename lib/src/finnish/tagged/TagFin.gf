resource TagFin = open ResFin, Prelude in {

oper
  Tag : Type = Str ;

  tagWord : Tag -> Str -> Str = \tag,lemma -> "[" ++ lemma ++ tag ++ "]" ;

  mkTag = overload {
    mkTag : Str -> Tag = \t -> "+" + t ;
    mkTag : Str -> Str -> Tag = \t,v -> t ++ "=" + v ;
    } ;
    
  tagNForm : NForm -> Str = \nf -> case nf of {
    NCase n c     => tagNumber n  ++ tagCase c ; 
    NComit        => tagNumber Pl ++ mkTag "Com" ;
    NInstruct     => tagNumber Pl ++ mkTag "Ins" ; 
    NPossNom n    => tagNumber n  ++ tagCase Nom ;
    NPossGen n    => tagNumber n  ++ tagCase Gen ;
    NPossTransl n => tagNumber n  ++ tagCase Transl ;
    NPossIllat n  => tagNumber n  ++ tagCase Illat ;
    NCompound     => mkTag "Comp"
    } ;

  tagAForm : AForm -> Str = \af -> case af of {
    AN nf => tagNForm nf ;
    AAdv => mkTag "Adv"
    } ;

  tagVForm : VForm -> Str = \vf -> case vf of {
    Inf    infform  => tagInfForm infform ;
    Presn  num pers => activeTag ++ presentTag ++ tagNumber num ++ tagPerson pers ;
    Impf   num pers => activeTag ++ imperfectTag ++ tagNumber num ++ tagPerson pers ;
    Condit num pers => activeTag ++ conditionalTag ++ tagNumber num ++ tagPerson pers ;
    Potent num pers => activeTag ++ potentialTag  ++ tagNumber num ++ tagPerson pers ;
    PotentNeg       => activeTag ++ potentialTag  ++ negativeTag ;
    Imper  num      => activeTag ++ imperativeTag ++ tagNumber num ++ tagPerson P2 ;
    ImperP3 num     => activeTag ++ imperativeTag ++ tagNumber num ++ tagPerson P3 ;
    ImperP1Pl       => activeTag ++ imperativeTag ++ tagNumber Pl  ++ tagPerson P1 ;
    ImpNegPl        => activeTag ++ imperativeTag ++ negativeTag ++ tagNumber Pl ;
    PassPresn bool  => passiveTag ++ presentTag ++ tagBool bool ;
    PassImpf  bool  => passiveTag ++ presentTag ++ tagBool bool ;
    PassCondit bool => passiveTag ++ imperfectTag ++ tagBool bool ;
    PassPotent bool => passiveTag ++ potentialTag ++ tagBool bool ;
    PassImper bool  => passiveTag ++ imperativeTag ++ tagBool bool ;
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


  nounTag = mkTag "N" ;
  adjectiveTag = mkTag "A" ;
  verbTag = mkTag "V" ;

  activeTag = mkTag "Act" ;
  passiveTag = mkTag "Pass" ;
  
  imperativeTag = mkTag "Imp" ;
  participleTag = mkTag "Part" ;
  agentTag = mkTag "Agent" ;
  infinitiveTag = mkTag "Inf" ;
  
  negativeTag = mkTag "Neg" ;
  
  presentTag = mkTag "Pres" ;
  imperfectTag = mkTag "Impf" ;
  conditionalTag = mkTag "Cond" ;
  potentialTag = mkTag "Pot" ;
  pastTag = mkTag "Past" ; -- for participles

  tagCase : Case -> Tag = \c -> case c of {
    Nom => mkTag "Nom" ;
    Gen => mkTag "Gen" ;
    Part => mkTag "Par" ;
    Transl => mkTag "Tra" ;
    Ess => mkTag "Ess" ;
    Iness => mkTag "Ine" ;
    Elat => mkTag "Ela" ;
    Illat => mkTag "Ill" ;
    Adess => mkTag "Ade" ;
    Ablat => mkTag "Abl" ;
    Allat => mkTag "All" ;
    Abess => mkTag "Abe" 
    } ;
    
  tagNumber : Number -> Tag = \n -> case n of {
    Sg => mkTag "Sg" ;
    Pl => mkTag "Pl"
    } ;
    
  tagDegree : Degree -> Tag = \n -> case n of {
    Posit  => mkTag "Pos" ;
    Compar => mkTag "Com" ;
    Superl => mkTag "Sup"
    } ;

  tagPerson : Person -> Tag = \p -> case p of {
    P1 => mkTag "Person1" ;
    P2 => mkTag "Person2" ;
    P3 => mkTag "Person3"
    } ;

  tagBool : Bool -> Tag = \b -> case b of {
    True => "Pos" ;
    False => "Neg"
    } ;

}