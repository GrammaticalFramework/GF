resource ParadigmsEus = open CatEus, ResEus, Prelude in {

oper

--2 Parameters 
--
-- To abstract over number, valency and (some) case names, 
-- we define the following identifiers. The application programmer
-- should always use these constants instead of the constructors
-- defined in $ResEus$.
  Number : Type ;
  sg : Number ;
  pl : Number ;

 -- Only restricted to izan and ukan, no other synthetic verbs. 
 -- If you need to add a new synthetic verb, see syntVerbNor and syntVerbNork in ResEus.
  AuxType : Type ;
  da : AuxType ;
  du : AuxType ;
  zaio : AuxType ;
  dio : AuxType ;

  Case : Type ;
  absolutive : Case ;
  ergative : Case ;
  dative : Case ;
  genitive : Case ;
  partitive : Case ;
  inessive : Case ;
  instrumental : Case ; -- Instrumental : 
  sociative : Case ; -- Sociative/comitative : txakurrarekin `with the dog'

  Animacy : Type ;
  animate : Animacy ;
  inanim : Animacy ;

--2 Nouns

  mkN = overload {
    mkN : Str -> N = \s -> lin N (mkNoun s) ;
    mkN : Str -> Bizi -> N = \s,bizi -> lin N (mkNoun s ** { anim = bizi }) ;
  } ;

  mkPN : Str -> PN = \s -> lin PN (mkPNoun s) ;
  
  mkN2 = overload {
    mkN2 : Str -> N2 = \s -> lin N2 (mkNoun2 s genitive) ; 
    mkN2 : Str -> Case -> N2 = \s,cas -> lin N2 (mkNoun2 s cas) ;
  } ;

--2 Adjectives

  mkA = overload {
    mkA : Str -> A = \s -> lin A (regAdj s) ;
    mkA : Str -> A -> A = \s,a -> irregAdvAdj s a 
  } ;

--  mkA2 : Str -> A2 = \s -> lin A2 (mkAdj s) ;



--2 Verbs

  mkV = overload {

    mkV : Str -> V = \s -> lin V (mkVerbDa s) ;  -- 

    mkV : Str -> V -> V = \lo,egin -> 
      lin V (egin ** { prc = \\t => lo ++ egin.prc ! t }) ;

  } ;

  -- For verbs with non-inflecting participle, see izanV, egonV and ukanV.

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (mkVerbDu s) ;

    mkV2 : Str -> AuxType -> V2 = \s,val -> lin V2 (mkVerbDa s ** { val = val }) ;

    mkV2 : Str -> V -> V2 = \lo,egin -> 
      lin V2 (egin ** { prc = \\t => lo ++ egin.prc ! t ;
                        val = Du Ukan }) ;

  } ;

  mkVA : Str -> VA = \s -> lin VA (mkVerbDa s) ; -- Nor

  mkV2A : Str -> V2A = \s -> lin V2A (mkVerbDu s) ;  -- Nor-nork   
  mkVQ : Str -> VQ = \s -> lin VQ (mkVerbDu s) ;  -- Nor-nork 
  mkVS : Str -> VS = \s -> lin VS (mkVerbDu s) ;  -- Nor-nork


  mkV2V : Str -> V2V = \s -> lin V2V (mkVerbDio s) ; -- ??? TODO check valency
  mkV2S : Str -> V2S = \s -> lin V2S (mkVerbDio s) ; -- Nor-nori-nork: (mutilari) (neska datorrela) erantzun diot
  mkV2Q : Str -> V2Q = \s -> lin V2Q (mkVerbDio s) ; -- Nor-nori-nork: (mutilari) (neska datorren) galdetu diot
  mkV3 : Str -> V3 = \s -> lin V3 (mkVerbDio s) ; -- Nor-nori-nork: (mutilari) (garagardoa) edan diot


  -----
  -- Verbs with non-inflecting participle
  -- These are just Verb, use izanV or egonV for intransitive and ukanV for transitive.

  izanV : Str -> Verb = \bizi -> 
    mkVerbDa bizi ** { prc = \\_ => bizi } ; -- Non-inflecting participle, auxtype is Da (nor): e.g. "bizi naiz", "beldur naiz"

  egonV : Str -> Verb = \zain -> 
    mkVerbDaEgon zain ** { prc = \\_ => zain } ; -- Non-inflecting participle, auxtype is Da (nor), but with egon: e.g. "zain nago"


  ukanV : Str -> Verb = \maite -> 
    mkVerbDu maite ** { prc = \\_ => maite } ; -- Non-inflecting participle, auxtype is Du (nor-nork): e.g, "maite zaitut"


--2 Structural categories

  mkPrep = overload { 
    mkPrep : Str -> Prep = \s -> 
       lin Prep (mkPost s genitive False) ; -- Default postposition: complement case genitive, not affixed; e.g. "nire atzean"

    mkPrep : Str -> (complCase : Case) -> Prep = \s,compl -> 
       lin Prep (mkPost s compl False) ; -- Specify complement case; not affixed

    mkPrep : Str -> (complCase : Case) -> (affixed : Bool) -> Prep = \s,compl,konf -> 
       lin Prep (mkPost s compl konf) ; -- Specify complement case and whether it is affixed
  } ; 
 
  affixPrep : Str -> Case -> Prep = \str,cas ->
    mkPrep str cas True ; -- Specify case, affix postposition to chosen case; e.g. neskaren+tzat `for the girl'

  
  locPrep : Str -> Prep = \str ->
    affixPrep str ResEus.LocStem ; -- Locative postpositions/cases attach to the same stem: mutile+tik, mutile+ra. Inessive is split into its own case, because of its behaviour with nouns ending in A.
 

  mkConj : (_,_ : Str) -> Number -> Conj = \s1,s2,num -> lin Conj { s1 = s1 ; s2 = s2 ; nbr = num } ; 
  mkSubj : Str -> Bool -> Subj   = \s,b   -> lin Subj { s = s ; isPre = b } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;

  mkAdV : Str -> AdV = \s -> lin AdV {s = s} ;

  mkAdA : Str -> AdA = \s -> lin AdA {s = s} ;


--.
-------------------------------------------------------------------------------
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Number = ResEus.Number ;
  sg = Sg ;
  pl = Pl ;

  AuxType = ResEus.AuxType ;
  da = Da Izan ;
  du = Du Ukan ;
  zaio = Zaio ;
  dio = Dio ;

  Case = ResEus.Case ;
  absolutive = Abs ;
  ergative = Erg ;
  dative = Dat ;
  genitive = Gen ;
  partitive = Par ;
  inessive = Ine ;
  instrumental = Ins ;
  sociative = Soc ;

  Animacy = ResEus.Bizi ;
  animate = Anim ;
  inanim = Inan ;

--------------------------------------------------------------------------------

}

