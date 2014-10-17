--1 Estonian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResEst = ParamX ** open Prelude in {

  flags optimize=all ; coding=utf8;


--2 Parameters for $Noun$

-- This is the $Case$ as needed for both nouns and $NP$s.

  param
    Case = Nom | Gen | Part  
         | Illat | Iness | Elat | Allat | Adess | Ablat 
         | Transl | Ess | Termin | Abess | Comit;

    NForm = NCase Number Case ; 


-- Agreement of $NP$ has number*person and the polite second ("te olette valmis").


    Agr = Ag Number Person | AgPol ;

  oper
    complNumAgr : Agr -> Number = \a -> case a of {
      Ag n _ => n ;
      AgPol  => Sg
      } ;
    verbAgr : Agr -> {n : Number ; p : Person} = \a -> case a of {
      Ag n p => {n = n  ; p = p} ;
      AgPol  => {n = Pl ; p = P2}
      } ;

  oper
    NP = {s : NPForm => Str ; a : Agr ; isPron : Bool} ;

--
--2 Adjectives
--
-- The major division is between the comparison degrees. A degree fixed,
-- an adjective is like common nouns, except for the adverbial form.

param
  AForm = AN NForm | AAdv ;

  Infl = Regular | Participle | Invariable ;

oper
  Adjective : Type = {s : Degree => AForm => Str; lock_A : {}} ;

--2 Noun phrases
--
-- Two forms of *virtual accusative* are needed for nouns in singular, 
-- the nominative and the genitive one ("loen raamatu"/"loe raamat"). 
-- For nouns in plural, only a nominative accusative exists in positive clauses. 
-- Pronouns use the partitive as their accusative form ("mind", "sind"), in both
-- positive and negative, indicative and imperative clauses.

param 
  NPForm = NPCase Case | NPAcc ;

oper
  npform2case : Number -> NPForm -> Case = \n,f ->

--  type signature: workaround for gfc bug 9/11/2007
    case <<f,n> : NPForm * Number> of {
      <NPCase c,_> => c ;
      <NPAcc,Sg>   => Gen ;-- appCompl does the job
      <NPAcc,Pl>   => Nom
    } ;

--2 For $Verb$

-- A special form is needed for the negated plural imperative.

param
  VForm = 
     Inf InfForm
   | Presn Number Person
   | Impf Number Person
   | Condit Number Person
   | ConditPass --loetagu
   | Imper Number
   | ImperP3 
   | ImperP1Pl
   | ImperPass
   | PassPresn Bool
   | PassImpf Bool
   | Quotative Voice
   | PresPart Voice
   | PastPart Voice
   ;

  Voice = Act | Pass ;
  
  InfForm =
     InfDa     -- lugeda
   | InfDes    -- lugedes 
   | InfMa     -- lugema  
   | InfMas    -- lugemas
   | InfMast   -- lugemast
   | InfMata   -- lugemata
   | InfMaks   -- lugemaks
   ;

  SType = SDecl | SQuest | SInv ;

--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;

--2 For $Numeral$

    CardOrd = NCard NForm | NOrd NForm ;

--2 Transformations between parameter types

  oper
    agrP3 : Number -> Agr = \n -> 
      Ag n P3 ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> case <a,b> of {
      <Ag n p, Ag m q> => Ag (conjNumber n m) (conjPerson p q) ;
      <Ag n p, AgPol>  => Ag Pl (conjPerson p P2) ;
      <AgPol,  Ag n p> => Ag Pl (conjPerson p P2) ;
      _ => b 
      } ;

---

  Compl : Type = {s : Str ; c : NPForm ; isPre : Bool} ;

  appCompl : Bool -> Polarity -> Compl -> NP -> Str = \isFin,b,co,np ->
    let
      c = case co.c of {
        NPAcc => case b of {
          Neg => NPCase Part ; -- ma ei näe raamatut/sind
          Pos => case isFin of {
               True => NPAcc ; -- ma näen raamatu/sind
               _ => case np.isPron of {
                  False => NPCase Nom ;  --tuleb see raamat lugeda
                  _ => NPAcc             --tuleb sind näha --TODO I: is this correct?
                  }
               }
          } ;
        _        => co.c
        } ;
{-
      c = case <isFin, b, co.c, np.isPron> of {
        <_,    Neg, NPAcc,_>      => NPCase Part ; -- en näe taloa/sinua
        <_,    Pos, NPAcc,True>   => NPAcc ;       -- näen/täytyy sinut
        <False,Pos, NPAcc,False>  => NPCase Nom ;  -- täytyy nähdä talo
        <_,_,coc,_>               => coc
        } ;
-}
      nps = np.s ! c
    in
    preOrPost co.isPre co.s nps ;

-- For $Verb$.

  Verb : Type = {
    s : VForm => Str ;
    p : Str  -- particle verbs
    } ;

param
  VIForm =
     VIFin  Tense  
   | VIInf  InfForm
   | VIPass Tense
   | VIImper 
   ;  

oper
  VP : Type = {
    s   : VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ; 
    s2  : Bool => Polarity => Agr => Str ; -- raamat/raamatu/raamatut
    adv : Str ;
    p : Str ; --uninflecting component in multi-word verbs
    ext : Str ;
    sc  : NPForm ;
    } ;
    
  predV : (Verb ** {sc : NPForm}) -> VP = \verb -> {
    s = \\vi,ant,b,agr0 => 
      let
        agr = verbAgr agr0 ;
        verbs = verb.s ;
        part  : Str = case vi of {
          VIPass _ => verbs ! (PastPart Pass) ; 
          _      => verbs ! (PastPart Act)
        } ; 
        
        einegole : Str * Str * Str = case <vi,agr.n> of {
          <VIFin Pres,   _>  => <"ei", verbs ! Imper Sg,     "ole"> ;
          <VIFin Fut,    _>  => <"ei", verbs ! Imper Sg,     "ole"> ;
          <VIFin Cond,   _>  => <"ei", verbs ! Condit Sg P3, "oleks"> ;
          <VIFin Past,   _>  => <"ei", part,                 "olnud"> ;
          <VIImper,      Sg> => <"ära", verbs ! Imper Sg,   "ole"> ;
          <VIImper,      Pl> => <"ärge", verbs ! Imper Pl,  "olge"> ;
          <VIPass Pres,   _>  => <"ei", verbs ! PassPresn False,  "ole"> ;
          <VIPass Fut,    _>  => <"ei", verbs ! PassPresn False,  "ole"> ; --# notpresent
          <VIPass Cond,   _>  => <"ei", verbs ! ConditPass,  "oleks"> ; --# notpresent
          <VIPass Past,   _>  => <"ei", verbs ! PassImpf False,  "olnud"> ; --# notpresent
          <VIInf i,      _>  => <"ei", verbs ! Inf i, "olla">
        } ;
        
        ei  : Str = einegole.p1 ;
        neg : Str = einegole.p2 ;
        ole : Str = einegole.p3 ;
        
        olema : VForm => Str = verbOlema.s ;
        
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> {fin = x ; inf = y} ;
        
        mkvf : VForm -> {fin, inf : Str} = \p -> case <ant,b> of {
          <Simul,Pos> => vf (verbs ! p) [] ;
          <Anter,Pos> => vf (olema ! p) part ; 
          <Simul,Neg> => vf (ei ++ neg) [] ;
          <Anter,Neg> => vf (ei ++ ole) part 
        } ;

        passPol = case b of {Pos => True ; Neg => False} ;

   in case vi of {
        VIFin Past  => mkvf (Impf agr.n agr.p) ; --# notpresent
        VIFin Cond  => mkvf (Condit agr.n agr.p) ; --# notpresent
        VIFin Fut   => mkvf (Presn agr.n agr.p) ; --# notpresent
        VIFin Pres  => mkvf (Presn agr.n agr.p) ;
        VIImper     => mkvf (Imper agr.n) ;
        VIPass Pres => mkvf (PassPresn passPol) ;
        VIPass Past => mkvf (PassImpf passPol) ;  --# notpresent
        VIPass Cond => mkvf (ConditPass) ; --# notpresent
        VIPass Fut  => mkvf (PassPresn passPol) ;  --# notpresent
        VIInf i    => mkvf (Inf i)
        } ;

    s2 = \\_,_,_ => [] ;
    adv = [] ;
    ext = [] ; --relative clause
    p = verb.p ; --particle verbs
    sc = verb.sc 
    } ;

  insertObj : (Bool => Polarity => Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\fin,b,a => vp.s2 ! fin ! b ! a  ++ obj ! fin ! b ! a ;
    adv = vp.adv ;
    p = vp.p ;
    ext = vp.ext ;
    sc = vp.sc ; 
    } ;

  insertObjPre : (Bool => Polarity => Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\fin,b,a => obj ! fin ! b ! a ++ vp.s2 ! fin ! b ! a ;
    adv = vp.adv ;
    p = vp.p ;
    ext = vp.ext ;
    sc = vp.sc ; 
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    s2 = vp.s2 ;
    p = vp.p ;
    ext = vp.ext ;
    adv = vp.adv ++ adv ;
    sc = vp.sc ; 
    } ;

  insertExtrapos : Str -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = vp.s2 ;
    p = vp.p ;
    ext = vp.ext ++ obj ;
    adv = vp.adv ;
    sc = vp.sc ; 
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => SType => Str
    } ;

  ClausePlus : Type = {
    s : Tense => Anteriority => Polarity => {subj,fin,inf,compl,adv,p,ext : Str}
    } ;

  -- The Finnish version of SQuest featured a word order change and
  -- the question particle "ko". The Estonian version just prefixes the
  -- declarative sentence with the yes/no-queryword "kas".
  -- SQuest: "kas" + SDecl
  -- It would be also correct to use the Finnish structure, just without the ko-particle.
  -- Inari: added a third SType, SInv. 
  -- Not sure if SInv is needed, but keeping it for possible future use.
  -- There's need for an inverted word order with auxiliary verbs; infVP handles that. ComplVV calls infVP, which inverts the word order for the complement VP, and puts it into the resulting VP's `compl' field.
  -- SInv made by mkClause would be for cases where you just need to construct an inverted word order, and then call it from some other place; application grammar (TODO: api oper for SType) or ExtraEst.
  mkClause : (Polarity -> Str) -> Agr -> VP -> Clause = 
    \sub,agr,vp -> {
      s = \\t,a,b => 
      let
        c = (mkClausePlus sub agr vp).s ! t ! a ! b ;
        --                 saan              sinust     aru    0
        --       ma        olen     täna     sinust     aru    saanud
        declCl = c.subj ++ c.fin ++ c.adv ++ c.compl ++ c.p ++ c.inf ++ c.ext ;
        --                                [sind näha]  0      tahtnud
        --      täna     olen     ma        sinust     aru    saanud
        invCl = c.adv ++ c.fin ++ c.subj ++ c.compl ++ c.p ++ c.inf ++ c.ext
      in 
         table {
           SDecl  => declCl ;
           SQuest => "kas" ++ declCl ;
           SInv   => invCl 
         }
      } ;

  mkClausePlus : (Polarity -> Str) -> Agr -> VP -> ClausePlus =
    \sub,agr,vp -> {
      s = \\t,a,b => 
        let 
          agrfin = case vp.sc of {
                    NPCase Nom => <agr,True> ;
                    _ => <agrP3 Sg,False>      -- minun täytyy, minulla on
                    } ;
          verb  = vp.s ! VIFin t ! a ! b ! agrfin.p1 ;
        in {subj = sub b ; 
            fin  = verb.fin ; 
            inf  = verb.inf ; 
            compl = vp.s2 ! agrfin.p2 ! b ! agr ;
            p = vp.p ;
            adv  = vp.adv ; 
            ext  = vp.ext ; 
            }
     } ;

  insertKinClausePlus : Predef.Ints 1 -> ClausePlus -> ClausePlus = \p,cl -> { 
    s = \\t,a,b =>
      let 
         c = cl.s ! t ! a ! b   
      in
      case p of {
         0 => {subj = c.subj ++ gi ; fin = c.fin ; inf = c.inf ;  -- Jussikin nukkuu
               compl = c.compl ; p = c.p ; adv = c.adv ; ext = c.ext ; h = c.h} ;
         1 => {subj = c.subj ; fin = c.fin ++ gi ; inf = c.inf ;  -- Jussi nukkuukin
               compl = c.compl ; p = c.p ; adv = c.adv ; ext = c.ext ; h = c.h}
         }
    } ;

  insertObjClausePlus : Predef.Ints 1 -> Bool -> (Polarity => Str) -> ClausePlus -> ClausePlus = 
   \p,ifKin,obj,cl -> { 
    s = \\t,a,b =>
      let 
         c = cl.s ! t ! a ! b ;
         co = obj ! b ++ if_then_Str ifKin (kin b) [] ;
      in case p of {
         0 => {subj = c.subj ; fin = c.fin ; inf = c.inf ; 
               compl = co ; p = c.p ; adv = c.compl ++ c.adv ; ext = c.ext ; h = c.h} ; -- Jussi juo maitoakin
         1 => {subj = c.subj ; fin = c.fin ; inf = c.inf ; 
               compl = c.compl ; p = c.p ; adv = co ; ext = c.adv ++ c.ext ; h = c.h}   -- Jussi nukkuu nytkin
         }
     } ;

  kin : Polarity -> Str  = 
    \p -> case p of {Pos => "gi" ; Neg => "gi"} ;
  
  --allomorph "ki", depends only on phonetic rules "üks+ki", "ühe+gi" 
  --waiting for post construction in GF :P
  gi : Str = "gi" ;

  glueTok : Str -> Str = \s -> "&+" ++ s ;


-- This is used for subjects of passives: therefore isFin in False.

  subjForm : NP -> NPForm -> Polarity -> Str = \np,sc,b -> 
    appCompl False b {s = [] ; c = sc ; isPre = True} np ;

  infVP : NPForm -> Polarity -> Agr -> VP -> InfForm -> Str =
    \sc,pol,agr,vp,vi ->
        let 
          fin = case sc of {     -- subject case
            NPCase Nom => True ; -- mina tahan joosta
            _ => False           -- minul peab auto olema
            } ;
          verb  = vp.s ! VIInf vi ! Simul ! Pos ! agr ; -- no "ei"
          compl = vp.s2 ! fin ! pol ! agr ; -- but compl. case propagated
          adv = vp.adv
        in
        -- inverted word order; e.g.
      --sinust   kunagi aru     saada       tahtnud     rel. clause
        compl ++ adv ++ vp.p ++ verb.inf ++ verb.fin ++ vp.ext ;
        --TODO adv placement?
        --TODO inf ++ fin or fin ++ inf? does it ever become a case here?

-- The definitions below were moved here from $MorphoEst$ so that  
-- auxiliary of predication can be defined.

  verbOlema : Verb = 
    let olema = mkVerb
      "olema" "olla" "olen" "ollakse" 
      "olge" "oli" "olnud" "oldud"
     in {s = table {
      Presn _ P3 => "on" ;
      v => olema.s ! v
      } ;
      p = []
    } ;

  verbMinema : Verb = 
    let minema = mkVerb 
      "minema" "minna" "läheb" "minnakse" 
      "minge" "läks" "läinud" "mindud"
    in {s = table {
      Impf Sg P1 => "läksin" ;
      Impf Sg P2 => "läksid" ;
      Impf Pl P1 => "läksime" ;
      Impf Pl P2 => "läksite" ;
      Impf Pl P3 => "läksid" ;
      Imper Sg => "mine" ;
      v => minema.s ! v
      } ;
      p = []
    } ;
    

--3 Verbs

  --Auxiliary for internal use
  mkVerb : (x1,_,_,_,_,_,_,x8 : Str) -> Verb = 
    \tulema,tulla,tuleb,tullakse,tulge,tuli,tulnud,tuldud -> 
    vforms2V (vForms8 
     tulema tulla tuleb tullakse tulge tuli tulnud tuldud
      ) ;

--below moved here from MorphoEst
    VForms : Type = Predef.Ints 7 => Str ;
    
    vForms8 : (x1,_,_,_,_,_,_,x8 : Str) -> VForms =
      \tulema,tulla,tuleb,tullakse,tulge,tuli,tulnud,tuldud ->
      table {
        0 => tulema ;
        1 => tulla ;
        2 => tuleb ;
        3 => tullakse ;
        4 => tulge ;
        5 => tuli ;
        6 => tulnud ;
        7 => tuldud
      } ;

    vforms2V : VForms -> Verb = \vh -> 
    let
      tulema = vh ! 0 ; 
      tulla = vh ! 1 ; 
      tuleb = vh ! 2 ; 
      tullakse = vh ! 3 ; --juuakse; loetakse 
      tulge = vh ! 4 ;  --necessary for tulla, surra (otherwise *tulege, *surege) 
      tuli = vh ! 5 ; --necessary for jooma-juua-jõi
      tulnud = vh ! 6 ;
      tuldud = vh ! 7 ; --necessary for t/d in tuldi; loeti
      
      tull_ = init tulla ; --juu(a); saad(a); tull(a);
      tulles = tull_ + "es" ; --juues; saades; tulles;
      
      tule_ = init tuleb ;
      
      lask_ = Predef.tk 2 tulema ;
      laulev = case (last lask_) of { --sooma~soov ; laulma~laulev
          ("a"|"e"|"i"|"o"|"u"|"õ"|"ä"|"ö"|"ü") => lask_ + "v" ;
          _ => lask_ + "ev" } ; --consonant stem in -ma, add e
          
      --imperfect stem
      kaisi_ = case (Predef.dp 3 tuli) of {
          "sis"    => lask_ + "i" ; --tõusin, tõusis
          _ + "i"  => tuli ;        --jõin, jõi
          _        => lask_ + "si"  --käisin, käis; muutsin, muutis
         }; 
            
      tuld_ = Predef.tk 2 tuldud ; --d/t choice for tuldi etc.
      tulgu = (init tulge) + "u" ;
    in
    {s = table {
      Inf InfDa => tulla ;
      Inf InfDes => tulles ;
      Presn Sg P1 => tule_ + "n" ;
      Presn Sg P2 => tule_ + "d" ;
      Presn Sg P3 => tuleb ;
      Presn Pl P1 => tule_ + "me" ;
      Presn Pl P2 => tule_ + "te" ;
      Presn Pl P3 => tule_ + "vad" ;
      Impf Sg P1  => kaisi_ + "n" ;   --# notpresent
      Impf Sg P2  => kaisi_ + "d" ;  --# notpresent
      Impf Sg P3  => tuli ;  --# notpresent
      Impf Pl P1  => kaisi_ + "me" ;  --# notpresent
      Impf Pl P2  => kaisi_ + "te" ;  --# notpresent
      Impf Pl P3  => kaisi_ + "d" ;  --# notpresent
      Condit Sg P1 => tule_ + "ksin" ;  --# notpresent
      Condit Sg P2 => tule_ + "ksid" ;  --# notpresent
      Condit Sg P3 => tule_ + "ks";  --# notpresent
      Condit Pl P1 => tule_ + "ksime" ;  --# notpresent
      Condit Pl P2 => tule_ + "ksite" ;  --# notpresent
      Condit Pl P3 => tule_ + "ksid" ;  --# notpresent
      ConditPass   => tuld_ + "aks" ; --# notpresent
      Imper Sg  => tule_ ; -- tule / ära tule
      Imper Pl  => tulge ; -- tulge / ärge tulge
      ImperP3   => tulgu ; -- tulgu (ta/nad) 
      ImperP1Pl => tulge + "m" ; -- tulgem
      ImperPass => tuld_ + "agu" ; --tuldagu
      PassPresn True  => tullakse ;
      PassPresn False => tuld_ + "a" ; --da or ta
      PassImpf  True  => tuld_ + "i" ; --di or ti
      PassImpf  False => tuldud ;  
      Quotative Act  => lask_ + "vat" ;
      Quotative Pass => tuld_ + "avat" ; --d or t
      PresPart Act  => laulev ;
      PresPart Pass => tuld_ + "av" ; --d or t
      PastPart Act  => tulnud ;
      PastPart Pass => tuldud ;
      Inf InfMa => tulema ;
      Inf InfMas => tulema + "s" ;
      Inf InfMast => tulema + "st" ;
      Inf InfMata => tulema + "ta" ;
      Inf InfMaks => tulema + "ks" 
      } ;
    sc = NPCase Nom ;
    p = [] ;
    lock_V = <>
    } ;

  -- For regular verbs, paradigm from 4 base forms
  -- Analoogiaseosed pöördsõna paradigmas
  -- http://www.eki.ee/books/ekk09/index.php?p=3&p1=5&id=227
  regVForms : (x1,_,_,x4 : Str) -> VForms = \vestlema,vestelda,vestleb,vesteldakse ->
    let
      vestle_ = Predef.tk 2 vestlema ;
      vesteld_ = init vestelda ;
      vestel_ = init vesteld_ ;
      lase_ = init vestleb ;
      jaet_ = Predef.tk 4 vesteldakse ;
      g = case (last vesteld_) of { --doesn't work for anda~andke
        "t" => "k" ;
        _   => "g"
      } ;
      toit_ = case (last vestle_) of {  
        ("t"|"d") => vesteld_ ; --toit(ma)   -> toitke;
         _        => vestel_    --vestle(ma) -> vestelge
      } ;
      laski_ = case (last vestle_) of { 
        ("a"|"e"|"i"|"o"|"u"|"õ"|"ä"|"ö"|"ü") 
            => vestle_ ;      --vestle(ma) -> vestles
         _  => vestle_ + "i"  --lask(ma)   -> laskis
      } ;
    in
      vForms8
        vestlema
        vestelda
        vestleb
        vesteldakse
        (toit_ + g + "e") --da: käskiva kõneviisi ainsuse 3. pööre ja mitmus;
        (laski_ + "s") --ma: kindla kõneviisi lihtmineviku pöörded;
        (toit_ + "nud") --da: isikulise tegumoe mineviku kesksõna
        (jaet_ + "ud"); --takse: ülejäänud umbisikulise tgm vormid
        

  regVerb : (_,_,_,_ : Str) -> Verb = \kinkima,kinkida,kingib,kingitakse ->
    vforms2V (regVForms kinkima kinkida kingib kingitakse) ;


  noun2adj : CommonNoun -> Adj = noun2adjComp True ;
--  noun2adj : Noun -> Adj = noun2adjComp True ;

  -- TODO: remove the unused arguments and clean up the code
  -- TODO: AAdv is current just Sg Ablat, which seems OK in most cases, although
  -- ilus -> ilusti | ilusalt?
  -- hea -> hästi
  -- parem -> paremini
  -- parim -> kõige paremini | parimalt?
  noun2adjComp : Bool -> CommonNoun -> Adj = \isPos,tuore ->
--  noun2adjComp : Bool -> Noun -> Adj = \isPos,tuore ->
    let 
      tuoreesti  = Predef.tk 1 (tuore.s ! NCase Sg Gen) + "sti" ; 
      tuoreemmin = Predef.tk 2 (tuore.s ! NCase Sg Gen) + "in"
    in {s = table {
         AN f => tuore.s ! f ;
         -- AAdv => if_then_Str isPos tuoreesti tuoreemmin
         AAdv => tuore.s ! NCase Sg Ablat
         } ;
       } ;

  CommonNoun = {s : NForm => Str} ;

-- To form an adjective, it is usually enough to give a noun declension: the
-- adverbial form is regular.

  Adj : Type = {s : AForm => Str} ;


-- Reflexive pronoun. 
--- Possessive could be shared with the more general $NounFin.DetCN$.

--oper
  --Estonian version started
  reflPron : Agr -> NP = \agr -> 
    let 
      ise = nForms2N (nForms6 "ise" "enda" "ennast" "endasse" "IGNORE" "IGNORE")
    in {
      s = table {
        NPAcc => "ennast" ;
        NPCase c => ise.s ! NCase Sg c
        } ;
      a = agr ;
      isPron = False -- no special acc form
      } ;



    Noun = CommonNoun ** {lock_N : {}} ;
    NForms : Type = Predef.Ints 5 => Str ;

    nForms6 : (x1,_,_,_,_,x6 : Str) -> NForms = 
      \jogi,joe,joge,joesse, -- sg nom, gen, part, ill
       jogede,jogesid -> table { -- pl gen, part,
      0 => jogi ;
      1 => joe ;
      2 => joge ;
      3 => joesse ;
      4 => jogede ;
      5 => jogesid 
      } ;

  n2nforms : CommonNoun -> NForms = \ukko -> table {
    0 => ukko.s ! NCase Sg Nom ;
    1 => ukko.s ! NCase Sg Gen ;
    2 => ukko.s ! NCase Sg Part ;
    3 => ukko.s ! NCase Sg Illat ;
    4 => ukko.s ! NCase Pl Gen ;
    5 => ukko.s ! NCase Pl Part 
  } ;

    -- Converts 6 given strings (Nom, Gen, Part, Illat, Gen, Part) into Noun
    -- http://www.eki.ee/books/ekk09/index.php?p=3&p1=5&id=226
    nForms2N : NForms -> CommonNoun = \f -> 
      let
        jogi = f ! 0 ;
        joe = f ! 1 ;
        joge = f ! 2 ;
        joesse = f ! 3 ;
        jogede = f ! 4 ;
        jogesid = f ! 5 ;
      in 
    {s = table {
      NCase Sg Nom    => jogi ;
      NCase Sg Gen    => joe ;
      NCase Sg Part   => joge ;
      NCase Sg Transl => joe + "ks" ;
      NCase Sg Ess    => joe + "na" ;
      NCase Sg Iness  => joe + "s" ;
      NCase Sg Elat   => joe + "st" ;
      NCase Sg Illat  => joesse ;
      NCase Sg Adess  => joe + "l" ;
      NCase Sg Ablat  => joe + "lt" ;
      NCase Sg Allat  => joe + "le" ;
      NCase Sg Abess  => joe + "ta" ;
      NCase Sg Comit  => joe + "ga" ;
      NCase Sg Termin => joe + "ni" ;

      NCase Pl Nom    => joe + "d" ;
      NCase Pl Gen    => jogede ;
      NCase Pl Part   => jogesid ;
      NCase Pl Transl => jogede + "ks" ;
      NCase Pl Ess    => jogede + "na" ;
      NCase Pl Iness  => jogede + "s" ;
      NCase Pl Elat   => jogede + "st" ;
      NCase Pl Illat  => jogede + "sse" ;
      NCase Pl Adess  => jogede + "l" ;
      NCase Pl Ablat  => jogede + "lt" ;
      NCase Pl Allat  => jogede + "le" ;
      NCase Pl Abess  => jogede + "ta" ;
      NCase Pl Comit  => jogede + "ga" ;
      NCase Pl Termin => jogede + "ni" 

      } --;
--    lock_N = <>
    } ;

oper
  rp2np : Number -> {s : Number => NPForm => Str ; a : RAgr} -> NP = \n,rp -> {
    s = rp.s ! n ;
    a = agrP3 Sg ;  -- does not matter (--- at least in Slash)
    isPron = False  -- has no special accusative
    } ;

  etta_Conj : Str = "et" ;

    heavyDet : PDet -> PDet ** {sp : Case => Str} = \d -> d ** {sp = d.s} ;
    PDet : Type = {
      s : Case => Str ;
      n : Number ;
      isNum : Bool ;
      isDef : Bool
      } ;

    heavyQuant : PQuant -> PQuant ** {sp : Number => Case => Str} = \d -> 
      d ** {sp = d.s} ; 
    PQuant : Type =  
      {s : Number => Case => Str ; isDef : Bool} ; 

}
