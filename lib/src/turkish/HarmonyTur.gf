--# -path=.:../abstract:../common:../../prelude

-- (c) 2010 Server Çimen under LGPL

resource HarmonyTur = ParamX ** open Prelude, Predef in {
  flags
    coding=utf8 ;
--Harmony
  param

--  Consonant are divided into 2 groups: Voiceless vs Voiced or Hard vs Soft.
--  This parameter type is used for consonant harmony, namely hardening and softening rules.
    Softness    = Soft | Hard ;

--  Parameter type for consonant harmony:
--  Suffixes should have three forms at the worst case for consonant harmony, these forms are
--  used when stem ends with:
--    1) soft consonant
--    2) hard consonant
--    3) vowel
    HarConP  = SCon Softness | SVow ;

--  Parameter type for vowel harmony:
--  Suffixes should have 4 forms, because of two dimensional vowel harmony
    HarVowP  = I_Har | U_Har | Ih_Har | Uh_Har ;

  oper
-- Some pattern macros used by some opers (especially those related to harmonies) in ResTur.gf and ParadigmsTur.gf

    --Capital forms of vowels are also added, otherwise harmony of proper nouns like "Of" can not be determined
    vowel     : pattern Str = #("a"|"e"|"ı"|"i"|"u"|"ü"|"o"|"ö"|"î"|"â"|"û"|"A"|"E"|"I"|"İ"|"U"|"Ü"|"O"|"Ö"|"Î"|"Â"|"Û") ;
    consonant : pattern Str = #("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h") ;
    --Extended consonant are used when proccessing words that contain non-letter characters like "stand-by"
    extConson : pattern Str = #("b"|"v"|"d"|"z"|"j"|"c"|"g"|"ğ"|"l"|"r"|"m"|"n"|"y"|"p"|"f"|"t"|"s"|"ş"|"ç"|"k"|"h"|"'"|"-") ;
    --The following are the hard (voiced) consonant in Turkish Alphabet (Order is determined by "Fıstıkçı Şahap" :) )
    hardCons  : pattern Str = #("f"|"s"|"t"|"k"|"ç"|"ş"|"h"|"p") ;
    

-- Type definition and constructor of Harmony.
    Harmony = {
      vow : HarVowP ;
      con : HarConP
    } ;

    mkHar : HarVowP -> HarConP -> Harmony;
    mkHar v c = { vow = v ; con = c } ;

    getHarmony : Str -> Harmony ;
    getHarmony base = {
      vow = getHarVowP base ;
      con = getHarConP base ;
    } ;

    getHarVowP : Str -> HarVowP
      = \base -> case base of {
		    _ + ("ı"|"a"|"â"|"I"|"A"|"Â") + #extConson* => I_Har ;
		    _ + ("i"|"e"|"î"|"İ"|"E"|"Î") + #extConson* => Ih_Har ;
		    _ + ("u"|"o"|"û"|"U"|"O"|"Û") + #extConson* => U_Har ;
		    _ + ("ü"|"ö"|"Ü"|"Ö")         + #extConson* => Uh_Har ;
		    _ => Ih_Har --this is for yiyor ("y" is base in that case)
		  } ;

--  Param base : a word, of which softness is to be determined
--  Returns whether Soft or Hard form of suffix will be used when adding a suffix to base
    getSoftness : Str -> Softness = \base -> case dp 1 base of {
                                              #hardCons => Hard ;
                                              _ => Soft
                                             } ;

--  Param larC : the consonant form of suffix of which softness is to be determined
--  Returns whether Soft or Hard form of base will be used when adding a suffix to parameter
    getBeginType : Str -> Softness = \larC -> case take 1 larC of {
					        #vowel => Soft ;
				                _ => Hard
					      }  ;

--  Param base : a word
--  Returns which SuffixForm will be used when adding a suffix to base
    getHarConP : Str -> HarConP =
      \base -> case dp 1 base of {
		 #vowel => SVow ;
		 _ => SCon (getSoftness base)
	       } ;

--  returns softened form of a base
    softenBase : Str -> Str = \base ->
      let root = tk 1 base in
      case base of {
	_+ "p" => root + "b" ;
	_+ "ç" => root + "c" ;
	_+ "t" => root + "d" ;
	_+ #consonant  + "k" => root + "g" ;
	_+ #vowel + ("k"|"g") => root + "ğ" ;
	_ => base
      } ;

-- harmony of progresive form of a verb is always the same, therefore it is constructed here to avoid unnecessary computation
    progHar : Harmony 
      = {
	vow = U_Har ;
	con = SCon Soft ;
      } ;


}