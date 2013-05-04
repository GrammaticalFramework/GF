--# -path=.:../abstract:../common:../prelude

resource ResLav = ParamX ** open Prelude in {

flags

  optimize = all ;
  coding = utf8 ;

param

  -- Nouns

  Case = Nom | Gen | Dat | Acc | Loc | Voc ;
  Gender = Masc | Fem ;
  Declension = D0 | D1 | D2 | D3 | D4 | D5 | D6 | DR ;

  -- Adjectives

  Definiteness = Indef | Def ;
  AType = AQual | ARel | AIndecl ;

  AForm =
      AAdj Degree Definiteness Gender Number Case
    | AAdv Degree ;

  -- Verbs

  Voice = Act | Pass ;
  Conjugation = C2 | C3 ;  -- C1 - "irregular" verbs

  -- Verb mood:
  --   Ind - indicative
  --   Rel - relative (http://www.isocat.org/rest/dc/3836)
  --   Deb - debitive (http://www.isocat.org/rest/dc/3835)
  --   Condit - conditional
  VMood =
      Ind Anteriority Tense
    | Rel Anteriority Tense  --# notpresent
    | Deb Anteriority Tense  --# notpresent
    | Condit Anteriority  --# notpresent
    ;

  VForm =
      VInf
    | VInd Person Number Tense
    | VRel Tense
    | VDeb
    | VImp Number
    | VDebRel  -- the relative subtype of debitive
    | VPart Voice Gender Number Case ;

  -- Verb agreement:
  --   Number depends on Subject.Person
  --   Subject.Gender has to be agreed in predicative nominal clauses, and in participle forms
  --   Polarity - double negation, if the subject/object NP has a negated determiner
  Agr =
      AgP1 Number Gender
    | AgP2 Number Gender
    | AgP3 Number Gender Polarity ;

  -- Other

  ThisOrThat = This | That ;

  CardOrd = NCard | NOrd ;
  DForm = DUnit | DTeen | DTen ;

oper

  Verb : Type = { s : Polarity => VForm => Str } ;

  Valence : Type = { subj : Case ; obj : Case ; agr : Agr } ;
  -- TODO: jāpāriet uz vienotu TopicFocus parametru
  -- TODO: ieraksta tips (c:CaseCase, p:Prep; kam ir agr?) vai algebr. param.?

  Prep : Type = { s : Str ; c : Number => Case } ;
  -- For simple case-based valences, the preposition is empty ([])
  -- TODO: position of prepositions (pre or post)

  VP = { v : Verb ; compl : Agr => Str ; val : Valence ; objNeg : Polarity ; voice : Voice } ;
  -- compl: objects, complements, adverbial modifiers
  -- TODO: lai varētu spēlēties ar vārdu secību, compl vēlāk būs jāskalda pa daļām

  VPSlash = VP ** { p : Prep } ;
  -- TODO: p pārklājas ar val.obj un val.agr / vai vp.p = v.p?

  toAgr : Person -> Number -> Gender -> Polarity -> Agr = \pers,num,gend,pol ->
    case pers of {
      P1 => AgP1 num gend ;
      P2 => AgP2 num gend ;
      P3 => AgP3 num gend pol
    } ;

  fromAgr : Agr -> { pers : Person ; num : Number ; gend : Gender ; pol : Polarity } = \agr ->
    case agr of {
      AgP1 num gend     => { pers = P1 ; num = num ; gend = gend ; pol = Pos } ;
      AgP2 num gend     => { pers = P2 ; num = num ; gend = gend ; pol = Pos } ;
      AgP3 num gend pol => { pers = P3 ; num = num ; gend = gend ; pol = pol }
    } ;

  conjAgr : Agr -> Agr -> Agr = \agr1,agr2 ->
    let
      a1 = fromAgr agr1 ;
      a2 = fromAgr agr2
    in
      toAgr
        (conjPerson a1.pers a2.pers) -- FIXME: personu apvienošana ir tricky un ir jāuztaisa korekti
        (conjNumber a1.num a2.num)
        (conjGender a1.gend a2.gend)
        (conjPolarity a1.pol a2.pol) ;

  conjGender : Gender -> Gender -> Gender = \gend1,gend2 ->
    case gend1 of {
      Fem => gend2 ;
      _   => Masc
    } ;

  conjPolarity : Polarity -> Polarity -> Polarity = \pol1,pol2 ->
    case pol1 of {
      Neg => Neg ;
      _   => pol2
    } ;

  toVal : Case -> Case -> Agr -> Valence = \subj,obj,agr -> {
    subj = subj ;
    obj = obj ;
    agr = agr
  } ;

  toVal_Reg : Case -> Valence = \subj -> toVal subj Nom (AgP3 Sg Masc Pos) ;

  vowel : pattern Str = #("a"|"ā"|"e"|"ē"|"i"|"ī"|"o"|"u"|"ū") ;

  simpleCons : pattern Str = #("c"|"d"|"l"|"n"|"s"|"t"|"z") ;
  labialCons : pattern Str = #("b"|"m"|"p"|"v") ;
  sonantCons : pattern Str = #("l"|"m"|"n"|"r"|"ļ"|"ņ") ;
  doubleCons : pattern Str = #("ll"|"ln"|"nn"|"sl"|"sn"|"st"|"zl"|"zn") ;

  prefix : pattern Str = #("aiz"|"ap"|"at"|"ie"|"iz"|"no"|"pa"|"pār"|"pie"|"sa"|"uz") ;

  NON_EXISTENT : Str = "NON_EXISTENT" ;

}
