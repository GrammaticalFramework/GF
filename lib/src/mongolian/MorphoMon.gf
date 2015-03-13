--# -path=.:../prelude:../common

-- A Simple Mongolian Resource Morphology

-- based on  D.Tserenpil, R.Kullmann: Mongolian Grammar, 4th revised edition, 2008
--       and Damdinsuren: Modern Mongolian Grammar (in Mongolian) 1983

-- This resource morphology contains definitions of the lexical entries
-- needed in the resource syntax.

-- We use the parameter types and word classes defined for morphology. We only
-- treat inflection, not derivation.

resource MorphoMon = ResMon ** open Prelude, Formal in {

 flags optimize=all ; coding=utf8 ;      
 
-- Vowel Harmony

-- The 7 vowels (and double vowels, diphthongs, auxiliary vowels) are separated in 3 types: 
-- masculine (=hard) vowels а, аа, аЙ, я (a), о, оо, оЙ, ё (o), у, уу, юу, уЙ, ю, юу (u),
-- feminine (=soft) vowels э, ээ, эЙ, е, иЙ (e), ө, өө (ö), ү, үү, юү, үЙ, юЙ, ю, юү (ü), 
-- and neuter и (i). Vowel harmony means that word forms must not mix masculine and 
-- feminine vowels.
-- Remark: The gender names have nothing to do with genders for nouns; 
-- in fact, Mongolian nouns have no gender.

-- Kullmann, p.7, p.20
--    Basic vowel := short or neuter vowel
--    Strong (= Masc or back) short vowels: a | o | u
--    Weak   (= Fem or front) short vowels: e| oe | ue 
--    Neuter vowel: i
--    Strong resp. weak words (suffixes) are those whose vowels are strong|neuter resp. weak.

oper 
   mascBasicVowel  : pattern Str = #( "а" | "о" | "у" ) ;
   femBasicVowel   : pattern Str = #( "э" | "ө" | "ү" ) ;
   neuterVowel     : pattern Str = #( "и" ) ; 
   yVowel          : pattern Str = #("я"|"е"|"ё"|"ю") ;
   doubleVowel : pattern Str = #("аа"|"оо"|"уу"|                -- mascDoubleVowel (not Kullmann)
                                 "ээ"|"өө"|"үү"|                -- femDoubleVowel 
                                 "яа"|"ёо"|"еэ"|"еө"|"юу"|"юү"| -- yDoubleVowel
                                 "иа"|"ио"|"иу") ;              -- neuterDoubleVowel
   diphtVowel : pattern Str =#("й") ;

   shortVowel : pattern Str = #("а"|"у"|"о"|"ү"|"э"|"ө")     ; -- (masc|fem BasicVowel) ;
   basicVowel : pattern Str = #("а"|"у"|"о"|"ү"|"э"|"ө"|"и") ; -- (shortVowel | "и") ;
   longVowel : pattern Str = #("аа"|"оо"|"уу"|
                                "ээ"|"өө"|"үү"|
                                "яа"|"ёо"|"еэ"|"еө"|"юу"|"юү"|
                                "иа"|"ио"|"иу"|
                                "ай"|"ой"|"уй"|"эй"|"үй"|"ий") ;

   -- avoid #vowel where it makes too many distinctions!
   -- to match double vowels and diphthongs, these must come first?

-- 2.2.2 (Kullmann) Consonants 

-- WeakCons   = C7 (vocalized: must be preceded or followed by a vowel)
-- StrongCons = C9 (non-vocalized)

oper
   c7 : pattern Str = #("м"|"н"|"г"|"л"|"б"|"в"|"р") ;  
   c9 : pattern Str = #("д"|"ж"|"з"|"с"|"т"|"ц"|"ч"|"ш"|"х") ;
   consonant : pattern Str = #("м"|"н"|"г"|"л"|"б"|"в"|"р"| 
                               "д"|"ж"|"з"|"с"|"т"|"ц"|"ч"|"ш"|"х") ;
   neuterCons : pattern Str = #("ь") ;

