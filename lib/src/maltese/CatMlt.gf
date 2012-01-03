-- CatMlt.gf: the common type system
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--concrete CatMlt of Cat = CommonX ** open ResMlt, Prelude, ParamX in {
concrete CatMlt of Cat = CommonX ** open ResMlt, Prelude in {

	flags optimize=all_subs ;


	lincat
--		S  = {s : Str} ;
--		Cl = {s : ResMlt.Tense => Bool => Str} ;
--		NP = ResMlt.NP ; -- {s : Case => {clit,obj : Str ; isClit : Bool} ; a : Agr} ;
--		VP = ResMlt.VP ; -- {v : Verb ; clit : Str ; clitAgr : ClitAgr ; obj : Agr => Str} ;
--		AP = {s : Gender => Number => Str ; isPre : Bool} ;
--		CN = ResMlt.Noun ; -- {s : Number => Str ; g : Gender} ;
--		Det = {s : Gender => Case => Str ; n : Number} ;
		N = ResMlt.Noun ;
		N2 = ResMlt.Noun ;
		N3 = ResMlt.Noun ;
		A = ResMlt.Adj ;
		V = ResMlt.Verb ;
--		V2 = ResMlt.Verb ** {c : Case} ;
--		AdA = {s : Str} ;
--		Pol = {s : Str ; b : Bool} ;
--		Tense = {s : Str ; t : ResMlt.Tense} ;
--		Conj = {s : Str ; n : Number} ;


		-- Cardinal or ordinal in WORDS (not digits)
		Numeral = {
			s : CardOrd => Num_Case => Str ;
			n : Num_Number
		} ;

		-- Cardinal or ordinal in DIGITS (not words)
		Digits = {
			s : Str ;			-- No need for CardOrd, i.e. no 1st, 2nd etc in Maltese
			n : Num_Number ;
			tail : DTail
		};

{-
-- These below are just examples, I believe they came form Italian.
		S  = {s : Str} ;
		Cl = {s : ResMlt.Tense => Bool => Str} ;
		NP = {s : Case => {clit,obj : Str ; isClit : Bool} ; a : Agr} ;
		VP = {v : Verb ; clit : Str ; clitAgr : ClitAgr ; obj : Agr => Str} ;
		AP = {s : Gender => Number => Str ; isPre : Bool} ;
		CN = {s : Number => Str ; g : Gender} ;
		Det = {s : Gender => Case => Str ; n : Number} ;
		N = {s : Number => Str ; g : Gender} ;
		N2 = {s : Number => Str ; g : Gender} ;
		A = {s : Number => Str ; isPre : Bool} ;
		V = ResMlt.Verb ;
		V2 = ResMlt.Verb ** {c : Case} ;
		AdA = {s : Str} ;
		Pol = {s : Str ; b : Bool} ;
		Tense = {s : Str ; t : ResMlt.Tense} ;
		Conj = {s : Str ; n : Number} ;
-}

}
