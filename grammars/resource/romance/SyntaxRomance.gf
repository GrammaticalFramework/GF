--1 A Small Romance Resource Syntax
--
-- Aarne Ranta 2002
--
-- This resource grammar contains definitions needed to construct 
-- indicative, interrogative, and imperative sentences in Romance languages.
-- We try to share as much as possible. Even if the definitions of certain
-- operations are different in $syntax.Fra.gf$ and $syntax.Ita.gf$, we can
-- often give their type signatures in this file.
--
-- The following files are presupposed:

interface SyntaxRomance = TypesRomance ** open Prelude, (CO=Coordination) in {

--2 Common Nouns
--
-- Common nouns are defined as number-dependent strings with a gender.
-- Complex common noun ($CommNounPhrase$)  have the same type as simple ones.
-- (The distinction is made just because of uniformity with other languages.)

oper
  CommNoun : Type = {s : Number => Str ; g : Gender} ;
  CommNounPhrase = CommNoun ;
  noun2CommNounPhrase : CommNounPhrase -> CommNoun = \x -> x ;

  commonNounComp : CommNoun -> Str -> CommNoun = \numero, detelephone -> 
    {s = \\n => numero.s ! n ++ detelephone ;
     g = numero.g
    } ;


--2 Noun phrase
--
-- The worst case is pronouns, which have inflection in the possessive
-- forms. Other noun phrases express all possessive forms with the genitive case.
-- Proper names are the simples example.

  ProperName : Type = {s : Str ; g : Gender} ;

  NounPhrase : Type = Pronoun ; -- the worst case

  nameNounPhrase : ProperName -> NounPhrase ;

  mkProperName : Str -> Gender -> ProperName = \jean,m ->
    {s = jean ; g = m} ;

  mkNameNounPhrase : Str -> Gender -> NounPhrase = \jean,m ->
    nameNounPhrase (mkProperName jean m) ;

  normalNounPhrase : (CaseA => Str) -> Gender -> Number -> NounPhrase = \cs,g,n ->
    {s = \\p => cs ! (pform2case p) ;
     g = PGen g ;
     n = n ;
     p = P3 ;    -- third person
     c = Clit0   -- not clitic
    } ;

  pronNounPhrase : Pronoun -> NounPhrase = \pro -> pro ;


--2 Determiners
--
-- Determiners are inflected according to the gender of the nouns they determine.
-- The determiner determines the number of the argument noun.

  Determiner : Type = {s : Gender => Str ; n : Number} ;

  detNounPhrase : Determiner -> CommNoun -> NounPhrase = \tout, homme -> 
    normalNounPhrase
      (\\c => prepCase c ++ tout.s ! homme.g ++ homme.s ! tout.n)
      homme.g 
      tout.n ;

-- The following macros are sufficient to define most determiners,
-- as shown by the examples that follow.

  mkDeterminer : Number -> Str -> Str -> Determiner = \n,tous,toutes -> 
    {s = genForms tous toutes ; n = n} ;

  mkDeterminer1 : Number -> Str -> Determiner = \n,chaque -> 
    mkDeterminer n chaque chaque ;


-- Indefinite and definite noun phrases are treated separately,
-- which strictly speaking is not necessary in Romance languages, since
-- articles could be treated as determiners.

  indefNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n,mec -> 
    normalNounPhrase 
      (\\c => artIndef mec.g n c ++ mec.s ! n)
      mec.g 
      n ; 

  defNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n,mec -> 
    normalNounPhrase 
      (\\c => artDef mec.g n c ++ mec.s ! n)
      mec.g
      n ; 

-- We often need indefinite noun phrases synacategorematically.

  indefNoun : Number -> CommNounPhrase -> Str = \n,mec -> 
    (indefNounPhrase n mec).s ! case2pform nominative ;

-- Genitives of noun phrases can be used like determiners, to build noun phrases.
-- The number argument makes the difference between "ma maison" - "mes maisons".
-- The clitic type of the NP decides between "ma maison" and "la maison de Jean".

