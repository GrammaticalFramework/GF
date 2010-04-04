--# -path=.:../abstract:../prelude:../common

--0 Polish Lexical Paradigms

-- Ilona Nowak Wintersemester 2007/08  

-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
 
-- Closed categories ( pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
-- For german and english grammar determiners are defined as 
-- closed categories in the file StructuralPol.gf.
-- In Polish language they aren't determiners.

-- The main difference between $MorphoPol.gf$ and $ParadigmsPol.gf$ is that the types 
-- referred to are compiled resource grammar types. I have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.

-- The structure of functions for each word class $C$ is the following:
-- first I give a handful of patterns that aim to cover all
-- regular cases. Then I give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
 
-- The following modules are presupposed:


   resource ParadigmsPol = open 
     (Predef=Predef), 
     Prelude, 
     MorphoPol,
     CatPol
  in 
     {
  flags  coding=utf8 ;


 oper Gender = MorphoPol.Gender ;
      Case = MorphoPol.Case ;
      Number = MorphoPol.Number ;
      Animacy = MorphoPol.Animacy ;
      Aspect = MorphoPol.Aspect ;
--       Voice = MorphoPol.Voice ;
--  Tense = Tense ;
      Bool = Prelude.Bool ;


-- Used abbreviations 

      masculineA = Masc Animate ;
      masculineI = Masc Inanimate ;
      masculineP = Masc Personal ;
      feminine  = Fem ;
      neuter = Neut ;
      nominative = Nom ;
      genitive = Gen ;
      dative = Dat ;
      accusative = Acc ;
      instrumental = Instr ; -- new, is like instrumental in russian
      locative = Loc ; -- new, is like prepositional in russian
      vocative = VocP ;
      singular = Sg ;
      plural = Pl ;
      animate = Animate ;
      inanimate = Inanimate ;
      personal = Personal ;

      true = True ;
      false = False ;
            
--1 Nouns

--  Parameters  --------

    Gender : Type ;

    masculineP : Gender ; -- personal
    masculineA : Gender ; -- animate
    masculineI : Gender ; -- inanimate
    feminine   : Gender ;
    neuter     : Gender ;

-- In Polish there are as in German 3 Genders: masculine, feminine and neuter.
-- But !!! in masculine declension we distinguish between:
-- a) masculineP - human, but !!! they are only masculine person:
-- f.e."mężczyzna" (man),"myśliwy" (hunter), "student" (student), 
-- "brat" (brother), "ksiądz" (pastor)),
-- b) animate (they are animals),
-- c) inanimate (all other nouns, "kobieta" (women), "dziewczyna" (girl) too.)
-- For declension of feminine and neuter nouns, it is not important,
-- if the noun is human, nonhuman, animate or inanimate. 
-- Only for masculine declension.


-- Animacy is only for masculine Nouns.
    Animacy: Type ; 
    
    animate: Animacy ;
    inanimate: Animacy ; 
    personal : Animacy ;


    Case : Type ;

    nominative    : Case ;
    genitive      : Case ;
    dative        : Case ;
    accusative    : Case ; 
    instrumental  : Case ;
    locative      : Case ;
    vocative      : Case ;    

-- To abstract over case names, I defined seven cases.
-- The seventh case vocative is like in english the phrase
-- vocative f.e. "my darling". Vocative is defined in GF, 
-- so I'll define it here for Polish again, 
-- but later in the programs I will use the abbreviation VocP for it,.
-- otherwise the program will create a problem.
-- I had to do it, because it can't differ from
-- polish case vocative and the vocative form, that is defined in GF.

                 
-- To abstract over number names, I define the following.
    Number : Type ;

    singular : Number ;
    plural   : Number ;


--1 Paradigms

-- Best case is for indeclinable nouns. They are: "alibi", "boa", "emu", "jury", "kakao", "menu", "zebu".

  mkIndeclinableNoun: Str -> Gender -> N ; --function declaration
  
  mkIndeclinableNoun = \str, g ->     -- function definition
  {
     s = table { SF _ _ => str } ;
     g = g 
  } ** {lock_N = <>} ;


