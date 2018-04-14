--# -path=.:../romance:../common:../../prelude

--1 A Simple Portuguese Resource Morphology
--
--
-- This resource morphology contains definitions needed in the
-- resource syntax. To build a lexicon, it is better to use
-- $ParadigmsPor$, which gives a higher-level access to this module.

resource MorphoPor = CommonRomance, ResPor **
  open PhonoPor, Prelude, Predef,
  CatPor in {

  flags optimize=all ;
        coding=utf8 ;
--2 Nouns
--
-- The following macro is useful for creating the forms of
-- number-dependent tables, such as common nouns.

oper
  numForms : (_,_ : Str) -> Number => Str = \campus, campi ->
    table {Sg => campus ; Pl => campi} ;

-- For example:
  nomVinho : Str -> Number => Str = \vinho ->
    numForms vinho (vinho + "s") ;

  nomAreia : Str -> Number => Str = \areia ->
    numForms areia areia ;

  nomAlemao : Str -> Number => Str = \alemao ->
    numForms alemao (init alemao + "es") ;

  nomFalcao : Str -> Number => Str = \falcao ->
    numForms falcao (tk 2 falcao + "ões") ;

  nomCidadao : Str -> Number => Str = -- for completeness
    nomVinho ;

  nomNuvem : Str -> Number => Str = \nuvem ->
    numForms nuvem (init nuvem + "ns") ;

  nomRapaz : Str -> Number => Str = \rapaz ->
    numForms rapaz (rapaz + "es") ;

  nomCanal : Str -> Number => Str = \canal ->
    numForms canal (init canal + "is") ;

  acuteVowel : Str -> Str = \v ->
    case v of {
      "a" => "á" ;
      "e" => "é" ;
      "i" => "í" ;
      "o" => "ó" ;
      "u" => "ú" ;
      _ => error "input must be vowel character."
    } ;

  nomReptil : Str -> Number => Str = \reptil ->
    numForms reptil (tk 2 reptil + "eis") ;

  nomFenol : Str -> Number => Str = \fenol ->
    case fenol of {
      fen + v@("a"|"e"|"i"|"o"|"u") + "l" => numForms fenol (fen + acuteVowel v + "is")
    };

  nomVowelL : Str -> Number => Str = \nom ->
    -- papel -> papéis, móvel -> móveis
    case occurs "áéíúó" nom of {
      PTrue => nomCanal nom ;
      PFalse => nomFenol nom
    } ;

-- Common nouns are inflected in number and have an inherent gender.

  mkNoun : (Number => Str) -> Gender -> Noun = \mecmecs,gen ->
    {s = mecmecs ; g = gen} ;

  mkNounIrreg : Str -> Str -> Gender -> Noun = \mec,mecs ->
    mkNoun (numForms mec mecs) ;

  smartGenNoun : Str -> Gender -> Noun = \vinho,g -> case vinho of {
    rapa + ("z"|"s") => -- capataz/Masc, flor/Fem, obus/Masc
      mkNoun (nomRapaz vinho) g ;
    can  + "al" => -- canal/Masc, vogal/Fem
      mkNoun (nomCanal vinho) g ;
    pap + "el" => -- cascavel/Fem, infiel/Masc
      mkNoun (nomVowelL vinho) g ;
    home  + "m" => -- homem/Masc, nuvem/nuvens
      mkNoun (nomNuvem vinho) g ;
    tóra + "x" => -- tórax/Masc, xerox/Fem
      mkNoun (nomAreia vinho) g ;
    _ =>
      mkNoun (nomVinho vinho) g
    } ;

  mkNomReg : Str -> Noun = \vinho -> case vinho of {
    cas   + ("a" | "ã" | "dade" | "tude" | "ise" | "ite")  =>
      -- casa, artesã, saudade, juventude, marquise, artrite
      mkNoun (nomVinho vinho) Fem ;
    va + "gem" =>
      mkNoun (nomNuvem vinho) Fem ;
    certid  + "ão" => -- other rules depend on stress, can this be built with gf?
      mkNoun (nomFalcao vinho) Fem ;
    proble + ("ma" | "n" | "o" | "á") => -- problema, líquen, carro, maracujá
      mkNoun (nomVinho vinho) Masc ;
    can + "r" => -- feminine words ending with 'r' usually are also masculine
      mkNoun (nomRapaz vinho) Masc ;
    can  + ("i" | "u") + "l"  =>  -- canil, azul | what about fóssil?
      mkNoun (nomCanal vinho) Masc ;
    fen + "ol" => mkNoun (nomVowelL vinho) Masc ;
    urub + "u" => mkNoun (nomVinho vinho) Masc ;
    _           => smartGenNoun vinho Masc
    } ;

--2 Adjectives
--
-- Adjectives are conveniently seen as gender-dependent nouns.  Here
-- are some patterns. First one that describes the worst case.

  mkAdj : (_,_,_,_,_ : Str) -> Adj =
    \burro,burra,burros,burras,burramente ->
    {s = table {
       AF Masc n => numForms burro burros ! n ;
       AF Fem  n => numForms burra burras ! n ;
       AA        => burramente
       }
    } ;

  mkAdj2N : (_,_: N) -> Str -> Adj = \mascN, femN, burramente ->
    {s = table {
       AF Masc n => mascN.s ! n ;
       AF Fem  n => femN.s ! n ;
       AA => burramente
       }
    } ;

  mkAdjN : N -> Str -> Adj = \n, burramente -> mkAdj2N n n burramente ;

-- Then the regular and invariant patterns.

  adjPreto : Str -> Adj = \preto ->
    let
      pret = Predef.tk 1 preto
    in
    mkAdj preto (pret + "a") (pret + "os") (pret + "as") (pret + "amente") ;

  -- masculine and feminine are identical:
  -- adjectives ending with -e, -a and many but not all that end in a
  -- consonant
  adjUtil : Str -> Str -> Adj = \útil,úteis ->
    mkAdj útil útil úteis úteis (útil + "mente") ;

  -- adjectives that end in consonant but have different masc and fem
  -- forms español, hablador ...
  adjOuvidor : Str -> Str -> Adj = \ouvidor,ouvidora ->
    mkAdj ouvidor ouvidora (ouvidor + "es") (ouvidor + "as") (ouvidora + "mente") ;

  adjBlu : Str -> Adj = \blu ->
    mkAdj blu blu blu blu blu ; --- blasé

 -- francês francesa franceses francesas
  adjFrances : Str -> Adj = \francês ->
    let franc  : Str = Predef.tk 2 francês ;
        frances : Str = franc + "es" ;
    in mkAdj francês (frances + "a") (frances + "es") (frances + "as") (frances + "amente") ;


  -- alemão alemã alemães alemãs
  -- is there really a need for this? is it as useful as the spanish
  -- one?
  adjVo : Str -> Adj = \alemão ->
    let alemã : Str = init alemão ;
        alem  : Str = init alemã ;
        ã : Str = last alemã ;
        v : Str = case ã of {
          "ã" => "a"
        } ;
        alemvo : Str = alem + v + "o" ;
    in mkAdj alemão alemã (alemã + "s") (alemã + "es") (alemã + "amente") ;

  adjEuropeu : Str -> Adj = \europeu -> let europe = init europeu in
    mkAdj europeu (europe + "ia") (europeu + "s") (europe + "ias")
      (europe + "iamente") ;

  mkAdjReg : Str -> Adj = \a ->
    case a of {
      pret + "o" => adjPreto a ;
      anarquist + v@("e" | "a") => adjUtil (anarquist + v) (anarquist + v + "s") ;
      ouvido + "r" => adjOuvidor a (ouvido + "ra") ;
      chin + "ês" => adjFrances a ;
      europ + "eu" => adjEuropeu a ;
      alem + "ão" => adjVo a ;
      _   => adjUtil a (a + "s")
    } ;

--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "ne" as atonic genitive is debatable.
-- We follow the rule that the atonic nominative is empty.

  mkPronoun : (_,_,_,_,_,_,_,_ : Str) -> Gender -> Number -> Person
    -> Pronoun = \ele,o,lhe,Ele,seu,sua,seus,suas,g,n,p ->
    {poss = \\n,g => case <n,g> of {
       <Sg,Masc> => seu ;
       <Sg,Fem>  => sua ;
       <Pl,Masc> => seus ;
       <Pl,Fem>  => suas
       } ;
     a = Ag g n p ;
     hasClit = True ; isPol = False
    } ** pronLin ele o lhe Ele ;

  pronLin : (_,_,_,_ : Str) -> {s : Case =>  {c1,c2,comp,ton : Str}}
    = \você, o, lhe, Você ->
    let
      aVocê : Case -> Str = \x -> prepCase x ++ Você ;
    in
    {s = table {
       Nom        => {c1 = [] ; c2 = []  ; comp = você ; ton = Você} ;
       Acc        => {c1 = o ; c2 = []  ; comp = [] ; ton = Você} ;
       CPrep P_a  => {c1 = [] ; c2 = lhe ; comp = [] ; ton = aVocê (CPrep P_a)} ;
       c          => {c1 = [] ; c2 = []  ; comp, ton = aVocê c}
       }
    } ;

  pronAgr : Pronoun -> Gender -> Number -> Person -> Pronoun
    = \pron, g, n, p -> pron ** {a = Ag g n p} ;

  mkPronFrom : Pronoun -> (_,_,_,_ : Str) -> Gender -> Number -> Person
    -> Pronoun = \pron, você, o, lhe, Você, g, n, p ->
    (pronAgr pron g n p) ** pronLin você o lhe Você ;


--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are
-- inflected in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str =
    \tale,g,n -> tale.s ! AF g n ;

  mkOrdinal : A -> Ord = \adj ->
  lin Ord {
    s = \\ag => adj.s ! Posit ! AF ag.g ag.n ;
    } ;

  mkQuantifier : (esse,essa,esses,essas : Str) -> Quant = \esse,essa,esses,essas->
    let
      attrforms : Number => Gender => Case => Str = table {
        Sg => \\g,c => prepCase c ++ genForms esse essa ! g ;
        Pl => \\g,c => prepCase c ++ genForms esses essas ! g
        } ;
    in lin Quant {
      s = \\_ => attrforms ;
      s2 = [] ;
      sp = attrforms  ; -- in spanish it was different
      isNeg = False
      } ;

  mkDeterminer : (muito,muita : Str) -> Number -> Bool -> Det = \muito,muita,number,neg ->
    lin Det {
      s,sp = \\g,c => prepCase c ++ genForms muito muita ! g ;
      n = number;
      s2 = [] ;
      isNeg = neg
      } ;

   mkIDet : (quantos, quantas : Str) -> Number -> IDet = \quantos,quantas,number ->
  lin IDet {
        s = \\g,c => prepCase c ++ genForms quantos quantas ! g ;
        n = number
        } ;

}
