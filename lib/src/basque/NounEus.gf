concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns

  -- : Det -> CN -> NP
  DetCN det cn = 
    let ag : Agr = case det.nbr of {
                 Sg => Hau ;
                 Pl => Hauek 
               } ;
        s : Case => Str = 
          \\c => cn.heavyMod ! ag -- e.g. rel clause, adverb
             ++ det.pref     -- nire
             ++ cn.s ! ag    -- baso handi
             ++ det.s ! c ! cn.ph  -- bat, &+a
             ++ cn.comp ;    -- ardo gorri
    in { s = s ;
         stem = s ! Abs ; -- This really shouldn't become relevant: 
         agr = ag ;       -- stem is only used in ApposCN, which makes sense 
         anim = cn.anim ; -- with NPs formed out of PNs or Symbs.
         isDef = det.isDef 
        } ;

  -- : PN -> NP ;
  UsePN pn = { s    = \\c => pn.s ++ artIndef ! c ! pn.ph;
               stem = pn.s ;
               agr  = Hau ; 
               anim = pn.anim ; 
               isDef = True } ; --in Extra : add UsePNIndef to allow "hemen ez dago Olatzik"

  -- : Pron -> NP ; 
  UsePron pron = lin NP pron ;


  -- : Predet -> NP -> NP ; -- only the man 
  PredetNP predet np = np ** { s = \\cas => predet.s ++ np.s ! cas } ; --TODO: test


-- A noun phrase can also be postmodified by the past participle of a
-- verb, by an adverb, or by a relative clause


  -- : NP -> V2  -> NP ;    -- the man seen / ikusi gizona (sounds weird but so does English)
  PPartNP np v2 = np ** { s = \\c => v2.prc ! Past ++ np.s ! c } ;

  -- : NP -> Adv -> NP ;    -- Paris today ; boys, such as ..
  AdvNP,ExtAdvNP = \np,adv -> np ** { s = \\c => adv.s ++ np.s ! c } ;


  -- : NP -> RS  -> NP ;    -- Paris, which is here
  RelNP np rs = np ** { s = \\c => rs.s ! np.agr ++ np.s ! c } ;

-- Determiners can form noun phrases directly.

  -- : Det -> NP ;  -- nirea ?
  DetNP det = 
    let f : Case => Str = 
      \\c => if_then_Str det.indep 
               (det.pref ++ det.s ! c ! FinalCons)
               nonExist ; -- To prevent forms that start with BIND
     in { s = f ;
          stem = f ! Abs ;
          agr = case det.nbr of {Sg => Hau ; Pl => Hauek } ;
          anim = Inan ;
          isDef = det.isDef } ;

  -- MassNP : CN -> NP ; 
  MassNP cn = 
    let s : Case => Str = 
      \\c => cn.heavyMod ! Hau -- e.g. rel clause, adverb
          ++ cn.s ! Hau   -- baso handi
          ++ artIndef ! c ! cn.ph  -- no -a in Abs
          ++ cn.comp ;    -- ardo gorri
    in { s = s ;
         stem = s ! Abs ;
         agr   = Hau ;
         anim  = Inan ;
         isDef = False } ;


--2 Determiners

-- The determiner has a fine-grained structure, in which a 'nucleus'
-- quantifier and an optional numeral can be discerned.

  -- : Quant -> Num -> Det ; 
  DetQuant quant num = quant ** 
    { s = \\c,ph => case <num.isNum,num.n> of { --numeral 1 ("bat") goes after NP!
                 <True,Sg> => num.s ++ quant.s ! num.n ! c ! FinalCons ; 
                 _         => quant.s ! num.n ! c ! ph 
               } ;
      nbr = num.n ;
      pref = case num.n of {
                Sg => quant.pref ;
                Pl => quant.pref ++ num.s 
              } ;
      isDef = orB quant.isDef num.isNum } ;

  -- : Quant -> Num -> Ord -> Det ;  -- these five best
  DetQuantOrd quant num ord = 
    let theseFive = DetQuant quant num 
    in theseFive ** { s = \\c,ph => theseFive.s ! c ! ph ++ ord.s } ; --TODO: dummy implementation

-- Whether the resulting determiner is singular or plural depends on the
-- cardinal.

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner. It is, however, the $Num$ that determines
-- the inherent number.

  NumSg = { s = [] ; n = Sg ; isNum = False } ; 
  NumPl = { s = [] ; n = Pl ; isNum = False } ; 

  -- : Card -> Num ;
  NumCard card = (card ** { isNum = True }) ;

  -- : Digits  -> Card ;
  NumDigits dig = { s = dig.s ! NCard ; n = dig.n } ;

  -- : Numeral -> Card ;
  NumNumeral num = num ;

  -- : AdN -> Card -> Card ;
  AdNum adn card = card ** { s = adn.s ++ card.s } ;

  -- : Digits  -> Ord ; 
  OrdDigits digs = digs ** { s = digs.s ! NOrd } ;

  -- : Numeral -> Ord ; 
  OrdNumeral num = num ;

  -- : A       -> Ord ;
  OrdSuperl a = { s = a.s ! AF Superl ; n = Sg } ; -- why force Sg? 

