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

interface SyntaxRomanceVP = SyntaxRomance ** open Prelude in {


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

oper
  complTransVerb : TransVerb -> NounPhrase -> Complemnt = \aime,jean ->
    complTransVerbGen aime jean (\\_,_,_ => []) ;

  complTransVerbGen : TransVerb -> NounPhrase ->
    (Gender => Number => Person => Str) -> Complemnt = 
    \aime,jean,ici ->
      let
        clit  = andB (isNounPhraseClit jean) (isTransVerbClit aime) ;
        Jean  = jean.s ! (case2pformClit aime.c) ; 
        aimee = if_then_Str clit
                   (aime.s ! VPart (pgen2gen jean.g) jean.n)
                   (aime.s ! VPart  Masc             Sg)
      in
        \\g,n,p => 
          let Ici = ici ! g ! n ! p 
          in
          case clit of {
            True  => {clit = Jean ; part = aimee ; compl = Ici} ;
            False => {clit = []   ; part = aimee ; compl = Jean ++ Ici}
            } ;

----- add auxVerb to Complemnt to switch to $esse$ in refl ?

  reflTransVerb : TransVerb -> Complemnt = \aime ->
      let
        clit = isTransVerbClit aime ;
      in  
        \\g,n,p => 
        let 
          soi = reflPron ! n ! p ! unstressed accusative ; ---- (case2pformClit aime.c) ; 
          aimee = aime.s ! VPart g n
        in
        case clit of {
            True  => {clit = soi ; part = aimee ; compl = []} ;
            False => {clit = []  ; part = aimee ; compl = soi}
            } ;

--2 Sentences
--
-- Sentences depend on a *mode parameter* selecting between 
-- indicative and subjunctive forms.

oper
  VerbGroup : Type = {s : Bool => Gender => VPForm => Str} ;

  predVerbGroup : Bool -> {s : Str ; a : Anteriority} -> VerbGroup -> VerbPhrase = 
    \b,ant,vg -> 
    {s = \\vi,g,n,p => ant.s ++ vg.s ! b ! g ! VPF ant.a VInfin ---- imper
    } ;

  cl2vp : ClForm -> Number -> Person -> VPForm = \c,n,p -> case c of {
    ClPres   a m   => VPF a (VFin (VPres m) n p) ;
    ClImperf a m   => VPF a (VFin (VImperf m) n p) ;
    ClPasse  a     => VPF a (VFin VPasse n p) ;
    ClFut    a     => VPF a (VFin VFut n p) ;
    ClCondit a     => VPF a (VFin VCondit n p) ;
    ClInfinit a    => VPF a VInfin
    } ;

  vp2cl : VPForm -> ClForm = \vf -> case vf of {
    VPF a (VFin (VPres m)   _ _) => ClPres   a m ;
    VPF a (VFin (VImperf m) _ _) => ClImperf a m ;
    VPF a (VFin (VPasse) _ _)    => ClPasse  a ;
    VPF a (VFin (VFut) _ _)      => ClFut    a ;
    VPF a (VFin (VCondit) _ _)   => ClCondit a ;
    VPF a VInfin    => ClInfinit a ;
    _    => ClInfinit Simul ---- imper
    } ;
-- Predication is language-dependent in the negative case.

  complVerb : Verb -> Complemnt = \verb ->
    mkCompl verb (\\_,_,_ => []) ;

  mkCompl : Verb -> (Gender => Number => Person => Str) -> Complemnt = 
    \verb,comp -> complNoClit (
      \\g,n,p => <verb.s ! (case verb.aux of {
          AEsse   => VPart g n ;
          AHabere => VPart Masc Sg
          }),
      comp ! g ! n ! p
      >) ;

  complNoClit : (Gender => Number => Person => (Str*Str)) -> Complemnt = 
    \comp -> \\g,n,p =>
      let com = comp ! g ! n ! p in 
      {clit = [] ; part = com.p1 ; compl = com.p2} ;

  complCopula : (Gender => Number => Person => Str) -> Complemnt = 
    mkCompl copula ;

  predCopula : NounPhrase -> Complemnt -> Clause = \np,co ->
    predVerbClause np copula co ;



  Complemnt = Gender => Number => Person => {clit, part, compl : Str} ; ---- ment

  predVerbClause : NounPhrase -> Verb -> Complemnt -> Clause =  \np,verb,comp -> 
    let nv = predVerbClauseGen np verb comp in
    {s = \\b,cl => let nvg = nv ! b ! cl in nvg.p1 ++ nvg.p2} ;

