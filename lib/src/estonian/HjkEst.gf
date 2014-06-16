resource HjkEst = open ResEst, Prelude, Predef in {

-- Implementation of the noun inflection rules from
-- Heiki-Jaan Kaalep. "Eesti käänamissüsteemi seaduspärasused" (2012)
--
-- @author Kaarel Kaljurand
-- @version 2013-09-09

  flags
	coding = utf8 ;

  -- TODO: change the name of this file and the names of the opers in this file

  param
	-- S1: stress on the last syllable
	-- S2: stress on the penultimate syllable
	-- S3: stress not on the last 2 syllables
	-- If the S2 word ends with a vowel then we distinguish between:
	-- S21: 1st quantity: blo.gi, ta.la
	-- S22: 2nd quantity: rat.su, vol.le
	-- S23: 3rd quantity: aas.ta
	SylType = S1 | S2 | S21 | S22 | S23 | S3 ;

  oper

	foreign : pattern Str = #("z" | "ž" | "š") ;
	-- Foreign vowel endings
	foreign_v : pattern Str = #("ko" | "po" | "to" | "fo" | "ka" | "pa" | "ta" | "fa" | "ku" | "pu" | "tu" | "fu") ;
	v : pattern Str = #("a" | "e" | "i" | "o" | "u" | "õ" | "ä" | "ö" | "ü" | "w") ;
	vv : pattern Str = #("aa" | "ee" | "ii" | "oo" | "uu" | "õõ" | "ää" | "öö" | "üü") ;
	c : pattern Str = #("m" | "n" | "p" | "b" | "t" | "d" | "k" | "g" | "f" | "v" | "s" | "h" | "l" | "j" | "r" | "z" | "ž" | "š" | "c" | "q") ;
	lmnr : pattern Str = #("l" | "m" | "n" | "r") ;
	kpt : pattern Str = #("k" | "p" | "t" | "f" | "š") ;
	gbd : pattern Str = #("g" | "b" | "d") ;

	-- Types that map singular nominative to the full paradigm.
	-- VI and VII include gradation which is described separately.
	hjk_type,
	hjk_type_I_koi,
	hjk_type_II_ema,
	hjk_type_III_ratsu,
	hjk_type_IVa_aasta,
	hjk_type_IVb_maakas,
	hjk_type_Va_otsene,
	hjk_type_Vb_oluline,
	hjk_type_VI_link,
	hjk_type_VI_imelik,
	hjk_type_VI_meeskond,
	hjk_type_VI_seminar,
	hjk_type_VII_touge : Str -> NForms ;

	-- IVa additionally needs the stem vowel.
	hjk_type_IVb_audit,
	hjk_type_IVb_audit1 : Str -> Str -> NForms ;

	hjk_type_VI_link2 : Str -> Str -> NForms ;

	hjk_type2 : Str -> Str -> NForms ;


	-- Definition of the mapping rules.
	-- Verbatim from HJKEKS.
	hjk_type_I_koi x =
		nForms6 x x (x+"d") (x+"sse") (x+"de") (x+"sid") ;

	hjk_type_II_ema x =
		nForms6 x x x (x+"sse") (x+"de") (x+"sid") ;

	hjk_type_III_ratsu x =
		nForms6 x x (x+"t") (x+"sse") (x+"de") (x+"sid") ;

	-- if ends with 'i' ('arvuti') then last form is 'arvut' + 'e' + 'id'
	-- There are ~50 such words in the WordNet.
	hjk_type_IVa_aasta x =
		let
			x1 : Str = case x of { _ + "i" => (init x) + "e" ; _ => x }
		in
		nForms6 x x (x+"t") (x+"sse") (x+"te") (x1+"id") ;

	-- (audit "a") can be used with comparative and superlative adjectives.
	hjk_type_IVb_audit x v_g =
		let
			v_pl = case v_g of { "i" => "e" ; _ => v_g }
		in
		nForms6 x (x+v_g) (x+v_g+"t") (x+v_g+"sse") (x+v_g+"te") (x+v_pl+"id") ;

	-- TODO: clean this up
	-- 2nd argument is sg gen without the final vowel
	hjk_type_IVb_audit1 x y =
		nForms6 x (y + "i") (y+"it") (y+"isse") (y+"ite") (y+"eid") ;

	hjk_type_IVb_maakas x =
		let
			gen = init x
		in
		nForms6 x gen (gen+"t") (gen+"sse") (gen+"te") (gen+"id") ;


	--Maakas is for maakas:maaka:maakat, this is for hammas:hamba:hammast
	--Not sure if this is already covered by some hjk_type,
	--anyway the grades are explicit with two args, more reliable
	dHammas : (_,_ : Str) -> NForms ;
	dHammas hammas hamba =
		nForms6 hammas hamba (hammas+"t") (hamba+"sse") (hammas+"te") (hamba+"id") ;

	dMeri : (_,_ : Str) -> NForms ;
	dMeri meri mere =
	        let
		  mer = init mere ;
	        in
		nForms6 meri mere (mer+"d") (mere+"sse") (mere+"de") (mere+"sid") ;

	-- This rule handles the removal of -ne and -s endings, and the addition of 'e'
	-- in the case of Cne-nouns (e.g. 'raudne').
	-- vastus - vastuse - vastust
	-- otsene - otsese - otsest
	-- raudne - raudse - raudsEt - raudsesse - raudsEte - raudseid (additional 'e')
	-- TODO: variant: vastusesse | vastusse
	hjk_type_Va_otsene x =
		let
			f : Str = case x of {
				y + c@(#c) + "ne" => y + c + "se" ;
				y + "ne" => y + "s" ;
				_ => x
			} ;
			f1 : Str = case x of {
				y + "ne" => y + "s" ;
				_ => x
			}
		in
		nForms6 x (f1+"e") (f+"t") (f1+"esse") (f+"te") (f1+"eid") ;

	-- TODO: variant: olulisesse | olulisse
	hjk_type_Vb_oluline x =
		let
			f : Str = case x of {
				y + "ne" => y + "s" ;
				y + "ke" => y + "kes" ;
				_ => x
			}
		in
		nForms6 x (f+"e") (f+"t") (f+"esse") (f+"te") (f+"i") ;

	-- Examples:
	-- siid, link, president, romanss, tendents
	-- rostbiif, portfell, seersant, impulss
	-- TODO: remove: never called
	hjk_type_VI_link x =
		let
			x_n : Str = weaker_noun x
		in
		nForms6 x (x_n+"i") (x+"i") (x+"i") (x+"ide") (x+"e") ;

	-- same as hjk_type_VI_link but additionally takes the genitive ending
	hjk_type_VI_link2 x i =
		let
			x_n : Str = weaker_noun x ;
			-- TODO: think about it
			e : Str = case i of {
				"a" => "asid" ; -- pikk/pika -> pikkasid
				"e" => "i" ; -- sulg/sule -> sulgi
				_ => "e"
			}
		in
		nForms6 x (x_n+i) (x+i) (x+i) (x+i+"de") (x+e) ;


	hjk_type_VI_imelik x =
		let
			x_t : Str = stronger_noun x
		in
		nForms6 x (x+"u") (x_t+"u") (x_t+"u") (x+"e") (x_t+"e") ;

	hjk_type_VI_meeskond x =
		let
			x_n : Str = weaker_noun x
		in
		nForms6 x (x_n+"a") (x+"a") (x+"a") (x+"ade") (x+"i") ;

	hjk_type_VI_seminar x =
		nForms6 x (x+"i") (x+"i") (x+"i") (x+"ide") (x+"e") ;

	hjk_type_VII_touge x =
		let
			x_t : Str = (stronger_noun (init x)) + "e"
		in
		nForms6 x x_t (x+"t") (x_t+"sse") (x+"te") (x_t+"id") ;

	--Identical to the above, just taking 2 arguments (nom + gen)
	--There are 67 nouns in test cases where stronger_noun gets it wrong
	--handles liige:liikme as well
	hjk_type_VII_touge2 : (_,_ : Str) -> NForms ;
	hjk_type_VII_touge2 touge touke =
	        let
	                liikme : Str = case touke of {
	                        _ + "me" => touke ;
	                        _ + "mne" => touke ;
	                        _ => touge }
	        in
	        nForms6 touge touke (touge+"t") (touke+"sse") (liikme+"te") (touke+"id") ;

	-- Use this only to weaken the verbs
	weaker : Str -> Str ;
	weaker link =
		let
			li = Predef.tk 2 link ;
			nk = Predef.dp 2 link
		in
		case nk of {
			"kk" => li + "k" ;
			"pp" => li + "p" ;
			"tt" => li + "t" ;
			"ff" => li + "f" ;
			("üt"|"üs") => li + "ö" ; --süsi,söe ; ütlema,öelda
			--"ad" => li + "aj" ; --sada,saja; maybe remove
			V@(#v) + "k" => li + V + "g" ;
			V@(#v) + "p" => li + V + "b" ;
			V@(#v) + "t" => li + V + "d" ;
			V@(#v) + "g" => li + V ; --liuglema,liuelda
			V@(#v) + "b" => li + V + "v" ; --leib,leiva
			V@(#v) + "d" => li + V ; --hoidma,hoiab
			N@(#lmnr) + "k" => li + N + "g" ;
			N@(#lmnr) + "p" => li + N + "b" ;
			N@(#lmnr) + "t" => li + N + "d" ;
			N@(#lmnr) + "d" => li + N + N ;
			N@(#lmnr) + "b" => li + N + N ;
			N@("l"|"r") + "g" => li + N ; --algama,alata
			"sk" => li + "s" ;
			"h" + #kpt => li + "h" ;
			_ => link
	} ;


	-- Weakening of nouns.
	-- Only the very stable weakening that happens to nouns.
	-- TODO: verify correctness/completeness based on some other implementation.
	weaker_noun : Str -> Str ;
	weaker_noun link =
		case link of {
			li + "kk" => li + "k" ;
			li + "pp" => li + "p" ;
			li + "tt" => li + "t" ;
			li + "ff" => li + "f" ;
			li + "šš" => li + "š" ;
			li + N@(#lmnr) + "ss" => li + N + "s" ;
			li + V@(#v) + "k" => li + V + "g" ;
			li + V@(#v) + "p" => li + V + "b" ;
			li + V@(#v) + "t" => li + V + "d" ;
			li + N@(#lmnr) + "k" => li + N + "g" ;
			li + N@(#lmnr) + "p" => li + N + "b" ;
			li + N@(#lmnr) + "t" => li + N + "d" ;
			li + "h" + #kpt => li + "h" ;
			li + "kond" => li + "konn" ;
			_ => link
	} ;

	-- Strengthening of nouns.
	-- Input must not have the last vowel.
	stronger_noun : Str -> Str ;
	stronger_noun x =
		case x of {
			y + "lg" => y + "lg" ;
			y + "hk" => y + "hk" ; -- tahke
			y + "tk" => y + "tk" ; -- katke
			y + "rs" => y + "rs" ; -- morse
			y + "rr" => y + "rd" ; -- murre
			y + "ks" => y + "ks" ; -- makse
			y + "us" => y + "us" ; -- lause
			y + "sk" => y + "sk" ; -- raske (?)
			y + "ts" => y + "ts" ; -- katse
			y + "ps" => y + "psm" ; -- ripse -> ripsme
			y + "nt" => y + "nt" ; -- tante
			y + "st" => y + "st" ; -- TODO: sometimes stm: iste, kaste
			y + k@("k"|"p"|"t"|"s") => y + k + k ;
			y + "g" => y + "k" ;
			y + "d" => y + "t" ;
			y + "b" => y + "p" ;
			y + v@(#v) + "v" => y + v + "b" ; -- works for 'iive' but not 'irve'
			y + "mm" => y + "mb" ; -- komme -> kombe
			y + "nn" => y + "nd" ;
			_ => x
		} ;

	-- Strengthening of verbs.
	stronger : Str -> Str ;
	stronger x =
		let
			beginning = tk 2 x ;
			ending = dp 2 x
		in
		beginning + case ending of {
			y + k@("k"|"p"|"t"|"s") + e => y + k + k + e ;
			y + "g" + e => y + "k" + e ;
			y + "d" + e => y + "t" + e ;
			y + "b" + e => y + "p" + e ;
			_ => ending
		} ;


	-- Mapping of singular nominative to HJKEKS types.
	-- This implements the patterns from HJKEKS section 8 but
	-- makes the rule ordering explicit, handles things like dropping 'e'
	-- in 'reegel' -> 'reegli', etc.
	-- Works ~90% correctly, ~100% correctly with input longer than 10 letters.
	-- If this rule delivers an incorrect form, then use the 6-arg oper.
	-- This is also needed if another legal form is desired,
	-- e.g. palk -> palga (the default is palk -> palgi).
	--
	-- This rule does not cover:
	--  - exceptional words (workaround: take these from the lexicon)
	--  - compound words (workaround: mark the compound border manually)
	--  - comparative and superlative adjective forms (workaround: use mkA instead)
	--  - type VII (t6uge -> t6uke), as one needs to detect derivation from verb
	--  - last syllable superlong (rostbiif)
	hjk_type x = hjk_type2 x "i" ;

	hjk_type2 x i =
		case <(syl_type x), x, i> of {
			<S3, _ + "ke", _>
				=> hjk_type_Vb_oluline x ;

			<_, _ + "kond", _>
				=> hjk_type_VI_meeskond x ;

			-- Some S2 -ik words (voolik), we only cover words with double vowel
			<_, _ + #vv + ("lik"|"nik"|"stik"), _>
				=> hjk_type_IVb_audit x "u" ;

			-- Other -ik words as in HJKEKS,
			-- but added 'ndik' which fixes fractions ('kaheksandik')
			-- and is wrong only for 'kandik'.
			<_, _ + ("lik"|"nik"|"stik"|"ndik"), _>
				=> hjk_type_VI_imelik x ;

			-- Remaining -k words (but need to be S2)
			-- but not 'konjak'
			<S2, _ + ("a"|"e"|"i") + ("ng"|"k"), _>
				=> hjk_type_IVb_audit x "u" ;

			-- Other -ik words (not in HJKEKS)
			-- including also: alevik, asemik, lobudik, hämarik, sarapik, põletik
			<_, _ + ("vik"|"mik"|"dik"|"rik"|"pik"|"tik"), _>
				=> hjk_type_VI_imelik x ;

			-- kikas
			<_, ? + #v + #c + #v + "s", _>
				=> hjk_type_Va_otsene x ;

			<_, _ + ("ngas"|"kas"|"jas"|"nud"|"tud"), _>
				=> hjk_type_IVb_maakas x ;

			<S1, _ + #v + #v, _>
				=> hjk_type_I_koi x ;

			-- 'statiiv' (not like 'karjuv')
			<S1, _ + #vv + #c, i>
				=> hjk_type_VI_link2 x i ;

			<S3, _ + #c + #v + #lmnr, _>
				=> hjk_type_VI_seminar x ;

			<S1, _ + #v + #v + #c, i>
				=> hjk_type_VI_link2 x i ;

			<_, _ + ("us"|"is"), _>
				=> hjk_type_Vb_oluline x ;

			<S3, _ + #v + #v + #c, i>
				=> hjk_type_VI_link2 x i ;

			<(S1|S3), _ + #v + #c + #c, i>
				=> hjk_type_VI_link2 x i ;

			<(S1|S3), _ + #v + #c + #c + #c, i>
				=> hjk_type_VI_link2 x i ;

			<_, _ + "nna", _>
				=> hjk_type_III_ratsu x ;

			<-(S21|S22), _ + ("nu"|"tu"), _>
				=> hjk_type_IVa_aasta x ;

			-- TODO: improve foreign detection
			<S2, _ + #foreign + _ + "in", i>
				=> hjk_type_IVb_audit x i ;

			-- TODO: this is not in HJKEKS
			-- 'absurd' vs 'ebard'
			<S2, _ + #v + #lmnr + "d", i>
				=> hjk_type_IVb_audit x i ;

			-- sometimes 'a' (laurits) TODO: this is not in HJKEKS
			<S2, _ + #v + #kpt + "s", i>
				=> hjk_type_IVb_audit x i ;

			-- TODO: next 3 rules: last syllable must be long
			-- portfell, TODO: not 'karask'
			<S2, _ + #v + #c + #c, i>
				=> hjk_type_VI_link2 x i ;

			-- rostbiif, not viiul
			<S2, _ + #c + #v + #v + #c, i>
				=> hjk_type_VI_link2 x i ;

			-- impulss
			<S2, _ + #v + #c + #c + #c, i>
				=> hjk_type_VI_link2 x i ;

			-- TODO: sometimes masked by 'maakas'
			<_, _ + #v + "s", _>
				=> hjk_type_Va_otsene x ;

			-- TODO: only for adjectives?
			<_, _ + ("v"|"tav"), _>
				=> hjk_type_IVb_audit x "a" ;

			-- The choice between Va (pl part: -seid) and Vb (pl part: -si)
			-- is based on checking the derivational ending.
			-- We just check the ending of the word and require at least 2 letters
			-- to precede the ending.
			-- We added also -tine and -ldane (which occur with adjectives).
			<_, _ + ? + ? + ("line"|"lane"|"mine"|"kene"|"tine"|"ldane"), _>
				=> hjk_type_Vb_oluline x ;

			-- k6ne
			<S21, _ + "e", _>
				=> hjk_type_III_ratsu x ;

			-- Many adjectives end with "ne" (40% in WordNet)
			-- We require them to be at least 5 letters long (excluding 'öine'),
			-- to give a chance to VII_touge (next rule).
			<_, _ + ? + ? + ? + "ne", _>
				=> hjk_type_Va_otsene x ;

			-- Note: this rule does not actually check the derivation from verb.
			-- verb + e, TODO: masked by S21/e
			<(S2|S22), _ + "e", _>
				=> hjk_type_VII_touge x ;

			-- ufo, pita, lito
			<S21, _ + #foreign_v, _>
				=> hjk_type_III_ratsu x ;

			<S21, _ + #v, _>
				=> hjk_type_II_ema x ;

			<S22, _ + #v, _>
				=> hjk_type_III_ratsu x ;

			<S23, _ + #v, _>
				=> hjk_type_IVa_aasta x ;

			<S2, _ + "in", _>
				=> hjk_type_IVb_audit x "a" ;

			-- 'e' deletion
			-- kringel -> kringli, amper -> ampri, meeter -> meetri, reegel -> reegli
			-- kaabel-> kaabli (TODO: not: juubel -> juubli)
			-- spikker -> spikri (TODO: not: pokker -> pokkeri)
			-- Note: pintsel -> pintsli, but not pitser -> pitsri
			-- Note: 'redel' and 'paber' do not lose the 'e'.
			<S2, y + kk@("kk"|"pp"|"tt"|"hh") + "e" + l@("l"|"r"), _>
				=> hjk_type_IVb_audit1 x (y + (init kk) + l) ;

			-- aaker -> aakri, teater -> teatri
			<S2, y + vvkpt@(#v + #v + #kpt) + "e" + l@("l"|"r"), _>
				=> hjk_type_IVb_audit1 x (y+vvkpt+l) ;

			<S2, y + vv@(#vv) + gbd@(#gbd) + "e" + l@("l"|"r"), _>
				=> hjk_type_IVb_audit1 x (y+vv+gbd+l) ;

			-- Disabled, 50-50 correctness
			--<S2, y + vv@(#vv) + lmnr@(#lmnr) + "e" + l@("l"|"r"), _>
			--	=> hjk_type_IVb_audit1 x (y+vv+lmnr+l) ; -- 50-50

			<S2, y + vv@(#vv) + s@("s"|"v") + "e" + l@("l"|"r"), _>
				=> hjk_type_IVb_audit1 x (y+vv+s+l) ;

			<S2, y + n@("ht"|"hk"|"hv"|"nts"|"ld"|"lv"|"lb"|"ng"|"nd"|"mb"|"mp"|"nt"|"ps"|"ks"|"sk"|"st") + "e" + l@("l"|"r"), _>
				=> hjk_type_IVb_audit1 x (y+n+l) ;

			<S2, y + "e" + l@("l"|"r"), i>
				=> hjk_type_IVb_audit x i ;

			-- TODO: sometimes masked by 'link'
			<S2, _ + #c, i>
				=> hjk_type_IVb_audit x i ;

			<S3, _ + #v, _>
				=> hjk_type_IVa_aasta x ;

			-- verb + 'e'
			<_, _ + "e", _>
				=> hjk_type_VII_touge x ;

			-- catch all that end with consonant
			<_, _ + #c, i>
				=> hjk_type_IVb_audit x i ;

			-- TODO: not in HJKEKS
			<_, _ + ("ia"|"ja"), _> --kündja, not gerilja
				=> hjk_type_IVa_aasta x ;

			--added by Inari 07.10.
			<S23, _ + #c + ("la"), _> --haigla, not gorilla
				=> hjk_type_IVa_aasta x ;

			-- catch all
			<_, _, _>
				=> hjk_type_III_ratsu x
		} ;


	-- Assigns stress/quantity indicator (SylType) to the word based on
	-- its character composition.
	-- Note: you cannot use recursion (circular definitions) in these rules
	-- Note: patterns must be linear (GF book C.4.13), i.e. you cannot write
	--     oi@(#v + #v) + oi => S2 ; -- oi-oi, ai-ai, oo-oo
	syl_type : Str -> SylType ;
	syl_type x =
		case x of {
			-- all 1-letters
			? => S1 ;
			-- all 2-letters
			? + ? => S1 ;
			-- all 3-letters
			#v + #c + #v => S21 ;
			#v + #v + #v => S22 ;
			? + ? + ? => S1 ; -- koi, kae
			-- all 4-letters
			#c + #v + #v + #c => S1 ; -- siid
			#c + #v + #c + #c => S1 ; -- link
			#v + #c + #v + #c => S2 ;
			#v + #vv + #c => S1 ; -- auul, ioon, oaas
			#v + #v + #v + #c => S2 ; -- aiak (?)
			#v + #v + #c + #v => S22 ; -- aine, aade; not: 6ige
			#v + #c + #v + #v => S1 ; -- epee, oboe
			#v + #c + #c + #v => S22 ; -- iste, iglu; not: 6htu
			#c + #v + #c + #v => S21 ;
			#c + #v + #v + #v => S22 ; -- muie, neiu, riie
			? + ? + ? + ? => S1 ;
			-- at least 5-letters
			_ + #c + "ia" => S2 ; -- aaria, minia, orgia, kirurgia, nostalgia
			#v + #c + #c + #v + #v => S1 ; -- armee
			#c + #v + #c + #v + #v => S1 ; -- depoo
			#c + #c + #v + #c + #c => S1 ; -- tramm
			#c + #v + #c + #c + #c => S1 ;
			#c + #v + #vv     + #c => S1 ; -- poeem
			#c + #v + #v + #v + #c => S2 ; -- hoius, laius, maius
			#c + #v + #c + #v + #c => S2 ; -- redel
			#c + #v + #c + #gbd + "e" => S23 ; -- valge, k6rge; p6rge, hange
			#c + #v + #v + #gbd + "e" => S22 ; -- haige, kauge; t6uge
			#c + #v + #v + #c + #v => S22 ; -- lause; TODO: leitu, rootu (S23)
			#c + #v + #c + #c + #v => S22 ; -- ratsu; not: surnu
			#v + #c + #c + #c + #v => S23 ;
			#v + #c + #c + #v + #c => S2 ; -- amper
			#v + #c + #v + #c + #c => S2 ; -- avang
			_ + #c + #vv + #c + #c => S1 ; -- loots (double vowel, otherwise the same as below)
			#c + #v + #v + #c + #c => S2 ; -- laeng, loend
			#c + #c + #v + #v + #c => S1 ; -- bluus, kruus, kreem
			#v + #c + #v + #v + #c => S1 ; -- ukaas, TODO: not 'avaus'
			#v + #v + #c + #v + #c => S2 ; -- aatom
			#v + #v + #c + #c + #v => S23 ; -- aasta
			#v + #v + #c + #v + #v => S1 ; -- aaloe (?)
			#c + #c + #v + #c + #v => S21 ; -- blogi
			_ + ? + #v + #vv + #c => S1 ; -- -ioos, kruiis
			#c + #c + #v + #v + #v + #c => S2 ; -- flaier
			_ + ? + #c + #v + #c + #v => S3 ; -- oluline
			-- at least 6-letters
			#v + #c + #c + #v + #v + #c => S1 ; -- aplaus
			#v + #c + #c + #v + #c + #c => S2 ; -- astang, ellips
			#c + #vv + #c + #v + #v => S23 ; -- muumia, raadio, TODO: exclude 'vaarao'
			#c + #v + #v + #c + #v + #v => S1 ; -- peoleo
			#c + #v + #v + #c + #c + #v => S23 ; -- haigla --added by Inari, not sure if always correct
			#c + #v + #c + #c + #c + #v => S23 ; -- vangla --added by Inari, not sure if always correct
			#c + #v + #c + #vv + #c => S1 ; -- deviis (double vowel in the last syllable)
			#v + #c + #v + #c + #v + #v => S1 ; -- agoraa
			#c + #v + #c + #v + #c + #c => S2 ;
			#c + #v + #c + #v + #c + #v => S3 ;
			_ + #c + #v + #vv + #c + #v => S2 ; -- koaala
			_ + #c + #v + #v + #v + #c + #v => S3 ; -- saiake
			#v + #c + #v + #c + #c + #v => S3 ; -- üheksa
			#c + #v + #c + #c + #v + #c => S2 ; -- rektor
			#c + #v + #c + #v + #v + #c => S2 ; -- paleus
			#c + #v + #v + #c + #v + #c => S2 ; -- meeter, reegel
			#v + #v + #c + #c + #v + #c => S2 ; -- aastak
			#v + #c + #c + #c + #v + #c => S2 ; -- andmik
			#v + #c + #c + #v + #c + #v => S3 ;
			_ + #v + #v + #v + #c + #v + #v => S1 ; -- meierei
			_ + #v + #c + #v + #c + #v + #c => S3 ; -- alevik, elanik
			-- at least 7-letters
			_ + ? + ? + #c + #vv + #c => S1 ; -- double vowel in the last syllable: bensiin, benseen, bensool
			#c + #v + #v + #c + #c + #v + #c => S2 ; -- jooksik
			#c + #v + #c + #c + #c + #v + #c => S2 ; -- hurtsik
			#c + #v + #c + #c + #v + #c + #c => S2 ; -- kitsend
			#c + #v + #c + #c + #v + #v + #c => S2 ; -- pension
			#c + #v + #c + #v + #c + #v + #c => S3 ; -- seminar
			#c + #c + #v + #c + #c + #v + #c => S2 ; -- kringel, plastik
			_ + #v + #c + #v + #kpt + #kpt + #v + #c => S2 ; -- elekter, adapter
			_ + #c + #v + #lmnr + #gbd + #v + #c => S2 ; -- (k)alender, (dets)ember
			_ + #c + #v + #lmnr + #kpt + #v + #c => S2 ; -- (re)porter
			_ + #c + #v + "stik" => S3 ; -- kuristik (TODO: not logistik)
			_ + #c + #v + "s" + #kpt + #v + #c => S2 ; -- (k)anister
			#v + #c + #v + #c + #c + #v + #c => S3 ; -- apelsin
			#v + #c + #c + #v + #c + #v + #c => S3 ; -- admiral
			#c + #v + #c + #v + #c + #c + #v => S3 ; -- kaheksa
			#c + #c + #v + #c + #v + #c + #c => S2 ; -- klopits
			#c + #v + #v + #c + #v + #c + #c => S2 ; -- haarang
			#c + #v + #v + #c + #v + #v + #c => S2 ; -- raadius, kauneim
			_ + #c + #v + #v + #c + #v + #c => S2 ; -- araabik
			_ + #lmnr + #gbd + #v + #c + #c + #v + #c => S3 ; -- (pa)lderjan, (ko)rgitser
			-- other
			_ + #c + #v + #c + #c + #v + #c + #v + #c => S3 ; -- karneval
			#c + #v + #c + #v + #c + #c + #v + #c => S3 ; -- ragastik (kalender is handled above)
			_ + #v + #v + #c + #v + #c + #c + #v + #c => S3 ; -- ainestik
			_ + #c + #c + #v + #c + #c + #v + #c + #c => S3 ; -- ampersand
			_ + #c + #v + #c + #v + #c + #c => S1 ; -- dividend
			_ + #v + #vv => S1 ; -- buržuaa
			_ + #v + #c + #c + #c + #v + #v => S1 ; -- displei
			_ + #c + #v + #c + #c + #v + #v => S1 ; -- politsei
			     _ + #c + #v + #c + #v + #v => S1 ; -- defilee, kompanii
			_ => S2 -- the default is S2, but the above rules should catch most of the words
		} ;

}