  npGenDet : Number -> NounPhrase -> CommNounPhrase -> NounPhrase = \n,jeanne,mec ->
    let {str : CaseA => Str = case jeanne.c of {
          Clit0 => npGenDe   n jeanne mec ;
          _     => npGenPoss n jeanne mec
          }
        } in
    normalNounPhrase str mec.g n ; 

-- These auxiliary rules define the genitive with "de" and with the possessive.
-- Here there is a difference between French and Italian: Italian has a definite
-- article before possessives (with certain exceptions).

  npGenDe : Number -> NounPhrase -> CommNounPhrase -> CaseA => Str = 
    \n,jeanne,mec ->
    \\c => artDef mec.g n c ++ mec.s ! n ++ jeanne.s ! case2pform genitive ;

  npGenPoss : Number -> NounPhrase -> CommNounPhrase -> CaseA => Str ;

--2 Adjectives
--
-- Adjectives have a parameter $p$ telling if postposition is 
-- allowed (complex APs). There is no real need in Romance languages to distinguish
-- between simple adjectives and adjectival phrases.

  Adjective : Type = Adj ** {p : Bool} ;

  adjPre = True ; adjPost = False ;
  
  AdjPhrase : Type = Adjective ;
  
  adj2adjPhrase : Adjective -> AdjPhrase = \x -> x ;

  mkAdjective : Adj -> Bool -> Adjective = \adj,p -> adj ** {p = p} ;


--3 Comparison adjectives
--
-- The type is defined in $types.Romance.gf$. Syntax adds to lexicon the position
-- information.

  AdjDegr = AdjComp  ** {p : Bool} ;

  mkAdjDegr : AdjComp -> Bool -> AdjDegr = \adj,p ->
    adj ** {p = p} ;

  mkAdjDegrLong : Adj -> Bool -> AdjDegr = \adj,p ->
    adjCompLong adj ** {p = p} ;


-- Each of the comparison forms has a characteristic use:
--
-- Positive forms are used alone, as adjectival phrases ("bon").

  positAdjPhrase : AdjDegr -> AdjPhrase = \bon -> 
    {s = bon.s ! Pos ; 
     p = bon.p
    } ;

-- Comparative forms are used with an object of comparison, as
-- adjectival phrases ("meilleur que toi"). The comparing conjunction
-- is of course language-dependent; Italian moreover has the free
-- variants "che" and "di".

  comparAdjPhrase : AdjDegr -> NounPhrase -> AdjPhrase = \bon, toi ->
    {s = \\g,n => bon.s ! Comp ! g ! n ++ comparConj ++ 
         toi.s ! stressed accusative ; 
     p = False
    } ;

  comparConj : Str ;

-- Superlative forms are used with a common noun, picking out the
-- maximal representative of a domain 
-- ("le meilleur mec", "le mec le plus intelligent").

  superlNounPhrase : AdjDegr -> CommNoun -> NounPhrase = \bon, mec ->
    normalNounPhrase 
      (\\c => artDef mec.g Sg c ++ if_then_else Str bon.p 
           (bon.s ! Sup ! mec.g ! Sg ++ mec.s ! Sg)
           (mec.s ! Sg ++ artDef mec.g Sg nominative ++ bon.s ! Sup ! mec.g ! Sg)
      )
      mec.g 
      Sg ; 


--3 Prepositions and complements
--
-- Most prepositions are just strings. But "à" and "de" are treated as cases in
-- French. In Italian, there are more prepositions treated in this way:
-- "a", "di", "da", "in", "su", "con".
-- An invariant is that, if the preposition is not empty ($[]$), then the case
-- is $Acc$.

  Preposition = Str ;

  Complement =  {s2 : Preposition ; c : CaseA} ;

  complement : Str -> Complement = \par ->
    {s2 = par ; c = nominative} ;

  complementDir : Complement = complement [] ;

  complementCas : CaseA -> Complement = \c ->
    {s2 = [] ; c = c} ;


--3 Two-place adjectives
--
-- A two-place adjective is an adjective with a preposition used before
-- the complement, and the complement case.

  AdjCompl = AdjPhrase ** Complement ; 

  mkAdjCompl : Adj -> Bool -> Complement -> AdjCompl = \adj,p,c ->
    mkAdjective adj p ** c ;

