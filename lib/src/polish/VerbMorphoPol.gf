--# -path=.:../prelude:../common:../abstract
--# -coding=utf8

-- A Polish verb Resource Morphology 
--
-- Adam Slaski, 2009 <adam.slaski@gmail.com>
--
resource VerbMorphoPol = ResPol ** open Prelude, CatPol, (Predef=Predef), (Adj=AdjectiveMorphoPol) in {

     flags  coding=utf8; 

-- 2 Conjugation classes

-- According to "Czasownik polski. Odmiana. Slownik." by Zygmunt Saloni 2001 
-- there are 106 schemes of verb inflection in Polish. I implement only 
-- these, which are necessery. Numeration as in mentioned book.

-- opers for the building of the whole paradigm of a verb
-- in all tenses

  oper ConjCl : Type = Str -> { s:VFormM => Str; p:adj11table };

  oper conj1 : ConjCl = 
    \byc -> 
    mkRegItConjCl byc "" "bądź" "bądźmy" "bądźcie" "jestem" "jesteś" "jest" "jesteśmy" "jesteście" "są" "był" "była" "było" "byli" "były";

  oper conj3 : ConjCl = 
    \zastac -> let zasta = Predef.tk 1 zastac 
    in mkRegConjCl zastac zasta "ń" "ńmy" "ńcie" "nę" "niesz" "nie" "niemy" "niecie" "ną" "ł" "ła" "ło" "li" "ły" "n" "n";
  
  oper conj4 : ConjCl = 
    \chlonac -> let chlo = Predef.tk 3 chlonac
    in mkRegConjCl chlonac chlo "ń" "ńmy" "ńcie" "nę" "niesz" "nie" "niemy" "niecie" "ną" "nął" "nęła" "nęło" "nęli" "nęły" "nięt" "nięc";

  oper conj5 : ConjCl = 
    \ciagnac -> let ciagn = Predef.tk 2 ciagnac
    in mkRegConjCl ciagnac ciagn "ij" "ijmy" "ijcie" "ę" "iesz" "ie" "iemy" "iecie" "ą" "ął" "ęła" "ęło" "ęli" "ęły" "ięt" "ięc";

  oper conj6 : ConjCl = 
    \cisnac -> let ci = Predef.tk 4 cisnac
    in mkRegConjCl cisnac ci "śnij" "śnijmy" "śnijcie" "snę" "śniesz" "śnie" "śniemy" "śniecie" "sną" "snął" "snęła" "snęło" "snęli" "snęły" "śnięt" "śnięc";
  
  oper conj7 : ConjCl = 
    \brzeknac -> let brzek = Predef.tk 3 brzeknac
    in mkRegConjCl brzeknac brzek "nij" "nijmy" "nijcie" "nę" "niesz" "nie" "niemy" "niecie" "ną" "nął" "nęła" "nęło" "nęli" "nęły" "nięt" "nięc";
  
  oper conj15 : ConjCl = 
    \biec -> let bie = Predef.tk 1 biec
    in mkRegConjCl biec bie "gnij" "gnijmy" "gnijcie" "gnę" "gniesz" "gnie" "gniemy" "gniecie" "gną" "gł" "gła" "gło" "gli" "gły" "gnięt" "gnięc";

  oper conj17 : ConjCl = 
    \krasc -> let kra = Predef.tk 2 krasc
    in mkRegConjCl krasc kra "dnij" "dnijmy" "dnijcie" "dnę" "dniesz" "dnie" "dniemy" "dniecie" "dną" "dł" "dła" "dło" "dli" "dły" "dnięt" "dnięc";

  oper conj23 : ConjCl = 
    \ciac -> 
    mkRegConjCl ciac "" "tnij" "tnijmy" "tnijcie" "tnę" "tniesz" "tnie" "tniemy" "tniecie" "tną" "ciął" "cięła" "cięło" "cięli" "cięły" "cięt" "cięc";

  oper conj25 : ConjCl = 
    \klasc -> let kla = Predef.tk 2 klasc 
    in mkRegConjCl klasc kla "dź" "dźmy" "dźcie" "dę" "dziesz" "dzie" "dziemy" "dziecie" "dą" "dł" "dła" "dło" "dli" "dły" "dzion" "dzen";

  oper conj26a : ConjCl = 
    \gryzc -> let gry = Predef.tk 2 gryzc 
    in mkRegConjCl gryzc gry "ź" "źmy" "źcie" "zę" "ziesz" "zie" "ziemy" "ziecie" "zą" "zł" "zła" "zło" "źli" "zły" "zion" "zien";

  oper conj27 : ConjCl = 
    \wzmoc -> let wzm = Predef.tk 2 wzmoc 
    in mkRegConjCl wzmoc wzm "óż" "óżmy" "óżcie" "ogę" "ożesz" "oże" "ożemy" "ożecie" "ogą" "ógł" "ogła" "ogło" "ogli" "ogły" "ożon" "ożen";
  
  oper conj40 : ConjCl = 
    \znalezc -> let zna = Predef.tk 4 znalezc 
    in mkRegConjCl znalezc zna "jdź" "jdźmy" "jdźcie" "jdę" "jdziesz" "jdzie" "jdziemy" "jdziecie" "jdą" "lazł" "lazła" "lazło" "leźli" "lazły" "lezion" "lezien";

  oper conj41 : ConjCl = 
    \przyjsc -> let przy = Predef.tk 3 przyjsc 
    in mkRegItConjCl przyjsc przy "jdź" "jdźmy" "jdźcie" "jdę" "jdziesz" "jdzie" "jdziemy" "jdziecie" "jdą" "szedł" "szła" "szło" "szli" "szły";
    
  oper conj41a : ConjCl = 
    \isc -> 
    mkRegItConjCl isc "" "idź" "idźmy" "idźcie" "idę" "idziesz" "idzie" "idziemy" "idziecie" "idą" "szedł" "szła" "szło" "szli" "szły";
    
  oper conj42 : ConjCl = 
    \pojsc -> 
    mkRegItConjCl pojsc "p" "ójdź" "ójdźmy" "ójdźcie" "ójdę" "ójdziesz" "ójdzie" "ójdziemy" "ójdziecie" "ójdą" "oszedł" "oszła" "oszło" "oszli" "oszły";
  
  oper conj43 : ConjCl = 
    \trzec -> let t = Predef.tk 4 trzec
    in mkRegConjCl trzec t "rzyj" "rzyjmy" "rzyjcie" "rę" "rzesz" "rze" "rzemy" "rzecie" "rą" "arł" "arła" "arło" "arli" "arły" "art" "arc";
    
  oper conj45 : ConjCl = 
    \zechciec -> let zechc = Predef.tk 3 zechciec
    in mkRegConjCl zechciec zechc "iej" "iejmy" "iejcie" "ę" "esz" "e" "emy" "ecie" "ą" "iał" "iała" "iało" "ieli" "iały" "ian" "en";

  oper conj51 : ConjCl = 
    \bic -> let bi = Predef.tk 1 bic 
    in mkRegConjCl bic bi "j" "jmy" "jcie" "ję" "jesz" "je" "jemy" "jecie" "ją" "ł" "ła" "ło" "li" "ły" "t" "c";

  oper conj52 : ConjCl = 
    \siac -> let si = Predef.tk 2 siac 
    in mkRegConjCl siac si "ej" "ejmy" "ejcie" "eję" "ejesz" "eje" "ejemy" "ejecie" "eją" "ał" "ała" "ało" "ali" "ały" "an" "an";

  oper conj53 : ConjCl = 
    \ratowac -> let rat = Predef.tk 4 ratowac 
    in mkRegConjCl ratowac rat "uj" "ujmy" "ujcie" "uję" "ujesz" "uje" "ujemy" "ujecie" "ują" "ował" "owała" "owało" "owali" "owały" "owan" "owan";
    
  oper conj54 : ConjCl = 
    \skazywac -> let skaz = Predef.tk 4 skazywac 
    in mkRegConjCl skazywac skaz "uj" "ujmy" "ujcie" "uję" "ujesz" "uje" "ujemy" "ujecie" "ują" "ywał" "ywała" "ywało" "ywali" "ywały" "ywan" "ywan";
  
  oper conj57 : ConjCl = 
    \dawac -> let da = Predef.tk 3 dawac
    in mkRegConjCl dawac da "waj" "wajmy" "wajcie" "ję" "jesz" "je" "jemy" "jecie" "ją" "wał" "wała" "wało" "wali" "wały" "wan" "wan";

  oper conj59 : ConjCl = 
    \wiazac -> let wia = Predef.tk 3 wiazac
    in mkRegConjCl wiazac wia "ż" "żmy" "żcie" "żę" "żesz" "że" "żemy" "żecie" "żą" "zał" "zała" "zało" "zali" "zały" "zan" "zan";

  oper conj60 : ConjCl = 
    \pisac -> let pis = Predef.tk 2 pisac 
    in mkRegConjCl pisac pis "z" "zmy" "zcie" "zę" "zesz" "ze" "zemy" "zecie" "zą" "ał" "ała" "ało" "ali" "ały" "an" "an";

  oper conj61 : ConjCl = 
    \plukac -> let plu = Predef.tk 3 plukac 
    in mkRegConjCl plukac plu "cz" "czmy" "czcie" "czę" "czesz" "cze" "czemy" "czecie" "czą" "kał" "kała" "kało" "kali" "kały" "kan" "kan";

  oper conj65 : ConjCl = 
    \rwac -> let rw = Predef.tk 2 rwac 
    in mkRegConjCl rwac rw "ij" "ijmy" "ijcie" "ę" "iesz" "ie" "iemy" "iecie" "ą" "ał" "ała" "ało" "ali" "ały" "an" "an";
    
  oper conj67 : ConjCl = 
    \wyslac -> let wy = Predef.tk 4 wyslac 
    in mkRegConjCl wyslac wy "ślij" "ślijmy" "ślijcie" "ślę" "ślesz" "śle" "ślemy" "ślecie" "ślą" "słał" "słała" "słało" "słali" "słały" "słan" "słan";

  oper conj70 : ConjCl = 
    \kopac -> let kop = Predef.tk 2 kopac 
    in mkRegConjCl kopac kop "" "my" "cie" "ię" "iesz" "ie" "iemy" "iecie" "ią" "ał" "ała" "ało" "ali" "ały" "an" "an";

  oper conj72 : ConjCl = 
    \kupic -> let kup = Predef.tk 2 kupic 
    in mkRegConjCl kupic kup "" "my" "cie" "ię" "isz" "i" "imy" "icie" "ią" "ił" "iła" "iło" "ili" "iły" "ion" "ien";
    
  oper conj72em : ConjCl = 
    \lubic -> let lub = Predef.tk 2 lubic 
    in mkRegConjCl lubic lub "" "my" "cie" "ię" "isz" "i" "imy" "icie" "ią" "ił" "iła" "iło" "ili" "iły" "ian" "ian";
  
  oper conj75 : ConjCl = 
    \dzielic -> let dziel = Predef.tk 2 dzielic 
    in mkRegConjCl dzielic dziel "" "my" "cie" "ę" "isz" "i" "imy" "icie" "ą" "ił" "iła" "iło" "ili" "iły" "on" "en";
  
  oper conj77 : ConjCl = 
    \robic -> let r = Predef.tk 4 robic 
    in mkRegConjCl robic r "ób" "óbmy" "óbcie" "obię" "obisz" "obi" "obimy" "obicie" "obią" "obił" "obiła" "obiło" "obili" "obiły" "obion" "obien";

  oper conj77a : ConjCl = 
    \stanowic -> let stan = Predef.tk 4 stanowic 
    in mkRegConjCl stanowic stan "ów" "ówmy" "ówcie" "owię" "owisz" "owi" "owimy" "owicie" "owią" "owił" "owiła" "owiło" "owili" "owiły" "owion" "owien";
  
  oper conj80 : ConjCl = 
    \budzic -> let bud = Predef.tk 3 budzic 
    in mkRegConjCl budzic bud "ź" "źmy" "źcie" "zę" "zisz" "zi" "zimy" "zicie" "zą" "ził" "ziła" "ziło" "zili" "ziły" "zon" "zen";
  
  oper conj81 : ConjCl = 
    \tracic -> let tra = Predef.tk 3 tracic 
    in mkRegConjCl tracic tra "ć" "ćmy" "ćcie" "cę" "cisz" "ci" "cimy" "cicie" "cą" "cił" "ciła" "ciło" "cili" "ciły" "con" "cen";
  
  oper conj83 : ConjCl = 
    \prosic -> let pro = Predef.tk 3 prosic 
    in mkRegConjCl prosic pro "ś" "śmy" "ście" "szę" "sisz" "si" "simy" "sicie" "szą" "sił" "siła" "siło" "sili" "siły" "szon" "szen";
  
  oper conj84 : ConjCl = 
    \opuscic -> let opu = Predef.tk 4 opuscic 
    in mkRegConjCl opuscic opu "ść" "śćmy" "śćcie" "szczę" "ścisz" "ści" "ścimy" "ścicie" "szczą" "ścił" "ściła" "ściło" "ścili" "ściły" "szczon" "szczen";
  
  oper conj87 : ConjCl = 
    \meczyc -> let mecz = Predef.tk 2 meczyc
    in mkRegConjCl meczyc mecz "" "my" "cie" "ę" "ysz" "y" "ymy" "ycie" "ą" "ył" "yła" "yło" "yli" "yły" "on" "en";
  
  oper conj88 : ConjCl = 
    \tworzyc -> let tw = Predef.tk 5 tworzyc
    in mkRegConjCl tworzyc tw "órz" "órzmy" "órzcie" "orzę" "orzysz" "orzy" "orzymy" "orzycie" "orzą" "orzył" "orzyła" "orzyło" "orzyli" "orzyły" "orzon" "orzen";
  
  oper conj88a : ConjCl = --wlozyc
    \tworzyc -> let tw = Predef.tk 5 tworzyc
    in mkRegConjCl tworzyc tw "óż" "óżmy" "óżcie" "ożę" "ożysz" "oży" "ożymy" "ożycie" "ożą" "ożył" "ożyła" "ożyło" "ożyli" "ożyły" "ożon" "ożen";
      
  oper conj90 : ConjCl = 
    \myslec -> let mys = Predef.tk 3 myslec
    in mkRegConjCl myslec mys "l" "lmy" "lcie" "lę" "lisz" "li" "limy" "licie" "lą" "lał" "lała" "lało" "leli" "lały" "lan" "lan";
  
  oper conj91 : ConjCl = 
    \pomniec -> let pomn = Predef.tk 3 pomniec
    in mkRegConjCl pomniec pomn "ij" "ijmy" "ijcie" "ę" "isz" "i" "imy" "icie" "ą" "iał" "iała" "iało" "ieli" "iały" "ian" "ian";
  
  oper conj92 : ConjCl = 
    \widziec -> let wid = Predef.tk 4 widziec
    in mkRegConjCl widziec wid "ź" "źmy" "źcie" "zę" "zisz" "zi" "zimy" "zicie" "zą" "ział" "ziała" "ziało" "zieli" "ziały" "zian" "zian";
  
  oper conj93 : ConjCl = 
    \wisiec -> let wi = Predef.tk 4 wisiec
    in mkRegConjCl wisiec wi "ś" "śmy" "ście" "szę" "sisz" "si" "simy" "sicie" "szą" "siał" "siała" "siało" "sieli" "siały" "sian" "szen";
  
  oper conj94 : ConjCl = 
    \slyszec -> let slysz = Predef.tk 2 slyszec
    in mkRegConjCl slyszec slysz "" "my" "cie" "ę" "ysz" "y" "ymy" "ycie" "ą" "ał" "ała" "ało" "eli" "ały" "an" "an";
  
  oper conj94a : ConjCl = 
    \obejrzec -> let obejrz = Predef.tk 2 obejrzec
    in mkRegConjCl obejrzec obejrz "yj" "yjmy" "yjcie" "ę" "ysz" "y" "ymy" "ycie" "ą" "ał" "ała" "ało" "eli" "ały" "an" "an";
  
  oper conj95 : ConjCl = 
    \wystac -> let wyst = Predef.tk 2 wystac
    in mkRegConjCl wystac wyst "ój" "ójmy" "ójcie" "oję" "oisz" "oi" "oimy" "oicie" "oją" "ał" "ała" "ało" "ali" "ały" "an" "an";
  
  oper conj96 : ConjCl = 
    \spac -> 
    mkRegConjCl spac "" "śpij" "śpijmy" "śpijcie" "śpię" "śpisz" "śpi" "śpimy" "śpicie" "śpią" "spał" "spała" "spało" "spali" "spały" "span" "span";
  
  oper conj98 : ConjCl = 
    \pytac -> let pyta = Predef.tk 1 pytac 
    in mkRegConjCl pytac pyta "j" "jmy" "jcie" "m" "sz" "" "my" "cie" "ją" "ł" "ła" "ło" "li" "ły" "n" "n";

  oper conj99 : ConjCl = 
    \dac -> let da = Predef.tk 1 dac 
    in mkRegConjCl dac da "j" "jmy" "jcie" "m" "sz" "" "my" "cie" "ją" "ł" "ła" "ło" "li" "ły" "n" "n";
  
  oper conj100 : ConjCl = 
    \miec -> let m = Predef.tk 3 miec
    in mkRegConjCl miec m "iej" "iejmy" "iejcie" "am" "asz" "a" "amy" "acie" "ają" "iał" "iała" "iało" "ieli" "iały" "ian" "ian";

  oper conj101 : ConjCl = 
    \rozumiec -> let rozumi = Predef.tk 2 rozumiec
    in mkRegConjCl rozumiec rozumi "ej" "ejmy" "ejcie" "em" "esz" "e" "emy" "ecie" "eją" "ał" "ała" "ało" "eli" "ały" "an" "an";

  oper conj102 : ConjCl = 
    \jesc -> let j = Predef.tk 3 jesc 
    in mkRegConjCl jesc j "edz" "edzmy" "edzcie" "em" "esz" "e" "emy" "ecie" "dzą" "adł" "adła" "adło" "edli" "adły" "edzon" "edzen";
      
  oper conj103 : ConjCl = 
    \wiedziec -> let wie = Predef.tk 5 wiedziec
    in mkRegConjCl wiedziec wie "dz" "dzmy" "dzcie" "m" "sz" "" "my" "cie" "dzą" "dział" "działa" "działo" "dzieli" "działy" "dzian" "dzian";

  oper conjbac : ConjCl = \_->
    mkRegConjCl "bać" "b" "ój" "ójmy" "ójcie" "oję" "oisz" "oi" "oimy" "oicie" "oją" "ał" "ała" "ało" "ali" "ały" "an" "an";

  oper mkRegItConjCl : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> 
    Str -> Str -> ConjCl;
  oper mkRegItConjCl pytac pyta j jmy jcie m sz sg3 my cie ja l la lo li ly = {
    s = mkVerbTable pytac pyta j jmy jcie m sz sg3 my cie ja l la lo li ly;
    p = record2table { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "["++pytac ++ [": the participle form does not exist]"] };
  };
    
  oper mkRegConjCl : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> 
    Str -> Str -> Str -> Str -> ConjCl;
  oper mkRegConjCl pytac pyta j jmy jcie m sz sg3 my cie ja l la lo li ly n npl = {
    s = mkVerbTable pytac pyta j jmy jcie m sz sg3 my cie ja l la lo li ly;
    p = record2table (Adj.model4 (pyta+n+"y") (pyta+npl+"i"))
  };
    
  oper mkVerbTable : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> 
    Str -> Str -> Str -> VFormM =>Str;
  oper mkVerbTable pytac pyta j jmy jcie m sz sg3 my cie ja l la lo li ly = 
    table {
      VInfM => pytac;
      VImperSg2M => pyta + j;
	  VImperPl1M => pyta + jmy;
	  VImperPl2M => pyta + jcie;
	  VFinM Sg P1 => pyta + m;
	  VFinM Sg P2 => pyta + sz;
	  VFinM Sg P3 => pyta + sg3;
	  VFinM Pl P1 => pyta + my;
	  VFinM Pl P2 => pyta + cie;
	  VFinM Pl P3 => pyta + ja;
	  VPraetM (MascPersSg|MascAniSg|MascInaniSg) P1 => pyta + l + "em";
	  VPraetM (MascPersSg|MascAniSg|MascInaniSg) P2 => pyta + l + "eś";
	  VPraetM (MascPersSg|MascAniSg|MascInaniSg) P3 => pyta + l;
	  VPraetM MascPersPl P1  => pyta + li + "śmy";
	  VPraetM MascPersPl P2  => pyta + li + "ście";
	  VPraetM MascPersPl P3  => pyta + li;
	  VPraetM FemSg P1       => pyta + la + "m";
	  VPraetM FemSg P2       => pyta + la + "ś";
	  VPraetM FemSg P3       => pyta + la;
	  VPraetM NeutSg P1     => pyta + lo + "m";
	  VPraetM NeutSg P2     => pyta + lo + "ś";
	  VPraetM NeutSg P3     => pyta + lo;
	  VPraetM OthersPl P1    => pyta + ly + "śmy";
	  VPraetM OthersPl P2    => pyta + ly + "ście";
	  VPraetM OthersPl P3    => pyta + ly;
	  VCondM (MascPersSg|MascAniSg|MascInaniSg) P1 => pyta + l + "by" + "m";
	  VCondM (MascPersSg|MascAniSg|MascInaniSg) P2 => pyta + l + "by" + "ś";
	  VCondM (MascPersSg|MascAniSg|MascInaniSg) P3 => pyta + l + "by";
	  VCondM MascPersPl P1  => pyta + li + "by" + "śmy";
	  VCondM MascPersPl P2  => pyta + li + "by" + "ście";
	  VCondM MascPersPl P3  => pyta + li + "by" ;
	  VCondM FemSg P1       => pyta + la + "by" + "m";
	  VCondM FemSg P2       => pyta + la + "by" + "ś";
	  VCondM FemSg P3       => pyta + la + "by" ;
	  VCondM NeutSg P1     => pyta + lo + "by" + "m";
	  VCondM NeutSg P2     => pyta + lo + "by" + "ś";
	  VCondM NeutSg P3     => pyta + lo + "by" ;
	  VCondM OthersPl P1    => pyta + ly + "by" + "śmy";
	  VCondM OthersPl P2    => pyta + ly + "by" + "ście";
	  VCondM OthersPl P3    => pyta + ly + "by" 
   };

-- 3 Verb types definition   

  mkV : Str ->  ConjCl -> Str ->  ConjCl -> Verb; 
  mkV = mkVerb;	   
  
  mkV1 : Str ->  ConjCl -> Str ->  ConjCl -> Verb; 
  mkV1 s c s2 c2 = mkItVerb (mkVerb s c s2 c2);	   

  
-- reflexive verbs
  
  oper mkReflVerb : Verb -> Verb = 
	 \v -> 
	 {si = v.si;
	  sp = v.sp;
	  refl = "się";
	  asp = v.asp;
	  ppartp =  v.ppartp;
	  pparti =  v.pparti
	 };
 
-- intransitive verbs

  oper mkItVerb : Verb -> Verb = 
	 \v -> 
	 {si = v.si;
	  sp = v.sp;
	  refl = v.refl;
	  asp = v.asp;
	  ppartp = record2table { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "["++v.si!VInfM ++ [": the participle form does not exist]"]};
	  pparti = record2table { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "["++v.si!VInfM ++ [": the participle form does not exist]"]}
	 };
	 
-- monoaspective verbs

  oper mkMonoVerb : Str -> ConjCl -> Aspect -> Verb = 
	 \s, c, a -> let tmp = (c s) in 
	 {si = tmp.s;
	 sp = tmp.s; 
	 refl = "";
	 asp = a;
	 ppartp = tmp.p;
	 pparti = tmp.p
	 };

-- normal verbs
  
  oper mkVerb : Str -> ConjCl -> Str -> ConjCl -> Verb = 
	 \s, c, s2, c2 -> let tmpp = (c2 s2); tmpi = (c s) in 
	 {si = tmpi.s;
	 sp = tmpp.s;
	 refl = "";
	 asp = Dual;
	 ppartp = tmpp.p;
	 pparti = tmpi.p
	 };

-- Comlicated verbs
-- Comlicated verbs like 'mieć nadzieję' ('to hope'). Sometimes happens that English verb
-- can't be translated directly into one Polish word, so I introduced this (little bit
-- unnatural) construction.

  oper mkComplicatedVerb : Verb -> Str -> Verb = 
	 \v,s -> 
	 {si = \\form => v.si !form ++ s;
	 sp = \\form => v.sp !form ++ s;
	 refl = v.refl; asp = v.asp;
	 ppartp = record2table { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "["++v.si!VInfM ++s++ [": the participle form does not exist]"]};
	 pparti = record2table { s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 = "["++v.si!VInfM ++s++ [": the participle form does not exist]"]}
	 };

  
