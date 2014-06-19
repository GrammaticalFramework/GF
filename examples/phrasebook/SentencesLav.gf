concrete SentencesLav of Sentences = NumeralLav ** SentencesI - [
	LAnguage,
	PLanguage,
	NPNationality,
	mkNPNationality,
	NameNN, 
	IFemale, 
	YouFamFemale, 
	YouPolFemale,
	WeFemale,
	YouPlurFamFemale,
	YouPlurPolFemale,
	TheyFemale
]
with
	(Syntax = SyntaxLav),
	(Symbolic = SymbolicLav),
	(Lexicon = LexiconLav) **
open
	Prelude,
	SyntaxLav,
	(P = ParadigmsLav),
	ExtraLav
in {
	
	lincat
		LAnguage = NPLanguage ;

	lin
		PLanguage x = mkPhrase (mkUtt x.lang) ;

		NameNN = mkNP (P.mkN "NN") ;

		IFemale = mkPerson i8fem_Pron ;
		YouFamFemale = mkPerson youSg8fem_Pron ;
		YouPolFemale = mkPerson youPol8fem_Pron ;
		WeFemale = mkPerson we8fem_Pron ;
		YouPlurFamFemale, YouPlurPolFemale = mkPerson youPl8fem_Pron ;
		TheyFemale = mkPerson they8fem_Pron ;

	oper
		NPLanguage : Type = {lang : NP ; modif : Adv} ;
		NPNationality : Type = {lang : NPLanguage ; country : NP ; prop : A} ;

		mkNPNationality : NPLanguage -> NP -> A -> NPNationality = \la,co,pro -> {
			lang = la ; 
        	country = co ;
        	prop = pro
        } ;
}