  complAdj : AdjCompl -> NounPhrase -> AdjPhrase = \relie,jean ->
    {s = \\g,n => relie.s ! g ! n ++ relie.s2 ++ jean.s ! case2pform relie.c ; 
     p = False
    } ;


--3 Modification of common nouns
--
-- The two main functions of adjective are in predication ("Jean est jeune")
-- and in modification ("un jeune homme"). Predication will be defined
-- later, in the chapter on verbs.
--
-- Modification must pay attention to pre- and post-noun
-- adjectives: "jeune homme"; "homme intelligent".

  modCommNounPhrase : AdjPhrase -> CommNounPhrase -> CommNounPhrase = \bon,mec -> 
    {s = \\n => if_then_else Str bon.p 
           (bon.s ! mec.g ! n ++ mec.s ! n)
           (mec.s ! n ++ bon.s ! mec.g ! n) ;
     g = mec.g
    } ;

--2 Function expressions

-- A function expression is a common noun together with the
-- preposition prefixed to its argument ("mère de x").
-- The type is analogous to two-place adjectives and transitive verbs.

  Function : Type = CommNounPhrase ** Complement ;

-- The application of a function gives, in the first place, a common noun:
-- "mor/mödrar till Johan". From this, other rules of the resource grammar 
-- give noun phrases, such as "la mère de Jean", "les mères de Jean",
-- "les mères de Jean et de Marie", and "la mère de Jean et de Marie" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  appFunComm : Function -> NounPhrase -> CommNounPhrase = \mere,jean -> 
    noun2CommNounPhrase
      {s = \\n => mere.s ! n ++ mere.s2 ++ jean.s ! case2pform mere.c ;
       g = mere.g
      } ;

-- It is possible to use a function word as a common noun; the semantics is
-- often existential or indexical.

  funAsCommNounPhrase : Function -> CommNounPhrase = 
    noun2CommNounPhrase ;

-- The following is an aggregate corresponding to the original function application
-- producing "ma mère" and "la mère de Jean". It does not appear in the
-- resource grammar API any longer.

  appFun : Bool -> Function -> NounPhrase -> NounPhrase = \coll, mere, jean ->
    let {n = jean.n ; g = mere.g ; nf = if_then_else Number coll Sg n} in 
    variants {
      defNounPhrase nf (appFunComm mere jean) ;
      npGenDet nf jean mere
      } ;


--2 Verbs
--
--3 Verb phrases
--
-- Unlike many other languages, verb phrases in Romance languages
-- are not discontinuous.
-- We use clitic parameters instead. 
--
-- (It is not quite sure, though, whether this
-- will suffice in French for examples like "je n'*y* vais pas": one may want to
-- add "y" to "ne vais pas" instead of "ne - pas" to "y vais".)
--
-- So far we restrict the syntax to present-tense verbs, even though
-- morphology has complete conjugations.

  VerbPhrase = {s : Gender => VF => Str} ;

  Verb = VerbPres ;

-- Predication is language-dependent in the negative case.

  predVerb : Bool -> VerbPres -> VerbPhrase = \b,aller ->
    if_then_else VerbPhrase b 
      {s = \\_ => aller.s}
      {s = \\_,v => negVerb (aller.s ! v)} ;

  negVerb : Str -> Str ;

-- Verb phrases can also be formed from adjectives ("est bon"),
-- common nouns ("est un homme"), and noun phrases ("est Jean").
-- We need a copula, which is of course language-dependent.

  copula : Bool -> VF => Str ;

-- The third rule is overgenerating: "est chaque homme" has to be ruled out
-- on semantic grounds.

  predAdjective : Bool -> AdjPhrase -> VerbPhrase = \b,bon ->
    {s = \\g,v => copula b ! v ++ bon.s ! g ! nombreVerb v} ; 

  predCommNoun : Bool -> CommNounPhrase -> VerbPhrase = \b,homme ->
    {s = \\g,v => copula b ! v ++ indefNoun (nombreVerb v) homme} ; 

  predNounPhrase : Bool -> NounPhrase -> VerbPhrase = \b,jean ->
    {s = \\g,v => copula b ! v ++ jean.s ! stressed nominative} ; 


-- complement a verb with noun phrase and optional preposition

  TransVerb : Type = VerbPres ** Complement ;

