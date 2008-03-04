
abstract Wiki = {

	flags startcat = Sentence ;
		  coding   = utf8 ;

    cat
		Sentence ;
		Verb ;
		Noun ;
		CountryPN ;
		CuisinePN ;
		Determiner ;

    fun
-- Sentences
		SingleWordCommand	: Verb -> Sentence ;
		Command				: Verb -> Determiner -> Noun -> Sentence ;
		RandomlyCommand		: Verb -> Determiner -> Noun -> Sentence ;
		Label				: Noun -> Sentence ;
		CountryName			: CountryPN -> Sentence ;
		CuisineName			: CuisinePN -> Sentence ;

-- Verbs
		Cancel				: Verb ;
		Select				: Verb ;
		Edit				: Verb ;
		Save				: Verb ;
		Add					: Verb ;
		Undo				: Verb ;
		Redo				: Verb ;
		Cut					: Verb ;
		Copy				: Verb ;
		Paste				: Verb ;
		Delete				: Verb ;
		Refine				: Verb ;
		Replace				: Verb ;
		Wrap				: Verb ;

-- Nouns
--	Field Labels
--	  Information
		Information			: Noun ;
		Name				: Noun ;
		Address				: Noun ;
		City				: Noun ;
		State				: Noun ;
		Postalcode			: Noun ;
		Country				: Noun ;
		Phone				: Noun ;
		Cuisine				: Noun ;
		Language			: Noun ;

--	  Misc
		Page				: Noun ;
		Index				: Noun ;
		Review				: Noun ;
		Restaurant			: Noun ;
		Food				: Noun ;
		Service				: Noun ;
		Node				: Noun ;
		Tree				: Noun ;

-- Proper Nouns
--	Countries
		Andorra										: CountryPN ;
		UnitedArabEmirates							: CountryPN ;
		Afghanistan									: CountryPN ;
		AntiguaAndBarbuda							: CountryPN ;
		Anguilla									: CountryPN ;
		Albania										: CountryPN ;
		Armenia										: CountryPN ;
		NetherlandsAntilles							: CountryPN ;
		Angola										: CountryPN ;
		Antarctica									: CountryPN ;
		Argentina									: CountryPN ;
		AmericanSamoa								: CountryPN ;
		Austria										: CountryPN ;
		Australia									: CountryPN ;
		Aruba										: CountryPN ;
		AlandIslands								: CountryPN ;
		Azerbaijan									: CountryPN ;
		BosniaAndHerzegovina						: CountryPN ;
		Barbados									: CountryPN ;
		Bangladesh									: CountryPN ;
		Belgium										: CountryPN ;
		BurkinaFaso									: CountryPN ;
		Bulgaria									: CountryPN ;
		Bahrain										: CountryPN ;
		Burundi										: CountryPN ;
		Benin										: CountryPN ;
		Bermuda										: CountryPN ;
		Brunei										: CountryPN ;
		Bolivia										: CountryPN ;
		Brazil										: CountryPN ;
		Bahamas										: CountryPN ;
		Bhutan										: CountryPN ;
		BouvetIsland								: CountryPN ;
		Botswana									: CountryPN ;
		Belarus										: CountryPN ;
		Belize										: CountryPN ;
		Canada										: CountryPN ;
		CocosIslands								: CountryPN ;
		CongoDemocraticRepublicofthe				: CountryPN ;
		CentralAfricanRepublic						: CountryPN ;
		Congo										: CountryPN ;
		Switzerland									: CountryPN ;
		CotedIvoire									: CountryPN ;
		CookIslands									: CountryPN ;
		Chile										: CountryPN ;
		Cameroon									: CountryPN ;
		China										: CountryPN ;
		Colombia									: CountryPN ;
		CostaRica									: CountryPN ;
		SerbiaAndMontenegro							: CountryPN ;
		Cuba										: CountryPN ;
		CapeVerde									: CountryPN ;
		ChristmasIsland								: CountryPN ;
		Cyprus										: CountryPN ;
		CzechRepublic								: CountryPN ;
		Germany										: CountryPN ;
		Djibouti									: CountryPN ;
		Denmark										: CountryPN ;
		Dominica									: CountryPN ;
		DominicanRepublic							: CountryPN ;
		Algeria										: CountryPN ;
		Ecuador										: CountryPN ;
		Estonia										: CountryPN ;
		Egypt										: CountryPN ;
		WesternSahara								: CountryPN ;
		Eritrea										: CountryPN ;
		Spain										: CountryPN ;
		Ethiopia									: CountryPN ;
		Finland										: CountryPN ;
		Fiji										: CountryPN ;
		FalklandIslands								: CountryPN ;
		Micronesia									: CountryPN ;
		FaroeIslands								: CountryPN ;
		France										: CountryPN ;
		Gabon										: CountryPN ;
		UnitedKingdom								: CountryPN ;
		Grenada										: CountryPN ;
		Georgia										: CountryPN ;
		FrenchGuiana								: CountryPN ;
		Guernsey									: CountryPN ;
		Ghana										: CountryPN ;
		Gibraltar									: CountryPN ;
		Greenland									: CountryPN ;
		Gambia										: CountryPN ;
		Guinea										: CountryPN ;
		Guadeloupe									: CountryPN ;
		EquatorialGuinea							: CountryPN ;
		Greece										: CountryPN ;
		SouthGeorgiaAndTheSouthSandwichIslands		: CountryPN ;
		Guatemala									: CountryPN ;
		Guam										: CountryPN ;
		GuineaBissau								: CountryPN ;
		Guyana										: CountryPN ;
		HongKong									: CountryPN ;
		HeardIslandAndMcDonaldIslands				: CountryPN ;
		Honduras									: CountryPN ;
		Croatia										: CountryPN ;
		Haiti										: CountryPN ;
		Hungary										: CountryPN ;
		Indonesia									: CountryPN ;
		Ireland										: CountryPN ;
		Israel										: CountryPN ;
		IsleofMan									: CountryPN ;
		India										: CountryPN ;
		BritishIndianOceanTerritory					: CountryPN ;
		Iraq										: CountryPN ;
		Iran										: CountryPN ;
		Iceland										: CountryPN ;
		Italy										: CountryPN ;
		Jersey										: CountryPN ;
		Jamaica										: CountryPN ;
		Jordan										: CountryPN ;
		Japan										: CountryPN ;
		Kenya										: CountryPN ;
		Kyrgyzstan									: CountryPN ;
		Cambodia									: CountryPN ;
		Kiribati									: CountryPN ;
		Comoros										: CountryPN ;
		SaintKittsAndNevis							: CountryPN ;
		NorthKorea									: CountryPN ;
		SouthKorea									: CountryPN ;
		Kuwait										: CountryPN ;
		CaymanIslands								: CountryPN ;
		Kazakhstan									: CountryPN ;
		Laos										: CountryPN ;
		Lebanon										: CountryPN ;
		SaintLucia									: CountryPN ;
		Liechtenstein								: CountryPN ;
		SriLanka									: CountryPN ;
		Liberia										: CountryPN ;
		Lesotho										: CountryPN ;
		Lithuania									: CountryPN ;
		Luxembourg									: CountryPN ;
		Latvia										: CountryPN ;
		Libya										: CountryPN ;
		Morocco										: CountryPN ;
		Monaco										: CountryPN ;
		Moldova										: CountryPN ;
		Montenegro									: CountryPN ;
		Madagascar									: CountryPN ;
		MarshallIslands								: CountryPN ;
		Macedonia									: CountryPN ;
		Mali										: CountryPN ;
		Myanmar										: CountryPN ;
		Mongolia									: CountryPN ;
		Macao										: CountryPN ;
		NorthernMarianaIslands						: CountryPN ;
		Martinique									: CountryPN ;
		Mauritania									: CountryPN ;
		Montserrat									: CountryPN ;
		Malta										: CountryPN ;
		Mauritius									: CountryPN ;
		Maldives									: CountryPN ;
		Malawi										: CountryPN ;
		Mexico										: CountryPN ;
		Malaysia									: CountryPN ;
		Mozambique									: CountryPN ;
		Namibia										: CountryPN ;
		NewCaledonia								: CountryPN ;
		Niger										: CountryPN ;
		NorfolkIsland								: CountryPN ;
		Nigeria										: CountryPN ;
		Nicaragua									: CountryPN ;
		Netherlands									: CountryPN ;
		Norway										: CountryPN ;
		Nepal										: CountryPN ;
		Nauru										: CountryPN ;
		Niue										: CountryPN ;
		NewZealand									: CountryPN ;
		Oman										: CountryPN ;
		Panama										: CountryPN ;
		Peru										: CountryPN ;
		FrenchPolynesia								: CountryPN ;
		PapuaNewGuinea								: CountryPN ;
		Philippines									: CountryPN ;
		Pakistan									: CountryPN ;
		Poland										: CountryPN ;
		SaintPierreAndMiquelon						: CountryPN ;
		Pitcairn									: CountryPN ;
		PuertoRico									: CountryPN ;
		PalestinianTerritory						: CountryPN ;
		Portugal									: CountryPN ;
		Palau										: CountryPN ;
		Paraguay									: CountryPN ;
		Qatar										: CountryPN ;
		Reunion										: CountryPN ;
		Romania										: CountryPN ;
		Serbia										: CountryPN ;
		Russia										: CountryPN ;
		Rwanda										: CountryPN ;
		SaudiArabia									: CountryPN ;
		SolomonIslands								: CountryPN ;
		Seychelles									: CountryPN ;
		Sudan										: CountryPN ;
		Sweden										: CountryPN ;
		Singapore									: CountryPN ;
		SaintHelena									: CountryPN ;
		Slovenia									: CountryPN ;
		SvalbardAndJanMayen							: CountryPN ;
		Slovakia									: CountryPN ;
		SierraLeone									: CountryPN ;
		SanMarino									: CountryPN ;
		Senegal										: CountryPN ;
		Somalia										: CountryPN ;
		Suriname									: CountryPN ;
		SaoTomeAndPrincipe							: CountryPN ;
		ElSalvador									: CountryPN ;
		Syria										: CountryPN ;
		Swaziland									: CountryPN ;
		TurksAndCaicosIslands						: CountryPN ;
		Chad										: CountryPN ;
		FrenchSouthernTerritories					: CountryPN ;
		Togo										: CountryPN ;
		Thailand									: CountryPN ;
		Tajikistan									: CountryPN ;
		Tokelau										: CountryPN ;
		EastTimor									: CountryPN ;
		Turkmenistan								: CountryPN ;
		Tunisia										: CountryPN ;
		Tonga										: CountryPN ;
		Turkey										: CountryPN ;
		TrinidadAndTobago							: CountryPN ;
		Tuvalu										: CountryPN ;
		Taiwan										: CountryPN ;
		Tanzania									: CountryPN ;
		Ukraine										: CountryPN ;
		Uganda										: CountryPN ;
		UnitedStatesMinorOutlyingIslands			: CountryPN ;
		UnitedStates								: CountryPN ;
		Uruguay										: CountryPN ;
		Uzbekistan									: CountryPN ;
		VaticanCity									: CountryPN ;
		SaintVincentAndtheGrenadines				: CountryPN ;
		Venezuela									: CountryPN ;
		VirginIslandsBritish						: CountryPN ;
		VirginIslandsUS								: CountryPN ;
		Vietnam										: CountryPN ;
		Vanuatu										: CountryPN ;
		WallisAndFutuna								: CountryPN ;
		Samoa										: CountryPN ;
		Yemen										: CountryPN ;
		Mayotte										: CountryPN ;
		SouthAfrica									: CountryPN ;
		Zambia										: CountryPN ;
		Zimbabwe									: CountryPN ;

--	Cuisines
		Afghani				: CuisinePN ;
		African				: CuisinePN ;
		American			: CuisinePN ;
		Arabic				: CuisinePN ;
		Argentine			: CuisinePN ;
		Armenian			: CuisinePN ;
		Asian				: CuisinePN ;
		Australian			: CuisinePN ;
		Austrian			: CuisinePN ;
		Balinese			: CuisinePN ;
		Basque				: CuisinePN ;
		Belgian				: CuisinePN ;
		Brazilian			: CuisinePN ;
		Bulgarian			: CuisinePN ;
		Burmese				: CuisinePN ;
		Cajun				: CuisinePN ;
		Cambodian			: CuisinePN ;
		Caribbean			: CuisinePN ;
		Catalan				: CuisinePN ;
		Chinese				: CuisinePN ;
		Colombian			: CuisinePN ;
		Contemporary		: CuisinePN ;
		Continental			: CuisinePN ;
		Creole				: CuisinePN ;
		Cuban				: CuisinePN ;
		Czech				: CuisinePN ;
		Dutch				: CuisinePN ;
		EasternEuropean		: CuisinePN ;
		Eclectic			: CuisinePN ;
		Egyptian			: CuisinePN ;
		English				: CuisinePN ;
		Ethiopian			: CuisinePN ;
		Ethnic				: CuisinePN ;
		French				: CuisinePN ;
		Fusion				: CuisinePN ;
		German				: CuisinePN ;
		Greek				: CuisinePN ;
		Haitian				: CuisinePN ;
		Hungarian			: CuisinePN ;
		Indian				: CuisinePN ;
		Indonesian			: CuisinePN ;
		International		: CuisinePN ;
		Irish				: CuisinePN ;
		Israeli				: CuisinePN ;
		Italian				: CuisinePN ;
		Jamaican			: CuisinePN ;
		Japanese			: CuisinePN ;
		Jewish				: CuisinePN ;
		Korean				: CuisinePN ;
		LatinAmerican		: CuisinePN ;
		Lebanese			: CuisinePN ;
		Malaysian			: CuisinePN ;
		Mexican				: CuisinePN ;
		MiddleEastern		: CuisinePN ;
		Mongolian			: CuisinePN ;
		Moroccan			: CuisinePN ;
		NewZealandCuisine	: CuisinePN ;
		Nicaraguan			: CuisinePN ;
		Nouveau				: CuisinePN ;
		Pakistani			: CuisinePN ;
		Persian				: CuisinePN ;
		Peruvian			: CuisinePN ;
		Philippine			: CuisinePN ;
		Polish				: CuisinePN ;
		Polynesian			: CuisinePN ;
		Portuguese			: CuisinePN ;
		PuertoRican			: CuisinePN ;
		Russian				: CuisinePN ;
		Salvadorean			: CuisinePN ;
		Scandinavian		: CuisinePN ;
		Scottish			: CuisinePN ;
		Seafood				: CuisinePN ;
		Singaporean			: CuisinePN ;
		Spanish				: CuisinePN ;
		SriLankan			: CuisinePN ;
		Swedish				: CuisinePN ;
		Swiss				: CuisinePN ;
		Tex_Mex				: CuisinePN ;
		Thai				: CuisinePN ;
		Tibetan				: CuisinePN ;
		Turkish				: CuisinePN ;
		Ukrainian			: CuisinePN ;
		Vegan				: CuisinePN ;
		Vegetarian			: CuisinePN ;
		Venezulean			: CuisinePN ;
		Vietnamese			: CuisinePN ;

-- Determiners
		DefSgDet			: Determiner ;
--		DefPlDet			: Determiner ;
		IndefSgDet			: Determiner ;
--		IndefPlDet			: Determiner ;
		This				: Determiner ;
--		That				: Determiner ;
--		These				: Determiner ;
--		Those				: Determiner ;

}
