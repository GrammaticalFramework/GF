concrete VerbEus of Verb = CatEus ** open ResEus, AditzTrinkoak, Prelude in {


lin

-----
-- VP

  UseV = ResEus.useV ;

  -- : VV  -> VP -> VP ;  -- [lo egin/neska ikusi/jakin] nahi/ahal/behar dut
  ComplVV vv vp = 
    let vcomp : Str = linVPPrc vp ;
    in ResEus.insertComp vcomp (useV vv) ;


  -- : VS  -> S  -> VP ;  -- uste dut [neska etorriko dela]
  -- The subordinator suffix -la is hardcoded in ComplVS
  -- In Extra: ComplVS that takes the S with other suffixes (-en,-tzera)
  ComplVS vs s =
    let scomp : Str = linSSub s.s "la" ;
    in ResEus.insertComp scomp (useV vs) ;

  -- : VQ -> QS -> VP ;   -- ez dakit [nor den]
  ComplVQ vq qs = 
    let qi : Sentence = qs.s ! Indir ; -- choose the version without al
        qcomp : Str = linSSub qi "n" ;
    in ResEus.insertComp qcomp (useV vq) ;

  -- : VA -> AP -> VP ;  -- they become red
  ComplVA va ap = ResEus.insertComp (CompAP ap).s (useV va) ;


--------
-- Slash

  -- : V2 -> VPSlash
  SlashV2a = ResEus.slashDObj ;


  -- : V3 -> NP -> VPSlash ; -- give it (to her)
  Slash2V3 v3 npNori = slashDObj v3 **
    { iobj = { s = npNori.s ! Dat ;
               agr = npNori.agr }
    } ;

  -- : V3 -> NP -> VPSlash ; -- give (it) to her
  Slash3V3 v3 npNor = slashIObj v3 **
    { dobj = npNor ** { s = mkDObj npNor } 
    } ;


  -- : V2V -> VP -> VPSlash ;  -- beg (her) to go
  SlashV2V v2v vp = slashDObj v2v **   -- TODO: something wrong in this function!
    { comp = \\agr => linVPPrc vp } ; --How about agreement with tense of the main clause???
    

  -- : V2S -> S  -> VPSlash ;  -- answer (to him) that it is good
  SlashV2S v2s s = slashDObj v2s **
    { comp = \\agr => linSSub s.s "la" } ;

  -- : V2Q -> QS -> VPSlash ;  -- ask (him) who came
  SlashV2Q v2q qs = slashDObj v2q **
    { comp = \\agr => linSSub (qs.s ! Indir) "la" } ;

  -- : V2A -> AP -> VPSlash ;  -- paint (it) red
  SlashV2A v2a ap = slashDObj v2a **
    { comp = (CompAP ap).s } ;


  -- : VPSlash -> NP -> VP
  ComplSlash vps np = ResEus.complSlash vps np ;


  -- : VV  -> VPSlash -> VPSlash ; -- [___ ikusi] nahi/ahal/behar dut
                  -- Just like ComplVV except missing subject!
  SlashVV vv vps = ComplVV vv vps ** { missing = vps.missing ; 
                                       post = vps.post } ;
 
  -- : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy
  SlashV2VNP v2v np vps = 
    ComplVV v2v vps **
      { missing = vps.missing ;
        post = vps.post ;
        iobj = np ** { s = np.s ! Dat } } ;

--2 Other ways of forming verb phrases

-- Verb phrases can also be constructed reflexively and from
-- copula-preceded complements.

  -- : VPSlash -> VP ;
  ReflVP vps = complSlash vps buru_NP ; ------ TODO

  -- : Comp -> VP ;
  UseComp comp = insertComp comp.s (copulaVP comp.copula) ;


  --  : V2 -> VP ;               -- be loved
  PassV2 v2 = 
   let kantatuak : Agr => Str = table {
         (Gu|Zuek|Hauek) => v2.prc ! Past ++ BIND ++ "ak" ;
         _               => v2.prc ! Past } ;
    in insertComp kantatuak (copulaVP Izan) ; --TODO: we lose the nstem, but maybe that's okay?

  -- : VP -> Adv -> VP ;  -- sleep here
  AdvVP vp adv = ResEus.insertAdv adv vp ;

  -- : VP -> Adv -> VP ;  -- sleep , even though ...
  ExtAdvVP vp adv = ResEus.insertAdv (postfixSS (SOFT_BIND ++ ",") adv) vp ;

  -- : AdV -> VP -> VP ;  -- always sleep
  AdVVP adv vp = ResEus.insertAdv adv vp ;

  -- : VPSlash -> Adv -> VPSlash ;  -- use (it) here
  AdvVPSlash vps adv = vps ** { adv = vps.adv ++ adv.s } ;

  -- : AdV -> VPSlash -> VPSlash ;  -- always use (it)
  AdVVPSlash adv vps = vps ** { adv = adv.s ++ vps.adv } ;

  -- : VP -> Prep -> VPSlash ;  -- live in (it)
  VPSlashPrep vp prep = vp ** 
   { post = prep ; 
     missing = MissingAdv } ;


lin

--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

  -- the house is big   = etxea handia da
  -- the houses are big = etxeak handiak dira
  -- I am [a house that sleeps here] = ni [hemen lo egiten den etxea] naiz
  -- we are [houses that sleep here] = gu [hemen lo egiten diren etxeak] gara

  -- Complement : Type = {s : Agr => Str ; copula : SyntVerb1 } ;

  -- : AP  -> Comp ;
  CompAP ap = { s = \\agr => ap.s ++ artDef ! getNum agr ! Abs ! ap.ph  ;
                copula = Izan };

  -- : CN  -> Comp ;
  CompCN cn = { s = \\agr => cn.s ! agr ++ artDef ! getNum agr ! Abs ! cn.ph ;
                copula = Izan } ; 

  --  NP  -> Comp ;
  CompNP np = { s = \\agr => np.s ! Abs ; copula = Izan } ; 

  -- : Adv  -> Comp ;
  CompAdv adv = { s = \\agr => adv.s ; copula = Egon } ; 


  -- : VP -- Copula alone; intransitive and Izan by default
  UseCopula = copulaVP Izan ;


oper 

  copulaVP : SyntVerb1 -> VerbPhrase = \izan ->
    ResEus.useV { prc = \\tns => [] ; 
                  nstem = case izan of { Izan => "izate" ; _ => "egote" } ; --TODO is this correct?
                  val = Da izan } ;
} 