  verbOfTransVerb       : TransVerb -> VerbPres   = \v -> {s = v.s} ;
  complementOfTransVerb : TransVerb -> Complement = \v -> {s2 = v.s2 ; c = v.c} ;

  isNounPhraseClit : NounPhrase -> Bool = \n -> case n.c of {
     Clit0 => False ;
     _  => True
     } ;

-- This function is language-dependent, because it uses the language-dependent
-- type of case.

  isTransVerbClit : TransVerb -> Bool ;


--3 Transitive verbs
--
-- Transitive verbs are verbs with a preposition for the complement,
-- in analogy with two-place adjectives and functions.
-- One might prefer to use the term "2-place verb", since
-- "transitive" traditionally means that the inherent preposition is empty.
-- Such a verb is one with a *direct object* - which may still be accusative,
-- dative, or genitive.
--
-- In complementation, we do need some dispatching of clitic types:
-- "aime Jean" ; "n'aime pas Jean" ; "l'aime" ; "ne l'aime pas".
-- More will be needed when we add ditransitive verbs.

  complTransVerb : Bool -> TransVerb -> NounPhrase -> VerbPhrase = \b,aime,jean ->
    {s = \\g,w =>  ---- BUG: v gives stack overflow
       let {Jean = jean.s ! (case2pform aime.c) ; Aime = aime.s ! w} in 
       if_then_else Str (andB (isNounPhraseClit jean) (isTransVerbClit aime))
         (posNeg b (Jean ++ Aime) [])
         (posNeg b Aime           Jean)
    } ;

  mkTransVerb : Verb -> Preposition -> CaseA -> TransVerb = \v,p,c -> 
    v ** {s2 = p ; c = c} ;

  mkTransVerbPrep : Verb -> Preposition -> TransVerb = \passer,par -> 
    mkTransVerb passer par accusative ;

  mkTransVerbCas : Verb -> CaseA -> TransVerb = \penser,a -> 
    mkTransVerb penser [] a ;

  mkTransVerbDir : Verb -> TransVerb = \aimer -> 
    mkTransVerbCas aimer accusative ;

-- The following macro builds the "ne - pas" or "non" negation. The second
-- string argument is used for the complement of a verb phrase. In Italian,
-- one string argument would actually be enough.

  posNeg : Bool -> (verb, compl : Str) -> Str ;


--2 Adverbials
--
-- Adverbials are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).
--
-- (We should also take into account clitic ones, like "y",
-- as well as the position: "est toujours heureux" / "est heureux à Paris".) 

  Adverb : Type = SS ;

  adVerbPhrase : VerbPhrase -> Adverb -> VerbPhrase = \chante, bien ->
    {s = \\g,v => chante.s ! g ! v ++ bien.s} ;

-- Adverbials are typically generated by prefixing prepositions.
-- The rule for creating locative noun phrases by the preposition "dans"
-- in French and "in" in Italian. This is of course shaky, since other 
-- prepositions may be preferred ("en", "à" ; "a", "su").

  locativeNounPhrase : NounPhrase -> Adverb ;

-- This is a source of the "homme avec un téléscope" ambiguity, and may produce
-- strange things, like "les voitures toujours".
-- Semantics will have to make finer distinctions among adverbials.
-- French moreover says "les voitures d'hier" rather than "les voitures hier".

  advCommNounPhrase : CommNounPhrase -> Adverb -> CommNounPhrase = \mec,aparis ->
    {s = \\n => mec.s ! n ++ aparis.s ;
     g = mec.g
    } ;

--2 Sentences
--
-- Sentences depend on a *mode parameter* selecting between 
-- indicative and subjunctive forms.

  Sentence : Type = SS1 Mode ;

-- This is the traditional $S -> NP VP$ rule. It takes care of both
-- mode and agreement.

  predVerbPhrase : NounPhrase -> VerbPhrase -> Sentence = \jean,dort ->
    {s = \\m => jean.s ! unstressed nominative ++ 
                dort.s ! pgen2gen jean.g ! VFin m jean.n jean.p
    } ;


