-- ResMlt.gf: Language-specific parameter types, morphology, VP formation
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

{-
	Verb types summary:
	===================
	- Strong verb: none of radicals are semi-vowels		eg ĦAREĠ (Ħ-R-Ġ)
	- Defective verb: third radical is semivowel GĦ		eg QATA' (Q-T-GĦ)
	- Weak verb: third radical is semivowel J			eg MEXA (M-X-J)
	- Hollow verb: long A or IE btw radicals 1 & 3		eg QAL (Q-W-L) or SAB (S-J-B)
	- Double/Geminated verb: radicals 2 & 3 identical	eg ĦABB (Ħ-B-B)
	- Quadriliteral verb: 4 radicals					eg QARMEĊ (Q-R-M-Ċ)
-}


resource ResMlt = PatternsMlt ** open Prelude in {

	flags coding=utf8 ;

	param

		-- Used in the NumeralMlt module
		CardOrd = NCard | NOrd ;
		DTail = T1 | T2 | T3 ; -- This is already defined in ParamX...
		Num_Number =
			  NumSg
			| NumDual
			| NumPl
		;
		DForm =
			  Unit		-- 0..10
			| Teen		-- 11-19
			--| TeenIl	-- 11-19
			| Ten		-- 20-99
			| Hund		-- 100..999
			--| Thou		-- 1000+
		;
		Num_Case =
			  NumNominative
			| NumAdjectival ;


{-
	Note: NNQ = Non-numerically quantifiable

	Nouns can have the following forms:
		o Singular
			- Singulative (1, >10)
			- Collective (NNQ)
		o Dual (2)
		o Plural
			- Determinate (2-10)
			- Indeterminate (NNQ)
				- Sound
				- Broken
				- Plural of Plural

	Typical combinations thereof  (* marks base form):
		- Singulative, no plural!
		- Singulative*, Plural
		- Singulative* (1), Dual (2), Plural (>2)
		- Singulative (1, >10), Collective* (NNQ), Determinate Plural (2-10)
		- Singulative, Collective*, Determinate Plural, Indeterminate Plural -> very few nouns have these 4 forms
-}
		Noun_Sg_Type =
			  Singulative	-- eg ĦUTA
			| Collective	-- eg ĦUT
		;
		Noun_Pl_Type =
			  Determinate	-- eg ĦUTIET
			| Indeterminate	-- eg ĦWIET
		;
		Noun_Number =
			  Singular Noun_Sg_Type		-- eg ĦUTA / ĦUT
			| Dual						-- eg WIDNEJN
			| Plural Noun_Pl_Type		-- eg ĦUTIET / ĦWIET
		;

{-
		Noun_PluralType =
			  Sound				-- External (affix), eg FERGĦA -> FERGĦAT
			| Broken			-- Internal, eg FERGĦA -> FRIEGĦI
			| Irregular			-- eg MARA -> NISA
			| PluralOfPlural	-- eg TARF -> TRUF -> TRUFIJIET
			| Foreign			-- eg KARTI, PRATTIĊI, TELEVIXINS
		;
-}

		Gender  = Masc | Fem ;

		Animacy =
			  Animate
			| Inanimate
		;

		Definiteness =
			  Definite		-- eg IL-KARTA. In this context same as Determinate
			| Indefinite	-- eg KARTA
		;

{-
		-- CASE AS DEFINED BY GRAMMATIKA MALTIJA, p132
		-- Noun cases
		Case =
			  Nominative	-- referent as subject, eg IT-TARBIJA ...
			| Genitive		-- referent as possessor, eg ... TAT-TARBIJA
			| Accusative	-- referent as direct object
			| Dative		-- referent as indirect object, eg ... LIT-TARBIJA
			| Ablative		-- referent as instrument, cause, location, source or time, eg ... MINN TARBIJA
			| Vocative		-- referent being adressed, eg AA TARBIJA (lol)
		;
-}

		-- CASE AS DEFINED BY ME
		-- Noun cases (note my examples include DEFINITE ARTICLE)
		-- Commented lines mean that noun iflection is unchanged, not that the case does not occur in Maltese!
		Case =
--			  Absessive		-- lack or absence of referent (MINGĦAJR)
--			| Ablative		-- referent as instrument, cause, location, source or time
--			| Absolutive	-- subject of intransitive or object of transitive verb (in ergative-absolutive languages)
--			| Accusative	-- referent as direct object (in nominative-accusative languages)
--			| Allative		-- motion towards referent (LEJN)
--			| Additive		-- synonym of Allative (above)
			Benefactive		-- referent as recipient, eg GĦAT-TARBIJA. cf Dative.
--			| Causative		-- referent as the cause of a situation (MINĦABBA)
			| Comitative	-- with, eg MAT-TARBIJA
			| Dative		-- referent as indirect object, eg LIT-TARBIJA. cf Benefactive.
--			| Delative		-- motion downward from referent
			| Elative		-- motion away from referent, eg MIT-TARBIJA
			| Equative		-- likeness or identity, eg BĦAT-TARBIJA
--			| Ergative		-- subject of transitive verb (in ergative-absolutive languages)
--			| Essive		-- temporary state / while / in capacity of (BĦALA)
			| Genitive		-- referent as possessor, eg TAT-TARBIJA
--			| Illative		-- motion into / towards referent, eg SAT-TARBIJA. cf Allative.
			| Inessive		-- within referent, eg ĠOT-TARBIJA, FIT-TARBIJA
			| Instrumental	-- referent as instrument, eg BIT-TARBIJA. cf Ablative.
			| Lative		-- motion up to referent, eg SAT-TARBIJA
--			| Locative		-- location at referent
			| Nominative	-- referent as subject, eg IT-TARBIJA
--			| Partitive		-- partial nature of referent
--			| Prolative		-- motion along / beside referent
--			| Superessive	-- on / upon (FUQ)
--			| Translative	-- referent noun or adjective as result of process of change
--			| Vocative		-- referent being adressed, eg AA TARBIJA (lol)
		;

--		Person  = P1 | P2 | P3 ;
--		State   = Def | Indef | Const ;
--		Mood    = Ind | Cnj | Jus ;
--		Voice   = Act | Pas ;
		Origin =
			  Semitic
			| Romance
			| English
		;
--		Order   = Verbal | Nominal ;

		-- Just for my own use
		-- Mamma = Per3 Sg Masc ;

		-- Shortcut type
		-- GenNum = gn Gender Number2 ;


		Person_Number = Sg | Pl ;

		-- Agreement features
		Agr =
			  Per1 Person_Number	-- Jiena, Aħna
			| Per2 Person_Number	-- Inti, Intom
			| Per3Sg Gender	-- Huwa, Hija
			| Per3Pl		-- Huma
		;

		-- Possible tenses
		Tense =
			  Perf	-- Perfect tense, eg SERAQ
			| Impf -- Imperfect tense, eg JISRAQ
			| Imp	-- Imperative, eg ISRAQ
			-- | PresPart	-- Present Particible. Intransitive and 'motion' verbs only, eg NIEŻEL
			-- | PastPart	-- Past Particible. Both verbal & adjectival function, eg MISRUQ
			-- | VerbalNoun	-- Verbal Noun, eg SERQ
		;

		-- Possible verb forms (tense + person)
		VForm =
			  VPerf Agr		-- Perfect tense in all pronoun cases
			| VImpf Agr		-- Imperfect tense in all pronoun cases
			| VImp Person_Number	-- Imperative is always Per2, Sg & Pl
			-- | VPresPart GenNum	-- Present Particible for Gender/Number
			-- | VPastPart GenNum	-- Past Particible for Gender/Number
			-- | VVerbalNoun			-- Verbal Noun
		;

		-- Possible verb types
		VType =
			  Strong	-- Strong verb: none of radicals are semi-vowels	eg ĦAREĠ (Ħ-R-Ġ)
			| Defective	-- Defective verb: third radical is semivowel GĦ	eg QATA' (Q-T-GĦ)
			| Weak		-- Weak verb: third radicl is semivowel J			eg MEXA (M-X-J)
			| Hollow	-- Hollow verb: long A or IE btw radicals 1 & 3		eg QAL (Q-W-L) or SAB (S-J-B)
			| Double	-- Double/Geminated verb: radicals 2 & 3 identical	eg ĦABB (Ħ-B-B)
			| Quad		-- Quadliteral verb									eg KARKAR (K-R-K-R), MAQDAR (M-Q-D-R), LEMBEB (L-M-B-B)
		;

	oper

		-- Roots & Patterns
		Pattern : Type = {v1, v2 : Str} ; -- vowel1, vowel2
		-- Root3 : Type = {K, T, B : Str} ;
		-- Root4 : Type = Root3 ** {L : Str} ;
		Root : Type = {K, T, B, L : Str} ;

		-- Some classes. I need to include "c" because currently "ċ" gets downgraded to "c" in input :/
		Consonant : pattern Str = #( "b" | "c" | "ċ" | "d" | "f" | "ġ" | "g" | "għ" | "ħ" | "h" | "j" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "w" | "x" | "ż" | "z" );
		CoronalConsonant : pattern Str = #( "c" | "ċ" | "d" | "n" | "r" | "s" | "t" | "x" | "ż" | "z" ); -- "konsonanti xemxin"
		LiquidCons : pattern Str = #( "l" | "m" | "n" | "r" | "għ" );
		Vowel : pattern Str = #( "a" | "e" | "i" | "o" | "u" );
		Digraph : pattern Str = #( "ie" );
		SemiVowel : pattern Str = #( "għ" | "j" );

		{- ===== Type declarations ===== -}

		-- VP = {
			-- v : Verb ;
			-- clit : Str ;
			-- clitAgr : ClitAgr ;
			-- obj : Agr => Str
		-- } ;

		-- NP = {
			-- s : Case => {clit,obj : Str ; isClit : Bool} ;
			-- a : Agr
		-- } ;

{-
		Noun : Type = {
			s : Number5 => Str ;
			g : Gender ;
		} ;
-}
		Noun : Type = {
			s : Noun_Number => Definiteness => Case => Str ;
			g : Gender ;
		} ;

		Adj : Type = {
			s : Gender => Person_Number => Str ;
			-- isPre : Bool ;
		} ;

		Verb : Type = {
			s : VForm => Str ;	-- Give me the form (tense, person etc) and I'll give you the string
			t : VType ;			-- Inherent - Strong/Hollow etc
			o : Origin ;		-- Inherent - a verb of Semitic or Romance origins?
		} ;


		{- ===== Useful helper functions ===== -}

		addDefinitePreposition : Str -> Str -> Str = \prep,n -> (getDefinitePreposition prep n) ++ n ;
		addDefiniteArticle = addDefinitePreposition "il" ;
		getDefiniteArticle = getDefinitePreposition "il" ;

		-- Correctly inflect definite preposition
		-- A more generic version of getDefiniteArticle
			-- Params:
				-- preposition (eg TAL, MAL, BĦALL)
				-- noun
		-- NOTE trying to call this with a runtime string will cause a world of pain. Design around it.
		getDefinitePreposition : Str -> Str -> Str = \prep,noun ->
			let
				-- Remove either 1 or 2 l's
				prepStem : Str = case prep of {
					_ + "ll" => Predef.tk 2 prep ;
					_ + "l"  => Predef.tk 1 prep ;
					_ => prep -- this should never happen, I don't think
				}
			in
			case noun of {
				("s"|#LiquidCons) + #Consonant + _ 	=> prep + "-i" ;		-- L-ISKOLA
				("għ" | #Vowel) + _ 				=> case prep of {		-- L-GĦATBA...
														("fil"|"bil")	=> (Predef.take 1 prep) + "l-" ;
														"il" 			=> "l" + "-" ;
														_ 				=> prep + "-"
													};
				K@#CoronalConsonant + _ 			=> prepStem + K + "-" ;	-- IĊ-ĊISK
				#Consonant + _ 						=> prep + "-" ;			-- IL-QADDIS
				_ 									=> []					-- ?
			} ;

		definiteArticle : Str =
			pre {
				"il-" ;
				"l-" / strs { "a" ; "e" ; "i" ; "o" ; "u" ; "h" ; "għ" } ;
				"iċ-" / strs { "ċ" } ;
				"id-" / strs { "d" } ;
				"in-" / strs { "n" } ;
				"ir-" / strs { "r" } ;
				"is-" / strs { "s" } ;
				"it-" / strs { "t" } ;
				"ix-" / strs { "x" } ;
				"iż-" / strs { "ż" } ;
				"iz-" / strs { "z" }
			} ;

}