-- One can combine a numeral and a superlative.

  -- : Numeral -> A -> Ord ; -- third largest
  OrdNumeralSuperl num a = num ** { s = num.s ++ a.s ! AF Superl } ; --TODO: is the word order correct?

  -- : Quant
  DefArt = { s     = artDef ;
             indep = False ;
             pref  = [] ;
             isDef = True } ; 
  -- : Quant
  IndefArt = { s     = artDef ;
               indep = False ;
               pref  = [] ;
               isDef = False } ; --has suffix, but turns into partitive in negative!

  -- : Pron -> Quant
  PossPron pron = { s     = artDef ;
                    indep = True ;
                    pref  = pron.s ! Gen ;
                    isDef = True } ;

--2 Common nouns

  -- : N -> CN
  -- : N2 -> CN ;
  UseN,UseN2 = ResEus.useN ;


  -- : N2 -> NP -> CN ;    -- mother of the king
  ComplN2 n2 np = 
    let compl = applyPost n2.compl1 np ;
    in useN n2 ** { s = \\agr => compl ++ n2.s } ;

  -- : N3 -> NP -> N2 ;    -- distance from this city (to Paris)
  ComplN3 n3 np = 
    let compl = applyPost n3.compl2 np ;
    in n3 ** {s = compl ++ n3.s } ;

  -- : N3 -> N2 ;          -- distance (from this city)
  Use2N3 n3 = lin N2 n3 ** { compl1 = n3.compl2 } ;

  -- : N3 -> N2 ;          -- distance (to Paris)
  Use3N3 n3 = lin N2 n3 ;

  -- : AP -> CN -> CN 
  AdjCN ap cn =
    let a : Str = artIndef ! Abs ! cn.ph ; --`a' for FinalA, [] for other
        result : {s : Agr => Str ; ph : Phono} =
          case ap.typ of {
                Ko => { s = \\agr => ap.s ++ cn.s ! agr ;
                        ph = cn.ph } ;
                Bare => { s = \\agr => cn.s ! agr ++ a ++ ap.s ;
                          ph = ap.ph }
             } ;
      in cn ** { s  = result.s ;
                 ph = result.ph } ; 

  -- : CN -> RS  -> CN ;
  RelCN cn rs = cn ** { heavyMod = \\agr => cn.heavyMod ! agr ++ rs.s ! agr } ;


  -- : CN -> Adv -> CN ;
  AdvCN cn adv = cn ** { heavyMod = \\agr => cn.heavyMod ! agr ++ adv.s } ;

-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide. Sentential complements are defined in VerbEus.

  -- : CN -> SC  -> CN ;   -- question where she sleeps
  SentCN cn sc = cn ** { heavyMod = \\agr => cn.heavyMod ! agr ++ sc.s } ;


--2 Apposition

-- This is certainly overgenerating.

  -- : CN -> NP -> CN ;    -- city Paris (, numbers x and y)
  ApposCN cn np = cn ** { s = \\agr => np.stem ++ cn.s ! agr } ;


--2 Possessive and partitive constructs

  -- : PossNP  : CN -> NP -> CN ; -- (mutilaren / taberna honetako) garagardo
  PossNP cn np = 
    let npPoss = applyPost (case np.anim of {
                             Anim => mkPost [] Gen False ;
                             Inan => mkPost "ko" LocStem True 
                           }) np ;
    in cn ** { s = \\agr => npPoss ++ cn.s ! agr } ;

  -- : CN -> NP -> CN ;     -- glass of wine / baso bat ardo beltz
                            -- two kilos of red apples / bi kilo sagar gorri
  PartNP cn np =
    let baso = cn ;
        sagarGorri = np.stem 
    in baso ** { comp = sagarGorri } ;



-- This is different from the partitive, as shown by many languages.

  -- : Det -> NP -> NP ;    -- gutarik zenbait
  CountNP det np = np ** 
    { s = \\c => elative np
              ++ det.pref 
              ++ det.s ! c ! FinalCons } ; -- Nonsense for DefArt or IndefArt

--3 Conjoinable determiners and ones with adjectives

  -- : DAP -> AP -> DAP ;    -- the large (one)
  AdjDAP dap ap = dap ** { s = \\cas,ph => ap.s ++ dap.s ! cas ! ph } ;

  -- : Det -> DAP ;          -- this (or that) 
  DetDAP det = det ;

oper 
  elative : NP -> Str = \np -> glue (np.s ! LocStem) "rik" ;

}