--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.
-- The mode of the complement depends on the verb, and can be different
-- for positive and negative uses of the verb 
-- ("je crois qu'elle vient" -"je ne crois pas qu'elle vienne"),

  SentenceVerb : Type = VerbPres ** {mp, mn : Mode} ;

  complSentVerb : Bool -> SentenceVerb -> Sentence -> VerbPhrase = 
    \b,croire,jeanboit ->
    let {m = if_then_else Mode b croire.mp croire.mn} in
    {s = \\_,w => posNeg b (croire.s ! w) (embedConj ++ jeanboit.s ! m)} ; ----w

  verbSent : Verb -> Mode -> Mode -> SentenceVerb = \v,mp,mn ->
    v ** {mp = mp ; mn = mn} ;

-- The embedding conjunction is language dependent.

  embedConj : Str ;


--2 Sentences missing noun phrases
--
-- This is one instance of Gazdar's *slash categories*, corresponding to his
-- $S/NP$.
-- We cannot have - nor would we want to have - a productive slash-category former.
-- Perhaps a handful more will be needed.
--
-- Notice that the slash category has the same relation to sentences as
-- transitive verbs have to verbs: it's like a *sentence taking a complement*.

  SentenceSlashNounPhrase = Sentence ** Complement ;

  slashTransVerb : Bool -> NounPhrase -> TransVerb -> SentenceSlashNounPhrase = 
    \b,jean,aimer ->
    predVerbPhrase jean (predVerb b (verbOfTransVerb aimer)) ** 
    complementOfTransVerb aimer ;


--2 Relative pronouns and relative clauses
--
-- Relative pronouns are inflected in
-- gender, number, and case. They can also have an inherent case,
-- but this case if 'variable' in the sense that it
-- is sometimes just mediated from the correlate
-- ("homme qui est bon"), sometimes inherent to the
-- pronominal phrase itself ("homme dont la mère est bonne").

oper

  RelPron   : Type = {s : RelFormA => Str ; g : RelGen} ;
  RelClause : Type = {s : Mode => Gender => Number => Str} ;

  mkGenRel : RelGen -> Gender -> Gender = \rg,g -> case rg of {
    RG gen => gen ;
    _      => g
    } ;

-- Simple relative pronouns ("qui", "dont", "par laquelle")
-- have no inherent gender.

  identRelPron : RelPron ;

  composRelPron : Gender -> Number -> CaseA -> Str ;

-- Complex relative pronouns ("dont la mère") do have an inherent gender.

  funRelPron : Function -> RelPron -> RelPron ;

-- There are often variants, i.e. short and long forms
-- ("que" - "lequel", "dont" -"duquel"), etc.

  allRelForms : RelPron -> Gender -> Number -> CaseA -> Str ;

