--# -path=.:../abstract:../common:../../prelude

resource ParadigmsTur = open
  CatTur,
  Predef,
  Prelude,
  ResTur,
  SuffixTur,
  HarmonyTur
  in {

flags
  coding=utf8 ; optimize=noexpand ;

oper
-- Paradigms for verb

  mkV : overload {
    --make regular verbs, one form is enough
    mkV : (esmek : Str) -> Verb ; 
    -- make verbs of which aorist form is irregular
    mkV : (gelmek : Str) -> AoristType -> Verb ; 
    -- make verbs which do not obey softnening rule
    mkV : (gitmek, gidmek : Str) -> Verb ; 
    -- make verbs which progressive and future forms has "e" to "i" conversion like "yemek" -> "yiyorum" and "demek" -> "diyorum"
    -- two forms are enough but third form is needed to differentiate from the other overloads
    mkV : (yemek, yemek, yimek : Str) -> Verb ;
    -- make verbs that is usually formed by a noun and a auxiallary verb
    -- contiguity indicates whether they are written concatenated or separated
    mkV : (seyr : Str) -> (etmek : Verb) -> (con : Contiguity) -> Verb ;
    -- same as above, defined to make separated form default
    mkV : (nefret : Str) -> (etmek : Verb) -> Verb ;
  } ;

  

  mkV2 : overload {
    -- make V2, use default case and preposition which are accusative case and no preposition
    mkV2 : (sormak : Verb) -> Verb ** {c : Case; p : Prep} ;
    -- make V2, set case explicitly
    mkV2 : (korkmak : Verb) -> (dat : Case) -> Verb ** {c : Case; p : Prep} ;
    -- make V2, set case and preposition explicitly
    mkV2 : (dovusmek : Verb) -> (dat : Case) -> (against : Prep) -> Verb ** {c : Case; p : Prep} ;
  } ;

  mkV3 : overload {
    -- make V3, use default cases and prepositions which are accusative and dative cases and no preposition.
    mkV3 : (satmak : Verb) -> Verb ** {c1 : Case; p1 : Prep; c2 : Case; p2 : Prep} ;
    -- make V3, set cases and prepositions explicitly.
    mkV3 : (konusmak : Verb) -> Case -> Prep -> Case -> Prep -> Verb ** {c1 : Case; p1 : Prep; c2 : Case; p2 : Prep} ;
  } ;


  -- worst-case function
  -- bases of all forms are required.
  makeVerb : (inf,base,presBase,pastBase,aoristBase : Str) -> ( futureBase : Softness => Str ) -> Harmony -> Verb ;

  -- make a regular verb
  -- supply infinitive, softened infinitive, future infinitive forms and aorist type
  regVerb : (inf, softInf, futInf : Str) -> AoristType -> Verb ;

  -- make a regular verb, only infinitive form is needed
  regV : (inf : Str) -> Verb ;

  -- make a verb, aorist type must be specified
  -- see AoristType for list of verbs that has irregular aorist suffix
  irregV_aor : (inf : Str) -> AoristType -> Verb ;

  -- make a verb from a str (usually a noun) and a auxiallary verb, also specify contiguity (i.e whether they will be concatenated or separated)
  auxillaryVerb : Str -> Verb -> Contiguity -> Verb ;

  mkV2 = overload {
    -- sormak
    mkV2 : Verb -> Verb ** {c : Case; p : Prep} = \verb -> verb ** {c = Acc; p = no_Prep} ;
    -- (bir şeyden) korkmak
    mkV2 : Verb -> Case -> Verb ** {c : Case; p : Prep} = \verb,ca -> verb ** {c = ca; p = no_Prep} ;
    -- (bir şeye karşı) dövüşmek
    mkV2 : Verb -> Case -> Prep -> Verb ** {c : Case; p : Prep} = \verb,ca,prep -> verb ** {c = ca; p = prep} ;
  } ;

  
  mkV3 = overload {
    -- (birine bir şeyi) satmak
    mkV3 : Verb -> Verb ** {c1 : Case; p1 : Prep; c2 : Case; p2 : Prep} = \verb -> verb ** {c1 = Acc; p1 = no_Prep; c2 = Dat; p2 = no_Prep} ;
    -- (biri ile bir şeyi) konuşmak
    mkV3 : Verb -> Case -> Prep -> Case -> Prep -> Verb ** {c1 : Case; p1 : Prep; c2 : Case; p2 : Prep} = 
      \verb,c1,p1,c2,p2 -> verb ** {c1 = c1; p1 = p1; c2 = c2; p2 = p2} ;
  } ;

-- Paradigms for noun

  -- overload all noun paradigms to mkN
  mkN : overload {
    -- regular noun, only nominative case is needed
    mkN : (araba : Str) -> Noun ;
    -- handles three type of irregularities which never overlap
    --	1.Doubling consonant	hak -> hakka
    --	2.Dropping vowel    	burun -> burnu
    --	3.Improper softening	bisiklet -> bisikleti
    mkN : (burun, burn : Str) -> Noun ;
    -- in addition to irregularities above, handles vowel harmony irregularities
    mkN : (divaniharp, divaniharb : Str) -> (ih_har : HarVowP) -> Noun ;
    -- links two noun to form a compound noun
    mkN : (fotograf, makine : Noun) -> Contiguity -> Noun ;
    -- same as above, make concatenated form default
    mkN : (zeytin, yag : Noun) -> Noun ;
  } ;
  
  mkN2 : Str -> Noun ** {c : Case} ;

  mkN3 : Str -> Noun ** {c1 : Case; c2 : Case} ;

  -- worst case function
  -- parameters: all singular cases of base, base of genitive table, plural form of base and harmony of base
  mkNoun : (nom,acc,dat,gen,loc,abl,abessPos,abessNeg,gens,plural : Str) -> Harmony -> Noun ;
  --this function is for nouns that has different harmony than their vowels imply
  irregN_h : (burun, burn : Str) -> HarVowP -> Noun ;
  -- this function handles all irregularities in nouns, because all irregularities require two forms of noun
  irregN : HarVowP -> (burun, burn : Str) -> Noun;
  -- paradigm for regular noun
  regN : Str -> Noun ;
  -- paradigm for proper noun
  regPN : Str -> Noun ;
  -- worst case function for proper nouns
  makePN : Str -> Str -> Noun ;
  -- digits can be seen as proper noun, but we need an additional harmony argument since harmony information can not be extracted from digit string.
  makeHarPN : Str -> Str -> Harmony -> Noun ;
  -- Link two nouns, e.g. zeytin (olive) + yağ (oil) -> zeytinyağı (olive oil)
  linkNoun : (tere,yag : Noun) -> Species -> Contiguity -> Noun ;

-- Paradigms for adjactives
  mkA : overload {
    -- güzel
    mkA : Str -> Adjective ;
    -- ak 
    mkA : Str -> Str -> Adjective ;
    -- kahve rengi
    mkA : Noun -> Noun -> Adjective ;
    -- pürdikkat
    mkA : Str -> Str -> HarVowP -> Adjective ;
  } ;

  mkA2 : overload {
    -- (biri) ile evli
    mkA2 : Adjective -> Case -> Prep -> Adjective ** {c : Case; p : Prep} ;
    -- makes default case accusative
    mkA2 : Adjective -> Prep -> Adjective ** {c : Case; p : Prep} ;
  } ;

  mkAdj2 : Adjective -> Case -> Prep -> Adjective ** {c : Case; p : Prep} ;

-- Paradigms for numerals
  mkNum : overload {
    -- a regular numeral, obeys softening and hardening rules. e.g. "bir" "birinci"
    mkNum : Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} ;
    -- an irregular numeral of which two form is needed. e.g. "kırk" "kırkıncı" "kırk" "kırkıncı" (does not soften)
    mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} ;
  } ;
  
  regNum : Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} ;
  makeNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} ;

  mkDig : overload {
    mkDig : Str -> {s : CardOrd => Number => Case => Str ; n : Number} ;
    mkDig : Str -> Str -> Number -> {s : CardOrd => Number => Case => Str ; n : Number} ;
  } ;

  regDigit : Str -> {s : CardOrd => Number => Case => Str ; n : Number} ;
  makeDigit : Str -> Str -> Number -> {s : CardOrd => Number => Case => Str ; n : Number} ;


