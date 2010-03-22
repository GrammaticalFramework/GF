-- (c) 2009 Server Çimen under LGPL

{-
  This module currently contains
    -Type definition and paradigms for suffixes
    -Some ready-to-use suffixes (plural suffix, case suffixes, genitive suffixes, tense suffixes).
    -3 Suffix Tables of type Agr / Case => Suffix for case, genitive and verb suffixes
    -A function for adding a suffix to a base
-}

--# -path=.:../abstract:../common:../../prelude

resource SuffixTur = open Prelude, Predef, ResTur, HarmonyTur in {
  flags
    coding=utf8 ;

  oper
--  Considering both consonant and vowel harmonies, following table contains all
--  needed forms of a suffix
    SuffixTable : Type = HarConP => HarVowP => Str ;

    Suffix : Type = {
      st : SuffixTable ;
-- This field indicates whether soft or hard form of the stem will be used when
-- this suffix is appended to a stem
      stemT : Softness
    } ;

--  Always give the "e" or "i" forms of suffixes to regSuffix* opers
--  e.g. use 'regSuffix "ler" "ler"'
--   but not 'regSuffix "lar" "lar"'
--  similarly use 'regSuffix "in" "n"'
--        but not 'regSuffix "un" "n"' or 'regSuffix "ün" "n"' or 'regSuffix "ın" "n"'


--  Parameters for regSuffix* opers
--        larC : form of suffix that will be appended to a stem that ends with a consonant
--        larV : form of suffix that will be appended to a stem that ends with a consonant

--  Constructs a one syllable suffix
    regSuffix : Str -> Str -> Suffix ;
--  Constructs a two syllable suffix
    regSuffix2 : Str -> Str -> Suffix ;
--  Constructs a suffix where larC is two syllable and larV is one syllable
    regSuffix21 : Str -> Str -> Suffix ;


-- List of suffixes, grouped by type

--  Empty Suffix
--  This suffix is required for some suffix tables (e.g. nominative case and 3rd Sg person verbal suffix)
    empSuffix       : Suffix = regSuffix "" "" ;

--  Plural Suffix
    plSuffix        : Suffix = regSuffix "ler" "ler" ;

--  Case Suffixes
    accSuffix       : Suffix = regSuffix "i" "yi" ;
    datSuffix       : Suffix = regSuffix "e" "ye" ;
    genSuffix       : Suffix = regSuffix "in" "nin" ;
    locSuffix       : Suffix = regSuffix "de" "de" ;
    ablatSuffix     : Suffix = regSuffix "den" "den" ;
    abessPosSuffix  : Suffix = regSuffix "li" "li" ;
    abessNegSuffix  : Suffix = regSuffix "siz" "siz" ;
--  following 4 suffixes has other forms used after genSgP3Suffix
    accSuffixN      : Suffix = regSuffix "i" "ni" ;
    datSuffixN      : Suffix = regSuffix "e" "ne" ;
    locSuffixN      : Suffix = regSuffix "de" "nde" ;
    ablatSuffixN    : Suffix = regSuffix "den" "nden" ;

--  Genitive Suffixes
    genSgP1Suffix   : Suffix = regSuffix "im" "m" ;
    genSgP2Suffix   : Suffix = regSuffix "in" "n" ;
    genSgP3Suffix   : Suffix = regSuffix "i" "si" ;
    genPlP1Suffix   : Suffix = regSuffix21 "imiz" "miz" ;
    genPlP2Suffix   : Suffix = regSuffix21 "iniz" "niz" ;
--  3rd plural person genitive suffix is actually "-ları" but can be represented as plSuffix + current form,
--  see the comment at makeNoun operation in ParadigmsTur.gf
    genPlP3Suffix   : Suffix = regSuffix "i" "i" ;

--  Tense Suffixes
    pastSuffix      : Suffix = regSuffix "di" "di" ;
    inferentSuffix  : Suffix = regSuffix "miş" "miş" ;
--  Vowel "o" does not obey harmony rules so assume that "iyor" is a one syllable word (see oper oneSylParser)
    presentSuffix   : Suffix = regSuffix "iyor" "iyor" ;
    aoristIrSuffix  : Suffix = regSuffix "ir" "r" ;
    aoristErSuffix  : Suffix = regSuffix "er" "r" ;
    futureSuffix    : Suffix = regSuffix2 "ecek" "yecek" ;
    softFutureSuffix    : Suffix = regSuffix2 "eceğ" "yeceğ" ;
--  Person Suffixes for Verbs

    p1SgVerbalSuffix : Suffix = regSuffix "im" "m" ;
    p2SgVerbalSuffix : Suffix = regSuffix "sin" "n" ;
--  No suffix is used for the 3rd singular person  (i.e empty suffix will be used in suffix tables in ResTur.gf)
    p1PlVerbalSuffix : Suffix = regSuffix "iz" "k" ;
    p2PlVerbalSuffix : Suffix = regSuffix21 "siniz" "niz" ;
    p3PlVerbalSuffix : Suffix = regSuffix "ler" "ler" ;

--  Ordinal suffix for numbers
    ordNumSuffix     : Suffix = regSuffix21 "inci" "nci" ;
--  Suffix for deriving adverb from a adjective
    adjAdvSuffix     : Suffix = regSuffix "ce" "ce" ;

    caseSuffixes : Case => Suffix =
      table {
	Nom   => empSuffix ;
	Acc   => accSuffix ;
	Dat   => datSuffix ;
	Gen   => genSuffix ;
	Loc   => locSuffix ;
	Ablat => ablatSuffix ;
	Abess Pos => abessPosSuffix ;
	Abess Neg => abessNegSuffix
      } ;

    genSuffixes : Agr => Suffix =
      table {
	{n=Sg; p=P1} => genSgP1Suffix ;
	{n=Sg; p=P2} => genSgP2Suffix ;
	{n=Sg; p=P3} => genSgP3Suffix ;
	{n=Pl; p=P1} => genPlP1Suffix ;
	{n=Pl; p=P2} => genPlP2Suffix ;
	{n=Pl; p=P3} => genPlP3Suffix
      } ;

    verbSuffixes : Agr => Suffix =
      table {
	{n=Sg; p=P1} => p1SgVerbalSuffix ;
	{n=Sg; p=P2} => p2SgVerbalSuffix ;
	{n=Sg; p=P3} => empSuffix ;
	{n=Pl; p=P1} => p1PlVerbalSuffix ;
	{n=Pl; p=P2} => p2PlVerbalSuffix ;
	{n=Pl; p=P3} => p3PlVerbalSuffix
      } ;

--  Adds a suffix to the base given as Str using Harmony.
--  If only one form of base is given then it is assumed that base does not soften
    addSuffix = overload {
      addSuffix : Str               -> Harmony -> Suffix -> Str = addSuffixStr ;
      addSuffix : (Softness => Str) -> Harmony -> Suffix -> Str = addSuffixTable ;
    } ;

    addSuffixStr : Str -> Harmony -> Suffix -> Str =
      \base,har,suf -> base + suf.st ! har.con ! har.vow ;

    addSuffixTable : (Softness => Str) -> Harmony -> Suffix -> Str =
      \baseTable,har,suf -> (baseTable ! suf.stemT) + suf.st ! har.con ! har.vow ;


    regSuffix larC larV =
	{
	  st = regH4Suffix larC larV ;
	  stemT = getBeginType larC ;
	} ;

    regSuffix2 larC larV =
	{
	  st = regH4Suffix2 larC larV ;
	  stemT = getBeginType larC ;
	} ;


    regSuffix21 larC larV =
          {
	    st = table {
		  SCon z => (regH4Suffix2 larC larV) ! SCon z ;
		  SVow   => (regH4Suffix larC larV)  ! SVow
		 } ;
            stemT = getBeginType larC ;
	  } ;

--  Constructs suffix table for a one syllable suffix
    regH4Suffix : Str -> Str -> SuffixTable = \baseC,baseV ->
      let
        wordC = oneSylParser baseC ;
        lirCH = hardenWord wordC ;
        lirC = case wordC.p3 of {
                "WXQ" => <wordC.p1, wordC.p1, wordC.p1, wordC.p1, lirCH, lirCH, lirCH, lirCH> ;
	        "i"   => <wordC.p1 + "ı" + wordC.p2,
                          wordC.p1 + "i" + wordC.p2,
                          wordC.p1 + "u" + wordC.p2,
                          wordC.p1 + "ü" + wordC.p2,
                          lirCH + "ı" + wordC.p2,
                          lirCH + "i" + wordC.p2,
                          lirCH + "u" + wordC.p2,
                          lirCH + "ü" + wordC.p2> ;
                _     => <wordC.p1 + "a" + wordC.p2,
                          wordC.p1 + "e" + wordC.p2,
                          wordC.p1 + "a" + wordC.p2,
                          wordC.p1 + "e" + wordC.p2,
                          lirCH + "a" + wordC.p2,
                          lirCH + "e" + wordC.p2,
                          lirCH + "a" + wordC.p2,
                          lirCH + "e" + wordC.p2>
        } ;
        wordV = oneSylParser baseV ;
        lirV = case wordV.p3 of {
                "WXQ" => <wordV.p1, wordV.p1, wordV.p1, wordV.p1> ;
                "i"   => <wordV.p1 + "ı" + wordV.p2,
                          wordV.p1 + "i" + wordV.p2,
                          wordV.p1 + "u" + wordV.p2,
                          wordV.p1 + "ü" + wordV.p2> ;
                _     => <wordV.p1 + "a" + wordV.p2,
                          wordV.p1 + "e" + wordV.p2,
                          wordV.p1 + "a" + wordV.p2,
                          wordV.p1 + "e" + wordV.p2>
        } ;
      in makeH4Table lirV lirC ;

--  Constructs suffix table for a two syllable suffix
    regH4Suffix2 : Str -> Str -> SuffixTable = \baseC,baseV ->
      let
        wordC = twoSylParser baseC ;
        lirCH = hardenWord wordC ;
        lirC = case wordC.p4 of {
                "WXQ" => <wordC.p1, wordC.p1, wordC.p1, wordC.p1, lirCH, lirCH, lirCH, lirCH> ;
                "i"   => <wordC.p1 + "ı" + wordC.p2 + "ı" + wordC.p3,
                          wordC.p1 + "i" + wordC.p2 + "i" + wordC.p3,
                          wordC.p1 + "u" + wordC.p2 + "u" + wordC.p3,
                          wordC.p1 + "ü" + wordC.p2 + "ü" + wordC.p3,
                          lirCH + "ı" + wordC.p2 + "ı" + wordC.p3,
                          lirCH + "i" + wordC.p2 + "i" + wordC.p3,
                          lirCH + "u" + wordC.p2 + "u" + wordC.p3,
                          lirCH + "ü" + wordC.p2 + "ü" + wordC.p3> ;
                _   => <wordC.p1 + "a" + wordC.p2 + "a" + wordC.p3,
                          wordC.p1 + "e" + wordC.p2 + "e" + wordC.p3,
                          wordC.p1 + "a" + wordC.p2 + "a" + wordC.p3,
                          wordC.p1 + "e" + wordC.p2 + "e" + wordC.p3,
                          lirCH + "a" + wordC.p2 + "a" + wordC.p3,
                          lirCH + "e" + wordC.p2 + "e" + wordC.p3,
                          lirCH + "a" + wordC.p2 + "a" + wordC.p3,
                          lirCH + "e" + wordC.p2 + "e" + wordC.p3>
        } ;
        wordV = twoSylParser baseV ;
        lirV = case wordV.p4 of {
                "WXQ" => <wordV.p1, wordV.p1, wordV.p1, wordV.p1> ;
                "i"     => <wordV.p1 + "ı" + wordV.p2 + "ı" + wordV.p3,
                          wordV.p1 + "i" + wordV.p2 + "i" + wordV.p3,
                          wordV.p1 + "u" + wordV.p2 + "u" + wordV.p3,
                          wordV.p1 + "ü" + wordV.p2 + "ü" + wordV.p3> ;
                _     => <wordV.p1 + "a" + wordV.p2 + "a" + wordV.p3,
                          wordV.p1 + "e" + wordV.p2 + "e" + wordV.p3,
                          wordV.p1 + "a" + wordV.p2 + "a" + wordV.p3,
                          wordV.p1 + "e" + wordV.p2 + "e" + wordV.p3>
        }
      in makeH4Table lirV lirC ;

--  Parses a one syllable word and returns consonant parts and the vowel
--  NOTE: not a general purpose parser, can parse only when vowel is e or i
    oneSylParser : Str -> {p1 : Str; p2 : Str; p3 : Str} =
      \base -> case base of {
                x@((#consonant)*) +
                c@("i"|"e") +
                y@((#consonant|"o")*) => <x, y, c> ; --"o" does not obey harmony rules, so it is like a consonant in this sense
                 _ => <base, "WXQ", "WXQ">
              } ;

--  Parses a two syllable word and returns consonant parts and the vowel
--  NOTE: not a general purpose parser, can parse only when vowel is e or i
    twoSylParser : Str -> {p1 : Str; p2 : Str; p3 : Str; p4 : Str} =
      \base -> case base of {
                x@(#consonant*) +
                c@("i"|"e") +
                y@(#consonant*) +
                d@("i"|"e") +
                z@(#consonant*)=> <x, y, z, c> ;
                 _ => <base, "WXQ", "WXQ", "WXQ">
              } ;

--  Constructs the SCon Hard form of the suffix
    hardenWord : {p1 : Str; p2 : Str} -> Str =
      \wordC -> let ordC = drop 1 wordC.p1 ;
                in case take 1 wordC.p1 of {
                ("b") => "p" + ordC  ;
                ("c") => "ç" + ordC  ;
                ("d") => "t" + ordC  ;
                ("g") => "k" + ordC  ;
                _ => wordC.p1
              } ;

--  An auxiallary oper that fills in SuffixTable, used to avoid copy-paste
    makeH4Table : {p1 : Str ; p2 : Str ; p3 : Str ; p4 : Str ;} -> {p1 : Str ; p2 : Str ; p3 : Str ; p4 : Str ; p5 : Str ; p6 : Str ; p7 : Str ; p8 : Str ;} -> SuffixTable =
      \lirV,lirC ->
	table {
	  SVow => table {
		      I_Har => lirV.p1 ;
		      Ih_Har => lirV.p2 ;
		      U_Har => lirV.p3 ;
		      Uh_Har => lirV.p4
		  } ;
	  SCon Soft => table {
			I_Har => lirC.p1 ;
			Ih_Har => lirC.p2 ;
			U_Har => lirC.p3 ;
			Uh_Har => lirC.p4
		      } ;
	  SCon Hard => table {
			I_Har => lirC.p5 ;
			Ih_Har => lirC.p6 ;
			U_Har => lirC.p7 ;
			Uh_Har => lirC.p8
		      }
        } ;
}