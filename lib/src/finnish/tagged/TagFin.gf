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

  pairTag : Tag -> Tag -> Tag * Tag = \t,u -> <t,u> ;

  tagNForm : NForm -> Tag = \nf -> let ts = tagNForms nf in consTag ts.p1 ts.p2 ;
  
  tagNForms : NForm -> Tag * Tag = \nf -> case nf of {  -- keep separate in order to squeeze in Degree of adjectives
    NCase n c     => pairTag (tagCase c) (tagNumber n) ;
    NComit        => pairTag (mkTag "Case" "Com") (tagNumber Pl) ; 
    NInstruct     => pairTag (mkTag "Case" "Ins") (tagNumber Pl) ; 
    NPossNom n    => pairTag (tagCase Nom) (tagNumber n) ; 
    NPossGen n    => pairTag (tagCase Gen) (tagNumber n) ; 
    NPossTransl n => pairTag (tagCase Transl) (tagNumber n) ; 
    NPossIllat n  => pairTag (tagCase Illat) (tagNumber n) ; 
    NCompound     => pairTag (mkTag "Form" "Comp") (tagNumber Sg) ---- TODO: how is this in UD?
    } ;

  tagPron : Str -> Agr -> NPForm -> Tag = \typ,agr,npf ->
    let tagr : Number * Person = case agr of {
      Ag n p => <n, p> ;
      AgPol => <Pl, P2> ---- Plur in ud?
      } ;
      n = tagr.p1 ; p = tagr.p2 ;
      pt : Tag = mkTag "PronType" typ ; -- Dem Ind Int Prs Rel
    in
    case npf of {
      NPCase c => consTag (tagNForm (NCase n c))(tagPerson p) pt ;
      NPAcc    => consTag (mkTag "Case" "Acc") (tagNumber n) (tagPerson p) pt ; ---- effect for pronouns only?
      NPSep    => consTag (tagNForm (NCase n Nom))(tagPerson p) pt              ---- correct pro-drop effect?
    } ;

  tagDegreeAForm : Degree -> AForm -> Str = \d,af -> case af of {
    AN nf => let ts = tagNForms nf in consTag ts.p1 (tagDegree d) ts.p2 ;
    AAdv  => consTag adverbTag (tagDegree d)  ---- TODO: how is this in UD?
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
    PastPartAct af  => consTag (tagDegreeAForm Posit af) (tagPartForm "Past") participleTag activeTag ;
    PastPartPass af => consTag (tagDegreeAForm Posit af) (tagPartForm "Past") participleTag passiveTag ;
    PresPartAct af  => consTag (tagDegreeAForm Posit af) (tagPartForm "Pres") participleTag activeTag ;
    PresPartPass af => consTag (tagDegreeAForm Posit af) (tagPartForm "Pres") participleTag passiveTag ;
    AgentPart af    => consTag (tagDegreeAForm Posit af) (tagPartForm "Agt")  participleTag activeTag
    } ;

  tagInfForm : InfForm -> Str = \vf -> case vf of {
    Inf1           => infinitiveTag "1" ;
    Inf1Long       => infinitiveTag "1" ;       --- insert Person[psor]=3 when used with poss suff
    Inf2Iness      => infinitiveTag "Ine" "2" ;
    Inf2Instr      => infinitiveTag "Ins" "2" ;
    Inf2InessPass  => infinitiveTag "Ins" "2" "Pass" ;   
    Inf3Iness      => infinitiveTag "Ine" "3" ;
    Inf3Elat       => infinitiveTag "Ela" "3" ;
    Inf3Illat      => infinitiveTag "Ill" "3" ;
    Inf3Adess      => infinitiveTag "Ade" "3" ;
    Inf3Abess      => infinitiveTag "Abe" "3" ;
    Inf3Instr      => infinitiveTag "Ins" "3" ; 
    Inf3InstrPass  => infinitiveTag "Ins" "3" "Pass" ;
    Inf4Nom        => infinitiveTag "Nom" "4" ;
    Inf4Part       => infinitiveTag "Par" "4" ;
    Inf5           => infinitiveTag "5" ; ---- not in UD
    InfPresPart    => consTag (tagDegreeAForm Posit (AN (NCase Sg Nom))) (tagPartForm "Pres") participleTag activeTag ;
    InfPresPartAgr => consTag (tagDegreeAForm Posit (AN (NCase Sg Nom))) (tagPartForm "Pres") participleTag activeTag --- poss to add
    } ;

  infinitiveTag = overload {
    infinitiveTag : Str -> Tag = \i ->
      consTag (mkTag "InfForm" i) (tagNumber Sg) (mkTag "VerbForm" "Inf") activeTag ;  --- UD wants voice and number
    infinitiveTag : Str -> Str -> Tag = \c,i ->
      consTag (mkTag "Case" c) (mkTag "InfForm" i) (tagNumber Sg) (mkTag "VerbForm" "Inf") activeTag ;
    infinitiveTag : Str -> Str -> Str -> Tag = \c,i,v ->
      consTag (mkTag "Case" c) (mkTag "InfForm" i) (tagNumber Sg) (mkTag "VerbForm" "Inf") (mkTag "Voice" v) ;
    } ;

  tagPartForm : Str -> Tag = \pf -> mkTag "PartForm" pf ;

  nounTag = mkTag "NOUN" ;
  adjectiveTag = mkTag "ADJ" ;
  verbTag = mkTag "VERB" ;
  adverbTag = mkTag "ADV" ;

  activeTag = mkTag "Voice" "Act" ;
  passiveTag = mkTag "Voice" "Pass" ;
  
  imperativeTag = mkTag "Mood" "Imp" ;
  indicativeTag = mkTag "Mood" "Ind" ;
  participleTag = mkTag "VerbForm" "Part" ;
  agentTag = mkTag "Agent" ;
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