  predVerbClauseGen : NounPhrase -> Verb -> Complemnt -> 
    (Bool => ClForm => (Str * Str)) =  \np,verb,comp -> 
      let 
        jean = np.s ! unstressed nominative ;
        co   = comp ! pgen2gen np.g ! np.n ! np.p ;
        la   = co.clit ;
        ici  = co.compl ;
        aimee = co.part ;
        aime  : TMode -> Str = \t -> verb.s ! (VFin t np.n np.p) ;
        avoir : TMode -> Str = \t -> (auxVerb verb).s ! (VFin t np.n np.p) ;
        aimer = verb.s ! VInfin ;
        avoirr = (auxVerb verb).s ! VInfin
      in
      \\b => table {
        ClPres   Simul m => <jean, posNeg b (la ++ aime  (VPres m))   ici> ;
        ClPres   a m     => <jean, posNeg b (la ++ avoir (VPres m))   (aimee ++ ici)> ;
        ClImperf Simul m => <jean, posNeg b (la ++ aime  (VImperf m)) ici> ;
        ClImperf a m     => <jean, posNeg b (la ++ avoir (VImperf m)) (aimee ++ ici)> ;
        ClPasse  Simul   => <jean, posNeg b (la ++ aime  VPasse)      ici> ;
        ClPasse  a       => <jean, posNeg b (la ++ avoir VPasse)      (aimee ++ ici)> ;
        ClFut    Simul   => <jean, posNeg b (la ++ aime  VFut)      ici> ;
        ClFut    a       => <jean, posNeg b (la ++ avoir VFut)      (aimee ++ ici)> ;
        ClCondit Simul   => <jean, posNeg b (la ++ aime  VFut)      ici> ;
        ClCondit a       => <jean, posNeg b (la ++ avoir VFut)      (aimee ++ ici)> ;
        ClInfinit Simul  => <jean, posNeg b (la ++ aimer)           ici> ;
        ClInfinit a      => <jean, posNeg b (la ++ avoirr)          (aimee ++ ici)>
        } ;

-- These three function are just to restore the $VerbGroup$ ($VP$) based structure.

  predVerbGroupClause : NounPhrase -> VerbGroup -> Clause = \np,vp ->
    let
      it = np.s ! unstressed nominative
    in
    {s = \\b,cf => it ++ vp.s  ! b ! pgen2gen np.g ! cl2vp cf np.n np.p} ;

  predClauseGroup : Verb -> Complemnt -> VerbGroup =  \verb,comp -> 
    let
      nvg : PronGen -> Number -> Person -> (Bool => ClForm => (Str * Str)) =
        \g,n,p -> 
        predVerbClauseGen {s = \\_ => [] ; g=g ; n=n ; p=p ; c=Clit0} verb comp 
                          -- clit type irrelevant in subject position
    in
    {s  = \\b,g,vf => 
       (nvg (PGen g) (nombreVerbPhrase vf)  (personVerbPhrase vf) ! b ! (vp2cl vf)).p2
    } ;

  predClauseBeGroup : Complemnt -> VerbGroup = 
    predClauseGroup copula ;


--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.
-- The mode of the complement depends on the verb, and can be different
-- for positive and negative uses of the verb 
-- ("je crois qu'elle vient" -"je ne crois pas qu'elle vienne"),

  complSentVerb : SentenceVerb -> Sentence -> Complemnt = \croire,jeanboit ->
    mkCompl 
      croire 
      (\\g,n,p =>
         ----- add Bool to Complemnt ?
         ----- let m = if_then_else Mode b croire.mp croire.mn 
         embedConj ++ jeanboit.s ! croire.mp) ;

  complDitransSentVerb : 
   (TransVerb ** {mp, mn : Mode}) -> NounPhrase -> Sentence -> Complemnt = 
    \dire,lui,jeanboit ->
      complTransVerbGen 
        dire lui 
        (\\g,n,p =>
         embedConj ++ jeanboit.s ! dire.mp) ;

  complQuestVerb : Verb -> QuestionSent -> Complemnt = \demander,sijeanboit ->
    mkCompl 
      demander 
      (\\g,n,p => sijeanboit.s ! IndirQ) ;

  complDitransQuestVerb : TransVerb -> NounPhrase -> QuestionSent -> Complemnt = 
    \dire,lui,jeanboit ->
      complTransVerbGen 
        dire lui 
        (\\g,n,p => jeanboit.s ! IndirQ) ;