--Implementation of verb paradigms

  mkV = overload {
    --esmek
    mkV : Str -> Verb = regV ; 
    --gelmek
    mkV : Str -> AoristType -> Verb = irregV_aor ; 
    --gitmek
    mkV : Str -> Str -> Verb = \inf,softInf -> regVerb inf softInf softInf (getAoristType (tk 3 inf)) ; 
    --yemek
    mkV : Str -> Str -> Str -> Verb = \inf,softInf,futInf -> regVerb inf softInf futInf (getAoristType (tk 3 inf)) ;
    --seyretmek
    mkV : Str -> Verb -> Contiguity -> Verb = auxillaryVerb ;
    --nefret etmek
    mkV : Str -> Verb -> Verb = \base,v -> auxillaryVerb base v Sep ;
  } ;

  auxillaryVerb prefix verb con = case con of {
                          Sep => {s = \\t => prefix ++ verb.s ! t} ;
                          Con => {s = \\t => prefix + verb.s ! t}
                        } ;
  
  regV inf = regVerb inf inf inf (getAoristType (tk 3 inf)) ;

  
  irregV_aor inf aorT = regVerb inf inf inf aorT ;

  
  regVerb inf softInf futInf aoristType =
    let base = (tk 3 inf) ;
        softBase = (tk 3 softInf) ;
        futBase = (tk 3 futInf) ;
        har = getHarmony base ;
        softness = getSoftness base ;
        futureBase = addSuffix futBase har futureSuffix ;
	softFutureBase = addSuffix futBase har softFutureSuffix ;
        pastBase = addSuffix base har pastSuffix ;
	futureTable = table {
		    Soft => softFutureBase ;
		    Hard => futureBase
		   } ;
        aoristBase = case aoristType of {
		      SgSylConReg => addSuffix softBase har aoristErSuffix ;
		      _           => addSuffix softBase har aoristIrSuffix
		     } ;
        progBase = case (getHarConP base) of {
                      SVow => addSuffix (tk 1 base) (getHarmony (tk 1 base)) presentSuffix ;
                      _    => addSuffix softBase har presentSuffix
		   } ;
        in makeVerb inf base progBase pastBase aoristBase futureTable har;

  
  makeVerb inf base progBase pastBase aoristBase futureTable har =
    let 
	futht = getHarVowP (futureTable ! Hard) ;
	pastHar = {vow = har.vow ; con = SVow} ;
	futHar = {vow = futht ; con = (SCon Soft)} ;
	aorHar = {vow = getHarVowP aoristBase ; con = (SCon Soft)} ;
    in {
          s = table {
               VProg agr   => addSuffix progBase   progHar (verbSuffixes ! agr) ;
               VPast agr   => addSuffix pastBase   pastHar (verbSuffixes ! agr) ;
               VFuture agr => addSuffix futureTable futHar (verbSuffixes ! agr) ;
               VAorist agr => addSuffix aoristBase aorHar (verbSuffixes ! agr) ;
               VImperative => base ;
               VInfinitive => inf
             }
       } ;

  
