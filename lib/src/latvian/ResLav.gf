--# -path=.:abstract:common:prelude

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

  -- Verb moods:
  --   Ind - indicative
  --   Rel - relative (http://www.isocat.org/rest/dc/3836)
  --   Deb - debitive (http://www.isocat.org/rest/dc/3835)
  --   Condit - conditional
  VMood =
      Ind Anteriority Tense
    | Rel Anteriority Tense  --# notpresent
    | Deb Anteriority Tense  --# notpresent
    | Condit Anteriority     --# notpresent
    ;

  VForm =
      VInf
    | VInd Person Number Tense
    | VRel Tense
    | VDeb
    | VImp Number
    | VDebRel  -- the relative subtype of debitive
    | VPart Voice Gender Number Case ;

  -- Number and gender has to be agreed in predicative nominal clauses
  Agreement =
      AgrP1 Number Gender
    | AgrP2 Number Gender
    | AgrP3 Number Gender ;

  -- Other

  ThisOrThat = This | That ;

  CardOrd = NCard | NOrd ;
  DForm = DUnit | DTeen | DTen ;

oper

  Noun : Type = { s : Number => Case => Str ; gend : Gender } ;

  ProperNoun : Type = { s : Case => Str ; gend : Gender ; num : Number } ;
  
  Pronoun : Type = { s : Case => Str ; agr : Agreement ; poss : Gender => Number => Case => Str ; pol : Polarity } ;

  Adjective : Type = { s : AForm => Str } ;

  Preposition : Type = { s : Str ; c : Number => Case } ;

  Verb : Type = { s : Polarity => VForm => Str ; leftVal : Case } ;

  VP : Type = {
    v        : Verb ;
    compl    : Agreement => Str ;  -- the subject-complement agreement
    voice    : Voice ;
    leftVal  : Case ;              -- the left valence (typically, the subject)
    rightAgr : Agreement ;         -- for the potential subject-verb agreement (the subject can be on the right side)
    rightPol : Polarity            -- for the potential double negation
  } ;

  VPSlash : Type = VP ** { rightVal : Preposition } ;  -- the right valence (typically, the object)

  buildVP : VP -> Polarity -> VForm -> Agreement -> Str = \vp,pol,vf,agr ->
    vp.v.s ! pol ! vf ++ vp.compl ! agr ;

  insertObj : (Agreement => Str) -> VP -> VP = \obj,vp -> {
    v        = vp.v ;
    compl    = \\agr => vp.compl ! agr ++ obj ! agr ;
    voice    = vp.voice ;
    leftVal  = vp.leftVal ;
    rightAgr = vp.rightAgr ;
    rightPol = vp.rightPol
  } ;

  insertObjPre : (Agreement => Str) -> VP -> VP = \obj,vp -> {
    v        = vp.v ;
    compl    = \\agr => obj ! agr ++ vp.compl ! agr ;
    voice    = vp.voice ;
    leftVal  = vp.leftVal ;
    rightAgr = vp.rightAgr ;
    rightPol = vp.rightPol
  } ;

  insertObjSlash : (Agreement => Str) -> VPSlash -> VPSlash = \obj,vp ->
    insertObj obj vp ** { rightVal = vp.rightVal } ;

  getInf : Verb -> Str = \v -> v.s ! Pos ! VInf ;

  toAgr : Person -> Number -> Gender -> Agreement = \pers,num,gend ->
    case pers of {
      P1 => AgrP1 num gend ;
      P2 => AgrP2 num gend ;
      P3 => AgrP3 num gend
    } ;

  fromAgr : Agreement -> { pers : Person ; num : Number ; gend : Gender } = \agr ->
    case agr of {
      AgrP1 num gend => { pers = P1 ; num = num ; gend = gend } ;
      AgrP2 num gend => { pers = P2 ; num = num ; gend = gend } ;
      AgrP3 num gend => { pers = P3 ; num = num ; gend = gend }
    } ;

  conjAgr : Agreement -> Agreement -> Agreement = \agr1,agr2 ->
    let
      a1 = fromAgr agr1 ;
      a2 = fromAgr agr2
    in toAgr
      (conjPerson a1.pers a2.pers)
      (conjNumber a1.num a2.num)
      (conjGender a1.gend a2.gend) ;

  conjGender : Gender -> Gender -> Gender = \gend1,gend2 ->
    case gend1 of {
      Fem  => gend2 ;
      Masc => Masc
    } ;

  vowel : pattern Str = #("a"|"ā"|"e"|"ē"|"i"|"ī"|"o"|"u"|"ū") ;

  simpleCons : pattern Str = #("c"|"d"|"l"|"n"|"s"|"t"|"z") ;
  labialCons : pattern Str = #("b"|"m"|"p"|"v") ;
  sonantCons : pattern Str = #("l"|"m"|"n"|"r"|"ļ"|"ņ") ;
  doubleCons : pattern Str = #("ll"|"ln"|"nn"|"sl"|"sn"|"st"|"zl"|"zn") ;

  prefix : pattern Str = #("aiz"|"ap"|"at"|"ie"|"iz"|"no"|"pa"|"pār"|"pie"|"sa"|"uz") ;

  NON_EXISTENT : Str = "NON_EXISTENT" ;

}