-- Worst case gives many forms.

-- Here are some common patterns. The list is far from complete. 
-- Here will be handled only nouns, that are in GF-lexicon.
-- The very exact classification for polish nouns have 125 paradigms.
-- This information is from the internet site of Grzegorz Jagodziński
-- for polish grammar under http://free.of.pl/g/grzegorj/gram/pl/deklin04.htm

-------------------------------------------------
----- Abbreviation for names of declensions -----
-------------------------------------------------
-- VA1 - vowel alternation 1: o:ó, ó:o
-- VA2 - vowel alternation 2: a:e, e:o, ę:o, o:e
-- VA3 - vowel alternation 3: ę:ą, ą:ę
-- CA - consonant alternation
-- CL - consonant lengthening
-- CAL - consonant alternation and lengthening 
-- F - feminine
-- N - neuter
-- MP - masculine personal
-- MA - masculine animate
-- MI - masculine inanimate


---------- Patterns for feminine nouns ----------

  nKapiel : Str -> N ; -- feminine, subject ending in "-l"
  nKapiel = \s -> l_End_F_1 s ** {lock_N = <>} ; 

  nLodz : Str -> N ; -- feminine, subject ending in "-dź"
  nLodz = \x -> dzx_End_VA1_CAL_F x ** {lock_N = <>} ;
  
  nSul : Str -> N ; -- feminine, subject ending in "-l"
  nSul = \x -> l_End_VA1_F x ** {lock_N = <>} ;
             
  nKonew : Str -> N ; -- feminine, subject ending in "-w"
  nKonew = \s -> w_End_FleetingEminus_F s ** {lock_N = <>} ;

  nWies : Str -> N ; -- feminine, subject ending in "-ś"
  nWies = \x -> sx_End_CAL_FleetingIEminus_F x ** {lock_N = <>} ;

  nDlon : Str -> N ; -- feminine, subject ending in "-ń"
  nDlon = \x -> nx_End_CAL_F x ** {lock_N = <>} ;

  nSiec : Str -> N ; -- feminine, subject ending in "-ć" (sieć),"-ść" (miłość)
  nSiec = \x -> cx_End_CAL_F_1 x ** {lock_N = <>} ;

  nDrzwi : Str -> N ; -- drzwi, wnętrzności, usta
  nDrzwi = \x -> onlyPlNoun x ** {lock_N = <>} ;

  nKosc : Str -> N ; -- feminine, subject ending in "-ść"(kość), "-ć" (nić),
  nKosc = \x -> cx_End_CAL_F_2 x ** {lock_N = <>} ;

  nNoc : Str -> N ; -- feminine, subject ending in "-c", "-cz", "-rz", "-ż"
  nNoc = \s -> hardened_End_F_1 s ** {lock_N = <>} ;

  nWesz : Str -> N ; -- feminine, subject ending in "-sz"
  nWesz = \s -> sz_End_FleetingEminus_F s ** {lock_N = <>} ;

  nKrolowa : Str -> N ; -- feminine, subject ending in "-wa", but also for "księżna"
  nKrolowa = \s -> wa_na_End_F s ** {lock_N = <>} ;

  nReka : Str -> N ; -- feminine "ręka", irregularly noun
  nReka = \x -> k_End_Unregulary_VA3_CA_F x ** {lock_N = <>} ;

  nApteka : Str -> N ; -- feminine, subject ending in "-k", -"g", consonant alternation k:c, g:dz
  nApteka = \s -> g_k_End_CA_F s ** {lock_N = <>} ; 

  nDroga : Str -> N ; -- feminine, subject ending in "g", consonant alternation d:dz, vowel alternation o:ó
  nDroga = \s -> g_End_VA1_CA_F s ** {lock_N = <>} ;      
     
  nMatka : Str -> N ; -- feminine, subject ending in -k,consonant alternation k:c, fleeting e
  nMatka = \s -> k_End_CA_FleetingEplus_F s ** {lock_N = <>} ;

  nZiemia : Str -> N ; -- feminine, subject ending in "-ia"
  nZiemia = \s -> ia_End_F_1 s ** {lock_N = <>} ;

  nFala : Str -> N ; -- feminine, subject ending in "-l"
  nFala = \s -> l_End_F_2 s ** {lock_N = <>} ;

  nLilia : Str -> N ; -- feminine, subject ending in "-ia"
  nLilia = \s -> ia_End_F_2 s ** {lock_N = <>} ;

  nKobieta : Str -> N ; -- feminine, subject ending in "-t"
  nKobieta = \s -> hard_End_CAL_F s ** {lock_N = <>} ;

  nLiczba : Str -> N ; -- feminine, subject ending in "-b", "-p", "-n"
  nLiczba = \s -> hard_End_CL_F s ** {lock_N = <>} ;

  nSila : Str -> N ; -- feminine, subject ending in "-ł", "-r"
  nSila = \s -> hard_End_CA_F s ** {lock_N = <>} ;

  nDoba : Str -> N ; -- feminine, subject ending in "-b", "-p"
  nDoba = \s -> hard_End_VA1_CL_F s ** {lock_N = <>} ;

  nWoda : Str -> N ; -- feminine, subject ending in "-d"
  nWoda = \s -> hard_End_VA1_CAL_F s ** {lock_N = <>} ;

  nSzkola : Str -> N ; -- feminine, subject ending in "-oła", "-ra"
  nSzkola = \s -> hard_End_VA1_CA_F s ** {lock_N = <>} ;

  nWojna : Str -> N ; -- feminine, subject ending in two consonants: jn, łz, łn, ćm,żw 
  nWojna = \s -> hard_End_CL_FleetingEplus_F s ** {lock_N = <>} ;

  nWiosna : Str -> N ; -- feminine, subject ending in two consonants: sn 
  nWiosna = \s -> sn_End_CAL_FleetingIEplus_F s ** {lock_N = <>} ;

  nMgla : Str -> N ; -- feminine, subject ending in "-gł"
  nMgla = \x -> hard_l_End_CA_FleetingIEplus_F x ** {lock_N = <>} ;

  nGwiazda : Str -> N ; -- feminine, subject ending in "-zd"
  nGwiazda = \s -> zd_st_End_VA2_CAL_F s ** {lock_N = <>} ;

  nUlica : Str -> N ; -- feminine, subject ending mainly in "-c", but also in "-ż", "-rz", "-dz"
  nUlica = \s -> hardened_End_F_2 s ** {lock_N = <>} ;

  nOwca : Str -> N ; -- feminine, subject ending in "-c"
  nOwca = \x -> c_End_FleetingIEplus_F x ** {lock_N = <>} ;