-- Implementation of noun paradigms
  mkNoun sn sa sd sg sl sabl sgabPos sgabNeg sgs pln har =
      let plHar = getHarmony pln ;
      in
     {
      s   = table {
              Sg => table {
		      Nom     => sn ;
		      Acc     => sa ;
		      Dat     => sd ;
		      Gen     => sg ;
		      Loc     => sl ;
		      Ablat   => sabl ;
		      Abess Pos => sgabPos ;
                      Abess Neg => sgabNeg
		    } ;
               Pl => table {
		      Abess Pos => addSuffix sgabPos plHar plSuffix;
		      Abess Neg => addSuffix sgabNeg plHar plSuffix;
		      c => addSuffix pln plHar (caseSuffixes ! c)
		    }
                } ;
      gen = table {
              Sg => table {
--Genitive suffix for P3 is always -ları, always selecting plural form of base and harmony is a trick to implement this
		      {n=Pl; p=P3} => addSuffix pln plHar genPlP3Suffix ;
		      s            => addSuffix sgs har (genSuffixes ! s)
		  } ;
              Pl => \\s => addSuffix pln plHar (genSuffixes ! s)
        } ;
      harmony = har
    } ;
  
  irregN_h sn sg har = irregN har sn sg ;

  
  irregN ht sn sg =
    let
        pln = add_number Pl sn ht ;
        har = mkHar ht (SCon (getSoftness sn)) ;
        irHar = mkHar ht (getHarConP sg) ;
    in
    mkNoun sn
           (addSuffix sg irHar accSuffix)
	   (addSuffix sg irHar datSuffix)
           (addSuffix sg har genSuffix)
           (addSuffix sn har locSuffix)
	   (addSuffix sn har ablatSuffix)
	   (addSuffix sn har abessPosSuffix)
	   (addSuffix sn har abessNegSuffix)
	   sg
           pln
           har ;

  
  regN sn =
    let har = getHarmony sn ;
        pln = add_number Pl sn har.vow ;
        bt = getBaseTable sn
    in
    mkNoun sn
           (addSuffix bt har accSuffix)
           (addSuffix bt har datSuffix)
	   (addSuffix bt har genSuffix)
	   (addSuffix bt har locSuffix)
	   (addSuffix bt har ablatSuffix)
	   (addSuffix bt har abessPosSuffix)
	   (addSuffix bt har abessNegSuffix)
	   (bt ! Soft)
	   pln
	   har ;

  
  regPN sn = makePN sn sn ;

  makeHarPN sn sy har = 
    let bn = sn + "'" ;
        by = sy + "'" ;
        pln = add_number Pl bn har.vow ;
    in
    mkNoun sn
           (addSuffix by har accSuffix)
           (addSuffix by har datSuffix)
	   (addSuffix by har genSuffix)
	   (addSuffix bn har locSuffix)
	   (addSuffix bn har ablatSuffix)
           (addSuffix bn har abessPosSuffix)
	   (addSuffix bn har abessNegSuffix)
	   by
           pln
           har ;

  makePN sn sy = makeHarPN sn sy (getHarmony sn) ;

  
  
  linkNoun n1 n2 lt ct =
      let n1sn = n1.s ! Sg ! Nom ;--tere
          n2sn = n2.s ! Sg ! Nom ;--yağ
          n2pn = n2.s ! Pl ! Nom ;--yağlar
          n2sb = n2.gen ! Sg ! {n = Sg;  p = P3} ;--yağı
          n2pb = n2.gen ! Pl ! {n = Sg;  p = P3} ;--yağları
	  n2AbessPos = n2. s ! Sg ! Abess Pos ;
	  n2AbessNeg = n2. s ! Sg ! Abess Neg ;
          con = case ct of {
                  Con => <n1sn +  n2sn, n1sn +  n2sb, n1sn +  n2pn, n1sn +  n2pb, n1sn +  n2AbessPos, n1sn +  n2AbessNeg> ;
                  Sep => <n1sn ++ n2sn, n1sn ++ n2sb, n1sn ++ n2pn, n1sn ++ n2pb, n1sn ++ n2AbessPos, n1sn ++ n2AbessNeg>
                } ;
          sb = con.p1 ;--tereyağ
          sn = con.p2 ;--tereyağı
          pb = con.p3 ;--tereyağlar
          pn = con.p4 ;--tereyağları
	  sgAbessPos = con.p5 ;
	  sgAbessNeg = con.p6 ;
          sgHar = getHarmony sn ;
          plHar = getHarmony pn
      in {
        s   = table {
              Sg => table {
		      Nom     => sn ; --tereyağı
		      Acc     => addSuffix sn sgHar accSuffixN ; --tereyağını
		      Dat     => addSuffix sn sgHar datSuffixN ; --tereyağına
		      Gen     => addSuffix sn sgHar genSuffix ; --tereyağının
		      Loc     => addSuffix sn sgHar locSuffixN ; --tereyağında
		      Ablat   => addSuffix sn sgHar ablatSuffixN ; --tereyağından
		      Abess Pos => sgAbessPos ; --tereyağlı
                      Abess Neg => sgAbessNeg   --tereyağsız
		    } ;
               Pl => table {
		      Nom     => pn ;--tereyağları
		      Acc     => addSuffix pn plHar accSuffixN ; --tereyağlarını
		      Dat     => addSuffix pn plHar datSuffixN ; --tereyağlarına
		      Gen     => addSuffix pn plHar genSuffix ; --tereyağlarının
		      Loc     => addSuffix pn plHar locSuffixN ; --tereyağlarında
		      Ablat   => addSuffix pn plHar ablatSuffixN ; --tereyağlarından
		      Abess   Pos => addSuffix sgAbessPos plHar abessPosSuffix ; --tereyağlılar
		      Abess   Neg => addSuffix sgAbessNeg plHar abessNegSuffix   --tereyağsızlar
                    }
                } ;
        gen = case ct of {
                Con => \\num,agr => n1sn + n2.gen ! num ! agr ;
                Sep => \\num,agr => n1sn ++ n2.gen ! num ! agr
	      } ;
	harmony = sgHar
    } ;
  
  mkN = overload {
    mkN : (araba : Str) -> Noun = regN ;
    mkN : (burun, burn : Str) -> Noun = \sn,sg -> irregN (getComplexHarmony sn sg) sn sg ;
    mkN : (divaniharp, divaniharb : Str) -> (ih_har : HarVowP) -> Noun = irregN_h ;
    mkN : (fotograf, makine : Noun) -> Contiguity -> Noun = \n1,n2,c -> linkNoun n1 n2 Indef c ;
    mkN : (zeytin, yag : Noun) -> Noun = \n1,n2 -> linkNoun n1 n2 Indef Con ;
  } ;

  
  mkN2 base = let noun = mkN base in noun ** {c = Gen} ;

  
  mkN3 base = let noun = mkN base in noun ** {c1 = Gen; c2 = Dat} ;

  
