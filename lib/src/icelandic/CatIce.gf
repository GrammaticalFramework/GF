concrete CatIce of Cat = CommonX ** open ResIce, Prelude in {

  flags optimize=all_subs ;

	lincat

		--2 Sentences and clauses

		S = {s : Str} ;

		QS = {s : QForm => Str} ;

		RS = {
			s : Agr => Str ;
			c : NPCase
		} ;

		Cl = ResIce.Cl ;

		ClSlash = {
			s : ResIce.Tense => Anteriority => Polarity => Order => Str ;
			c2 : Preposition
		} ;

		SSlash = {
			s : Order => Str ;
			c2 : Preposition
		} ;

		Imp = {s : Polarity => Number => Str} ;


		--2 Questions and interrogatives

		QCl = {s : ResIce.Tense => Anteriority => Polarity => QForm => Str} ;

		IP = {
			s : Gender => Case => Str ; 
			n : Number
		} ;

		IComp = {s : Number => Gender => Case => Str} ;

		IDet = {s : Gender => Case => Str ; n : Number} ;

		IQuant = {s : Number => Gender => Case => Str} ;


		--2 Relative clauses and pronouns

		RCl = {s : ResIce.Tense => Anteriority => Polarity => Agr => Str} ;

		RP = {s : Str} ;


		--2 Verb phrases

		VP = ResIce.VP ;

		Comp = {s : Agr => Str} ; 

		VPSlash = ResIce.VP ** {
			c2 : Preposition
		} ;	

		--2 Adjectival phrases

		AP = {s : Number => Gender => Declension => Case => Str} ;


		--2 Nouns and noun phrases

		CN = {
			s : Number => Species => Declension => Case => Str ;
			comp : Number => Case => Str ; -- used to separate the head from its tail components in cases of possessive constructions.
			g : Gender
		} ;

		NP =  ResIce.NP ;

		Pron = ResIce.Pron ;

		Det = {
			s : Gender => Case => Str ;
			pron : Gender => Case => Str ; -- pronouns generally follow the noun that they describe, but numbers and ordinals/adjectivs preced it
			n : Number ; 
			b : ResIce.Species ; 
			d : ResIce.Declension
		} ;

		Predet = {
			s : Number => Gender => Case => Str
		} ;

		Quant = {
			s : Number => Gender => Case => Str ;
			b : ResIce.Species ; -- for nouns, indication if the suffixed article is used or not.
			d : ResIce.Declension ; -- for adjectives, indication if the weak or strong form of the adjective is used.
			isPron : Bool -- pronouns generally follow the noun that they describe
		} ;

		Num  = {
			s : Gender => Case => Str ; 
			n : Number ; 
			hasCard : Bool
		} ;

		Card = {
			s : Gender => Case => Str ; 
			n : Number
		} ;

		Ord = {
			s : ResIce.Declension => Number => Gender => Case => Str
		} ; 

		DAP = {
			s : Gender => Case => Str ;
			n : Number ;
			b : ResIce.Species ;
			d : ResIce.Declension
		} ;


		--2 Numerals

		Numeral = {s : CardOrd => Str ; n : Number} ;
		Digits = {s : CardOrd => Str ; n : Number} ;


		--2 Structural words

		Conj = {s1,s2 : Str ; n : Number} ;
		Prep = ResIce.Preposition ;


		--2 Words of open classes

		V, VS, VQ, VA = ResIce.Verb;
		VV, V2, V2A, V2S, V2Q = ResIce.Verb ** {c2 : Preposition} ;
		V3, V2V = ResIce.Verb ** {c2,c3 : Preposition} ;

		A = ResIce.Adj ;
		A2 = ResIce.Adj ** {c2 : Preposition} ;

		N = ResIce.Noun ;
		N2 = ResIce.Noun ** {c2 : Preposition} ;
		N3 = ResIce.Noun ** {c2,c3 : Preposition} ;
		PN = {s : Case => Str ; g : Gender} ;
}