-------- Patterns for neuter nouns ----------


  nDanie : Str -> N ; -- neuter, subject ending in "-ni"
  nDanie = \s -> ci_ni_week_End_CA_N s ** {lock_N = <>} ;

  nSerce : Str -> N ; -- neuter, subject ending in a hardened consonant "-c", "-rz"
  nSerce = \s -> hardened_End_N s ** {lock_N = <>} ;

  nNasienie : Str -> N ; -- neuter, subject ending in "-ni" (only for "nasienie")
  nNasienie = \x -> ni_End_VA2_N x ** {lock_N = <>} ;

  nMorze : Str -> N ; -- neuter, subject ending in "-rz", "-ż"
  nMorze = \x -> rz_zx_End_VA1_N x ** {lock_N = <>} ;

  nImie : Str -> N ; -- neuter, subject ending in "-ę"
  nImie = \x -> ex_End_VA2_N x ** {lock_N = <>} ;

  nCiele : Str -> N ; -- neuter, subject ending in "-ę"
  nCiele = \s -> ex_End_VA3_N s ** {lock_N = <>} ;

  nUdo : Str -> N ; -- neuter, subject ending in hard consonant + "o"
  nUdo = \s -> hard_End_CAL_N s ** {lock_N = <>} ;

  nPiwo : Str -> N ; -- neuter, subject ending in a hard consonant + "o"
  nPiwo = \s -> hard_End_CL_N s ** {lock_N = <>} ;

  nZero : Str -> N ; -- neuter, subject ending in "-r"
  nZero = \s -> r_End_CA_N s ** {lock_N = <>} ;

  nNiebo : Str -> N ; -- neuter, declension for "niebo"
  nNiebo = \x -> niebo_Unregulary_N x ** {lock_N = <>} ;

  nTlo : Str -> N ; -- neuter, subject ending in "-ło"
  nTlo = \s -> lx_End_CA_FleetingEplus_N s ** {lock_N = <>} ;

  nZebro : Str -> N ; -- neuter, subject ending in "-r"
  nZebro = \s -> hard_End_CA_FleetingEplus_N s ** {lock_N = <>} ;

  nOkno : Str -> N ; -- neuter, subject ending in "-n"
  nOkno = \s -> n_End_CL_FleetingIEplus_N s ** {lock_N = <>} ;
 
  nGniazdo : Str -> N ; -- neuter, subject ending in "-zd", "-st"
  nGniazdo = \s -> hard_End_VA_CAL_N s ** {lock_N = <>} ;

  nWojsko : Str -> N ; -- neuter, subject ending in "-k"
  nWojsko = \s -> k_End_CL_N s ** {lock_N = <>} ;

  nJajo : Str -> N ; -- neuter, subject ending in "-j"
  nJajo = \s -> j_End_N s ** {lock_N = <>} ;

  nJablko : Str -> N ; -- neuter, subject ending in "-k"
  nJablko = \s -> k_End_CL_FleetingEplus_N s ** {lock_N = <>} ;

  nStudio : Str -> N ; -- neuter, subject ending in "-n"
  nStudio = \s -> o_End_N s ** {lock_N = <>} ;

  nDziecko : Str -> N ; -- neuter, subject ending in "-n"
  nDziecko = \s -> k_End_CAL_N s ** {lock_N = <>} ;

  nUcho : Str -> N ; -- neuter, subject ending in "-ch"
  nUcho = \x -> ch_End_Unregulary_CA_N x ** {lock_N = <>} ;

  nOko : Str -> N ; -- neuter, subject ending in "-k"
  nOko = \x -> k_End_Unregulary_CAL_N x ** {lock_N = <>} ;