-- Suffixation: dropping the unstressed vowel in the stem: (Kullmann p.24) 
-- Adding a suffix beginning with a vowel causes the final unstressed vowel 
-- between consonants to drop (unless it has a grammatical function). 	
-- The vowel is only dropped if it is unstressed, i.e. not the first vowel in the stem.	 
-- Apply dropVowel in case the suffix begins with a vowel:
-- ("ын"|"ийн"|"ы"|"ий"|"ыг"|"ийг"|"аас"|"ээс"|"өөс"|"оос"
-- |"аар"|"ээр"|"оор"|"өөр"|"ууд"|"үүд"|"иуд"|"иүд"),
-- so we need only check if suffix = ("ы"|"и"|"а"|"э"|"ө"|"о"|"у"|"ү") + rest. 

 dropUnstressedVowel : Str -> Str = \stem -> case stem of {
   _ + #doubleVowel + #consonant                                         => stem ;
   x@(_+(#femBasicVowel|"и")+"г") + #femBasicVowel + y@(#c7|#c9)         => (x+y) ;
   x@(_+#basicVowel+("н"|"г")) + #shortVowel + y@("н"|"г")               => stem ;
   x@(_+(#basicVowel|"й")+#c7) + #shortVowel + y@#c7                     => (x+y) ;  
  (_+#basicVowel+"ш") + "и" + "н" 										 => stem ; -- "шашин" ; "машин"
   x@(_+?+("ж"|"ч"|"ш")) + ("и") + y@#c7                                 => (x+y) ;
   x@(_+#basicVowel+#c7+("хт"|"сч"|"хч"|"ст")) + #shortVowel + y@#c7     => (x+y) ; -- Damdinsuren 18
   x@(_+(#diphtVowel|#basicVowel|"ь"+#c9)) + #shortVowel + y@(#c7|#c9)   => (x+y) ;
   x@(_+(#basicVowel|"ь")+#c9) + #shortVowel + y@(#c7|#c9)               => (x+y) ; -- Damdinsuren 18
   x@(_+#c7+ #c9) + #shortVowel + y@#c7                                  => (x+y) ; 
   _                                                                     => stem
  } ;

-- examples: cc dropUnstressedVowel "орон"
--                                  "дусал" 
--                                  "суртал" 
--                                  "төрөлхтөн"


-- We use dropUnstressedVowel in noun declination classes and regN explicitly,
-- and in regV implicitly via addSuf below.


 addSuf : Str -> Suffix -> Str = addSuffix ; -- provide a stem and a suffix with voweltype variants,
                                             -- derive the voweltype from the stem and 
                                             -- use the appropriate suffix

-- The following addSufVt is used in ParadigmsMon to combine suffix strings,
-- and in the addSuffix-function below.

-- Extend a stem with a suffix string, by inserting a4 (in the given voweltype) 
-- or a softness marker (in the given voweltype) between stem and suffix, if needed:

 addSufVt : VowelType -> Str -> Str -> Str = \vt, stm, suffix ->  
    let 
	insertVowel = table Str { _+("ж"|"ш"|"ч") => "и" ; _ => a4 ! vt } ; 
    a4 = insertVowel ! stm 
    in 
    case stm of {
	    _ + #yVowel => case suffix of {
		    #doubleVowel + _                            => stm + Predef.drop 1 suffix ;
			_                                           => stm + suffix } ;
        _ + #longVowel                    => case suffix of { 
		    #doubleVowel + _                            => stm + "г" + suffix ; 
            _                                           => stm + suffix } ;
        
	    _ + y@(#c7|#c9) + "и"             => case suffix of {
		    ""                                          => Predef.tk 1 stm + "ь" ;
            #doubleVowel + _                            => stm + Predef.drop 1 suffix ;
			#yVowel                                     => Predef.tk 1 stm + "ь" + suffix ;
            "х" + _                                     => stm + suffix ;
	        #c9 + _ => case y of { 
			    #c7    => Predef.tk 1 stm + "ь" + suffix ;
                _      => stm + suffix } ;
			_                                           => stm + suffix} ;
	    x + y@("лг"|(#c7+"л")) + #shortVowel            => case suffix of { 
		    #doubleVowel + _                            => x + y + suffix ;
            _                                           => stm + suffix } ;
        _ + #consonant + #consonant       => case suffix of { 
		    ("на"|"нэ"|"нө"|"но"|("х" + _)|"я"|"ё"|"е") => stm + a4 + suffix ;
			(#consonant + (""|(#consonant + _)))        => stm + a4 + suffix ;  
            _                                           => stm + suffix } ;
        _ + #basicVowel + c@(#c7|#c9)     => case suffix of { 
		    ("я"|"ё")                                   => stm + "ъ" + suffix ;
		    "е"                                         => stm + "ь" + suffix ;
            (("х" + _)|("в"|"г"))                       => stm + a4 + suffix ;
            "ж"     => case c of {
			    #c9    => stm + a4 + suffix ; 
				_      => stm + suffix } ;
            y@#consonant + #consonant + _ => case c of { 
			    #c7 => case y of {
  				       #c9 => stm + suffix ; 
                       _ => stm + a4 + suffix } ;
                _   => stm + a4 + suffix } ;
            _                                           => stm + suffix
                            } ;			
        _                                               => stm + suffix 
    } ;
     
-- Given a string (a stem perhaps extended by suffixes) and a suffix varying with 
-- the vowel type, choose the proper suffix variant, and concatenate (with addSufVt)
-- both, with insertion of a vowel/softness sign	

 addSuffix : Str -> Suffix -> Str = \stem,suffix -> 
    let 
    vt = vowelType stem ;
    suf = suffix ! vt 				 
    in addSufVt vt stem suf ;

 stemVerb : Str -> Str = \inf -> case inf of {
    stem@(_ + ("ч"|"ш"|"ж")) + "их"              => stem ; 
    stem@(_ + ("и"|#longVowel|#yVowel)) + "х"    => stem ;
	stem@(_ + "н" + #shortVowel) + "х"           => stem ;
    stem@(_ + #c7 + "л" + #shortVowel) + "х"     => stem ;
    stem@(_ + #c9) + "л" + v@(#shortVowel) + "х" => case stem of {
                                  _ + ("ж"|"ш"|"ч") => stem + "и" + "л" ;
                                                  _ => stem + v + "л" } ;
    stem@((#consonant)* + ?) + "х"               => stem ;
                                               _ => Predef.tk 2 inf
    } ;

-- Personal pronouns with possessive as additional PronForm:

oper 
 pronEnding : VowelType => RCase => Str = table {
    MascA => table RCase ["";"ын";"ад";"ыг";"аас";"аар";"тай";"руу"] ;
	_     => table RCase ["";"ийн";"эд";"ийг";"ээс";"ээр";"тэй"; "рүү"] 
	} ;
	
 mkPron : (_,_,_,_,_,_,_,_ : Str) -> Number -> Person -> Pron = 
    \bi,minii,nadad,namaig,nadaas,nadaar,nadtai,nadruu,n,p -> 
    let 
    vt = vowelType minii 
    in {
	s = table {
	    PronCase rc => table RCase [bi;minii;nadad;namaig;nadaas;nadaar;nadtai;nadruu] ! rc ;
	    PronPoss rc => minii + "х" + pronEnding ! vt ! rc 
		} ;
		n = n ; 
		p = p 
	} ;

-- Nouns

-- Mongolian noun declension

-- There are 5 different plural suffixes, 4 genitive, 2 dative, 2 accusative, 2 directive.
-- an ablative, comitative and instrumental suffix which depends on the vowel harmony.
                                         
oper
    plSuffix : Str -> Str = \stem ->
    let 
	vt = vowelType stem ;
	stemDr = dropUnstressedVowel stem -- doesn't drop the vowel in loan words, cf. mkDecl
    in 
    table VowelType { vts => case stem of {
	    _ + #basicVowel + ("гч"|"лч"|"ч")       => stem + "ид" ; -- зохиолчид
	    y@(_ + #doubleVowel + #consonant) + "ь" => y + iud2 ! vts ; -- сургуулиуд
	    y + ("ь")                               => y + "и" + nuud2 ! vts ; -- хонинууд
		_ + ("сан"|"нан"|"нин"|"шин")           => stem + guud2 ! vts ; -- шашингууд
		_ + #consonant + #consonant + "и"       => stem + nuud2 ! vts ; -- тамхинууд
		_ + "р"                                 => stemDr + uud2 ! vts ; -- чихрүүд
		_ + ("га"|"гэ"|"го"|"гө")               => stem + nuud2 ! vts ; -- хурганууд
		_ + "ран"                               => stem + uud2 ! vts ; 
		y + "н"                                 => y + "д" ; --охид
		y@(_ + #consonant) + #shortVowel        => y + uud2 ! vts ;
		_                                       => stem + nuud2 ! vts  -- туулайнууд
	   } 
    } ! vt ;
    
-- mkDecl is used for declension of nouns and proper names, depending on the
-- parameter drop:Bool. The parameter drop is used to distinguish between 
-- declination for ordinary nouns and declination for proper names 
-- and foreign nouns. If the suffix added begins with a vowel, the
-- unstressed vowel in the stem has to be dropped in noun declension, but not in
-- proper name declension. The dropping function is dropUnstressedVowel for
-- nouns, but the identity for proper names. For nouns, drop=True, 
-- and a function dropUnstressedVowel is applied to the stem; 
-- for proper names, drop=False suppresses the vowel dropping.

-- Note: It is much more efficient to use a flag drop:Bool instead of a parameter
-- drop:(Str -> Str) which is later instantiated to \x->x or dropUnstressedVowel only.
-- A previous version with a function parameter drop:(Str->Str) was much slower.

 SemiDcl : Type = Str -> Str -> VowelType => NCase => Str ;

 sgDcl : SemiDcl = \stem,stemDr -> \\vts =>
            table { NNom   => stem ;
                    NGen   => stemDr + iin2 ! vts ;
                    NDat   => stem + "д" ; 
	                NAcc d => case d of {
					    Definite => stem ;
						Indefinite => stemDr + iig2 ! vts } ;
                    NAbl   => stemDr + aas4 ! vts ;
                    NInst  => stemDr + aar4 ! vts ;
					NCom   => stem + tai3 ! vts ;
                    NDir   => stem ++ ruu2 ! vts 
                  } ;
				  
 plDcl : SemiDcl = \stem,stemDr -> \\vts => 
            table { NNom  => stem ;
                    NGen  => stemDr + iin2 ! vts ;
                    NDat  => case stem of { _ + "нар" => stem + "т" ; 
                                                   _ => stemDr + ad4 ! vts } ; 
                    NAcc d => case d of {
					    Definite => stem ;
						Indefinite => stemDr + iig2 ! vts } ;
                    NAbl  => stemDr + aas4 ! vts ;  
                    NInst => stemDr + aar4 ! vts ;
                    NCom  => stem + tai3 ! vts ;
                    NDir  => stem ++ (case stem of { _ + "нар" => "луу" ; 
                                                            _ => ruu2 ! vts }) 
                  } ;
				  
 Dcl : Type = Str -> Str -> Str -> Str -> VowelType => VowelType => SubstForm => Str ;

 nounDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts => \\vtp => 
            table { SF Sg NNom   => stem ;
                    SF Sg NGen   => stemDr + iin2 ! vts ;
                    SF Sg NDat   => stem + "д" ; 
	                SF Sg (NAcc d) => case d of {
					    Definite   => stemDr + iig2 ! vts ;
						Indefinite => stem} ;
                    SF Sg NAbl   => stemDr + aas4 ! vts ;
                    SF Sg NInst  => stemDr + aar4 ! vts ;
                    SF Sg NCom   => stem + tai3 ! vts ;
                    SF Sg NDir   => stem ++ ruu2 ! vts ;
                    SF Pl NNom   => stemPl ; 
                    SF Pl NGen   => stemPlDr + iin2 ! vtp ;
                    SF Pl NDat   => stemPlDr + a4 ! vtp + "д" ;
                    SF Pl (NAcc d) => case d of {
					    Definite   => stemPlDr + iig2 ! vts ;
						Indefinite => stemPl} ;
                    SF Pl NAbl   => stemPlDr + aas4 ! vtp ;
                    SF Pl NInst  => stemPlDr + aar4 ! vtp ;
                    SF Pl NCom   => stemPl + tai3 ! vtp ;
                    SF Pl NDir   => stemPl ++ ruu2 ! vtp 
                  } ;

 gaDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    n      = nounDcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
	gaStem = Predef.tk 1 stem 
    in
    table { SF Sg NGen   => stem + nii2 ! vts ; 
	        SF Sg NDat   => stem + "нд" ;
		 	SF Sg (NAcc d) => case d of {
			    Definite   => gaStem + iig2 ! vts ;
				Indefinite => stem } ;
	    	SF Sg NAbl   => stem + naas4 ! vts ;
			SF Sg NInst  => gaStem + aar4 ! vts ;
                     sf => n ! sf } ;
			
 longDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    ga = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg (NAcc d) => case d of {
			    Definite   => stem + "г" ;
				Indefinite => stem } ;
              SF Sg NInst  => stem + gaar4 ! vts ;     
                     sf => ga ! sf } ;
 
 iDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
	ga    = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
	iStem = Predef.tk 1 stem 
    in  
    table { SF Sg (NAcc d) => case d of {
			    Definite   => iStem + "ийг" ;
				Indefinite => stem } ;
            SF Sg NInst  => iStem + iar3 ! vts ; 
                     sf => ga ! sf } ;
				 
 nDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    n = nounDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NGen => stemDr + i2 ! vts ;
                   sf => n ! sf } ;
            
 shDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    ga = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in
    table { SF Sg NDat   => stemDr + and4 ! vts ;
	        SF Sg (NAcc d) => case d of {
			    Definite   => stemDr + iig2 ! vts ;
				Indefinite => stem } ;
	    	SF Sg NInst  => stemDr + aar4 ! vts ;
                    sf  => ga ! sf } ;
         
 gDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    k = c92kDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NGen => stemDr + "ийн" ;
	        SF Sg NDat => stem + "т" ;
                   sf => k ! sf } ;
			
 vDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    n = nounDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NDat => stem + "т";
                   sf => n ! sf } ;
			
 shortDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
	ga        = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
	shortStem = Predef.tk 1 stem ;
    in
    table { SF Sg NGen => shortStem + iin2 ! vts ;
		    SF Sg NDat => stem + "д" ; 
		    SF Sg NAbl => shortStem + aas4 ! vts ;		 
                   sf => ga ! sf } ;
			
 c91Dcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    sh = shDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NGen => case stem of {
                         _ + #doubleVowel + "лт" => stem + iin2 ! vts ;
                         _                       => stem + nii2 ! vts } ;
                   sf => sh ! sf } ;	
			
 c92kDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    ga = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NDat   => stemDr + "инд" ;
		    SF Sg (NAcc d) => case d of {
			    Definite   => stemDr + "ийг" ;
				Indefinite => stem } ;
		    SF Sg NInst  => stemDr + aar4 ! vts ;
                     sf => ga ! sf } ;
 
 yeyaDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    n = nounDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
	table { SF Sg NAbl  => stemDr + as4 ! vts ; 
         	SF Sg NInst => stemDr + ar4 ! vts ; 
                    sf => n ! sf } ;
			
 rDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let  
    n = nounDcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NDat => stem + "т";
            SF Sg NAbl => stem + naas4 ! vts ;     
            SF Pl NDir => stem ++ luu2 ! vts ;                 
                   sf => n ! sf } ; 
            
 neuterConsDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
	ga = gaDcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
    neuterConsStem = Predef.tk 1 stem ;
    nCstem         = neuterConsStem + "и" 
    in 
	table { SF Sg NGen   => nCstem + nii2 ! vts ;
		    SF Sg NDat   => nCstem + "нд" ;
	        SF Sg NAbl   => neuterConsStem + ias3 ! vts ; 
	        SF Sg (NAcc d) => case d of {
			    Definite   => neuterConsStem + "ийг" ;
				Indefinite => stem } ;
		    SF Sg NInst  => neuterConsStem + iar3 ! vts ; 
                     sf => ga ! sf } ;
            
 lneuterConsDcl : Dcl = \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    nC = neuterConsDcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
    neuterConsStem = Predef.tk 1 stem ;
    in 
	table { SF Sg NGen  => neuterConsStem + "ийн" ; 
            SF Sg NDat  => stem + "д" ;
                    sf => nC ! sf } ;


 modDcl01a : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    d = dcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in  
    table { SF Sg NGen => case stem of {
                      _ + "й" => stem + "н" ;
                      _       => stem + nii2 ! vts } ;
            SF Sg NDat => case stem of {
                      _ + "й" => stem + "д" ;
                      _       => stemDr + and4 ! vts } ;
            SF Sg NAbl => case stem of {
                      _ + "й" => stem + gaas4 ! vts ;
                      _       => stem + naas4 ! vts } ;
                   sf => d ! sf } ; 

 modDcl01b : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    d = dcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in  
    table { SF Sg NDat => stemDr + and4 ! vts ;
                   sf => d ! sf } ;

 modDcl01c : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    d = dcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in  
    table { SF Sg NAbl => stemDr + aas4 ! vts ;
                   sf => d ! sf } ;

 modDcl01d : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    nSg = dcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
    stemSg = stem + "г" ;
    stemPl = stemSg + uud2 ! vtp ; -- overwrite stemPl,stemPlDr
    nPl = plDcl stemPl stemPl ! vtp
    in  
    table { SF Sg NGen   => stemSg + "ийн" ;
            SF Sg (NAcc d) => case d of {
			       Definite   => stemSg ;
			       Indefinite => stem } ;
		    SF Sg NAbl   => stemSg + aas4 ! vts ;
		    SF Sg NInst  => stemSg + aar4 ! vts ;
		    SF Sg c     => nSg ! SF Sg c ;
            SF Pl NGen   => stemPl + iin2 ! vtp ;
            SF Pl NDat   => stemPl + a4 ! vtp + "д" ;
            SF Pl NAbl   => stemPl + aas4 ! vtp ;
            SF Pl c     => nPl ! c } ;

 modDcl01e : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    nSg = dcl stem stemDr stemPl stemPlDr ! vts ! vtp ;
	stemPl = stemDr + uud2 ! vts ; -- overwrite stemPl,stemPlDr
    nPl = plDcl stemPl stemPl ! vts
    in  
    table { SF Sg NAbl => stemDr + aas4 ! vts ;
            SF Sg nc   => nSg ! (SF Sg nc) ;
            SF Pl NGen => stemPl + iin2 ! vtp ;
            SF Pl NDat => stemPl + a4 ! vtp + "д" ;
            SF Pl NAbl => stemPl + aas4 ! vtp ;
            SF Pl nc   => nPl ! nc } ;
            
 modDcl01f : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    e = (modDcl01e dcl) stem stemDr stemPl stemPlDr ! vts !vtp 
    in  
    table { SF Sg NGen => stemDr + iin2 ! vts ;
            SF Sg NDat => stemDr + ad4 ! vts ;
                   sf => e ! sf } ;

 modDcl01g : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    nSg = dcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in
    table { SF n nc => case n of { Sg => nSg ! SF Sg nc ;
                                  Pl => [] } } ;

 modDcl01h : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let 
    nSg = dcl stem stemDr stemPl stemPlDr ! vts ! vtp ;  -- stemPl,stemPlDr irrelevant
    stemPl = stem + nuud2 ! vts ;
    nPl = plDcl stemPl stemPl ! vts 
    in
    table { SF Sg NGen => stem + nii2 ! vts ;
	        SF Sg NDat => stemDr + and4 ! vts ;
		    SF Sg nc   => nSg ! (SF Sg nc) ;
            SF Pl NGen => stemPl + iin2 ! vtp ;
            SF Pl NDat => stemPl + ad4 ! vtp ;
            SF Pl nc   => nPl ! nc } ;


 modDcl2N : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp =>
    let 
    nSg = dcl stem stemDr stemPl stemPlDr ! vts ! vtp ;  
    nPl = plDcl stemPl stemPlDr ! vtp 
    in 
    table { SF Sg nc    => nSg ! (SF Sg nc) ;
            SF Pl nc    => nPl ! nc } ;

 modDcl02a : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let
    nSgPl  = (modDcl2N dcl) stem stemDr stemPl stemPlDr ! vts ! vtp  -- reg2N stem nompl ;
    in 
    table { SF Sg NGen => case stem of {
            _ + #longVowel    => stem + "г" + "ийн" ; 
            _ + ("ж"|"ч"|"ш") => stemDr + "ийн" ;    
			_                 => stemDr + iin2 ! vts } ;
            SF Sg NDat => case stem of {
            _ + #longVowel    => stem + "д" ;
            _ + ("ж"|"ч"|"ш") => stem + "ид" ;
            _                 => stemDr + ad4 ! vts } ;
            SF Sg NAbl => case stem of {
            _ + #longVowel    => stem + "г" + aas4 ! vts ;
            _                 => stemDr + aas4 ! vts } ;
                           sf => nSgPl ! sf } ; 

 modDcl02b : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let
    nSgPl  = (modDcl2N dcl) stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Pl NGen => stemPlDr + iin2 ! vtp ;
            SF Pl NDat => stemPlDr + ad4 ! vtp ;
            SF Pl NAbl => stemPlDr + aas4 ! vtp ;
                   sf => nSgPl ! sf } ;

 modDcl02c : Dcl -> Str -> Dcl = \dcl,ablsg -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let
    nSgPl  = dcl stem stemDr stemPl stemPlDr ! vts ! vtp 
    in 
    table { SF Sg NDat => stemDr + and4!vts ;
            SF Sg NAbl => ablsg ;
                   sf => nSgPl ! sf } ;

 modDcl02d : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let
    nSgPl  = (modDcl2N dcl) stem stemDr stemPl stemPlDr ! vts ! vtp  
    in 
    table { SF Sg NDat => stem + "д" ;
            SF Sg NAbl => stem + aas4 ! vts ;
            SF Pl NGen => stemPl + iin2 ! vtp ;
            SF Pl NAbl => stemPl + aas4 ! vtp ;
                   sf => nSgPl ! sf } ;

 modDcl02e : Dcl -> Dcl = \dcl -> \stem,stemDr,stemPl,stemPlDr -> \\vts,vtp => 
    let
    nSgPl  = (modDcl02b dcl) stem stemDr stemPl stemPlDr ! vts ! vtp  
    in 
    table { SF Pl NDat => stemPl + "т" ;
                   sf => nSgPl ! sf } ;


-- Slower with optimize=noexpand:
            
 mkDecl : Bool => Dcl -> Str -> Noun = \\drop => \dcl -> \stem ->
    let 
	stemDr   = case drop of { False => stem ; _ => dropUnstressedVowel stem } ;
	stemPl   = plSuffix stem ;
    stemPlDr = case drop of { False => stemPl ; _ => dropUnstressedVowel stemPl } ;
    vts      = vowelType stem ;
    vtp      = case stemPl of {"" => MascA ;
                               _ + ("үүд"|"ууд") => vowelType (uud2!vts) ; 
                               _ => vowelType stemPl } 
	in			 
    { s = (dcl stem stemDr stemPl stemPlDr) ! vts ! vtp } ;
    
 mkDeclDrop   : Dcl -> Str -> Noun = (mkDecl ! True) ;
 mkDeclNoDrop : Dcl -> Str -> Noun = (mkDecl ! False) ;
 
 mkDecl2 : Bool => Dcl -> Str -> Str -> Noun = \\drop => \dcl,stem,stemPl ->
    let 
	vts      = vowelType stem ;
    vtp      = vowelType stemPl ; 
    stemDr   = case drop of { False => stem ; _ => dropUnstressedVowel stem } ;
    stemPlDr = case drop of { False => stemPl ; _ => dropUnstressedVowel stemPl } 
    in			 
    { s = (dcl stem stemDr stemPl stemPlDr) ! vts ! vtp } ;
    
 mkDecl2Drop : Dcl -> Str -> Str -> Noun = (mkDecl2!True) ;
 mkDecl2NoDrop : Dcl -> Str -> Str -> Noun = (mkDecl2!False) ;

};