-- Implementation of adjactive paradigms
  mkA = overload {
    -- güzel
    mkA : Str -> Adjective = \base -> (mkN base)  ** { adv = addSuffix base (getHarmony base) adjAdvSuffix } ;
    -- ak 
    mkA : Str -> Str -> Adjective = \base,soft -> (irregN (getComplexHarmony base soft) base soft )  ** { adv = addSuffix base (getHarmony base) adjAdvSuffix } ;
    -- kahve rengi
    mkA : (zeytin, yag : Noun) -> Adjective = \n1,n2 -> let n = linkNoun n1 n2 Indef Con in n ** {adv = addSuffix (n.s ! Sg ! Nom) (getHarmony (n.s ! Sg ! Nom)) adjAdvSuffix }  ;
    -- pürdikkat
    mkA : (base, base1 : Str) -> (ih_har : HarVowP) -> Adjective = \base,base1,ih_har -> (irregN_h base base ih_har) ** { adv = addSuffix base (mkHar ih_har (getHarConP base)) adjAdvSuffix };
  } ;


  mkA2 = overload {
    mkA2 : Adjective -> Case -> Prep -> Adjective ** {c : Case; p : Prep} = mkAdj2 ;
    mkA2 : Adjective -> Prep -> Adjective ** {c : Case; p : Prep} = \n,p -> mkAdj2 n Acc p ;
  } ;

  mkAdj2 base c prep = base ** {c = c; p = prep} ;
  
