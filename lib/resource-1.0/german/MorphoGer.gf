--# -path=.:../common:../../prelude
--
----1 A Simple German Resource Morphology
----
---- Aarne Ranta & Harald Hammarström 2002 -- 2006
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsGer$, which
---- gives a higher-level access to this module.
--
resource MorphoGer = ResGer ** open Prelude, (Predef=Predef) in {

  flags optimize=all ;

oper

-- For [Structural Structural.html].

  mkPrep : Str -> Case -> Preposition = \s,c -> 
    {s = s ; c = c} ;

  nameNounPhrase : {s : Case => Str} ->  {s : Case => Str ; a : Agr} = \name ->
    name ** {a = agrP3 Sg} ;

  detLikeAdj : Number -> Str -> 
    {s : Gender => Case => Str ; n : Number ; a : Adjf} = \n,dies -> 
      {s = appAdj (regA dies) ! n ; n = n ; a = Weak} ;




{-
--2 Nouns

-- But we never need all the six forms at the same time. Often
-- we need just two, three, or four forms.
oper

  mkNoun4 : (_,_,_,_ : Str) -> Gender -> CommNoun = \kuh,kuhes,kühe,kühen ->
      mkNoun kuh kuh kuh kuhes kühe kühen ;

  mkNoun3 : (_,_,_ : Str) -> Gender -> CommNoun = \kuh,kühe,kühen ->
      mkNoun kuh kuh kuh kuh kühe kühen ;

  mkNoun2n : (_,_ : Str) -> Gender -> CommNoun = \zahl, zahlen -> 
      mkNoun3 zahl zahlen zahlen ;

  mkNoun2es : (_,_ : Str) -> Gender -> CommNoun = \wort, wörter -> 
      mkNoun wort wort wort (wort + "es") wörter (wörter + "n") ;

  mkNoun2s : (_,_ : Str) -> Gender -> CommNoun = \vater, väter -> 
      mkNoun vater vater vater (vater + "s") väter (väter + "n") ;

  mkNoun2ses : (_,_ : Str) -> Gender -> CommNoun = \wort,wörter -> 
      mkNoun wort wort wort (wort + variants {"es" ; "s"}) wörter (wörter + "n") ;

-- Here are the school grammar declensions with their commonest variations.
-- Unfortunately we cannot define *Umlaut* in GF, but have to give two forms.
--
-- First declension, with plural "en"/"n", including weak masculines:

  declN1  : Str -> CommNoun = \zahl  -> 
    mkNoun2n zahl  (zahl + "en") Fem ;

  declN1in : Str -> CommNoun = \studentin -> 
    mkNoun2n studentin (studentin + "nen") Fem ;

  declN1e : Str -> CommNoun = \stufe -> 
    mkNoun2n stufe (stufe + "n") Fem ; 

  declN1M : Str -> CommNoun = \junge -> let {jungen = junge + "n"} in
    mkNoun junge jungen jungen jungen jungen jungen Masc ;

  declN1eM : Str -> CommNoun = \soldat -> let {soldaten = soldat + "en"} in
    mkNoun soldat soldaten soldaten soldaten soldaten soldaten Masc ;

-- Second declension, with plural "e":

  declN2  : Str -> CommNoun = \punkt -> 
    mkNoun2es punkt (punkt+"e") Masc ;

  declN2n  : Str -> CommNoun = \bein -> 
    mkNoun2es bein (bein+"e") Neut ;

  declN2i  : Str -> CommNoun = \onkel -> 
    mkNoun2s onkel onkel Masc ;

  declN2in  : Str -> CommNoun = \segel -> 
    mkNoun2s segel segel Neut ;

  declN2u : (_,_ : Str) -> CommNoun = \raum,räume -> 
    mkNoun2es raum räume Masc ;

  declN2uF : (_,_ : Str) -> CommNoun = \kuh,kühe -> 
    mkNoun3 kuh kühe (kühe + "n") Fem ;

-- Third declension, with plural "er":

  declN3  : Str -> CommNoun = \punkt -> 
    mkNoun2es punkt (punkt+"er") Neut ;

  declN3u : (_,_ : Str) -> CommNoun = \buch,bücher -> 
    mkNoun2ses buch bücher Neut ;

  declN3uS : (_,_ : Str) -> CommNoun = \haus,häuser -> 
    mkNoun2es haus häuser Neut ;

-- Plural with "s":

  declNs : Str -> CommNoun = \restaurant -> 
    mkNoun3 restaurant (restaurant+"s") (restaurant+"s") Neut ;



--2 Adjectives
--
-- As explained in $types.Deu.gf$, it
-- would be superfluous to use the cross product of gender and number,
-- since there is no gender distinction in the plural. But it is handy to have
-- a function that constructs gender-number complexes.
  
  gNumber : Gender -> Number -> GenNum = \g,n -> 
    case n of {
      Sg => GSg g ;
      Pl => GPl
      } ;

-- This function costructs parameters in the complex type of adjective forms.

  aMod : Adjf -> Gender -> Number -> Case -> AForm = \a,g,n,c -> 
    AMod a (gNumber g n) c ;

-- The worst-case macro for adjectives (positive degree) only needs
-- two forms.
  
  mkAdjective : (_,_ : Str) -> Adjective = \böse,bös -> {s = table {
    APred => böse ;
    AMod Strong (GSg Masc) c => 
      caselist (bös+"er") (bös+"en") (bös+"em") (bös+"es") ! c ;
    AMod Strong (GSg Fem) c => 
      caselist (bös+"e") (bös+"e") (bös+"er") (bös+"er") ! c ;
    AMod Strong (GSg Neut) c => 
      caselist (bös+"es") (bös+"es") (bös+"em") (bös+"es") ! c ;
    AMod Strong GPl c => 
      caselist (bös+"e") (bös+"e") (bös+"en") (bös+"er") ! c ;
    AMod Weak (GSg g) c => case <g,c> of {
      <_,Nom>    => bös+"e" ;
      <Masc,Acc> => bös+"en" ;
      <_,Acc>    => bös+"e" ;
      _          => bös+"en" } ;
    AMod Weak GPl c => bös+"en"
    }} ;

-- Here are some classes of adjectives:
 
  adjReg   : Str -> Adjective = \gut -> mkAdjective gut gut ;
  adjE     : Str -> Adjective = \bös -> mkAdjective (bös+"e") bös ;
  adjEr    : Str -> Adjective = \teu -> mkAdjective (teu+"er") (teu+"r") ;
  adjInvar : Str -> Adjective = \prima -> {s = table {_ => prima}} ;

-- The first three classes can be recognized from the end of the word, depending
-- on if it is "e", "er", or something else.

  adjGen : Str -> Adjective = \gut -> let {
    er  = Predef.dp 2 gut ;
    teu = Predef.tk 2 gut ;
    e   = Predef.dp 1 gut ;
    bös = Predef.tk 1 gut
  } in
  ifTok Adjective er "er" (adjEr  teu) (
  ifTok Adjective e  "e"  (adjE   bös) (
                          (adjReg gut))) ;


-- The comparison of adjectives needs three adjectives in the worst case.

  mkAdjComp : (_,_,_ : Adjective) -> AdjComp = \gut,besser,best -> 
    {s = table {Pos => gut.s ; Comp => besser.s ; Sup => best.s}} ;

-- It can be done by just three strings, if each of the comparison
-- forms taken separately is a regular adjective.

  adjCompReg3 : (_,_,_ : Str) -> AdjComp = \gut,besser,best ->
    mkAdjComp (adjReg gut) (adjReg besser) (adjReg best) ;

-- If also the comparison forms are regular, one string is enough.

  adjCompReg : Str -> AdjComp = \billig ->
    adjCompReg3 billig (billig+"er") (billig+"st") ;


--OLD:
--2 Verbs
--
-- We limit ourselves to verbs in present tense infinitive, indicative, 
-- and imperative, and past participle. Other forms will be introduced later.
--
-- The worst-case macro needs three forms: the infinitive, the third person
-- singular indicative, and the second person singular imperative. 
-- We take care of the special cases "ten", "sen", "ln", "rn".
--
-- A famous law about Germanic languages says that plural first and third 
-- person are similar.

--NEW (By Harald Hammarström):
--2 Verbs
-- The worst-case macro needs six forms:
-- x Infinitive, 
-- x 3p sg pres. indicative, 
-- x 2p sg imperative, 
-- x 1/3p sg imperfect indicative, 
-- x 1/3p sg imperfect subjunctive (because this uncommon form can have umlaut)
-- x the perfect participle 

-- But you'll only want to use one of the five macros:
-- x weakVerb              -- For a regular verb like legen
-- x verbGratulieren       -- For a regular verb without ge- in the perfect
--                            particple. Like gratulieren, beweisen etc 
-- x verbStrongSingen      -- A strong verb without umlauting present tense.
--                            You'll need to supply the strong imperfect forms
--                            as well as the participle. 
-- x verbStrongSehen       -- A strong verb that umlauts in the 2/3p sg pres
--                            indicative as well as the imperative. You'll
--                            need to give (only) the 3rd p sg pres ind. in
--                            addition to the strong imperfect forms and the
--                            part participle.
-- x verbStrongLaufen      -- A strong verb that umlauts in the 2/3p sg pres
--                            indicative but NOT the imperative. You'll
--                            need to give (only) the 3rd p sg pres ind. in
--                            addition to the strong imperfect forms and the
--                            part participle.
--
-- Things that are handled automatically
-- x Imperative e (although optional forms are not given)
-- x Extra e in verbs like arbeitete, regnet, findet, atmet.
--   NOTE: If pres. umlauting strong verbs are defined through the verbumStrong
--   macro (which they should) it is automatically handled so they avoid 
--   falling into this rule e.g er tritt (rather than *er tritet)
-- x s is dropped in the 2p sg if appropriate du setzt
-- x verbs that end in -rn, -ln rather than -en

-- Things that are not handled:
-- x -ß-/-ss-
-- x Optional dropping of -e- in e.g wand(e)re etc
-- x Optional indicative forms instead of pres. subj. 2p sg. and 2p pl.  
-- x (Weak) verbs without the ge- on the participle (in wait for a systematic
--   treatment of the insep. prefixes and stress). You have to manually use
--   the verbGratulieren for this. E.g do verbGratulieren "beweisen" - 
--   verbWeak "beweisen" would yield *gebeweist.

  impe : Str -> Str = \stem ->  
  let
    e = ifTok Str (Predef.dp 2 stem) "ig" "e" [] ;
    e2 = (adde stem)
  in  
    e + e2 ;
 
  adde : Str -> Str = \stem ->
  let
    eVowelorLiquid : Str -> Str = \u -> case u of {
      "l" => "e" ; 
      "r" => "e" ;
      "a" => "e" ;
      "o" => "e" ;
      "u" => "e" ;
      "e" => "e" ;
      "i" => "e" ;
      "ü" => "e" ;
      "ä" => "e" ;
      "ö" => "e" ;
      _   => [] 
    } ;   

    eConsonantmn : Str -> Str -> Str = \nl, l -> 
      case l of {"m" => eVowelorLiquid nl ;
                 "n" => eVowelorLiquid nl ;
                 _ => []} ;
 

    twolast = Predef.dp 2 stem ;
    nl = Predef.tk 1 twolast ;
    l = Predef.dp 1 stem ;
    e = case l of {
          "d" => "e" ;
          "t" => "e" ;
          _ => eConsonantmn nl l
        } ;
  in 
    e ;


  mkVerbum : (_,_,_,_,_,_ : Str) -> Verbum = \geben,gibt,gib,gab,gäbe,gegeben -> 
    let {
       ifSibilant : Str -> Str -> Str -> Str = \u,b1,b2 -> case u of {
         "s" => b1 ;
         "x" => b1 ;
         "z" => b1 ;
         "ß" => b1 ;
         _   => b2 
       } ; 
       en = Predef.dp 2 geben ;
       geb = ifTok Tok (Predef.tk 1 en) "e" (Predef.tk 2 geben)(Predef.tk 1 geben) ;
       gebt = geb + (adde geb) + "t" ;
       gebte = ifTok Tok (Predef.dp 1 gab) "e" gab (gab + "e") ;
       gibst = ifSibilant (Predef.dp 1 gib) (gib + "t") (gib + "st") ;
       gegebener = (adjReg gegeben).s ;
    } in table {
       VInf       => geben ;
       VInd Sg P1 => geb + "e" ;
       VInd Sg P2 => gibst ;
       VInd Sg P3 => gibt ;
       VInd Pl P2 => gebt ;
       VInd Pl _  => geben ; -- the famous law
       VImp Sg    => gib + (impe gib) ;
       VImp Pl    => gebt ;
       VSubj Sg P1 => geb + "e" ;
       VSubj Sg P2 => geb + "est" ;
       VSubj Sg P3 => geb + "e" ;
       VSubj Pl P2 => geb + "et" ;
       VSubj Pl _  => geben ;
       VPresPart a => (adjReg (geben + "d")).s ! a ;

       VImpfInd Sg P1 => gab ;
       VImpfInd Sg P2 => gab + (adde gab) + "st" ;
       VImpfInd Sg P3 => gab ;
       VImpfInd Pl P2 => gab + (adde gab) + "t" ;
       VImpfInd Pl _  => gebte + "n" ;

       VImpfSubj Sg P1 => gäbe ;
       VImpfSubj Sg P2 => gäbe + "st" ;
       VImpfSubj Sg P3 => gäbe ;
       VImpfSubj Pl P2 => gäbe + "t" ;
       VImpfSubj Pl _  => gäbe + "n" ;

       VPart a    => gegebener ! a
       } ;
 
-- Weak verbs:
  verbumWeak : Str -> Verbum = \legen ->
    let 
       leg = (Predef.tk 2 legen) ;
       legte = leg + "te" ;
    in
       mkVerbum legen (leg + (adde leg) + "t") leg legte legte ("ge" + (leg + "t")) ;

  regVerb = verbumWeak ;


-- Weak verbs that don't have ge- in the participle
  verbumGratulieren : Str -> Verbum = \gratulieren ->
    let 
       gratulier = (Predef.tk 2 gratulieren) ;
       gratulierte = gratulier + "te" ;
    in
       mkVerbum gratulieren (gratulier + (adde gratulier) + "t") gratulier gratulierte gratulierte (gratulier + "t") ;



-- Strong verbs (non-present-tense umlauting):
  verbumStrongSingen : (_,_,_,_ : Str) -> Verbum = \singen, sang, sänge, gesungen ->
    let 
       sing = (Predef.tk 2 singen)
    in
       mkVerbum singen (sing + (adde sing) + "t") sing sang sänge gesungen ;

-- Verbs with Umlaut in the 2nd and 3rd person singular and imperative:
  verbumStrongSehen : (_,_,_,_,_ : Str) -> Verbum = \sehen,sieht,sah,sähe,gesehen -> 
    let 
       sieh = Predef.tk 1 sieht ;
    in 
       mkVerbum sehen sieht sieh sah sähe gesehen ;

-- Verbs with Umlaut in the 2nd and 3rd person singular but not imperative:
-- (or any verb where the 3rd p sg pres ind is "special" and the 2p sg pres ind -- uses its stem.)   
  verbumStrongLaufen : (_,_,_,_,_ : Str) -> Verbum = \laufen,läuft,lief,liefe,gelaufen -> 
    let  
       lauf = Predef.dp 2 laufen ;
    in 
       mkVerbum laufen läuft lauf lief liefe gelaufen ;


-- The verb "be":

  verbumSein : Verbum = let {
    sein = verbumStrongSingen "sein" "war" "wäre" "gewesen" ;
  } in
  table {
    VInf       => "sein" ;
    VInd Sg P1 => "bin" ;
    VInd Sg P2 => "bist" ;
    VInd Sg P3 => "ist" ;
    VInd Pl P2 => "seid" ;
    VInd Pl _  => "sind" ;
    VImp Sg    => "sei" ;
    VImp Pl    => "seid" ;

    VSubj Sg P1 => "sei" ;
    VSubj Sg P2 => (variants {"seiest" ; "seist"}) ;
    VSubj Sg P3 => "sei" ;
    VSubj Pl P2 => "seien" ;
    VSubj Pl _  => "seiet" ;
    VPresPart a => ((adjReg "seiend").s) ! a ;

    v => sein ! v 

    } ;

-- Modal auxiliary verbs
  verbumAux : (_,_,_,_,_ : Str) -> Verbum = \können,kann,konnte,könnte,gekonnt -> 
  let k =        mkVerbum können kann kann konnte könnte gekonnt ;--- (verbumStrongLaufen können kann konnte könnte gekonnt)
  in 
  table {
    VInd Sg P1 => kann ;
    v          => k ! v
  } ;

  verbumKönnen = verbumAux "können" "kann" "konnte" "könnte" "gekonnt" ;
  verbumDürfen = verbumAux "dürfen" "darf" "durfte" "dürfte" "gedurft" ;
  verbumMögen = verbumAux "mögen" "mag" "mochte" "möchte" "gemocht" ;
  verbumMüssen = verbumAux "müssen" "muss" "musste" "müsste" "gemusst" ;
  verbumSollen = verbumAux "sollen" "soll" "sollte" "söllte" "gesollt" ;
  verbumWollen = verbumAux "wollen" "will" "wollte" "wöllte" "gewollt" ;
  verbumWissen = verbumAux "wissen" "weiss" "wusste" "wüsste" "gewusst" ;

-- The verb "have":

  verbumHaben : Verbum = let {
    haben = (verbumStrongSingen "haben" "hatte" "hätte" "gehabt")
    } in 
    table {
      VInd Sg P2 => "hast" ;
      VInd Sg P3 => "hat" ;
      v          => haben ! v
      } ;

-- The verb "become", used as the passive auxiliary:

  verbumWerden : Verbum = let {
    werden = (verbumStrongSingen "werden" "wurde" "würde" "geworden") ;
    } in 
    table {
      VInd Sg P2 => "wirst" ;
      VInd Sg P3 => "wird" ;
      v          => werden ! v
      } ;




-- A *full verb* ($Verb$) consists of the inflection forms ($Verbum$) and
-- a *particle* (e.g. "aus-sehen"). Simple verbs are the ones that have no 
-- such particle.

  mkVerb : Verbum -> Particle -> Verb = \v,p -> {s = v ; s2 = p} ;

  mkVerbSimple : Verbum -> Verb = \v -> mkVerb v [] ;

  verbSein = mkVerbSimple verbumSein ;
  verbHaben = mkVerbSimple verbumHaben ;
  verbWerden = mkVerbSimple verbumWerden ;

-- Apparently needed for "es gibt" etc
  verbGeben = mkVerbSimple (verbumStrongSehen "geben" "gibt" "gab" "gäbe" "gegeben") ; 
-}

} ;

