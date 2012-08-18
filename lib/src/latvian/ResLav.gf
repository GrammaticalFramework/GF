--# -path=.:../abstract:../common:../prelude

resource ResLav = ParamX ** open Prelude in {

flags
  optimize = all ;
  coding = utf8 ;

param
  -- Nouns
  Case = Nom | Gen | Dat | Acc | Loc | Voc ;
  Gender = Masc | Fem ;
  NounDecl = D0 | D1 | D2 | D3 | D4 | D5 | D6 | DR ;

  -- Adjectives
  Definite = Indef | Def ;
  AdjType  = AdjQual | AdjRel | AdjIndecl ;

  -- TODO: pārveidot uz šādu formu lai ir arī apstākļa vārdi kas atvasināti no īpašības vārdiem
  AForm = AAdj Degree Definite Gender Number Case | AAdv Degree ;

  -- Verbs
  -- Ind  = Indicative
  -- Rel  = Relative (Latvian specific: http://www.isocat.org/rest/dc/3836)
  -- Deb  = Debitive (Latvian specific: http://www.isocat.org/rest/dc/3835)
  -- Condit = Conditional
  -- DebitiveRelative = the relative subtype of debitive
  VerbForm =
  	  Infinitive
  	| Indicative Person Number Tense
  	| Relative Tense
  	| Debitive
  	| Imperative Number
  	| DebitiveRelative
  	| Participle Gender Number Case
  	;
    -- TODO: divdabim noteiktā forma un arī pārākā / vispārākā pakāpe

  VerbMood =
  	  Ind Anteriority Tense
  	| Rel Anteriority Tense		--# notpresent
  	| Deb Anteriority Tense		--# notpresent
  	| Condit Anteriority		--# notpresent
  	;

  VerbConj = C2 | C3 ;

  -- TODO: Kāpēc Gender ir tikai P3? Lokāmo divdabju dēļ?
  --       Dzimte jāsaskaņo vienmēr - nominālo izteicēju dēļ... 
  Agr = AgP1 Number Gender | AgP2 Number Gender | AgP3 Number Gender ;

  ThisOrThat = This | That ;
  CardOrd = NCard | NOrd ;
  DForm = unit | teen | ten ;

oper
  vowel : pattern Str = #("a"|"ā"|"e"|"ē"|"i"|"ī"|"o"|"u"|"ū") ;

  simpleCons : pattern Str = #("c"|"d"|"l"|"n"|"s"|"t"|"z") ;
  labialCons : pattern Str = #("b"|"m"|"p"|"v") ;
  sonantCons : pattern Str = #("l"|"m"|"n"|"r"|"ļ"|"ņ") ;
  doubleCons : pattern Str = #("ll"|"ln"|"nn"|"sl"|"sn"|"st"|"zl"|"zn") ;

  prefix : pattern Str = #("aiz"|"ap"|"at"|"ie"|"iz"|"no"|"pa"|"pār"|"pie"|"sa"|"uz") ;

  NON_EXISTENT : Str = "NON_EXISTENT" ;

  Verb : Type = { s : Polarity => VerbForm => Str } ;

  VP = { v : Verb ; s2 : Agr => Str } ;  -- s2 = object(s), complements, adverbial modifiers

  VPSlash = VP ** { p : prep } ;
  -- principā rekur ir objekts kuram jau kaut kas ir bet ir vēl viena brīva valence...

  prep = { s : Str ; c : Number => Case } ;

  --Valence : Type = { p : Prep ; c : Number => Case } ;
  -- e.g. 'ar' + Sg-Acc or Pl-Dat; Preposition may be skipped for simple case-baced valences

  toAgr : Number -> Person -> Gender -> Agr = \n,p,g ->
    case p of {
      P1 => AgP1 n g ;
      P2 => AgP2 n g ;
      P3 => AgP3 n g
    } ;

  fromAgr : Agr -> { n : Number ; p : Person ; g : Gender } = \a ->
    case a of {
      AgP1 n g => { n = n ; p = P1 ; g = g } ;
      AgP2 n g => { n = n ; p = P2 ; g = g } ;
      AgP3 n g => { n = n ; p = P3 ; g = g }
    } ;

  conjAgr : Agr -> Agr -> Agr = \a0,b0 ->
    let
      a = fromAgr a0 ;
      b = fromAgr b0
    in
      toAgr
        (conjNumber a.n b.n)
        (conjPerson a.p b.p)	-- FIXME: personu apvienošana ir tricky un ir jāuztaisa korekti
		(conjGender a.g b.g) ;

  conjGender : Gender -> Gender -> Gender = \a,b ->
    case a of {
      Fem => b ;
      _  => Masc
    } ;

  agrgP3 : Number -> Gender -> Agr = \n,g -> toAgr n P3 g ;

}