---- Patterns for personal masculine nouns ------

  nFacet : Str -> N ; -- masculine personal, subject ending in a hard consonant "-t", -"n", nom pl "-i"
  nFacet = \s -> hard_End_CAL_MP_1 s ** {lock_N = <>} ;

  nArab : Str -> N ; -- masculine personal, subject ending in a hard consonant "-t", -"n", nom pl "-y"
  nArab = \s -> hard_End_CAL_MP_2 s ** {lock_N = <>} ;

  nPrzyjaciel : Str -> N ; -- masculine personal, subject ending in a hard consonant "-l"
  nPrzyjaciel = \s -> przyjaciel_VA1_VA2_CA_MP s ** {lock_N = <>} ;

  nKowal : Str -> N ; -- masculine personal, subject ending in a hard consonant "-l"
  nKowal = \s -> l_End_MP s ** {lock_N = <>} ;

  nLekarz : Str -> N ; -- masculine personal ending in -rz, -ż, -cz, -sz (piekarz, lekarz, papież, tłumacz, piwosz)
  nLekarz = \s -> hardened_End_MP s ** {lock_N = <>} ;

  nKrol : Str -> N ; -- masculine personal, subject ending in "-ul"
  nKrol = \s -> ul_End_MP s ** {lock_N = <>} ;

  nMaz : Str -> N ; -- masculine personal
  nMaz = \s -> maz_MP s ** {lock_N = <>} ;

  nWrog : Str -> N ; -- masculine personal, subject ending in "-g" ; only for "wróg"
  nWrog = \s -> wrog_VA1_CL_MP s ** {lock_N = <>} ;