-- Implementation of numeral paradigms
  mkNum = overload {
    mkNum : Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} = regNum ;
    mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Number => Case => Str} = makeNum ;
  } ;

  regNum  two twenty =
      makeNum two
              twenty
              (addSuffix (getBaseTable two) (getHarmony two) ordNumSuffix)
              (addSuffix (getBaseTable twenty) (getHarmony twenty) ordNumSuffix) ;

  makeNum two twenty second twentieth =
      {
	s = table {
	  unit => table {
		  NCard => (regN two).s ;
		  NOrd  => (regN second).s
		  } ;
	  ten  => table {
		  NCard => (regN twenty).s ;
		  NOrd  => (regN twentieth).s
		  }
	}
      } ;

  mkDig = overload {
    --all digits except 1 (plural)
    mkDig : Str -> {s : CardOrd => Number => Case => Str ; n : Number} = regDigit ;
    --for 1 (singular)
    mkDig : Str -> Str -> Number -> {s : CardOrd => Number => Case => Str ; n : Number} = makeDigit ;
  } ;

  regDigit card = makeDigit card (card + ".") Pl ;

  makeDigit card ordi num = 
    let
      digitStr = case card of {
	  "0" => "sıfır" ;
	  "1" => "bir" ;
	  "2" => "iki" ;
	  "3" => "üç" ;
	  "4" => "dört" ;
	  "5" => "beş" ;
	  "6" => "altı" ;
	  "7" => "yedi" ;
	  "8" => "sekiz" ;
	  "9" => "dokuz" 
	} ;
      harCard = getHarmony digitStr ;
      harOrd = getHarmony (addSuffix digitStr harCard ordNumSuffix)
    in
    {
      s = table {
	NCard => (makeHarPN card card harCard).s ;
	NOrd  => (makeHarPN ordi ordi harOrd).s 
      } ; 
      n = num
    } ;
    
