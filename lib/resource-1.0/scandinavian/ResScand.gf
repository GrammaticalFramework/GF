----1 Scandinavian auxiliary operations.
--
---- This module contains operations that are needed to make the
---- resource syntax work. To define everything that is needed to
---- implement $Test$, it moreover contains regular lexical
---- patterns needed for $Lex$.
--
resource ResScand = ParamScand ** open Prelude in {

  flags optimize=all ;

  oper

-- For $Lex$.

-- For each lexical category, here are the worst-case constructors.
--
-- But $mkNoun$ is fully defined only for each language, since
-- $Gender$ varies.

    nounForms : (_,_,_,_ : Str) -> (Number => Species => Case => Str) = 
      \man,mannen,men,mennen -> \\n,d,c => case <n,d> of {
        <Sg,Indef> => mkCase c man ;
        <Sg,Def>   => mkCase c mannen ;
        <Pl,Indef> => mkCase c men ;
        <Pl,Def>   => mkCase c mennen
        } ;

  mkAdjective : (s1,_,_,_,_,_,s7 : Str) -> {s : AForm => Str} = 
    \liten, litet, lilla, sma, mindre, minst, minsta -> {
    s = table {
      AF (APosit a) c          => mkCase c (mkAdjPos a liten litet lilla sma) ;
      AF ACompar c             => mkCase c mindre ;
      AF (ASuperl SupStrong) c => mkCase c minst ;
      AF (ASuperl SupWeak) c   => mkCase c minsta
      } 
    } ;

  mkVerb : (x1,_,_,_,_,_,_,x8 : Str) -> {s : VForm => Str} = 
   \finna,finner,finn,fann,funnit,funnen,funnet,funna -> {
   s = table {
    VF (VPres Act)  => finner ;
    VF (VPres Pass) => mkVoice Pass finn ;
    VF (VPret v)    => mkVoice v fann ;
    VF (VImper v)   => mkVoice v finn ;
    VI (VInfin v)   => mkVoice v finna ;
    VI (VSupin v)   => mkVoice v funnit ;
    VI (VPtPret a c) => mkCase c (mkAdjPos a funnen funnet funna funna)
    }
   } ;

-- These are useful auxiliaries.

  mkCase : Case -> Str -> Str = \c,f -> case c of {
      Nom => f ;
      Gen => f + case last f of {
        "s" | "x" => [] ;
        _ => "s"
        }
      } ;

  mkAdjPos : AFormPos -> (s1,_,_,s4 : Str) -> Str =
    \a, liten, litet, lilla, sma ->
    case a of {
      Strong gn => case gn of {
        SgUtr => liten ;
        SgNeutr => litet ;
        Plg => sma
      } ;
     Weak Sg => lilla ;
     Weak Pl => sma
   } ;

  mkVoice : Voice -> Str -> Str = \v,s -> case v of {
    Act => s ;
    Pass => s + case last s of {
      "s" => "es" ;
      _   => "s"
      }
    } ;

--    mkAdjective : (_,_,_,_ : Str) -> {s : AForm => Str} = 
--      \good,better,best,well -> {
--      s = table {
--        AAdj Posit  => good ;
--        AAdj Compar => better ;
--        AAdj Superl => best ;
--        AAdv        => well
--        }
--      } ;
--
--    mkVerb : (_,_,_,_,_ : Str) -> {s : VForm => Str} = 
--      \go,goes,went,gone,going -> {
--      s = table {
--        VInf   => go ;
--        VPres  => goes ;
--        VPast  => went ;
--        VPPart => gone ;
--        VPresPart => going
--        }
--      } ;
--
--    mkIP : (i,me,my : Str) -> Number -> {s : Case => Str ; n : Number} =
--     \i,me,my,n -> let who = mkNP i me my n P3 in {s = who.s ; n = n} ;

-- For $Noun$.

  artDef : GenNum -> Str = \gn -> gennumForms "den" "det" "de" ! gn ;

  mkNP : (x1,_,_,_,x5 : Str) -> GenNum -> Person -> 
         {s : NPForm => Str ; a : Agr} = \du,dig,din,ditt,dina,gn,p -> {
    s = table {
      NPNom => du ;
      NPAcc => dig ;
      NPPoss g => gennumForms din ditt dina ! g
      } ;
    a = {
      gn = gn ;
      p  = p
      }
    } ;

  gennumForms : (x1,x2,x3 : Str) -> GenNum => Str = \den,det,de -> 
    table {
      SgUtr => den ;
      SgNeutr => det ;
      _ => de
    } ;  

--    regNP : Str -> Number -> {s : Case => Str ; a : Agr} = \that,n ->
--      mkNP that that (that + "'s") n P3 ;
--

-- For $Verb$.

  Verb : Type = {
    s : VForm => Str
    } ;

  VP = {
      s : SForm => {
        fin : Str ;           -- V1 har  ---s1
        inf : Str             -- V2 sagt ---s4
        } ;
      a1 : Polarity => Str ; -- A1 inte ---s3
      n2 : Agr => Str ;      -- N2 dig  ---s5  
      a2 : Str ;             -- A2 idag ---s6
      ext : Str ;            -- S-Ext att hon går   ---s7
      --- ea1,ev2,           --- these depend on params of v and a1
      en2,ea2,eext : Bool    -- indicate if the field exists
      } ;


  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = \\a => vp.n2 ! a ++ obj ! a ;
    a2 = vp.a2 ;
    ext = vp.ext ;
    en2 = True ;
    ea2 = vp.ea2 ;
    eext = vp.eext
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ++ adv ;
    ext = vp.ext ;
    en2 = vp.en2 ;
    ea2 = True ;
    eext = vp.eext
    } ;

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = \\b => vp.a1 ! b ++ adv ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    ext = vp.ext ;
    en2 = vp.en2 ;
    ea2 = vp.ea2 ;
    eext = vp.eext
    } ;