-- Relative clauses can be formed from both verb phrases ("qui dort") and
-- slash expressions ("que je vois", "dont je parle"). 

  relVerbPhrase : RelPron -> VerbPhrase -> RelClause = \qui,dort ->
    {s = \\m,g,n => allRelForms qui g n nominative ++ dort.s ! g ! VFin m n P3 
    } ;

  relSlash : RelPron -> SentenceSlashNounPhrase -> RelClause = \dont,jeparle ->
    {s = \\m,g,n => jeparle.s2 ++ allRelForms dont g n jeparle.c ++ jeparle.s ! m
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "nombre x tel que x soit pair".

  relSuch : Sentence -> RelClause = \A ->
    {s = \\m,g,n => suchPron g n ++ embedConj ++ A.s ! m
    } ;

  suchPron : Gender -> Number -> Str ;

-- The main use of relative clauses is to modify common nouns.
-- The result is a common noun, out of which noun phrases can be formed
-- by determiners. A comma is used before the relative clause.
--
-- N.B. subjunctive relative clauses 
-- ("je cherche un mec qui sache chanter") must have another structure
-- (unless common noun phrases are given a mode parameter...).

  modRelClause : CommNounPhrase -> RelClause -> CommNounPhrase = \mec,quidort ->
    {s = \\n => mec.s ! n ++ quidort.s ! Ind ! mec.g ! n ;
     g = mec.g
    } ;

--2 Interrogative pronouns
--
-- If relative pronouns are adjective-like, interrogative pronouns are
-- noun-phrase-like. We use a simplified type, since we don't need the possessive
-- forms.
--
-- N.B. "est-ce que", etc, will be added below 
-- when pronouns are used in direct questions.

  IntPron : Type = {s : CaseA => Str ; g : Gender ; n : Number} ; 

-- In analogy with relative pronouns, we have a rule for applying a function
-- to a relative pronoun to create a new one. 

  funIntPron : Function -> IntPron -> IntPron = \mere,qui -> 
    {s = \\c => 
           artDef mere.g qui.n c ++ mere.s ! qui.n ++ mere.s2 ++ qui.s ! mere.c ;
     g = mere.g ;
     n = qui.n
    } ;

-- There is a variety of simple interrogative pronouns:
-- "quelle maison", "qui", "quoi". Their definitions are language-dependent.

  nounIntPron : Number -> CommNounPhrase -> IntPron ;
  intPronWho  : Number -> IntPron ;
  intPronWhat : Number -> IntPron ;

--2 Utterances

-- By utterances we mean whole phrases, such as 
-- 'can be used as moves in a language game': indicatives, questions, imperative,
-- and one-word utterances. The rules are far from complete.
--
-- N.B. we have not included rules for texts, which we find we cannot say much
-- about on this level. In semantically rich GF grammars, texts, dialogues, etc, 
-- will of course play an important role as categories not reducible to utterances.
-- An example is proof texts, whose semantics show a dependence between premises
-- and conclusions. Another example is intersentential anaphora.

  Utterance = SS ;
  
  indicUtt : Sentence -> Utterance = \x -> ss (x.s ! Ind ++ ".") ;
  interrogUtt : Question -> Utterance = \x -> ss (x.s ! DirQ ++ "?") ;

--2 Questions
--
-- Questions are either direct ("qui a pris la voiture") or indirect 
-- ("ce qui a pris la voiture").

param 
  QuestForm = DirQ | IndirQ ;

oper
  Question = SS1 QuestForm ;


--3 Yes-no questions 
--
-- Yes-no questions are used both independently ("Tu es fatigué?")
-- and after interrogative adverbials ("Pourquoi tu es fatigué?").
-- It is economical to handle with these two cases by the one
-- rule, $questVerbPhrase'$. The only difference is if "si" appears
-- in the indirect form.
--
-- N.B. the inversion variant ("Es-tu fatigué?") is missing, mainly because our
-- verb morphology does not support the intervening "t" ("Marche-t-il?").
-- The leading "est-ce que" is recognized as a variant, and requires
-- direct word order.

  questVerbPhrase : NounPhrase -> VerbPhrase -> Question ;

--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are line $S/NP - NP$ sentences.
--
-- N.B. inversion variants and "est-ce que" are treated as above.

  intVerbPhrase : IntPron -> VerbPhrase -> Question ;

  intSlash : IntPron -> SentenceSlashNounPhrase -> Question ;


--3 Interrogative adverbials
--
-- These adverbials will be defined in the lexicon: they include
-- "quand", "où", "comment", "pourquoi", etc, which are all invariant one-word
-- expressions. In addition, they can be formed by adding prepositions
-- to interrogative pronouns, in the same way as adverbials are formed
-- from noun phrases. 
--
-- N.B. inversion variants and "est-ce que" are treated as above.

  IntAdverb = SS ;

  questAdverbial : IntAdverb -> NounPhrase -> VerbPhrase -> Question ;


--2 Imperatives
--
-- We only consider second-person imperatives. 
-- 
-- N.B. following the API, we don't distinguish between 
-- singular and plural "vous", nor between masculine and feminine.
-- when forming utterances.
--
-- TODO: clitics, Italian negated imperative.

  Imperative = {s : Gender => Number => Str} ;

  imperVerbPhrase : VerbPhrase -> Imperative = \dormir -> 
    {s = \\g,n => dormir.s ! g ! vImper n P2
    } ;

  imperUtterance : Number -> Imperative -> Utterance = \n,I ->
    ss (I.s ! Masc ! n ++ "!") ;



--2 Coordination
--
-- Coordination is to some extent orthogonal to the rest of syntax, and
-- has been treated in a generic way in the module $CO$ in the file
-- $coordination.gf$. The overall structure is independent of category,
-- but there can be differences in parameter dependencies.
--
--3 Conjunctions
--
-- Coordinated phrases are built by using conjunctions, which are either
-- simple ("et", "ou") or distributed ("et - et", "pu - ou").

  Conjunction = CO.Conjunction ** {n : Number} ;
  ConjunctionDistr = CO.ConjunctionDistr ** {n : Number} ;

--3 Coordinating sentences
--
-- We need a category of lists of sentences. It is a discontinuous
-- category, the parts corresponding to 'init' and 'last' segments
-- (rather than 'head' and 'tail', because we have to keep track of the slot between
-- the last two elements of the list). A list has at least two elements.
--
-- N.B. we don't have repetion of "que" in subordinate coordinated sentences.

  ListSentence : Type = {s1,s2 : Mode => Str} ; 

  twoSentence : (_,_ : Sentence) -> ListSentence = 
    CO.twoTable Mode ;

  consSentence : ListSentence -> Sentence -> ListSentence = 
    CO.consTable Mode CO.comma ;

-- To coordinate a list of sentences by a simple conjunction, we place
-- it between the last two elements; commas are put in the other slots,
-- e.g. "Pierre fume, Jean boit et les autres regardsnt".

  conjunctSentence : Conjunction -> ListSentence -> Sentence = 
    CO.conjunctTable Mode ;

-- To coordinate a list of sentences by a distributed conjunction, we place
-- the first part in front of the first element, the second
-- part between the last two elements, and commas in the other slots.
-- For sentences this is really not used.

  conjunctDistrSentence : ConjunctionDistr -> ListSentence -> Sentence = 
    CO.conjunctDistrTable Mode ;

--3 Coordinating adjective phrases
--
-- The structure is the same as for sentences. The result is a prefix adjective
-- if and only if all elements are prefix.

  ListAdjPhrase : Type = 
    {s1,s2 : Gender => Number => Str ; p : Bool} ;

  twoAdjPhrase : (_,_ : AdjPhrase) -> ListAdjPhrase = \x,y ->
    CO.twoTable2 Gender Number x y ** {p = andB x.p y.p} ;

  consAdjPhrase : ListAdjPhrase -> AdjPhrase -> ListAdjPhrase =  \xs,x ->
    CO.consTable2 Gender Number CO.comma xs x ** {p = andB xs.p x.p} ;

  conjunctAdjPhrase : Conjunction -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctTable2 Gender Number c xs ** {p = xs.p} ;

  conjunctDistrAdjPhrase : ConjunctionDistr -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctDistrTable2 Gender Number c xs ** {p = xs.p} ;


--3 Coordinating noun phrases
--
-- The structure is the same as for sentences. The result is either always plural
-- or plural if any of the components is, depending on the conjunction.
-- The gender is masculine if any of the components is. A coordinated noun phrase
-- cannot be clitic.

  ListNounPhrase : Type = 
    {s1,s2 : CaseA => Str ; g : PronGen ; n : Number ; p : Person} ;

  twoNounPhrase : (_,_ : NounPhrase) -> ListNounPhrase = \x,y ->
    {s1 = \\c => x.s ! stressed c ; s2 = \\c => y.s ! stressed c} ** 
    {n = conjNumber x.n y.n ; g = conjGender x.g y.g ; p = conjPers x.p y.p} ;

  consNounPhrase : ListNounPhrase -> NounPhrase -> ListNounPhrase =  \xs,x ->
    {s1 = \\c => xs.s1 ! c ++ CO.comma ++ xs.s2 ! c ; 
     s2 = \\c => x.s ! stressed c} ** 
    {n = conjNumber xs.n x.n ; g = conjGender xs.g x.g ; p =conjPers xs.p x.p} ;

  conjunctNounPhrase : Conjunction -> ListNounPhrase -> NounPhrase = \co,xs ->
    {s = \\c => xs.s1 ! pform2case c ++ co.s ++ xs.s2 ! pform2case c} ** 
    {n = conjNumber co.n xs.n ; g = xs.g ; p = xs.p ; c = Clit0 } ;

  conjunctDistrNounPhrase : ConjunctionDistr -> ListNounPhrase -> NounPhrase = 
    \co,xs ->
    {s = \\c => co.s1++ xs.s1 ! pform2case c ++ co.s2 ++ xs.s2 ! pform2case c} ** 
    {n = conjNumber co.n xs.n ; g = xs.g ; p = xs.p ; c = Clit0} ;

-- We have to define a calculus of numbers of genders. For numbers,
-- it is like the conjunction with $Pl$ corresponding to $False$. For genders,
-- $Masc$ corresponds to $False$.

  conjNumber : Number -> Number -> Number = \m,n -> case <m,n> of {
    <Sg,Sg> => Sg ;
    _ => Pl 
    } ;

  conjGen : Gender -> Gender -> Gender = \m,n -> case <m,n> of {
    <Fem,Fem> => Fem ;
    _ => Masc 
    } ;

  conjGender : PronGen -> PronGen -> PronGen = \m,n -> case <m,n> of {
    <PGen Fem, PGen Fem> => PGen Fem ;
    _ => PNoGen
    } ;

-- For persons, we go in the descending order:
-- "moi et toi sommes forts", "lui ou toi es fort".
-- This is not always quite clear.

  conjPers : Person -> Person -> Person = \p,q -> case <p,q> of {
    <P3,P3> => P3 ;
    <P1,_>  => P1 ;
    <_,P1>  => P1 ;
    _       => P2
    } ;



--2 Subjunction
--
-- Subjunctions ("si", "quand", etc) 
-- are a different way to combine sentences than conjunctions.
-- The main clause can be a sentences, an imperatives, or a question,
-- but the subjoined clause must be a sentence.

  Subjunction = SS ;

  subjunctSentence : Subjunction -> Sentence -> Sentence -> Sentence = \si,A,B ->
    {s = \\m => subjunctVariants si A (B.s ! m)
     } ;

  subjunctImperative : Subjunction -> Sentence -> Imperative -> Imperative = 
    \si,A,B -> 
    {s = \\g,n => subjunctVariants si A (B.s ! g ! n)
    } ;

  subjunctQuestion : Subjunction -> Sentence -> Question -> Question = \si,A,B ->
    {s = \\q => subjunctVariants si A (B.s ! q)
    } ;

-- There are uniformly two variant word orders, e.g. 
-- "si tu fume je m'en vais"
-- and "je m'en vais si tu fume".

  subjunctVariants : Subjunction -> Sentence -> Str -> Str = \si,A,B ->
    let {As = A.s ! Ind} in 
    variants {
      si.s ++ As ++ B ; 
      B ++ si.s ++ As
      } ;

--2 One-word utterances
-- 
-- An utterance can consist of one phrase of almost any category, 
-- the limiting case being one-word utterances. These
-- utterances are often (but not always) in what can be called the
-- default form of a category, e.g. the nominative.
-- This list is far from exhaustive.

  useNounPhrase : NounPhrase -> Utterance = \jean ->
    postfixSS "." (defaultNounPhrase jean) ;
  useCommonNounPhrase : Number -> CommNounPhrase -> Utterance = \n,mec -> 
    useNounPhrase (indefNounPhrase n mec) ;


-- one-form variants

  defaultNounPhrase : NounPhrase -> SS = \jean -> 
    ss (jean.s ! stressed nominative) ;

  defaultQuestion : Question -> SS = \quiesttu ->
    ss (quiesttu.s ! DirQ) ;

  defaultSentence : Sentence -> SS = \x -> ss (x.s ! Ind) ;

----- moved from Types

  artDef : Gender -> Number -> CaseA -> Str ;
  artIndef : Gender -> Number -> CaseA -> Str ;
  genForms : Str -> Str -> Gender => Str ;

----- moved from Res

  pronJe, pronTu, pronIl, pronElle, pronNous, pronVous, pronIls, pronElles : 
    Pronoun ;
  chaqueDet, tousDet, quelDet, plupartDet : Determiner ;

  commentAdv, quandAdv, ouAdv, pourquoiAdv : Adverb ;

  etConj, ouConj : Conjunction ;
  etetConj, ououConj : ConjunctionDistr ;
  siSubj, quandSubj : Subjunction ;

  ouiPhr, noPhr : Utterance ;
    
}