--  nCzlowiek : Str -> N ; -- masculine personal
--  nCzlowiek = \s -> ul_End_MP s ** {lock_N = <>} ;

  nKsiadz : Str -> N ; -- masculine personal
  nKsiadz = \s -> ksiadz_VA3_CA_MP s ** {lock_N = <>} ;

  nOjciec : Str -> N ; -- masculine personal for "ojciec"
  nOjciec = \s -> ciec_End_CA_FleetingIEminus_MP s ** {lock_N = <>} ;

  nBrat : Str -> N ; -- masculine personal
  nBrat = \s -> hard_End_CAL_MP s ** {lock_N = <>} ;

  nBog : Str -> N ; -- masculine personal
  nBog = \s -> bog_VA1_CAL_MP s ** {lock_N = <>} ;

  nChlopiec : Str -> N ; -- masculine personal
  nChlopiec = \s -> iec_End_CA_FleetingIEminus_MP s ** {lock_N = <>} ;

  nMezczyzna : Str -> N ; -- masculine personal
  nMezczyzna = \s -> zna_End_CAL_MP s ** {lock_N = <>} ;


------------------- Patterns for animate masculine nouns -------


  nKon : Str -> N ; -- masculine animate, for "koń"
  nKon = \s -> kon_CAL_MA s ** {lock_N = <>} ;

  nWaz : Str -> N ; -- masculine animate, for "wąż"
  nWaz = \s -> waz_VA3_MA s ** {lock_N = <>} ;
  
  nPtak : Str -> N ; -- masculine animate, subject ending in "-k"
  nPtak = \s -> k_End_CL_MA s ** {lock_N = <>} ;

  nKot : Str -> N ; -- masculine animate, for "kot"
  nKot = \s -> kot_CAL_MA s ** {lock_N = <>} ;

  nPies : Str -> N ; -- masculine animate, for "pies"
  nPies = \s -> pies_CL_FleetingIEminus_MA s ** {lock_N = <>} ;