-- Helper functions and parameters
  -- finds which aorist type will be used with a base, see aorist type parameter for more info
  getAoristType : Str -> AoristType = 
    \base -> case base of {
	      #consonant* +
	      #vowel +
	      #consonant +
	      #consonant* => SgSylConReg ;
	      _ => PlSyl
	    } ;

  
  -- construct a table contatining soft and hard forms of a base
  getBaseTable : Str -> Softness => Str =
    \base -> table {
              Soft => softenBase base ;
              Hard => base
	     } ;

  -- following two functions are to help deciding har type of nouns like vakit, hasut
  getComplexHarmony : Str -> Str -> HarVowP =
    \sn,sg -> case <(getHarVowP sn), (getHarVowP sg)> of {
                <(I_Har | U_Har)  , Ih_Har> => I_Har  ;
                <(I_Har | U_Har)  , Uh_Har> => U_Har  ;
                <(Ih_Har | Uh_Har), I_Har>  => Ih_Har ;
                <(Ih_Har | Uh_Har), U_Har>  => Uh_Har ;
                <_,h>                       => h
              } ;

  add_number : Number -> Str -> HarVowP -> Str = 
    \n,base,harVow ->
      case n of {
        Sg => base ;
        Pl => addSuffix base (mkHar harVow SVow) plSuffix
      } ;

param
  AoristType = PlSyl         -- more than one syllable, takes -ir
	    | SgSylConIrreg -- one syllable ending with consonant, but takes -ir (here is the list: al-, bil-, bul-, dur-, gel-, gör-, kal-, ol-, öl-, var-, ver-, vur-, san- )
	    | SgSylConReg ; -- one syllable ending with consonant, takes -er

}