--  presVerb : {s : VForm => Str} -> Agr -> Str = \verb -> 
--    agrVerb (verb.s ! VPres) (verb.s ! VInf) ;

  infVP : VP -> Agr -> Str = \vp,a -> 
    (vp.s ! VInfinit Simul).inf ++ vp.n2 ! a ++ vp.a2 ++ vp.ext ; --- a1

--  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
--    case agr of {
--      {n = Sg ; p = P3} => has ;
--      _                 => have
--      } ;
--
--  have   = agrVerb "has"     "have" ;
--  havent = agrVerb "hasn't"  "haven't" ;
--  does   = agrVerb "does"    "do" ;
--  doesnt = agrVerb "doesn't" "don't" ;
--
--  Aux = {pres,past : Polarity => Agr => Str ; inf,ppart : Str} ;
--
--  auxBe : Aux = {
--    pres = \\b,a => case <b,a> of {
--      <Pos,{n = Sg ; p = P1}> => "am" ; 
--      <Neg,{n = Sg ; p = P1}> => ["am not"] ; --- am not I
--      _ => agrVerb (posneg b "is")  (posneg b "are") a
--      } ;
--    past = \\b,a => agrVerb (posneg b "was") (posneg b "were") a ;
--    inf  = "be" ;
--    ppart = "been"
--    } ;
--
--  posneg : Polarity -> Str -> Str = \p,s -> case p of {
--    Pos => s ;
--    Neg => s + "n't"
--    } ;
--
--  conjThat : Str = "that" ;
--
--  reflPron : Agr => Str = table {
--    {n = Sg ; p = P1} => "myself" ;
--    {n = Sg ; p = P2} => "yourself" ;
--    {n = Sg ; p = P3} => "itself" ; ----
--    {n = Pl ; p = P1} => "ourselves" ;
--    {n = Pl ; p = P2} => "yourselves" ;
--    {n = Pl ; p = P3} => "themselves"
--    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  mkS : Str -> Agr -> 
        (SForm => {fin,inf : Str}) -> (Polarity => Str) -> (Agr => Str) -> Clause =
    \subj,agr,verb,adv,compl0 -> {
      s = \\t,a,b,o => 
        let 
          verb  = verb ! VFinite t a ;
          neg   = adv ! b ;
          compl = compl0 ! agr
        in
        case o of {
          Main => subj ++ verb.fin ++ neg ++ verb.inf ++ compl ;
          Inv  => verb.fin ++ subj ++ neg ++ verb.inf ++ compl ;
          Sub  => subj ++ neg ++ verb.fin ++ verb.inf ++ compl
          }
    } ;

--
---- For $Numeral$.
--
--  mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
--    \two, twelve, twenty, second ->
--    {s = table {
--       unit => table {NCard => two ; NOrd => second} ; 
--       teen => \\c => mkCard c twelve ; 
--       ten  => \\c => mkCard c twenty
--       }
--    } ;
--
--  regNum : Str -> {s : DForm => CardOrd => Str} = 
--    \six -> mkNum six (six + "teen") (six + "ty") (regOrd six) ;
--
--  regCardOrd : Str -> {s : CardOrd => Str} = \ten ->
--    {s = table {NCard => ten ; NOrd => regOrd ten}} ;
--
--  mkCard : CardOrd -> Str -> Str = \c,ten -> 
--    (regCardOrd ten).s ! c ; 
--
--  regOrd : Str -> Str = \ten -> 
--    case last ten of {
--      "y" => init ten + "ieth" ;
--      _   => ten + "th"
--      } ;
--
}
