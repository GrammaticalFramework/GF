concrete SentencesLav of Sentences = NumeralLav ** SentencesI - [
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
	lin
		NameNN = mkNP (P.mkN "NN") ;

		IFemale = mkPerson i8fem_Pron ;
		YouFamFemale = mkPerson youSg8fem_Pron ;
		YouPolFemale = mkPerson youPol8fem_Pron ;
		WeFemale = mkPerson we8fem_Pron ;
		YouPlurFamFemale, YouPlurPolFemale = mkPerson youPl8fem_Pron ;
		TheyFemale = mkPerson they8fem_Pron ;

		--AHaveCurr p curr = mkCl p.name have_V2 (mkNP aPl_Det curr) ;
		--AHaveCurr p curr = mkCl (mkVP have_V3 (mkNP aPl_Det curr) p.name) ;
}