-- Two-place verbs   
-- Two-place verbs, and the special case with a direct object. Note that
-- a particle can be included in a $V$.
  
  mkV2 : Verb -> Str -> Case -> V2;  
  mkV2 v p cas = v ** { c = mkCompl p cas; lock_V2 = <>}; 
  
  mkV3 : Verb -> Str -> Str -> Case -> Case -> V3; 
  mkV3 v s1 s2 c1 c2 = v ** { c = mkCompl s1 c1; c2 = mkCompl s2 c2; lock_V3 = <>};  
  
  dirV2 : Verb -> V2; -- a typical case ie. "kochać", "pisać"
  dirV2 v = mkV2 v [] Acc;

  dirV3 : Verb -> V3; -- a typical case ie. "zabrać", "dać"
  dirV3 v = mkV3 v "" "" Acc Dat; 
	   
    indicative_form : Verb -> Bool -> Polarity -> Tense * Anteriority * GenNum * Person => Str;
    indicative_form verb imienne pol = 
        case imienne of {True => imienne_form verb pol; False => 
            let nie = case pol of { Pos => "" ; Neg => "nie" }; in
            let sie = verb.refl; in
            let perf = verb.sp; in
            let imperf = verb.si; in
            table {
                <Pres, Simul, gn, p>   =>  nie ++ imperf ! (VFinM (extract_num!gn) p) ++ sie ;
                <Pres, Anter, gn, p>   =>  nie ++ perf   ! (VPraetM gn p) ++ sie ;
                <Past, _, gn, p>       =>  nie ++ perf   ! (VPraetM gn p) ++ sie ;
                <Fut, Simul, gn, p>    =>  nie ++ bedzie ! <(extract_num!gn), p> ++ sie ++ imperf ! (VPraetM gn P3);
                <Fut, Anter, gn, p>    =>  nie ++ perf ! (VFinM (extract_num!gn) p) ++ sie;
                <Cond, Simul, gn, p>   =>  nie ++ imperf ! (VCondM gn p) ++ sie;
                <Cond, Anter, gn, p>   =>  nie ++ perf   ! (VCondM gn p) ++ sie
            }
        };
        
    imienne_form : Verb -> Polarity -> Tense * Anteriority * GenNum * Person => Str;
    imienne_form verb pol =
        let byc    = (case verb.asp of { Perfective   => conj3 "zostać"; _ => conj1 "być"    }).s; in
        let zostac = (case verb.asp of { Imperfective => conj1 "być";    _ => conj3 "zostać" }).s; in
        let nie = case pol of { Pos => "" ; Neg => "nie" }; in
        table {
            <Pres, Simul, gn, p> => nie ++ byc ! (VFinM (extract_num!gn) p) ++ (mkAtable (table2record verb.pparti)) ! AF gn Nom;
            <Pres, Anter, gn, p> => nie ++ zostac ! (VPraetM gn p) ++ (mkAtable (table2record verb.ppartp)) ! AF gn Nom;
            <Past, Simul, gn, p> => nie ++ byc ! (VPraetM gn p) ++ (mkAtable (table2record verb.pparti)) ! AF gn Nom;
            <Past, Anter, gn, p> => nie ++ zostac ! (VPraetM gn p) ++ (mkAtable (table2record verb.ppartp)) ! AF gn Nom;
            <Fut,  Simul, gn, p> => nie ++ case verb.asp of {
                Perfective => zostac ! (VFinM (extract_num!gn) p) ++ (mkAtable (table2record verb.ppartp)) ! AF gn Nom;
                _          => bedzie ! <extract_num!gn, p>  ++ (mkAtable (table2record verb.pparti)) ! AF gn Nom
            };
            <Fut,  Anter, gn, p> => nie ++ zostac ! (VFinM (extract_num!gn) p) ++ (mkAtable (table2record verb.ppartp)) ! AF gn Nom;
            <Cond, Simul, gn, p> => nie ++ byc ! (VCondM gn p) ++ (mkAtable (table2record verb.pparti)) ! AF gn Nom;
            <Cond, Anter, gn, p> => nie ++ zostac ! (VCondM gn p) ++ (mkAtable (table2record verb.ppartp)) ! AF gn Nom
        };
            
    bedzie : Number * Person => Str = table {
        <Sg, P1> => "będę";
        <Sg, P2> => "będziesz";
        <Sg, P3> => "będzie";
        <Pl, P1> => "będziemy";
        <Pl, P2> => "będziecie";
        <Pl, P3> => "będą"
    };
    
    imperative_form : Verb -> Bool -> Polarity ->  GenNum -> Person -> Str;
    imperative_form verb imienne pol gn p = 
        case imienne of {
            True =>
                let badz   = (case verb.asp of { Perfective   => zostan_op; _ => badz_op   })!<(extract_num!gn), p> in
                let zostan = (case verb.asp of { Imperfective => badz_op;   _ => zostan_op })!<(extract_num!gn), p> in
                case pol of {
                    Pos => badz ++ (mkAtable (table2record verb.pparti))! AF gn Nom;
                    Neg => "nie" ++ zostan ++ (mkAtable (table2record verb.ppartp))! AF gn Nom
                };
            False => 
                let sie = verb.refl; in
                case pol of {
                    Pos => case <(extract_num!gn), p> of {
                        <Sg, P1> => "niech" ++ sie ++ verb.sp ! VFinM Sg P1;
                        <Sg, P2> => verb.sp ! VImperSg2M ++ sie;
                        <Sg, P3> => "niech" ++ sie ++ verb.sp ! VFinM Sg P3;
                        <Pl, P1> => verb.sp ! VImperPl1M ++ sie;
                        <Pl, P2> => verb.sp ! VImperPl2M ++ sie;
                        <Pl, P3> => "niech" ++ sie ++ verb.sp ! VFinM Pl P3
                    } ;
                    Neg => case <(extract_num!gn), p> of {
                        <Sg, P1> => "niech" ++ sie ++ "nie" ++ verb.si ! VFinM Sg P1;
                        <Sg, P2> => "nie" ++ verb.si ! VImperSg2M ++ sie;
                        <Sg, P3> => "niech" ++ sie ++ "nie"  ++ verb.si ! VFinM Sg P3;
                        <Pl, P1> => "nie" ++ verb.si ! VImperPl1M ++ sie;
                        <Pl, P2> => "nie" ++ verb.si ! VImperPl2M ++ sie;
                        <Pl, P3> => "niech" ++ sie ++ "nie" ++ verb.si ! VFinM Pl P3
                    }
                }
        };
        
    infinitive_form : Verb -> Bool -> Polarity ->  Str;
    infinitive_form verb imienne pol = 
        case imienne of {
            True =>
                let byc = case verb.asp of { Perfective   => "zostać"; _ => "być" }; in
                case pol of {
                    Pos => byc ++ (mkAtable (table2record verb.pparti))! AF MascPersSg Nom;
                    Neg => "nie" ++ byc ++ (mkAtable (table2record verb.pparti))! AF MascPersSg Nom
                    };
            False => 
                let sie = verb.refl; in
                case pol of {
                    Pos => verb.sp ! VInfM ++ sie;
                    Neg => "nie" ++ verb.si ! VInfM ++ sie
                }
        };
  
        
    badz_op : Number * Person => Str = table {
        <Sg, P1> => ["niech będę"];
        <Sg, P2> => ["bądź"];
        <Sg, P3> => ["niech będzie"];
        <Pl, P1> => ["bądźmy"];
        <Pl, P2> => ["bądźcie"];
        <Pl, P3> => ["niech będą"]
    };
    
    zostan_op : Number * Person => Str = table {
        <Sg, P1> => ["niech zostanę"];
        <Sg, P2> => ["zostań"];
        <Sg, P3> => ["niech zostanie"];
        <Pl, P1> => ["zostańmy"];
        <Pl, P2> => ["zostańcie"];
        <Pl, P3> => ["niech zostaną"]
    };

    jest_op : GenNum * Person * Tense * Anteriority => Str = 
      let byc =  (conj1 "być").s in table {
        <gn, p, Pres, Simul> => byc ! (VFinM (extract_num!gn) p);
        <gn, p, Pres, Anter> => byc ! (VPraetM gn p);
        <gn, p, Past, _    > => byc ! (VPraetM gn p);
        <gn, p, Fut , _    > => bedzie ! <(extract_num!gn), p>;
        <gn, p, Cond, _    > => byc ! (VCondM gn p)
      };

    niema_op : Tense * Anteriority => Str = 
      let byc =  conj1 "być" in table {
        <Pres, Simul> => ["nie ma"];
        <Pres, Anter> => ["nie było"];
        <Past, _    > => ["nie było"];
        <Fut , _    > => ["nie będzie"];
        <Cond, _    > => ["nie byłoby"]
      };

}