------------------ Patterns for inanimate masculine nouns -----

 nBat : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nBat = \s -> vowel_hard_CAL_MI s ** {lock_N = <>} ;

 nChleb : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nChleb = \s -> vowel_hard_CL_MI s ** {lock_N = <>} ;

 nSer : Str -> N ; -- masculine inanimate, subject ending in "-r"
 nSer = \s -> r_End_CA_MI s ** {lock_N = <>} ;

 nZab : Str -> N ; -- masculine inanimate, subject ending in "-ąb"
 nZab = \s -> ab_End_VA3_CL_MI s ** {lock_N = <>} ;

 nKosciol : Str -> N ; -- masculine inanimate, for "kosciół"
 nKosciol = \s -> kosciol_VA1_VA2_CA_MI s ** {lock_N = <>} ;

 nCien : Str -> N ; -- masculine inanimate, subject ending in a week consonant
 nCien = \s -> week_End_CAL_MI s ** {lock_N = <>} ;

 nPien : Str -> N ; -- masculine inanimate, subject ending in a week consonant
 nPien = \s -> week_End_CAL_FleetingIEminus_MI s ** {lock_N = <>} ;

 nLisc : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nLisc = \s -> lisc_CAL_MI s ** {lock_N = <>} ;

 nKoc : Str -> N ; -- masculine inanimate, subject ending in a hardened consonant
 nKoc = \s -> hardened_End_MI_1 s ** {lock_N = <>} ;

 nWiersz : Str -> N ; -- masculine inanimate, subject ending in a hardened consonant
 nWiersz = \s -> hardened_End_MI_2 s ** {lock_N = <>} ;

 nDzien : Str -> N ; -- masculine inanimate, for "dzień"
 nDzien = \s -> dzien_MI s ** {lock_N = <>} ;

 nKajak : Str -> N ; -- masculine inanimate, subject ending in -g or -k
 nKajak = \s -> g_k_End_CL_MI_1 s ** {lock_N = <>} ;

 nMlotek : Str -> N ; -- masculine inanimate, subject ending in -ek
 nMlotek = \s -> k_End_CL_FleetingEminus_MI s ** {lock_N = <>} ;

 nMiech : Str -> N ; -- masculine inanimate, subject ending in -ch
 nMiech = \s -> ch_End_MI s ** {lock_N = <>} ;

 nSad : Str -> N ; -- masculine inanimate, subject ending in a hard consonant
 nSad = \s -> hard_End_CAL_MI s ** {lock_N = <>} ;

 nDym : Str -> N ; -- masculine inanimate, subject ending in a hard consonant
 nDym = \s -> hard_End_CL_MI s ** {lock_N = <>} ;

 nWal : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nWal = \s -> hard_End_CA_MI s ** {lock_N = <>} ;

 nDol : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nDol = \s -> hard_End_VA1_CA_MI s ** {lock_N = <>} ;

 nOgrod : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nOgrod = \s -> hard_End_VA1_CAL_MI s ** {lock_N = <>} ;

 nKwiat : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nKwiat = \s -> hard_End_VA2_CAL_MI s ** {lock_N = <>} ;

 nLas : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nLas = \s -> hard_End_VA2_CL_MI s ** {lock_N = <>} ;

 nWiatr : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nWiatr = \s -> wiatr_VA2_CA_MI s ** {lock_N = <>} ;

 nPopiol : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant
 nPopiol = \s -> popiol_VA2_CA_MI s ** {lock_N = <>} ;

 nPokoj : Str -> N ; -- masculine inanimate, subject ending in -ój
 nPokoj = \s -> onlySgNoun s ** {lock_N = <>} ;

 nGaj : Str -> N ; -- masculine inanimate, subject ending in a vowel + hard consonant j
 nGaj = \s -> vowel_j_or_handened_End_MI s ** {lock_N = <>} ;

 nBrzeg : Str -> N ; -- masculine inanimate, subject ending in -g or -k
 nBrzeg = \s -> g_k_End_CL_MI_2 s ** {lock_N = <>} ;

 nRok : Str -> Str -> N ; -- masculine inanimate for "rok", form in pl irregular
 nRok = \s, t -> rok_UnregularyPl_CL_MI s t ** {lock_N = <>} ;

 nProg : Str -> N ; -- masculine inanimate, subject ending in -óg
 nProg = \s -> ug_End_VA1_CL_MI s ** {lock_N = <>} ;

 nStatek : Str -> N ; -- masculine inanimate, subject ending in -ek
 nStatek = \s -> k_End_CL_FleetingEmins_MI s ** {lock_N = <>} ;

 nDom : Str -> N ; -- masculine inanimate, subject ending in -ch and for dom
 nDom = \s -> ch_End_dom_MI s ** {lock_N = <>} ;


-- Nominative, Genetive, Dative, Accusative, Instrumental, Locative and Vocative ;
-- corresponding seven plural forms and the gender.
  
  mkN  : (nomSg, genSg, datSg, accSg, instrSg, locSg, vocSg,
          nomPl, genPl, datPl, accPl, instrPl, locPl, vocPl: Str) -> Gender -> N ; 


  mkN =  \nomSg, genSg, datSg, accSg, instrSg, locSg, vocSg,
    nomPl, genPl, datPl, accPl, instrPl, locPl, vocPl, g ->
    {
      s = table { 
        SF Sg Nom => nomSg ;
        SF Sg Gen => genSg ;
        SF Sg Dat => datSg ;
        SF Sg Acc => accSg ;
        SF Sg Instr => instrSg ;
        SF Sg Loc => locSg ;
        SF Sg VocP => vocSg ;
        SF Pl Nom => nomPl ;
        SF Pl Gen => genPl ;
        SF Pl Dat => datPl ;
        SF Pl Acc => accPl ;
        SF Pl Instr => instrPl ;
        SF Pl Loc => locPl ;
        SF Pl VocP => vocPl 
	} ;                           
      g = g ;
    } ** {lock_N = <> }  ;