  complAdjVerb : Verb -> AdjPhrase -> Complemnt = \sent,bon ->
    mkCompl sent (\\g,n,_ => bon.s ! AF g n) ;
-- The third rule is overgenerating: "est chaque homme" has to be ruled out
-- on semantic grounds.

  complAdjective : AdjPhrase -> Complemnt = \bon ->
    complCopula (\\g,n,_ => bon.s ! AF g n) ;

  complCommNoun : CommNounPhrase -> Complemnt = \homme ->
    complCopula (\\_,n,_ => indefNoun n homme) ; 

  complNounPhrase : NounPhrase -> Complemnt = \jean ->
    complCopula (\\_,_,_ => jean.s ! stressed nominative) ; 

  complAdverb : Adverb -> Complemnt = \dehors ->
    complCopula (\\_,_,_ => dehors.s) ; 

  complVerbAdj : AdjCompl -> VerbPhrase -> AdjPhrase = \facile,ouvrir ->
    {s = \\gn => ---- p
      facile.s ! gn ++ prepCase facile.c ++ facile.s2 ++
      ouvrir.s ! VIInfinit ! Masc ! Sg ! P3 ;
     p = False
    } ;

  complVerbAdj2 : Bool -> AdjCompl -> NounPhrase -> VerbPhrase -> AdjPhrase = 
    \b,facile,lui,nager ->
    {s = \\gn => ---- p 
        facile.s ! gn ++ 
        lui.s ! stressed dative ++         ---- also "pour lui" ?
        prepCase facile.c ++ facile.s2 ++
        nager.s ! VIInfinit ! pgen2gen lui.g ! lui.n ! P3 ; ---- agr dep on b
     p = False
     } ;


--3 Verb-complement verbs
--
-- Verb-complement verbs take verb phrases as complements.
-- They can need an oblique case ("à", "de"), but they work like ordinary verbs.

  complVerbVerb : VerbVerb -> VerbPhrase -> Complemnt = \devoir, nager ->
    mkCompl
      devoir
      (\\g,n,p => prepCase devoir.c ++ nager.s ! VIInfinit ! g ! n ! p) ;

  progressiveVerbPhrase : VerbPhrase -> VerbGroup = \vp ->
   predClauseBeGroup
     (complCopula (\\g,n,p => 
       "en" ++ "train" ++ elisDe ++ vp.s !  VIInfinit ! g ! n ! p)) ;

--- This must be completed to account for the order of the clitics.
--- In the rule below, the last argument cannot get cliticized.

  complDitransVerb : 
    DitransVerb -> NounPhrase -> NounPhrase -> Complemnt = \donner,jean,vin ->
      complTransVerbGen 
        donner jean 
        (\\_,_,_ => donner.s3 ++ vin.s ! case2pform donner.c3) ;
  complDitransVerbVerb : 
    Bool -> DitransVerbVerb -> NounPhrase -> VerbPhrase -> Complemnt = 
     \obj, demander, toi, nager ->
        complTransVerbGen demander toi
          (\\g,n,p =>
           let 
             agr : Gender * Number * Person = case obj of {
               True  => <pgen2gen toi.g, toi.n, toi.p> ;
               False => <g,    n,    p>
               } 
           in 
           prepCase demander.c ++ 
           nager.s ! VIInfinit ! agr.p1 ! agr.p2 ! agr.p3) ;

  complDitransAdjVerb : 
    TransVerb -> NounPhrase -> AdjPhrase -> Complemnt = \rend,toi,sec ->
      complTransVerbGen rend toi (\\g,n,_ => sec.s ! AF g n) ;

  adVerbPhrase : VerbGroup -> Adverb -> VerbGroup = \chante, bien ->
    {s = \\b,g,v => chante.s ! b ! g ! v ++ bien.s} ;

  intVerbPhrase : IntPron -> VerbGroup -> Question = \ip,vg ->
    questClause (predVerbGroupClause (intNounPhrase ip) vg) ;

-- Passivization is like adjectival predication.

  passVerb : Verb -> Complemnt = \aimer ->
    complCopula (\\g,n,_ => aimer.s ! VPart g n) ;

  subjunctVerbPhrase : VerbGroup -> Subjunction -> Sentence -> VerbGroup =
    \V, si, A -> 
    adVerbPhrase V (ss (si.s ++ A.s ! si.m)) ;

}
