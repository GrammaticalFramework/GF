--# -path=.:../../prelude

--1 A Simple Icelandic Resource Morphology

-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsIce$, which
-- gives a higher-level access to this module.

resource MorphoIce = ResIce ** open Prelude, (Predef=Predef), ResIce in {

	flags optimize=all ;

	oper 

	-----------------------------
	-- Neuter Noun Declensions --
	-----------------------------

		dAuga : (SgNom,PlGen : Str) -> NForms = \auga,augna ->
			let
				aug = init auga ;
				uaug = a2ö aug
			in nForms8
				auga auga auga auga
				(uaug + "u") (uaug + "u") (uaug + "um") augna ;

		dKvæði : (SgNom,PlDat : Str) -> NForms = \kvæði,kvæðum ->
			let kvæð = init kvæði
			in nForms8
				kvæði kvæði kvæði (kvæði + "s")
				kvæði kvæði kvæðum (kvæð + "a") ;

		dBarn : (_,_ : Str) -> NForms = \barn,börn ->
			nForms8
				barn barn (barn + "i") (barn + "s")
				börn börn (börn + "um") (barn + "a") ;

		dSumar : (_,_ : Str) -> NForms = \sumar,sumur ->
			let sum = init (init sumar)
			in nForms8
				sumar sumar (sum + "ri") (sumar + "s")
				sumur sumur (sum + "rum") (sum + "ra") ;

		dTré : Str -> NForms = \tré ->
			let tr = init tré
			in nForms8
				tré tré tré (tré + "s")
				tré tré (tr + "jám") (tr + "jáa") ;

	-------------------------------
	-- Feminine Noun Declensions --
	-------------------------------

		dSaga : (SgNom,PlGen : Str) -> NForms = \saga,sagna ->
			let
				sag = init saga ;
				sög = a2ö sag ;
				sögu = sög + "u"
			in nForms8
				saga sögu sögu sögu
				(sög + "ur") (sög + "ur") (sög + "um") sagna ;

		dÞökk : (_,_ : Str) -> NForms = \þökk,þakkir ->
			let þakk = init (init þakkir)
			in nForms8
				þökk þökk þökk (þakk + "ar")
				þakkir þakkir (þökk + "um") (þakk + "a") ;

		dVerslun : (_,_ : Str) -> NForms = \verslun,verslanir ->
			let verslan = init (init verslanir)
			in nForms8
				verslun verslun verslun (verslun + "ar")
				verslanir verslanir (verslun + "um") (verslan + "a") ;

		dKeppni : (_,_ : Str) -> NForms = \keppni,keppnir ->
			let keppn = init keppni
			in nForms8
				keppni keppni keppni keppni
				keppnir keppnir (keppn + "um") (keppn + "a") ;

		dFjöður : (_,_ : Str) -> NForms = \fjöður,fjaðrir ->
			let
				fjöð = init (init fjöður) ;
				fjaðr = init (init fjaðrir)
			in nForms8
				fjöður fjöður fjöður (fjaðr + "ar")
				fjaðrir fjaðrir (fjöð + "rum") (fjaðr + "a") ;

		dBrúður : (_,_ : Str) -> NForms = \brúður,brúðir ->
			let brúð = init (init brúður)
			in nForms8
				brúður (brúð + "i") (brúð + "i") (brúð + "ar")
				brúðir brúðir (brúð + "um") (brúð + "a") ;


		dFylking : (_,_ : Str) -> NForms = \fylking,fylkingar ->
			nForms8
				fylking (fylking + "u") (fylking + "u") fylkingar
				fylkingar fylkingar (fylking + "um") (fylking + "a") ;

		dNál : (_,_ : Str) -> NForms = \nál,nálar ->
			nForms8
				nál nál nál nálar
				nálar nálar (nál + "um") (nál + "a") ;

		dLifur : (_,_ : Str) -> NForms = \lifur,lifrar ->
			let lifr = init (init lifrar)
			in nForms8
				lifur lifur lifur lifrar
				lifrar lifrar (lifr + "um") (lifr + "a") ;

		dÆður : (_,_ : Str) -> NForms = \æður,æðar ->
			let æð = init (init æður)
			in nForms8
				æður (æð + "i") (æð + "i") æðar
				æðar æðar (æð + "um") (æð + "a") ;

		dHeiði : (_,_ : Str) -> NForms = \heiði,heiðar ->
			let heið = init heiði
			in nForms8
				heiði heiði heiði heiðar
				heiðar heiðar (heið + "um") (heið + "a") ;

		dLygi : (_,_ : Str) -> NForms = \lygi,lygar ->
			let lyg = init lygi
			in nForms8
				lygi lygi lygi lygi
				lygar lygar (lyg + "um") (lyg + "ar") ;

		dNögl : (_,_,_ : Str) -> NForms = \nögl,naglar,neglur ->
			let
				nagl = init (init naglar)
			in nForms8
				nögl nögl nögl naglar
				neglur neglur (nögl + "um") (nagl + "a") ;

		dMörk : (SgNom,PlNom,PlGen : Str) -> NForms = \mörk,merkur,marka ->
			nForms8
				mörk mörk mörk merkur
				merkur merkur (mörk + "um") marka ;

		dMóðir : (_,_ : Str) -> NForms = \móðir,mæður ->
			let
				móð = init (init móðir) ;
				móður = móð + "ur" ;
				mæð = init (init mæður)
			in nForms8
				móðir móður móður móður
				mæður mæður (mæð + "rum") (mæð + "ra") ;

		dKona : (_,PlGen : Str) -> NForms = \kona,kvenna ->
			let
				kon = init kona
			in nForms8
				kona (kon + "u") (kon + "u") (kon + "u")
				(kon + "ur") (kon + "ur") (kon + "um") kvenna ;

		dTá : (_,_ : Str) -> NForms = \tá,tær ->
			nForms8
				tá tá tá (tá + "ar")
				tær tær (tá + "um") (tá + "a") ;

		dÁ : (_,_ : Str) -> NForms = \á,ár ->
			nForms8
				á á á ár
				ár ár (á + "m") (á + "a") ;

		dMús : (_,_ : Str) -> NForms = \mús,mýs ->
			nForms8
				mús mús mús (mús + "ar")
				mýs mýs (mús + "um") (mús + "a") ;

	--------------------------------
	-- Masculine Noun Declensions -- 
	--------------------------------

		dSími : Str -> NForms = \sími ->
			let
				sím = init sími ;
				usím = a2ö sím ;
				síma = sím + "a" 
			in nForms8
				sími síma síma síma
				(sím + "ar") síma (usím + "um") síma ;

		dNemandi : (_,_ : Str) -> NForms = \nemandi,nemendur ->
			let
				nemand = init nemandi ;
				nemanda = nemand + "a" ;
				nemend = init (init nemendur)
			in nForms8
				nemandi nemanda nemanda nemanda
				nemendur nemendur (nemend + "um") (nemend + "a") ;

		dDani : (_,_ : Str) -> NForms = \dani,danir ->
			let
				dan = init dani ;
				udan = a2ö dan ;
				dana = dan + "a"
			in nForms8
				dani dana dana dana
				danir dana (udan + "um") dana ;

		dArmur : (_,_ : Str) -> NForms = \armur,armar ->
			let
				arm = init (init armur) ;
				örm = a2ö arm
			in nForms8
				armur arm (arm + "i") (arm + "s")
				armar (arm + "a") (örm + "um") (arm + "a") ;

		dHöfundur : (_,_ : Str) -> NForms = \höfundur,höfundar ->
			let
				höfund = init (init höfundur)
			in nForms8
				höfundur höfund (höfund + "i") höfundar
				höfundar (höfund + "a") (höfund + "um") (höfund + "a") ;

		dAkur : (_,_ : Str) -> NForms = \akur,akrar ->
			let
				akr = init (init akrar) ;
				ökr = a2ö akr
			in nForms8
				akur akur (akr + "i") (akur + "s")
				akrar (akr + "a") (ökr + "um") (akr + "a") ;

		dFótur : (_,_ : Str) -> NForms = \fótur,fætur ->
			let
				fót = init (init fótur) ;
				fæt = init (init fætur)
			in nForms8
				fótur fót (fæt + "i") (fót + "ar")
				fætur fætur (fót + "um") (fót + "a") ;

		dMaður : (_,_,_ : Str) -> NForms = \maður,manns,menn ->
			let
				mann = init manns
			in nForms8
				maður mann (mann + "i") (mann + "s")
				menn menn ((a2ö mann) + "um") (mann + "a") ;

		dFaðir : (_,_,_ : Str) -> NForms = \faðir,föður,feður ->
			let
				föð = init (init föður) ;
				feð = init (init feður)
			in nForms8
				faðir föður föður föður
				feður feður (feð + "rum") (feð + "ra") ;

		dStóll : Str -> NForms = \stóll ->
			let
				stól = init stóll
			in nForms8
				stóll stól stól (stól + "s")
				(stól + "ar") (stól + "a") (stól + "um") (stól + "a") ;

		dSöfnuður : (_,_,_ : Str) -> NForms = \söfnuður,safnaðar,söfnuðir ->
			let
				söfnuð = init (init söfnuðir) ;
				safnað = init (init safnaðar)
			in nForms8
				söfnuður söfnuð (söfnuð + "i") (safnað + "ar")
				söfnuðir (söfnuð + "i") (söfnuð + "um") (safnað + "a") ;

		dHiminn : (_,_ : Str) -> NForms = \himinn,himnar ->
			let
				himin = init himinn ;
				himn = init (init himnar) ;
				uhimn = a2ö himn
			in nForms8
				himinn himin (himn + "i") (himin + "s")
				himnar (himn + "a") (uhimn + "um") (himn + "a") ;

		dMór : (_,_ : Str) -> NForms = \mór,móar ->
			let
				mó = init mór ;
				móa = init móar ;
				móu = a2u móa
			in nForms8
				mór mó mó (mó + "s")
				móar móa (móu + "m") (mó + "a") ;

		dDalur : (_,_ : Str) -> NForms = \dalur,dalir ->
			let
				dal = init (init dalur) ;
				döl = a2ö dal
			in nForms8
				dalur dal dal (dal + "s")
				dalir (dal + "i") (döl + "um") (dal + "a") ;

		dBiskup : Str -> NForms = \biskup ->
			nForms8
				biskup biskup (biskup + "i") (doubleS biskup)
				(biskup + "ar") (biskup + "ar") (biskup + "um") (biskup + "a") ;

		dFjörður : (_,_,_ : Str) -> NForms =\fjörður,fjarðar,firðir ->
			let
				fjörð = init (init fjörður) ;
				fjarð = init (init fjarðar) ;
				firð = init (init firðir)
			in nForms8
				fjörður fjörð (firð + "i") (fjarð + "ar")
				firðir (firð + "i") (fjörð + "um") (fjarð + "a") ;

	-----------------------
	-- Noun Construction -- 
	-----------------------

		nForms2NeutrNoun : NForms -> Noun = \nfs -> nForms2Noun nfs (nForms2Suffix nfs Neutr) Neutr ;

		nForms2MascNoun : NForms -> Noun = \nfs -> nForms2Noun nfs (nForms2Suffix nfs Masc) Masc ;

		nForms2FemNoun : NForms -> Noun = \nfs -> nForms2Noun nfs (nForms2Suffix nfs Fem) Fem ;

		nForms2Noun : NForms -> NForms -> Gender -> Noun = \free,suffix,g -> {
				s = table {
					Sg => table {
						Suffix	=> caseList (suffix ! 0) (suffix ! 1) (suffix ! 2) (suffix ! 3) ;
						_	=> caseList (free ! 0) (free ! 1) (free ! 2) (free ! 3)
					} ;
					Pl => table {
						Suffix	=> caseList (suffix ! 4) (suffix ! 5) (suffix ! 6) (suffix ! 7) ;
						_	=> caseList (free ! 4) (free ! 5) (free ! 6) (free ! 7)
					}
				} ;
				g = g
		} ;

	-----------------------------------
	-- Suffixed Article Construction --
	-----------------------------------

		nForms2Suffix : NForms -> Gender -> NForms = \nfs,g -> 
				let
					sgNom = suffixSgNom (nfs ! 0) (nfs ! 4) g ;
					sgAcc = suffixSgAcc (nfs ! 1) (nfs ! 4) g ;
					sgDat = suffixSgDat (nfs ! 2) (nfs ! 4) g ;
					sgGen = suffixSgGen (nfs ! 3) g ;
					plNom = suffixPlNom (nfs ! 4) g ;
					plAcc = suffixPlAcc (nfs ! 5) g ;
					plDat = suffixPlDat (nfs ! 6) g ;
					plGen = suffixPlGen (nfs ! 7) g
				in nForms8
					sgNom sgAcc sgDat sgGen
					plNom plAcc plDat plGen ;

		-- The plural form is given to deterimine if "-ur" is a part of the stem, i.e. an extened "-r", for
		-- feminine nouns. In that case the "-u-" drops before the suffixed article. The "-u-" also drops
		-- for neuter nouns, but that seems to be in general for neuter nouns with "-ur" in the stem - I
		-- am no entirely sure about this and can't find much in literature about this...

		--  hinn - hin - hið
		suffixSgNom : (Nom,Pl : Str) -> Gender -> Str = \s,p,g -> case <s,p,g> of {
			<_ + ("a" | "i" | "u" | "é"),_,Masc>		=> s + "nn" ;
			<_,_,Masc>					=> s + "inn" ;
			<_ + ("a" | "i" | "u" | "é"),_,Fem>		=> s + "n" ;
			<front + "ur",_ + ("rar" | "rur" | "rir"),Fem>	=> front + "rin" ;
			<_,_,Fem>					=> s + "in" ;
			<_ + ("a" | "i" | "u" | "é"),_,Neutr>		=> s + "ð" ;
			<front + "ur",_,Neutr>				=> front + "rið" ;
			<_,_,Neutr>					=> s + "ið"
		} ;

		-- hinn - hina - hið
		suffixSgAcc : (Acc,Pl : Str) -> Gender -> Str = \s,p,g -> case <s,p,g> of {
			<_ + ("a" | "i" | "u" | "é"),_,Masc>		=> s + "nn" ;
			<_,_,Masc>					=> s + "inn" ;
			<front + "ur",_ + ("rar" | "rur" | "rir"),Fem>	=> front + "rina" ;
			<_ + #consonant,_,Fem>				=> s + "ina" ;
			<_,_,Fem>					=> s + "na" ;
			<_ + ("a" | "i" | "u" | "é"),_,Neutr>		=> s + "ð" ;
			<front + "ur",_,Neutr>				=> front + "rið" ;
			<_,_,Neutr>					=> s + "ið"
		} ;

		-- hinum - hinni - hinu
		suffixSgDat : (Dat,Pl : Str) -> Gender -> Str = \s,p,g -> case <s,p,g> of {
			<_,_,Masc>					=> s + "num" ;
			<front + "ur",_ + ("rar" | "rur" | "rir"),Fem>	=> front + "rinni" ;
			<_ + #consonant,_,Fem>				=> s + "inni" ;
			<_,_,Fem>					=> s + "nni" ;
			<_,_,Neutr>					=> s + "nu"
		} ;

		-- hins - hinnar - hins
		suffixSgGen : Str -> Gender -> Str = \s,g -> case <s,g> of {
			<_ + ("a" | "i" | "u" | "é"),Masc>	=> s + "ns" ;
			<_,Masc>				=> s + "ins" ;
			<_ + #consonant,Fem>			=> s + "innar" ;
			<_,Fem>					=> s + "nnar" ;
			<_ + ("a" | "i" | "u" | "é"),Neutr>	=> s + "ns" ;
			<_,Neutr>				=> s + "ins"
		} ;

		-- hinir - hinar - hin
		suffixPlNom : Str -> Gender -> Str = \s,g -> case <s,g> of {
			<_ + "nn", Masc>			=> s + "irnir" ;
			<_ , Masc>				=> s + "nir" ;
			<_ , Fem>				=> s + "nar" ;
			<_ + ("a" | "i" | "u" | "é"),Neutr>	=> s + "n" ;
			<front + "ur",Neutr>			=> front + "rin" ;
			<_,Neutr>				=> s + "in"
		} ;

		-- hina - hinar - hin
		suffixPlAcc : Str -> Gender -> Str = \s,g -> case <s,g> of {
			<_ + "nn",Masc>				=> s + "ina" ;
			<_,Masc>				=> s + "na" ;
			<_,Fem>					=> s + "nar" ;
			<_ + ("a" | "i" | "u" | "é"),Neutr>	=> s + "n" ;
			<front + "ur",Neutr>			=> front + "rin" ;
			<_,Neutr>				=> s + "in"
		} ;

		-- hinum
		suffixPlDat : Str -> Gender -> Str = \s,g -> case <s,g> of {
			<stem + "m", _>		=> stem + "num" ;
			<_,_>			=> s + "unum"
		} ;

		-- hinna
		suffixPlGen : Str -> Gender -> Str = \s,g -> case <s,g> of {
			<front + end@("á" | "ó" | "ú") + "a",_>	=> front + end + "nna" ; -- not entirely sure if this goes for all masculine and neuter nouns
			<_, _>			=> s + "nna"
		} ;

	---------------------------
	-- Adjective Declensions -- 
	---------------------------

		--------------------------
		-- Positive declensions --
		--------------------------

		-- takes in the stem - i.e. Sg.Fem.Nom - except in the case of an u-umlaut
		dPositW : Str -> AForms = \góð -> dPositWW (góð + "i") (addJ ((a2ö góð) + "u")) ;

		-- takes in the Sg.Mas.Nom and Pl.Mas.Nom
		dPositWW : (_,_ : Str) -> AForms = \góði,góðu ->
			let
				góð = init góði ;
				góða = addJ (góð + "a") ;
				mas = nForms8 góði góða góða góða góðu góðu góðu góðu ;
				fem = nForms8 góða góðu góðu góðu góðu góðu góðu góðu ;
				neut = nForms8 góða góða góða góða góðu góðu góðu góðu
			in nForms2AForms mas fem neut ;

		--  used in dFalur
		-- -d+t = t, e.g., vondur - vond - vont (not vondt)
		-- and similarily -ð+t = t, góður - góð - gott (not goðt) - also the ó goes to o for some reason here...
		ðtdt : Str -> Str = \vondur -> case vondur of {
			front + "ó" + ("dur" | "ður") => front + "o" + "t" ;
			front + ("dur" | "ður")	=> front + "t" ;
			front@(_ + #consonant) + "tur"	=> front ;
			front + "ur"		=> front
		} ;

		dFalur : (_,_ : Str) -> AForms = \falur,föl ->
			let
				fal = init (init falur) ;
				falt = ðtdt falur ;
				mas = nForms8
					falur (fal + "an") (föl + "um") (fal + "s")
					(fal + "ir") (fal + "a") (föl + "um") (fal + "ra") ;
				fem = nForms8
					föl (fal + "a") (föl + "ri") (fal + "rar")
					(fal + "ar") (fal + "ar") (föl + "um") (fal + "ra") ;
				neut = nForms8
					(falt + "t") (falt + "t") (föl + "u") (fal + "s")
					föl föl (föl + "um") (fal + "ra") ;
			in nForms2AForms mas fem neut ;

		dFagur : (_,_ : Str) -> AForms = \fagur,fögur ->
			let
				fög = init (init fögur) ;
				fag = init (init fagur) ;
				mas = nForms8
					fagur (fag + "ran") (fög + "rum") (fagur + "s")
					(fag + "rir") (fag + "ra") (fög + "rum") (fagur + "ra") ;
				fem = nForms8
					fögur (fag + "ra") (fagur + "ri") (fagur + "rar")
					(fag + "rar") (fag + "rar") (fög + "rum") (fagur + "ra") ;
				neut = nForms8
					(fagur + "t") (fagur + "t") (fög + "ru") (fag + "urs")
					(fög + "ur") (fög + "ur") (fög + "rum") (fagur + "ra") ;
			in nForms2AForms mas fem neut ;

		-- takes in the stem - Sg.Fem.Nom
		dSmár : Str -> AForms = \smá ->
			let
				mas = nForms8
					(smá + "r") (smá + "an") (smá + "um") (smá + "s")
					(smá + "ir") (smá + "a") (smá + "um") (smá + "rra") ;
				fem = nForms8
					smá (smá + "a") (smá + "rri") (smá + "rrar")
					(smá + "ar") (smá + "ar") (smá + "um") (smá + "rrar") ;
				neut = nForms8
					(smá + "tt") (smá + "tt") (smá + "u") (smá + "s")
					smá smá (smá + "um") (smá + "rra") ;
			in nForms2AForms mas fem neut ;

		dFarinn : Str -> AForms = \farinn ->
			let
				farin = init farinn ;
				far = init (init farin) ;
				för = a2ö far ;
				mas = nForms8
					(farin + "n") (farin + "n") (för + "num") (farin + "s")
					(far + "nir") (far + "na") (för + "num") (farin + "na") ;
				fem = nForms8
					farin (far + "na") (farin + "ni") (farin + "nar")
					(far + "nar") (far + "nar") (för + "num") (farin + "na") ;
				neut = nForms8
					(far + "ið") (far + "ið") (för + "nu") (farin + "s")
					farin farin (för + "num") (farin + "na") ;
			in nForms2AForms mas fem neut ;

		dLítill : Str -> AForms = \lítill ->
			let
				lítil = init lítill ;
				líti = init lítil ;
				litl = í2i ((init líti) + "l") ;
				mas =  nForms8
					lítill (líti + "nn") (litl + "um") (lítil + "s")
					(litl + "ir") (litl + "a") (litl + "um") (lítil + "la") ;
				fem = nForms8
					lítil (litl + "a") (lítil + "li") (lítil + "lar")
					(litl + "ar") (litl + "ar") (litl + "um") (lítil + "la") ;
				neut = nForms8
					(líti + "ð") (líti + "ð") (litl + "u") (lítil + "s")
					lítil lítil (litl + "um") (lítil + "la") ;
			in nForms2AForms mas fem neut ;

		-- This only applies to adjective that are really the present particple of a verb,
		-- which has the tendency to "change" into an adjective at times. So this will be 
		-- mostly (only) used with verb paradigms - but kept here.
		dTalinn : Str -> AForms = \talinn ->
			let
				talin = init talinn ;
				tal = init (init talin) ;
				tald = dorð tal ;
				töl = a2ö tal ;
				töl = dorð töl ;
				mas = nForms8
					(talin + "n") (talin + "n") (töl + "dum") (talin + "s")
					(tal + "dir") (tal + "da") (töl + "dum") (talin + "na") ;
				fem = nForms8
					talin (tal + "da") (talin + "ni") (talin + "nar")
					(tal + "dar") (tal + "dar") (töl + "dum") (talin + "na") ;
				neut = nForms8
					(tal + "ið") (tal + "ið") (töl + "du") (talin + "s")
					talin talin (töl + "dum") (tal + "inna") ;
			in nForms2AForms mas fem neut ;

		dSeinn : Str -> AForms = \seinn ->
			let
				sein = init seinn ;
				mas = nForms8
					seinn (sein + "an") (sein + "um") (sein + "s")
					(sein + "ir") (sein + "a") (sein + "um") (sein + "na") ;
				fem = nForms8
					sein (sein + "a") (sein + "ni") (sein + "nar")
					(sein + "ar") (sein + "ar") (sein + "um") (sein +"na") ;
				neut = nForms8
					(sein + "t") (sein + "t") (sein + "u") (sein + "s")
					sein sein (sein + "um") (sein + "na") ;
			in nForms2AForms mas fem neut ;

		-- takes in the stem - Sg.Fem.Nom
		dNýr : Str -> AForms = \ný ->
			let 
				mas = nForms8
					(ný + "r") (ný + "jan") (ný + "jum") (ný + "s")
					(ný + "ir") (ný + "ja") (ný + "jum") (ný + "rra") ;
				fem = nForms8
					ný (ný + "ja") (ný + "rri") (ný + "rrar")
					(ný + "jar") (ný + "jar") (ný + "jum") (ný + "rra") ;
				neut = nForms8
					(ný + "tt") (ný + "tt") (ný + "ju") (ný + "s")
					ný ný (ný + "jum") (ný + "rra") ;
			in nForms2AForms mas fem neut ;

		dDýr : Str -> AForms = \dýr ->
			let
				udýr = a2ö dýr ;
				mas = nForms8
					dýr (dýr + "an") (udýr + "um") (dýr + "s")
					(dýr + "ir") (dýr + "a") (udýr + "um") (dýr + "ra") ;
				fem = nForms8
					udýr (dýr + "a") (dýr + "ri") (dýr + "rar")
					(dýr + "ar") (dýr + "ar") (udýr + "um") (dýr + "ra") ;
				neut = nForms8
					(dýr + "t") (dýr + "t") (udýr + "u") (dýr + "s")
					udýr udýr (udýr + "um") (dýr + "ra") ;
			in nForms2AForms mas fem neut ;

		-- Currently not used, I am not sure if all words ening in -all and -ull behave like this.
		dGamall : (_,_ : Str) -> AForms = \gamall,gömul ->
			let
				gamal = init gamall ;
				gaml = (init (init gamal)) + "l" ;
				göml = (init (init gömul)) + "l" ;
				mas = nForms8
					gamall (gaml + "an") (göml + "um") (gamal + "s")
					(gaml + "ir") (gaml + "a") (göml + "um") (gamal + "la") ;
				fem = nForms8
					gömul (gaml + "a") (gamal + "li") (gamal + "lar")
					(gaml + "ar") (gaml + "ar") (göml + "um") (gamal + "la") ;
				neut = nForms8
					(gamal + "t") (gamal + "t") (göml + "u") (gamal + "s")
					gömul gömul (göml + "um") (gamal + "la") ;
			in nForms2AForms mas fem neut ;

		-----------------------------
		-- Comparitive declensions --
		-----------------------------
		
		-- Here declension operations are named after their suffixed ending
		-- and are given the stem of the word as input. The masculine and feminine
		-- are identical in all cases and numbers.

		dAri : Str -> AForms = \gul -> 
			let
				gulari = gul + "ari" ;
				gulara = gul + "ara" ;
				mas = nForms8
					gulari gulari gulari gulari
					gulari gulari gulari gulari ;
				neut = nForms8
					gulara gulara gulara gulara
					gulari gulari gulari gulari ;
			in nForms2AForms mas mas neut ;

		dRi : Str -> AForms = \þynn ->
			let
				þynnri = þynn + "ri" ;
				þynnra = þynn + "ra" ;
				mas = nForms8
					þynnri þynnri þynnri þynnri
					þynnri þynnri þynnri þynnri ;
				neut = nForms8
					þynnra þynnra þynnra þynnra
					þynnri þynnri þynnri þynnri ;
			in nForms2AForms mas mas neut ;

		dI : Str -> AForms = \seinn ->
			let
				seinni = seinn + "i" ;
				seinna = seinn + "a" ;
				mas = nForms8
					seinni seinni seinni seinni
					seinni seinni seinni seinni ;
				neut = nForms8
					seinna seinna seinna seinna
					seinni seinni seinni seinni ;
			in nForms2AForms mas mas neut ;

		-----------------------------
		-- Superlative declensions -- 
		-----------------------------

		dFalastur : (_,_ : Str) -> AForms = \falastur,fölust ->
			let
				falast = init (init falastur) ;
				mas = nForms8
					falastur (falast + "an") (fölust + "um") (falast + "s")
					(falast + "ir") (falast + "a") (fölust + "um") (falast + "ra") ;
				fem = nForms8
					fölust (falast + "a") (falast + "ri") (falast + "rar")
					(falast + "ar") (falast + "ar") (fölust + "um") (falast + "ra") ;
				neut = nForms8
					falast falast (fölust + "u") (falast + "s")
					fölust fölust (fölust + "um") (falast + "ra") ;
			in nForms2AForms mas fem neut ;
		
		dSuperlW : (_,_ : Str) -> AForms = \falast,fölust ->
			let
				falasti = falast + "i" ;
				falasta = falast + "a" ;
				fölustu = fölust + "u" ;
				mas = nForms8
					falasti falasta falasta falasta
					fölustu fölustu fölustu fölustu ;
				fem = nForms8
					falasta fölustu fölustu fölustu
					fölustu fölustu fölustu fölustu ;
				neut = nForms8
					falasta falasta falasta falasta
					fölustu fölustu fölustu fölustu ;
			in nForms2AForms mas fem neut ;

	----------------------------
	-- Adjective Construction -- 
	----------------------------

		aForms2Adjective : (x1,_,_,_,x5 : AForms) -> Str -> Adj = \positw,posits,compar,superlw,superls,aadv -> {
				s = table {
					APosit Weak Sg Masc c		=> caseList (positw ! Masc ! 0) (positw ! Masc ! 1) (positw ! Masc ! 2) (positw ! Masc ! 3) ! c ;
					APosit Weak Sg Fem c		=> caseList (positw ! Fem ! 0) (positw ! Fem ! 1) (positw ! Fem ! 2) (positw ! Fem ! 3) ! c ;
					APosit Weak Sg Neutr c		=> caseList (positw ! Neutr ! 0) (positw ! Neutr ! 1) (positw ! Neutr ! 2) (positw ! Neutr ! 3) ! c ;
					APosit Weak Pl _ c 		=> caseList (positw ! Masc ! 4) (positw ! Masc ! 5) (positw ! Masc ! 6) (positw ! Masc ! 7) ! c ;
					APosit Strong Sg Masc c		=> caseList (posits ! Masc ! 0) (posits ! Masc ! 1) (posits ! Masc ! 2) (posits ! Masc ! 3) ! c ;
					APosit Strong Sg Fem c		=> caseList (posits ! Fem ! 0) (posits ! Fem ! 1) (posits ! Fem ! 2) (posits ! Fem ! 3) ! c ;
					APosit Strong Sg Neutr c	=> caseList (posits ! Neutr ! 0) (posits ! Neutr ! 1) (posits ! Neutr ! 2) (posits ! Neutr ! 3) ! c ;
					APosit Strong Pl Masc c		=> caseList (posits ! Masc ! 4) (posits ! Masc ! 5) (posits ! Masc ! 6) (posits ! Masc ! 7) ! c ;
					APosit Strong Pl Fem c		=> caseList (posits ! Fem ! 4) (posits ! Fem ! 5) (posits ! Fem ! 6) (posits ! Fem ! 7) ! c ;
					APosit Strong Pl Neutr c	=> caseList (posits ! Neutr ! 4) (posits ! Neutr ! 5) (posits ! Neutr ! 6) (posits ! Neutr ! 7) ! c ;
					ACompar Sg Masc c		=> caseList (compar ! Masc ! 0) (compar ! Masc ! 1) (compar ! Masc ! 2) (compar ! Masc ! 3) ! c ;
					ACompar Sg Fem c		=> caseList (compar ! Fem ! 0) (compar ! Fem ! 1) (compar ! Fem ! 2) (compar ! Fem ! 3) ! c ;
					ACompar Sg Neutr c		=> caseList (compar ! Neutr ! 0) (compar ! Neutr ! 1) (compar ! Neutr ! 2) (compar ! Neutr ! 3) ! c ;
					ACompar Pl _ c			=> caseList (compar ! Masc ! 4) (compar ! Masc ! 5) (compar ! Masc ! 6) (compar ! Masc ! 7) ! c ;
					ASuperl Weak Sg Masc c		=> caseList (superlw ! Masc ! 0) (superlw ! Masc ! 1) (superlw ! Masc ! 2) (superlw ! Masc ! 3) ! c ;
					ASuperl Weak Sg Fem c		=> caseList (superlw ! Fem ! 0) (superlw ! Fem ! 1) (superlw ! Fem ! 2) (superlw ! Fem ! 3) ! c ;
					ASuperl Weak Sg Neutr c		=> caseList (superlw ! Neutr ! 0) (superlw ! Neutr ! 1) (superlw ! Neutr ! 2) (superlw ! Neutr ! 3) ! c ;
					ASuperl Weak Pl _ c 		=> caseList (superlw ! Masc ! 4) (superlw ! Masc ! 5) (superlw ! Masc ! 6) (superlw ! Masc ! 7) ! c ;
					ASuperl Strong Sg Masc c	=> caseList (superls ! Masc ! 0) (superls ! Masc ! 1) (superls ! Masc ! 2) (superls ! Masc ! 3) ! c ;
					ASuperl Strong Sg Fem c		=> caseList (superls ! Fem ! 0) (superls ! Fem ! 1) (superls ! Fem ! 2) (superls ! Fem ! 3) ! c ;
					ASuperl Strong Sg Neutr c	=> caseList (superls ! Neutr ! 0) (superls ! Neutr ! 1) (superls ! Neutr ! 2) (superls ! Neutr ! 3) ! c ;
					ASuperl Strong Pl Masc c	=> caseList (superls ! Masc ! 4) (superls ! Masc ! 5) (superls ! Masc ! 6) (superls ! Masc ! 7) ! c ;
					ASuperl Strong Pl Fem c		=> caseList (superls ! Fem ! 4) (superls ! Fem ! 5) (superls ! Fem ! 6) (superls ! Fem ! 7) ! c ;
					ASuperl Strong Pl Neutr c	=> caseList (superls ! Neutr ! 4) (superls ! Neutr ! 5) (superls ! Neutr ! 6) (superls ! Neutr ! 7) ! c
				} ;
				adv = aadv
		} ;


	----------------------
	-- Verb Conjugation --
	----------------------

		--------------------------------
		-- Weak/regular verb patterns --
		--------------------------------

		-- the principal part for weak patterns is :
		-- infinitive - first person singular past tense indicative mood - past participle
		-- the present participle is not used in these patterns 

		-- telja - taldi - talinn
		cTelja : (_,_,_ : Str) -> MForms = \telja,tel,taldi ->
			let
				telj = init telja ;
				tald = init taldi ;
				töld = a2ö tald ;
				teld = tel + (getðiditi taldi) ;
				presInd = tForms6 tel (tel + "ur") (tel + "ur") (telj + "um") (telj + "ið") (telj + "a") ;
				pastInd = tForms6 taldi (taldi + "r") taldi (töld + "um") (töld + "uð") (töld + "u") ;
				presSub = tForms6 (telj + "i") (telj + "ir") (telj + "i") (telj + "um") (telj + "ið") (telj + "i") ;
				pastSub = tForms6 (teld + "i") (teld + "ir") (teld + "i") (teld + "um") (teld + "uð") (teld + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		-- dæma - dæmdi - dæmdur
		-- duga - dugði - dugaður (does not contain the past participle)
		cDæma : (_,_,_ : Str) -> MForms = \dæma,dæmi,dæmdi ->
			let
				dæm = init dæma ;
				udæm = a2ö dæm ;
				dæmd = init dæmdi ;
				udæmd = a2ö dæmd ;
				presInd = tForms6 dæmi (dæmi + "r") (dæmi + "r") (udæm + "um") (dæmi + "ð") dæma ;
				pastInd = tForms6 dæmdi (dæmdi + "r") dæmdi (udæmd + "um") (udæmd + "uð") (udæmd + "u") ;
				presSub = tForms6 dæmi (dæmi + "r") dæmi (udæm + "um") (dæmi + "ð") dæmi ;
				pastSub = tForms6 dæmdi (dæmdi + "r") dæmdi (udæmd + "um") (udæmd + "uð") (udæmd + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		-- kalla - kallaði - kallaður 
		cKalla : (_,_ : Str) -> MForms = \kalla,kallaði ->
			let
				kall = init kalla ;
				köll = a2ö kall ;
				kölluð = köll + "uð";
				presInd = tForms6 kalla (kalla + "r") (kalla + "r") (köll + "um") (kall + "ið") kalla ;
				pastInd = tForms6 kallaði (kallaði + "r") kallaði (kölluð + "um") (kölluð + "u") (kölluð + "u") ;
				presSub = tForms6 (kall + "i") (kall + "ir") (kall + "i") (köll + "um") (kall + "ið") (kall + "i") ;
				pastSub = tForms6 kallaði (kallaði + "r") kallaði (kölluð + "um") (kölluð + "uð") (kölluð + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;


		------------------------------------
		-- Strong/irregular verb patterns --
		------------------------------------

		-- the principal part for strong patterns is :
		-- infinitive - first person singular past tense indicative mood - first person plural past tense indicative mood - past participle
		-- the present participle is not used in these patterns..

		-- bíta beit bitum
		cBíta : (_,_,_ : Str) -> MForms = \bíta,beit,bitum ->
			let
				bít = init bíta ;
				bei = init beit ;
				bit = init (init bitum) ;
				presInd = tForms6 bít (bít + "ur") (bít + "ur") (bít + "um") (bít + "ið") (bít + "a") ;
				pastInd = tForms6 beit (bei + "st") beit bitum (bit + "uð") (bit + "u") ;
				presSub = tForms6 (bít + "i") (bít + "ir") (bít + "i") (bít + "um") (bít + "ið") (bít + "i") ;
				pastSub = tForms6 (bit + "i") (bit + "ir") (bit + "i") (bit + "um") (bit + "uð") (bit + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		-- bjóða býð bauð buðum byði
		cBjóða : (_,_,_,_,_ : Str) -> MForms = \bjóða,býð,bauð,buðum,byði ->
			let
				bjóð = init bjóða ;
				buð = init (init buðum) ;
				byð = init byði ;
				presInd = tForms6 býð (býð + "ur") (býð + "ur") (bjóð + "um") (bjóð + "ið") (bjóð + "a") ;
				pastInd = tForms6 bauð (bauð + "st") bauð buðum (buð + "uð") (buð + "u") ;
				presSub = tForms6 (bjóð + "i") (bjóð + "ir") (bjóð + "i") (bjóð + "um") (bjóð + "ið") (bjóð + "i") ;
				pastSub = tForms6 byði (byð + "ir") byði (byð + "um") (byð + "uð") (byð + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		-- bresta brast brustum brostið
		cBresta : (_,_,_,_,_ : Str) -> MForms = \bresta,brest,brast,brustum,brysti ->
			let
				brust = init (init brustum) ;
				bra = init (init brast) ;
				bryst = init brysti ;
				presInd = tForms6 brest (brest + "ur") (brest + "ur") (brest + "um") (brest + "ið") (brest + "a") ;
				pastInd = tForms6 brast (bra + "st") brast brustum (brust + "uð") (brust + "u") ;
				presSub = tForms6 (brest + "i") (brest + "ir") (brest + "i") (brest + "um") (brest + "ið") (brest + "i") ;
				pastSub = tForms6 brysti (bryst + "ir") brysti (bryst + "um") (bryst + "uð") (bryst + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		-- fara fór fórum farið 
		cFara : (_,_,_,_,_ : Str) -> MForms = \fara,fer,fór,fórum,færi ->
			let
				far = init (fara) ;
				för = a2ö far ;
				fær = init færi ;
				presInd = tForms6 fer (fer + "ð") fer (för + "um") (far + "ið") (far + "a") ;
				pastInd = tForms6 fór (fór + "st") fór fórum (fór + "uð") (fór + "u") ;
				presSub = tForms6 (far + "i") (far + "ið") (far + "i") (för + "um") (far + "ið") (far + "i") ;
				pastSub = tForms6 færi (fær + "ir") færi (fær + "um") (fær + "uð") (fær + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;


		cAusa : (_,_,_,_,_ : Str) -> MForms = \ausa,eys,jós,jusum,ysi ->
			let
				aus = init ausa ;
				jusu = init jusum ;
				ys = init ysi ;
				presInd = tForms6 eys (eys + "t") eys (aus + "um") (aus + "ið") ausa ;
				pastInd = tForms6 jós (jós + "t") jós jusum (jusu + "ð") jusu ;
				presSub = tForms6 (aus + "i") (aus + "ir") (aus + "i") (aus + "um") (aus + "ið") (aus + "i") ;
				pastSub = tForms6 ysi (ysi + "r") ysi (ys + "um") (ys + "uð") (ys + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;


		-------------------------------------------
		-- Preterite Present Verbs  and -ri verbs-- 
		-------------------------------------------

		cVera : (_,_,_,_,_ : Str) -> MForms = \er,var,voru,sé,væri ->
			let
				vær = init væri ;
				presInd = tForms6 er (er + "t") er (er + "um") (er + "uð") (er + "u") ;
				pastInd = tForms6 var (var + "st") var (voru + "m") (voru + "ð") voru ;
				presSub = tForms6 sé (sé + "rt") sé (sé + "um") (sé + "uð") (sé + "u") ;
				pastSub = tForms6 væri (væri + "r") væri (vær + "um") (vær + "uð") (vær + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

		cMuna : (_,_,_,_,_ : Str) -> MForms = \muna,man,mundi,muni,myndi -> 
			let
				mun = init muna ;
				munj = init muni ;
				mund = init mundi ;
				mynd = init myndi ;
				presInd = tForms6 man (p2End man) man (mun + "um") (mun + "ið") (mun + "a") ;
				pastInd = tForms6 mundi (mund + "ir") (mund + "i") (mund + "um") (mund + "uð") (mund + "u") ;
				presSub = tForms6 muni (muni + "r") muni (munj + "um") (munj + "ið") (munj + "i") ;
				pastSub = tForms6 myndi (mynd + "ir") (mynd + "i") (mynd + "um") (mynd + "ið") (mynd + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;


		-- in the 2nd person singular present indicative
		-- the case ending seems to be either -st or t. These
		-- preterite present verbs are only so many 10 (or 11 countin vera)
		-- so it can be easily pattern matched for all cases.
		p2End : Str -> Str = \man -> case man of {
			front + "an"	=> man + "st" ;
			front + "á"	=> man + "tt" ;
			front + "eit"	=> front + "eist" ;
			_		=> man + "t"
		} ;

		cRóa : (_,_,_,_ : Str) -> MForms = \róa,ræ,reri,rói ->
			let
				ró = init róa ;
				rer = init reri ;
				presInd = tForms6 ræ (ræ + "rð") (ræ + "r") (ró + "um") (ró + "ið") róa ;
				pastInd = tForms6 reri (reri + "r") reri (rer + "um") (rer + "uð") (rer + "u") ;
				presSub = tForms6 rói (rói + "r") rói (ró + "um") (rói + "ð") rói ;
				pastSub = tForms6 reri (reri + "r") reri (rer + "um") (rer + "uð") (rer + "u")
			in tForms2MForms presInd pastInd presSub pastSub ;

	-----------------------
	-- Verb Construction -- 
	-----------------------

		vForms2Verb : Str -> MForms -> (x5,x6,x7,x8 : Str) -> (x9,x10 : AForms) -> Verb = 
			\inf,mforms,impSg,impPl,presPart,sup,pastPartW,pastPartS -> 
			let
				presInd = mforms ! Indicative ! DPres ;
				pastInd = mforms ! Indicative ! DPast ;
				presSub = mforms ! Subjunctive ! DPres ;
				pastSub = mforms ! Subjunctive ! DPast
			in {
			s = table {
				VInf				=> inf ;
				VPres v Indicative Sg p		=> persList (mkVoice v (presInd ! 0)) (mkVoice v (presInd ! 1)) (mkVoice v (presInd ! 2)) ! p;
				VPres v Indicative Pl p 	=> persList (mkVoice v (presInd ! 3)) (mkVoice v (presInd ! 4)) (mkVoice v (presInd ! 5)) ! p;
				VPast v Indicative Sg p		=> persList (mkVoice v (pastInd ! 0)) (mkVoice v (pastInd ! 1)) (mkVoice v (pastInd ! 2)) ! p;
				VPast v Indicative Pl p 	=> persList (mkVoice v (presInd ! 3)) (mkVoice v (pastInd ! 4)) (mkVoice v (pastInd ! 5)) ! p;
				VPres v Subjunctive Sg p	=> persList (mkVoice v (presSub ! 0)) (mkVoice v (presSub ! 1)) (mkVoice v (presSub ! 2)) ! p;
				VPres v Subjunctive Pl p	=> persList (mkVoice v (presSub ! 3)) (mkVoice v (presSub ! 4)) (mkVoice v (presSub ! 5)) ! p;
				VPast v Subjunctive Sg p	=> persList (mkVoice v (pastSub ! 0)) (mkVoice v (pastSub ! 1)) (mkVoice v (pastSub ! 2)) ! p;
				VPast v Subjunctive Pl p	=> persList (mkVoice v (presSub ! 3)) (mkVoice v (pastSub ! 4)) (mkVoice v (pastSub ! 5)) ! p;
				VImp v Sg			=> mkVoice v impSg ;
				VImp v Pl			=> mkVoice v impPl
			} ;
			p = table {
				PWeak Sg Masc c		=> caseList (pastPartW ! Masc ! 0) (pastPartW ! Masc ! 1) (pastPartW ! Masc ! 2) (pastPartW ! Masc ! 3) ! c ;
				PWeak Sg Fem c		=> caseList (pastPartW ! Fem ! 0) (pastPartW ! Fem ! 1) (pastPartW ! Fem ! 2) (pastPartW ! Fem ! 3) ! c ; 
				PWeak Sg Neutr c	=> caseList (pastPartW ! Neutr ! 0) (pastPartW ! Neutr ! 1) (pastPartW ! Neutr ! 2) (pastPartW ! Neutr ! 3) ! c ;
				PWeak Pl _ c		=> caseList (pastPartW ! Masc ! 4) (pastPartW ! Masc ! 5) (pastPartW ! Masc ! 6) (pastPartW ! Masc ! 7) ! c ;
				PStrong Sg Masc c	=> caseList (pastPartS ! Masc ! 0) (pastPartS ! Masc ! 1) (pastPartS ! Masc ! 2) (pastPartS ! Masc ! 3) ! c ;
				PStrong Sg Fem c	=> caseList (pastPartS ! Fem ! 0) (pastPartS ! Fem ! 1) (pastPartS ! Fem ! 2) (pastPartS ! Fem ! 3) ! c ;
				PStrong Sg Neutr c	=> caseList (pastPartS ! Neutr ! 0) (pastPartS ! Neutr ! 1) (pastPartS ! Neutr ! 2) (pastPartS ! Neutr ! 3) ! c ;
				PStrong Pl Masc c	=> caseList (pastPartS ! Masc ! 4) (pastPartS ! Masc ! 5) (pastPartS ! Masc ! 6) (pastPartS ! Masc ! 7) ! c ;
				PStrong Pl Fem c	=> caseList (pastPartS ! Fem ! 4) (pastPartS ! Fem ! 5) (pastPartS ! Fem ! 6) (pastPartS ! Fem ! 7) ! c ;
				PStrong Pl Neutr c	=> caseList (pastPartS ! Neutr ! 4) (pastPartS ! Neutr ! 5) (pastPartS ! Neutr ! 6) (pastPartS ! Neutr ! 7) ! c ;
				PPres			=> presPart
			} ;
			sup =\\v			=> mkVoice v sup
		} ;


	----------------------
	-- Noun Auxiliaries --
	----------------------

		vowel : pattern Str = #("a" | "á" | "e" | "é" | "i" | "í" | "o" | "ó" | "u" | "ú" | "y" | "ý" | "æ" | "ö" | "au" | "ei" | "ey") ;

		consonant : pattern Str = #("b" | "d" | "ð" | "f" | "g" | "h" | "j" | "k" | "l" | "m" | "n" | "p" | "r" | "s" | "t" | "v" | "x" | "þ") ;

		-- This function is still naive. Only takes into count words where only one "a" changes to "ö".
		-- Therefore words like "banani - bönunum" are not included. And even in such cases there it
		-- can be ambiguous ho the shift should be, e.g., "ananas" - "ananösum" and "arabi" - "aröbum"
		-- but "banani" - "bönunum". But maybe such cases should be caught with more input variables 
		-- in the patternmatching of paradigms and in the noun declensions above.
		-- It must also be taken account for compound words. Then only the last word should decline and
		-- experience any shift in a to ö. 
	
		a2ö : Str -> Str = \barn -> case barn of {
			-- is this powerful enough?
			front + "a" + back@(#consonant*)		=> front + "ö" + back ;
			_						=> barn
		} ;

		a2u : Str -> Str = \s -> case s of {
			front + "a" + back@(#consonant*)		=> front + "u" + back ;
			_						=> s
		} ;

		-- I am fairly certain it works the same way as a2ö
		-- currently not used - keep or trash?
		ö2a : Str -> Str = \þökk -> case þökk of {
			front + "ö" + back@(#consonant*)		=> front + "a" + back ;
			_						=> þökk
		} ;

		doubleS : Str -> Str = \s -> case s of {
			front + "s"	=> s ;
			_		=> s + "s"
		} ;

		NForms : Type = Predef.Ints 7 => Str ; 

		-- another (maybe) possible option (and maybe more optimal) would be to have nForms just two, Sg.Nom and Pl.Nom
		nForms8 : (x1,_,_,_,_,_,_,x8 : Str) -> NForms =
			\sgNom,sgAcc,sgDat,sgGen,plNom,plAcc,plDat,plGen -> table {
				0	=> sgNom ;
				1	=> sgAcc ;
				2	=> sgDat ;
				3	=> sgGen ;
				4	=> plNom ;
				5	=> plAcc ;
				6	=> plDat ;
				7	=> plGen
			} ;

	---------------------------
	-- Adjective Auxiliaries --
	---------------------------

		-- Not to be confused with ResIce.AForm 
		-- I find this name fitting but it can lead to confusions.
		AForms : Type = Gender => NForms ;

		nForms2AForms : (x1,_,x3 : NForms) -> AForms = \mas,fem,neut -> table {
				Masc	=> mas ;
				Fem	=> fem ;
				Neutr	=> neut
		} ;

		í2i : Str -> Str = \lítl -> case lítl of {
			front + "í" + back@(#consonant*)	=> front + "i" + back ;
			_					=> lítl
		} ;

		addJ : Str -> Str = \nýa -> case nýa of {
			front + vow@("ý" | "æ") + end@("a" | "u")	=> front + vow + "j" + end ;
			_						=> nýa
		} ;

		-- read as d or ð, not d(eclension) orð...
		dorð : Str -> Str = \tal -> case tal of {
			_ + ("l" | "m" | "n") 	=> tal + "d" ;
			_ + "r"			=> tal + "ð" ;
			_			=> tal
		} ;

	----------------------
	-- Verb Auxiliaries --
	----------------------
		
		-- There are 12 word forms for both the Indicative, 
		-- and Subjunctive moods, and there are 6 word forms 
		-- for both the present and the past for each.

		TForms : Type = Predef.Ints 5 => Str ;

		MForms : Type = Mood => DTense => TForms ;

		tForms6 : (x1,_,_,_,_,x6 : Str) -> TForms =
			\sgP1,sgP2,sgP3,plP1,plP2,plP3 -> table {
				0	=> sgP1 ;
				1	=> sgP2 ;
				2	=> sgP3 ;
				3	=> plP1 ;
				4	=> plP2 ;
				5	=> plP3
			} ;

		tForms2MForms : (x1,_,_,x4 : TForms) -> MForms = 
			\presInd,pastInd,presSub,pastSub -> table {
				Indicative	=> table {
							DPres => presInd ;
							DPast => pastInd
						} ;
				Subjunctive	=> table {
							DPres => presSub ;
							DPast => pastSub
						}
			} ;

		-- for past weak/regular verbs
		ðiditi : Str -> Str = \stem -> case stem of {
			-- ði
			_ + #vowel				=> stem + "ði" ;
			front + ("f" | "j") 			=> front + "ði" ; 
			_ + #vowel + ("r" | "rf" | "rg")	=> stem + "ði" ; 
			_ + "rr"				=> stem + "ði" ; -- somethimes - otherwise + "ti", e.g., sperra-sperrti
			-- ti
			front@(_ + #consonant) + "t"		=> front + "i" ;
			_ + ("p" | "t" | "k")			=> stem + "ti" ;
			front@(_ + "r") + "ð"			=> front + "ti" ;
			front@(_ + ("l" | "n")) + "d"		=> front + "ti" ; -- usually otherwise + "di", e.g., ýlda-ýldi, senda-sendi
			_ + ("ll" | "nn")			=> stem + "ti" ; -- usually otherwise + "di", e.g, brenna-brenndi,fella felldi
			-- di
			front@(_ + #vowel) + "ð"		=> front + "ddi" ;
			_ + "dd"				=> stem + "i" ;
			_ 					=> stem + "di"
		} ;

		-- get the past ending (of week verbs) - only used for cTelja patterns
		getðiditi : Str -> Str = \s -> case s of {
			_ + "ði"	=> "ði" ;
			_ + "di"	=> "di" ;
			_ + "ti"	=> "ti"
		} ;

	param
		DTense = DPast | DPres ;
} ;