-- Nouns used as functions need a preposition. The most common is with Genitive.

  mkN2 : N -> N2  ;
  mkN2 n = mkFun n nullPrep  ;

  mkFun  : N -> Prep -> N2 ;
  mkFun f p = { s = f.s ; g = f.g ; c = { c = p.c ; s=p.s} ; lock_N2=<> }  ;

-- The commonest cases are functions with Genitive.
  nullPrep : Prep = {s = [] ; c= GenNoPrep ; lock_Prep=<>} ;  

  mkN3 : N -> Prep -> Prep -> N3 ;
  mkN3 f p r = { s = f.s ; g = f.g ; c = {s=p.s ; c=p.c}  ; c2 = {s=r.s ; c=r.c} ; lock_N3=<>} ; 
  
--6 Preposition   

-- A preposition is formed from a string and a case.

  mkPrep : Str -> Case -> Prep ;
  mkPrep s c = mkCompl s c ** {lock_Prep = <>} ;


-- Often just a case with the empty string is enough.
-- the directly following noun without a preposition

  genPrep : Prep ;
  genPrep = mkPrep [] genitive ;

  datPrep : Prep ;
  datPrep = mkPrep [] dative ;

  accPrep : Prep ;
  accPrep = mkPrep [] accusative ;

  instrPrep : Prep ;
  instrPrep = mkPrep [] instrumental ;


-- A great many of common prepositions are always with the genitive.

  bez_Prep : Prep ; --without
  bez_Prep = mkPrep "bez" genitive ;

  dla_Prep : Prep ; --for
  dla_Prep = mkPrep "dla" genitive ;

  do_Prep : Prep ; --to
  do_Prep = mkPrep "do" genitive ;

  dookola_Prep : Prep ; --(a)round
  dookola_Prep = mkPrep "dookoła" genitive ;

  kolo_Prep : Prep ; --near
  kolo_Prep = mkPrep "koło" genitive ;

  obok_Prep : Prep ; --beside, next to
  obok_Prep = mkPrep "obok" genitive ;

  od_Prep : Prep ; --from
  od_Prep = mkPrep "od" genitive ;

  oprocz_Prep : Prep ; --out of
  oprocz_Prep = mkPrep "oprócz" genitive ;

  podczas_Prep : Prep ; --during
  podczas_Prep = mkPrep "podczas" genitive ;

  mimo_Prep : Prep ; -- despite
  mimo_Prep = mkPrep "mimo" genitive ;

  spod_Prep : Prep ; --under
  spod_Prep = mkPrep "spod" genitive ;

  u_Prep : Prep ; --by, with (I was by Peter last sunday.)
  u_Prep = mkPrep "u" genitive ;

  wzdluz_Prep : Prep ; --along
  wzdluz_Prep = mkPrep "wzdłuż" genitive ;

  z_Prep : Prep ; --from (I come from Italy.), of/ from (The ring is made of silver.)
  z_Prep = mkPrep "z" genitive ;

  zamiast_Prep : Prep ; --instead of
  zamiast_Prep = mkPrep "zamiast" genitive ;

  znad_Prep : Prep ; --over, above
  znad_Prep = mkPrep "znad" genitive ;

  zza_Prep : Prep ; --behind
  zza_Prep = mkPrep "zza" genitive ;


-- Prepositions always with the dative.
  dzieki_Prep : Prep ; -- thanks for
  dzieki_Prep = mkPrep "dzięki" dative ;

  przeciw_Prep : Prep ; -- against 
  przeciw_Prep = mkPrep "przeciw" dative ;

} 
