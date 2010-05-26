--# -path=.:../../prelude:../common
--# -coding=utf8

--1 A polish Resource Morphology 
--
-- Ilona Nowak, Wintersemester 2007/08
--
resource NounMorphoPol = ResPol ** open Prelude, (Predef=Predef) in {

     flags  coding=utf8; optimize=all_subs; 


--1 Nouns   

-- Die Eigennamen im Polnischen sind wie
-- die CommNoun (S:SubstForm => Str; gender). 
-- Sie werden wie CommNoun dekliniert. Die Endung 
-- des Wortes ist immer entscheidend. 
-- Deswegen vrauche ich eine Funktion, die
-- ein CommNoun zu einem PN  macht.

--  oper ProperName = {s : SubstForm => Str; g : Gender};   
--  mkProperName : CommNoun -> ProperName = \cn ->
--    {s = \\c => cn.s! (SF Sg c); g=cn.g };


----- Abbreviations used in names of declensions -----

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

-- In Polish there are almost 125 main paradigms for noun declension.
-- (the classification of G. Jagodziński)
-- In this work I make only paradigms, that are needed for 
-- building lexicon entries.
     

--1.2 Operations for feminine nouns  


-- oper for feminine, noun ending in -l, 
-- no alternation
-- 104 paradigm by Grzegorz Jagodziński
-- by Nowak 104_4
-- oper nKapiel fo stal in GF lexicon

  oper l_End_F_1 : Str -> CommNoun = \kapiel ->
	 let 
	   x = kapiel;
	 in
	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Acc => x;
	     SF Sg Instr => x + "ą";
	     SF Sg _ => x + "i"; 
	     SF Pl Gen => x + "i";   
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e" 
	     };
	   g = Fem
	 };
       
       
-- oper for feminine, subject ending in -dź, 
-- consonant alternation in gen, dat, loc, instr Sg 
-- and in all plural forms.
-- Vowel alternation in almost all forms. 
-- Only nom and acc Sg haven't any changes.
-- 104' paradigm by Grzegorz Jagodziński
-- by Nowak 104'_1
-- oper nLodz for łódź in GF lexicon
-- dzx = dź
-- ludz = łódź

  oper dzx_End_VA1_CAL_F : Str -> CommNoun = \ludz ->
	 let
	   x = vowAlt1 ludz;
	   y = consAlt x;
	   z = consLength y;
       	 in
	 { s = table { 
	     SF Sg Nom => ludz;
	     SF Sg Acc => ludz;
	     SF Sg Instr => z + "ą";
	     SF Sg _ => y + "i"; 
	     SF Pl Gen => y + "i"; 
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => z + "e" 
	     };
	   g = Fem
	 };
       
       
-- oper for feminine, subject ending in -l, 
-- vowel alternation in almost all forms. 
-- Only nom and dat Sg haven't vowel alternation.
-- 104' paradigm by Grzegorz Jagodziński
-- by Nowak 104'_3
-- oper nSul for sól in GF lexicon

  oper l_End_VA1_F : Str -> CommNoun = \sul ->
	 let
	   x = vowAlt1 sul;
	 in
	 { s = table { 
	     SF Sg Nom => sul;
	     SF Sg Acc => sul;
	     SF Sg Instr => x + "ą";
	     SF Sg _ => x + "i"; 
	     SF Pl Gen => x + "i";   
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e" 
	     };
	   g = Fem
	 };

               
-- oper for feminine, subject ending in -w, 
-- fleeting e- minus between 2 consonants.
-- 104* paradigm number by Grzegorz Jagodziński
-- by Nowak 104*_1
-- oper nKonew for krew in GF lexicon

  oper w_End_FleetingEminus_F : Str -> CommNoun = \konew ->
	 let
	   x = fleetingEminus konew;
	   y = consLength x;
	 in
	 { s = table { 
	     SF Sg Nom => konew;
	     SF Sg Acc => konew;
	     SF Sg Instr => y + "ą";
	     SF Sg _ => x + "i"; 
	     SF Pl Gen => x + "i";   
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -ś, 
-- subject change: wieś : wsi
-- 104** paradigm by Grzegorz Jagodziński
-- by Nowak 104**
-- oper nWies only for wieś in GF lexicon
-- sx = ś
-- wies = wieś

  oper sx_End_CAL_FleetingIEminus_F : Str -> CommNoun = \wies ->
	let
	  x = consAlt wies;
	  y = fleetingIEminus x;
	  z = consLength y;
	  in
	 { s = table { 
	     SF Sg Nom => wies;
	     SF Sg Acc => wies;
	     SF Sg Instr => z + "ą";
	     SF Sg _ => y + "i"; 
	     SF Pl Gen => y + "i"; 
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => z + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -ń, 
-- consonant alternation, consonant lengthening.
-- 105 paradigm by Grzegorz Jagodziński
-- 105_1 by Nowak
-- oper nDlon for dłoń GF lexicon
-- nx = ń
-- dlon = dłoń

  oper nx_End_CAL_F : Str -> CommNoun = \dlon ->
	 let
	   x = consAlt dlon;
	   y = consLength x;
	 in
     	 { s = table { 
	     SF Sg Nom => dlon;
	     SF Sg Acc => dlon;
	     SF Sg Instr => y + "ą";
	     SF Sg _ => x + "i";
	     SF Pl Gen => x + "i";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => dlon + "mi";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e"
             };
	   g = Fem
	 };
       
-- oper for feminine, subject ending in -ć (sieć),
-- -ść (miłość), -ś (pierś), -dź (odpowiedź)
-- consonant alternation on last consonant
-- 106 paradigm by Grzegorz Jagodziński
-- 106_1 by Nowak
-- oper nSiec for miłość, odległość, pierś in GF lexicon
-- cx = ć
-- siec = sieć

  oper cx_End_CAL_F_1 : Str -> CommNoun = \siec  ->
	 let
	   x = consAlt siec;
	   y = consLength x;
	   in
	 { s = table { 
	     SF Sg Nom => siec;
	     SF Sg Acc => siec;
	     SF Sg Instr => y + "ą";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF _ _ => x + "i"
             };
	   g = Fem
	 };

       
-- oper for nouns having only the plural form
-- 98 by Grzegorz Jagodziński for usta - 98_2 by Nowak
-- 106 by Grzegorz Jagodziński for wnętrzności - 106_2 by Nowak
-- 106 by Grzegorz Jagodziński for drzwi - 106_3 by Nowak
-- 117 by Grzegorz Jagodziński for spodnie - 117_2 by Nowak
-- oper nDrzwi for drzwi, wnętrzności, usta, spodnie in GF-lexicon

  oper onlyPlNoun : Str -> CommNoun = \drzwi  ->
	 let 
	   i = my1Last drzwi;
	   drzw = last1Minus drzwi;
	   x = case i of {
	     "a" => last1Minus drzwi;
	     "e" => drzw;
	     "i" => drzwi;
	     "y" => drzw + "ów"};
	 in 
	 { s = table { 
	     SF _ Gen => x;
	     SF _ Dat => x + "om";
	     SF _ Instr => x + "ami";
	     SF _ Loc => x + "ach";
	     SF _ _ => drzwi
             };
	   g = Plur
	 };



-- oper for feminine, subject ending in -ść (kość), -ć(nić) 
-- consonant alternation and lengthening. Similar to nSiec, but different
-- in instr pl in the declension ending sieci-ami, kość-mi.
-- 107 paradigm by Grzegorz Jagodziński
-- 107 by Nowak
-- oper nKosc for kość in GF lexicon
-- cx = ć
-- kosc = kość
 
  oper cx_End_CAL_F_2 : Str -> CommNoun = \kosc ->
	 let
	   x = consAlt kosc;
	   y = consLength x;
	   in
     	 { s = table { 
	     SF Sg Nom => kosc;
	     SF Sg Acc => kosc;
	     SF Sg Instr => y + "ą";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => kosc + "mi";
	     SF Pl Loc => y + "ach";
	     SF _ _ => x + "i"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -c,-cz,-rz,-ż, 
-- 108 paradigm by Grzegorz Jagodziński
-- 108 by Nowak
-- oper nNoc for noc in GF lexicon
  oper hardened_End_F_1 : Str -> CommNoun = \noc ->
     	 { s = table { 
	     SF Sg Nom => noc;
	     SF Sg Acc => noc;
	     SF Sg Instr => noc + "ą";
	     SF Sg _ => noc + "y"; 
	     SF Pl Gen => noc + "y";
	     SF Pl Dat => noc + "om";
	     SF Pl Instr => noc + "ami";
	     SF Pl Loc => noc + "ach";
	     SF Pl _ => noc + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -sz, 
-- fleeting -e between 2 consonants.
-- 109* paradigm by Grzegorz Jagodziński 
-- 109* by Nowak
-- oper nWesz for wesz in GF lexicon
  
  oper sz_End_FleetingEminus_F : Str -> CommNoun = \wesz ->
	 let
	   x = fleetingEminus wesz;
	 in
     	 { s = table { 
	     SF Sg Nom => wesz;
	     SF Sg Acc => wesz;
	     SF Sg Instr => x + "ą";
	     SF Sg _ => x + "y"; 
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -wa, 
-- 112 paradigm by Grzegorz Jagodziński
-- 112 by Nowak
-- oper nKrolowa for królowa (queen) in GF lexicon

  oper wa_na_End_F : Str -> CommNoun = \krolowa ->
	 let
	   krolow = last1Minus krolowa;
	   in
     	 { s = table { 
	     SF Sg Nom => krolowa;
	     SF Sg Acc => krolow + "ą";
	     SF Sg Instr => krolow + "ą";
	     SF Sg VocP => krolow + "o";
	     SF Sg _ => krolow + "ej";
	     SF Pl Gen => krolow + "ych";
	     SF Pl Dat => krolow + "ym";
	     SF Pl Instr => krolow + "ymi";
	     SF Pl Loc => krolow + "ych";
	     SF Pl _ => krolow + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -wa, 
-- 113'@ paradigm by Grzegorz Jagodziński
-- 113'@ by Nowak
-- oper nReka for ręka in GF lexicon

  oper k_End_Unregulary_VA3_CA_F : Str -> CommNoun = \reka ->
	 let
	   x = last1Minus reka;
	   y = vowAlt3 x;
	   z = consAlt x;
	   in
     	 { s = table { 
	     SF Sg Nom => reka;
	     SF Sg Gen => x + "i";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => z + "e";
	     SF Pl Gen => y;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "oma";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => z + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -k (frytka), -g (ostryga, waga)
-- consonant alternation in dat, loc Sg.
-- 114 paradigm by Grzegorz Jagodziński
-- oper nApteka for fabryka, gramatyka, muzyka, 
-- nauka, rzeka, sztuka in GF lexicon

  oper g_k_End_CA_F : Str -> CommNoun = \apteka ->
	 let
	   x = last1Minus apteka;
	   y = consAlt apteka;
	 in 
	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "i";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e"; 
	     SF Pl Gen => x;   
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -g, 
-- consonant alternation in dat, loc sg,
-- vowel alternation in gen pl: o-ó (droga-dróg).
-- 114' paradigm by Grzegorz Jagodziński
-- by Nowak 114'
-- oper nDroga for podłoga, noga in GF lexicon
  
  oper g_End_VA1_CA_F : Str -> CommNoun = \droga ->
	let
	   x = last1Minus droga;
	   y = consAlt droga;
	   z = vowAlt1 droga;
	in
	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "i";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e"; 
	     SF Pl Gen => z; 
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -k, 
-- consonant alternation in dat, loc sg,
-- fleeting -e plus in gen pl.
-- 114* paradigm by Grzegorz Jagodziński
-- by Nowak 114*_1
-- oper nMatka for matka, piosenka, książka, kurtka,
-- lodówka, skarpetka, gumka in GF lexicon
  
  oper k_End_CA_FleetingEplus_F : Str -> CommNoun = \matka ->
	 let
	   x = last1Minus matka;
	   y = consAlt x;
	   z = fleetingEplus x;	   
	   in
	     { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "i";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e"; 
	     SF Pl Gen => z;   
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i"
             };
	   g = Fem
	  };


-- oper for feminine, subject ending in -ia, 
-- 116 paradigm by Grzegorz Jagodziński
-- 116_5 by Nowak
-- oper nZiemia for ziemia (earth) in GF lexicon

  oper ia_End_F_1 : Str -> CommNoun = \ziemia ->
	 let
	   ziemi = last1Minus ziemia;
	   ziem = last1Minus ziemi;
	   in
     	 { s = table { 
	     SF Sg Nom => ziemi + "a";
	     SF Sg Acc => ziemi + "ę";
	     SF Sg Instr => ziemi + "ą";
	     SF Sg VocP => ziemi + "o";
	     SF Sg _ => ziem + "i";
	     SF Pl Gen => ziem;
	     SF Pl Dat => ziemi + "om";
	     SF Pl Instr => ziemi + "ami";
	     SF Pl Loc => ziemi + "ach";
	     SF Pl _ => ziemi + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -l, 
-- 116 paradigm by Grzegorz Jagodziński
-- 116_6 by Nowak
-- oper nFala for koszula in GF lexicon

  oper l_End_F_2 : Str -> CommNoun = \fala ->
	 let
	   fal = last1Minus fala;
	   in
     	 { s = table { 
	     SF Sg Nom => fal + "a";
	     SF Sg Acc => fal + "ę";
	     SF Sg Instr => fal + "ą";
	     SF Sg VocP => fal + "o";
	     SF Sg _ => fal + "i";
	     SF Pl Gen => fal;
	     SF Pl Dat => fal + "om";
	     SF Pl Instr => fal + "ami";
	     SF Pl Loc => fal + "ach";
	     SF Pl _ => fal + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -ia, -ja:
-- in the spoken version of the word is -ja. Both
-- -ia and -ja have the same pronunciation. 
-- genitive sg ending in -ii.
-- 117 paradigm by Grzegorz Jagodziński
-- 117_4 by Nowak too
-- oper nLilia for religia, telewizja, restauracja in GF lexicon
  
  oper ia_End_F_2 : Str -> CommNoun = \lilia ->
	 let
	   lili = last1Minus lilia;
	   in
     	 { s = table { 
	     SF Sg Nom => lili + "a";
	     SF Sg Acc => lili + "ę";
	     SF Sg Instr => lili + "ą";
	     SF Sg VocP => lili + "o";
	     SF Sg _ => lili + "i";
	     SF Pl Gen => lili + "i";
	     SF Pl Dat => lili + "om";
	     SF Pl Instr => lili + "ami";
	     SF Pl Loc => lili + "ach";
	     SF Pl _ => lili + "e"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -t --------------------------------------, 
-- 121 paradigm by Grzegorz Jagodziński
-- 121_1 by Nowak
-- By Jagodziński there are many words in this group, 
-- that don't have consonant alternation in dat sg,
-- but only a consonantLengthening p: pi, n:ni, s:si
-- at the end of the subject.
-- So I create a new group here for małpa, lipa, benzyna, 
-- cytryna, szosa etc. S. nLiczba, below, 121_2 by Nowak
-- oper nKobieta for moneta, planeta, gazeta, ojczyzna in GF lexicon

  oper hard_End_CAL_F : Str -> CommNoun = \kobieta ->
	 let
	   x = last1Minus kobieta;
	   y = consAlt x;
	   z = consLength y;
	   in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => z + "e";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -t, -d, -b, -n, -w
-- (a hard consonant)
-- 121 paradigm by Grzegorz Jagodziński
-- 121_2 by Nowak
-- Only a consonantLengthening b:bi, p: pi, n:ni, s:si
-- at the end of the subject.
-- oper nLiczba for żona, trawa, dziewczyna, ryba, lampa, liczba in GF lexicon
  
  oper hard_End_CL_F : Str -> CommNoun = \liczba ->
	 let
	   x = last1Minus liczba;
	   y = consLength x;
	   in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -ł, -r, -ch
-- 121 paradigm by Grzegorz Jagodziński
-- 121_3 by Nowak
-- oper nSila for skała, reguła, chmura, góra, kamera, 
-- kora, mucha in GF lexicon
-- sixa = siła
  
  oper hard_End_CA_F : Str -> CommNoun = \sixa ->
	 let
	   x = last1Minus sixa;
	   y = consAlt x;
	   in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in hard consonants
-- f.e. -b(osoba), -p(stopa), -w (połowa), -z (koza)
-- vowel alternation o:ó in gen Pl and
-- consonant lengthening in dat, loc sg.
-- 121' paradigm by Grzegorz Jagodziński
-- 121'_1 by Nowak
-- oper nNora for stopa, wątroba, krowa
--  in GF lexicon

  oper hard_End_VA1_CL_F : Str -> CommNoun = \doba ->
	 let
	   x = last1Minus doba;
	   y = consLength x;
	   z = vowAlt1 x;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -d (broda, jagoda, moda),
-- -t (cnota, robota, sobota).
-- consonant alternation and lengthening d:dzi (woda:wodzie),
-- t:ci(sobota:sobocie) in dat, loc sg, 
-- vowel alternation o:ó (woda:wód, sobota:sobót) in gen pl.
-- 121' paradigm by Grzegorz Jagodziński
-- 121'_2 by Nowak
-- oper nWoda for woda in GF lexicon

  oper hard_End_VA1_CAL_F : Str -> CommNoun = \woda ->
	 let
	   x = last1Minus woda;
	   y = consLength (consAlt x);
	   z = vowAlt1 x;
	   in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -oła, -stra:
-- (pszczoła, szkoła, siostra).
-- consonant alternation ł:l, r:rz (szkoła:szkole,
-- siostra:siostrze) in dat, loc sg, 
-- vowel alternation o:ó (szkoła:szkół, siostra:sióstr) in gen pl.
-- 121' paradigm by Grzegorz Jagodziński
-- 121'_3 by Nowak
-- oper nSzkola for szkoła, siostra in GF lexicon

  oper hard_End_VA1_CA_F : Str -> CommNoun = \szkola ->
	 let
	   x = last1Minus szkola;
	   y = consAlt x;
	   z = vowAlt1 x;
	   in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };

 
-- oper for feminine, subject ending in -two consonants:
-- -jn, -łz, -łn, -żw
-- consonant lengthening 
-- 121* paradigm by Grzegorz Jagodziński
-- 121*_1 by Nowak
-- oper nWojna for wojna GF lexicon

  oper hard_End_CL_FleetingEplus_F : Str -> CommNoun = \wojna ->
	let
	  x = last1Minus wojna;
	  y = consLength x;
	  z = fleetingEplus x;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -sn
-- is almost like nWojna, but consonant alternation s:ś too
-- 121* paradigm by Grzegorz Jagodziński
-- 121*_1 by Nowak
-- oper nWiosna 

  oper sn_End_CAL_FleetingIEplus_F : Str -> CommNoun = \wiosna ->
	let
	  x = last1Minus wiosna;
	  y = consLength (consAlt x);
	  z = fleetingEplus x;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z; 
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -consonant + ł
-- f.e. like mgła, igła
-- fleeting -ie plus
-- 121** paradigm by Grzegorz Jagodziński
-- 121**_2 by Nowak
-- oper nMgla for mgła GF lexicon
-- x = ł
-- mgxa = mgła

  oper hard_l_End_CA_FleetingIEplus_F : Str -> CommNoun = \mgxa ->
	let
	  x = last1Minus mgxa;
	  y = consAlt x;
	  z = fleetingIEplus x;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper nGwiazda for gwiazda in GF-lexicon
-- 121^ paradigm by Grzegorz Jagodziński
-- 121^_1 by Nowak
-- only for words ending in -zda, -sta (gwiazda, niewiasta)

  oper zd_st_End_VA2_CAL_F : Str -> CommNoun = \gwiazda->
	 let
	  x = last1Minus gwiazda;
	  y = consLength (consAlt (vowAlt2 x));
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y"
             };
	   g = Fem
	 };


-- oper for feminine, subject ending in -c,-cz,-rz,-ż,  
-- 124 paradigm by Grzegorz Jagodziński 
-- 124_1 by Nowak
-- oper nUlica for ulica, rękawica GF lexicon

  oper hardened_End_F_2 : Str -> CommNoun = \ulica ->
	 let
	   x = last1Minus ulica;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => x + "y";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e"
             };
	   g = Fem
	 };

-- oper for feminine, subject ending in -c, 
-- irregulary form in genitive Pl
-- 124** paradigm by Grzegorz Jagodziński 
-- 124**_1 by Nowak
-- oper nOwca for owca in GF lexicon
  
  oper c_End_FleetingIEplus_F : Str -> CommNoun = \owca ->
	 let
	   x = last1Minus owca;
	   y = fleetingIEplus x;
	in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg VocP => x + "o";
	     SF Sg _ => x + "y";
	     SF Pl Gen => y;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e"
             };
	   g = Fem
	 };


--1.3 Operations for neuter nouns  

-- oper for neuter where subject ending in -ni,
-- functional weak ------- consonant
-- consonant alternation ni:ń in genitive Pl
-- 91 paradigm by Grzegorz Jagodziński 
-- 91_1 by Nowak
-- oper nDanie for mieszkanie in GF lexicon

  oper ci_ni_week_End_CA_N : Str -> CommNoun = \danie ->
	 let
	   x = last1Minus danie;
	   y = consAlt x;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "e";
	     SF Pl Gen => y;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -c,
-- functional weak consonant
-- 91 paradigm by Grzegorz Jagodziński 
-- 91_4 by Nowak
-- oper nSerce for słońce, serce, wzgórze GF lexicon

  oper hardened_End_N : Str -> CommNoun = \serce ->
	 let
	   x = last1Minus serce;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "e";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -
-- 91@ paradigm by Grzegorz Jagodziński 
-- 91@ by Nowak
-- oper nNasienie for nasienie GF lexicon
-- this is only for nasienie in polish language 
  
  oper ni_End_VA2_N : Str -> CommNoun = \nasienie ->
	let
	  x = fleetingEminus nasienie;
	  w = fleetingIEminus nasienie;
	  y = vowAlt2 w;
	in
     	{ s = table { 
	    SF Sg Gen => x + "a";
	    SF Sg Dat => x + "u";
	    SF Sg Instr => x + "em";
	    SF Sg Loc => x + "u";
	    SF Sg _ => x + "e";
	    SF Pl Gen => y;
	    SF Pl Dat => y + "om";
	    SF Pl Instr => y + "ami";
	    SF Pl Loc => y + "ach";
	    SF Pl _ => y + "a"
            };
	  g = Neut
	};


-- oper for neuter, subject ending in -rz 
-- in genitive Pl vowel alternation o:ó
-- here u=ó; both letters have the same pronunciation
-- 91' paradigm by Grzegorz Jagodziński 
-- 91' by Nowak  
-- oper nMorze for morze GF lexicon

  oper rz_zx_End_VA1_N : Str -> CommNoun = \morze ->
	let
	   x = last1Minus morze;
	   y = vowAlt1 morze;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "e";
	     SF Pl Gen => y;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -ę
-- in gen pl vowel alternation ę:o 
-- (imię:imiona, znamię:znamiona)
-- 97 paradigm by Grzegorz Jagodziński 
-- 97_1 by Nowak
-- oper nImie for imię GF lexicon

  oper ex_End_VA2_N : Str -> CommNoun = \imie ->
	 let
	  w = last1Minus imie;
	  x = w + "eni";
	  y = vowAlt2 imie;
	  z = y + "n";
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => w + "ę";
	     SF Pl Gen => z;
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => z + "a"
             };
	   g = NeutGr
	 };


-- oper for neuter, subject ending in -ę
-- genitive Pl -ęta
-- 97 paradigm by Grzegorz Jagodziński 
-- 97_2 by Nowak
-- oper nCiele for zwierzę, niemowlę GF lexicon
  
  oper ex_End_VA3_N : Str -> CommNoun = \ciele ->
	let
	   w = last1Minus ciele;
	   x = ciele + "ci";
	   y = vowAlt3 ciele + "t";
	   z = ciele + "t";
	in
     	{ s = table { 
	    SF Sg Gen => x + "a";
	    SF Sg Dat => x + "u";
	    SF Sg Instr => x + "em";
	    SF Sg Loc => x + "u";
	    SF Sg _ => w + "ę";
	    SF Pl Gen => y;
	    SF Pl Dat => z + "om";
	    SF Pl Instr => z  + "ami";
	    SF Pl Loc => z  + "ach";
	    SF Pl _ => z + "a"
            };
	  g = NeutGr
	};


-- According to G.Jagodziński "udo" and "piwo" have 
-- the same declention type. I part it, because "udo" 
-- changes in "udzie".
-- first there is consonant alternation d:dz 
-- and then consonant lengthening dz: dz' (dzi).
-- "Piwo" has only consonant lengthening w:w' (wi)

-- oper for neuter, subject ending in a consonant + "o"
-- 98 paradigm by Grzegorz Jagodziński 
-- 98_1_a by Nowak
-- oper nUdo for złoto GF lexicon
  
  oper hard_End_CAL_N : Str -> CommNoun = \udo ->
	 let
	  x = last1Minus udo ;
	  y = consLength (consAlt udo);
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x  + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in a consonant + "o"
-- 98 paradigm by Grzegorz Jagodziński 
-- 98_1_b by Nowak
-- oper nPiwo for piwo, wino, drzewo, kolano, 
-- mięso, żelazo GF lexicon

  oper hard_End_CL_N : Str -> CommNoun = \piwo ->
	 let
	   x = last1Minus piwo;
	   y = consLength piwo;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x  + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -r
-- consonant alternation r:rz
-- 98 paradigm by Grzegorz Jagodziński 
-- 98_4 by Nowak
-- oper nZero for jezioro, pióro GF lexicon

  oper r_End_CA_N : Str -> CommNoun = \zero ->
	 let
	   x = last1Minus zero;
	   y = consAlt zero;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter "niebo" - only
-- irregularly form in Pl "niebiosa"
-- 98@ paradigm by Grzegorz Jagodziński and by Nowak
-- oper nNiebo for  GF lexicon
-- only for niebo in polish language

  oper niebo_Unregulary_N : Str -> CommNoun = \niebo ->
	 let
	   x  = last1Minus niebo;
-- 	   y = consLength niebo;
	   z = x + "ios";
	in
     	{ s = table { 
	    SF Sg Gen => x + "a";
	    SF Sg Dat => x + "u";
	    SF Sg Instr => x + "em";
	    SF Sg Loc => x + "ie";
	    SF Sg _ => x + "o";
	    SF Pl Gen => z;
	    SF Pl Dat => z + "om";
	    SF Pl Instr => z + "ami";
	    SF Pl Loc => z + "ach";
	    SF Pl _ => z + "a"
            };
	  g = Neut
	};


-- oper for neuter, subject ending in -ł
-- consonant alternation
-- 98* paradigm by Grzegorz Jagodziński
-- 98*_3 by Nowak
-- oper nTlo for krzesło, masło, skrzydło GF lexicon 
-- x = ł
-- txo = tło 

  oper lx_End_CA_FleetingEplus_N : Str -> CommNoun = \txo ->
	 let
	   x = last1Minus txo;
	   y = consAlt txo;
	   z = fleetingEplus txo; 
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -r
-- genitive Pl fleetingEplus
-- 98*  paradigm by Grzegorz Jagodziński 
-- 98*_5 by Nowak
-- oper nZebro for srebro GF lexicon

  oper hard_End_CA_FleetingEplus_N : Str -> CommNoun = \zebro ->
	 let
	   x = last1Minus zebro;
	   y = consAlt zebro;
	   z = fleetingEplus zebro;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x  + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -n
-- consonant lengthening
-- 98** paradigm by Grzegorz Jagodziński 
-- 98**_1 by Nowak
-- oper nOkno for okno, drewno  GF lexicon

  oper n_End_CL_FleetingIEplus_N : Str -> CommNoun = \okno ->
	 let
	   x = last1Minus okno;
	   y = consLength okno;
	   z = fleetingIEplus okno;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x  + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -zdo, -sto
-- locative Sg gnieździe, mieście
-- 98^ paradigm by Grzegorz Jagodziński 
-- 98^_1 by Nowak
-- oper nGniazdo for miasto GF lexicon

  oper hard_End_VA_CAL_N : Str -> CommNoun = \gniazdo ->
	 let
	  x = last1Minus gniazdo;
	  y = vowAlt2 gniazdo;
	  z = consAlt y;
	  t = consLength z;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => t + "e";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x  + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -k,
-- consonant lengthening in instr Sg
-- 99 paradigm by Grzegorz Jagodziński 
-- 99_2 by Nowak
-- oper nWojsko for mleko GF lexicon

  oper k_End_CL_N : Str -> CommNoun = \wojsko ->
	 let
	   x = last1Minus wojsko;
	   y = consLength wojsko;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -j,
-- 99 paradigm by Grzegorz Jagodziński 
-- 99_4 by Nowak
-- oper nJajo for jajo GF lexicon

  oper j_End_N : Str -> CommNoun = \jajo ->
	let
	  x = last1Minus jajo;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "o";
	     SF Pl Gen => x;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, subject ending in -k,
-- consonant lengthening in instr Sg
-- 99* paradigm by Grzegorz Jagodziński 
-- 99*_2 by Nowak   
-- oper nJablko for jabłko, jajko GF lexicon
  
  oper k_End_CL_FleetingEplus_N : Str -> CommNoun = \jablko ->
	let
	  x = last1Minus jablko;
	  y = consLength jablko;
	  z = fleetingEplus jablko;
	in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "o";
	     SF Pl Gen => z;
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "a"
             };
	   g = Neut
	 };


-- oper for neuter, noun ending in -o,
-- 100 paradigm by Grzegorz Jagodziński 
-- 100_3 by Nowak
-- oper nStudio for radio GF lexicon
  
  oper o_End_N : Str -> CommNoun = \studio ->
	let
	  x = last1Minus studio;
	in
     	{ s = table { 
	    SF Sg Gen => x + "a";
	    SF Sg Dat => x + "u";
	    SF Sg Instr => x + "em";
	    SF Sg Loc => x + "u";
	    SF Sg _ => x + "o";
	    SF Pl Gen => x + "ów";
	    SF Pl Dat => x + "om";
	    SF Pl Instr => x + "ami";
	    SF Pl Loc => x + "ach";
	    SF Pl _ => x + "a"
            };
	  g = Neut
	};


-- oper for neuter for dziecko,
-- consonant alternation c:ć in instr Sg.
-- 101 paradigm by Grzegorz Jagodziński & by Nowak
-- oper nDziecko for dziecko GF lexicon

  oper k_End_CAL_N : Str -> CommNoun = \dziecko ->
	let
	  t = last1Minus dziecko; --dzieck
	  u = last1Minus t; --dziec
	  w = consLength u; --dzieci
	  x = consAlt w; --dzieć
	  y = consLength t; --dziecki
	in
     	 { s = table { 
	     SF Sg Gen => t + "a";
	     SF Sg Dat => t + "u";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => t + "u";
	     SF Sg _ => t + "o";
	     SF Pl Dat => w + "om";
	     SF Pl Instr => x + "mi";
	     SF Pl Loc => w + "ach";
	     SF Pl _ => u + "i"
             };
	   g = NeutGr --asl
	 };


-- oper for neuter, subject ending in -ch,
-- consonant alternation ch:sz
-- 102 paradigm by Grzegorz Jagodziński 
-- 102_1 by Nowak
-- oper nUcho for ucho GF lexicon 
-- ucho as ear

  oper ch_End_Unregulary_CA_N : Str -> CommNoun = \ucho ->
	 let
	   x = last1Minus ucho;
	   y = consAlt x;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "o";
	     SF Pl Gen => y + "u";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "y"
             };
	   g = NeutGr
	 };

-- oper for neuter, subject ending in -k,
-- consonant alternation for all forms in Pl k:cz
-- 102 paradigm by Grzegorz Jagodziński 
-- 102_2 by Nowak
-- oper nOko for oko GF lexicon

  oper k_End_Unregulary_CAL_N : Str -> CommNoun = \oko ->
	 let
	   x = last1Minus oko;
	   y = consAlt oko;
	   z = consLength x;
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "u";
	     SF Sg Instr => z + "em";
	     SF Sg Loc => x + "u";
	     SF Sg _ => x + "o";
	     SF Pl Gen => y + "u";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "y"
             };
	   g = NeutGr
	 };



--1.4 Operations for masculine nouns  


--1.4.1 Operations for masculine personal  


-- oper for masculine personal ending in hard consonant
-- -t, -n, nom pl ending in -i
-- consonant alternation t:c, consonant lengthening c:ci,
-- 3 paradigm by Grzegorz Jagodziński 
-- 3_1 by Nowak
-- oper nFacet for policjant, student, kuzyn in GF lexicon

  oper hard_End_CAL_MP_1 : Str -> CommNoun = \facet ->
	 let
	   x = facet;
	   y = consAlt x;
	   z = consLength y;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => z + "e";
	     SF Sg VocP => z + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => y + "i";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => y + "i";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in hard consonant
-- -t, -n, nom pl ending in -y
-- consonant alternation t:c, consonant lengthening c:ci,
-- 4 paradigm by Grzegorz Jagodziński 
-- 4_1 by Nowak
-- oper nArab for szef in GF lexicon

  oper hard_End_CAL_MP_2 : Str -> CommNoun = \Arab ->
	 let
	   x = Arab;
	   y = consLength x;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "owie";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in hard consonant
-- -l. Only for przyjaciel (friend).
-- consonant alternation l:ł, vowel alternation e:ó,
-- 7 paradigm by Grzegorz Jagodziński 
-- 7 by Nowak
-- oper nPrzyjaciel for przyjaciel in GF lexicon

  oper przyjaciel_VA1_VA2_CA_MP : Str -> CommNoun = \przyjaciel ->
	 let
	   t = przyjaciel;
	   u = vowAlt2 t; -- przyjaciol
	   w = consAlt u; -- przyjacioł
	   x = vowAlt1 w; -- przyjaciół
	 in
     	 { s = table { 
	     SF Sg Nom => t;
	     SF Sg Dat => t + "owi";
	     SF Sg Instr => t + "em";
	     SF Sg Loc => t + "u";
	     SF Sg VocP => t + "u";
	     SF Sg _ => t + "a";
	     SF Pl Nom => t + "e";
	     SF Pl Dat => w + "om";
	     SF Pl Instr => x  + "mi";
	     SF Pl Loc => w + "ach";
	     SF Pl VocP => t + "e";
	     SF Pl _ => x 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in hard consonant -l
-- 8 paradigm by Grzegorz Jagodziński 
-- 8_3 by Nowak
-- oper nKowal for nauczyciel (teacher) in GF lexicon
  
  oper l_End_MP : Str -> CommNoun = \kowal->
	 let
	   t = kowal;
	 in
     	 { s = table { 
	     SF Sg Nom => t;
	     SF Sg Dat => t + "owi";
	     SF Sg Instr => t + "em";
	     SF Sg Loc => t + "u";
	     SF Sg VocP => t + "u";
	     SF Sg _ => t + "a";
	     SF Pl Nom => t + "e";
	     SF Pl Dat => t + "om";
	     SF Pl Instr => t  + "ami";
	     SF Pl Loc => t + "ach";
	     SF Pl VocP => t + "e";
	     SF Pl _ => t + "i"
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in hard double consonant
-- -rz, -ż, -cz, -sz (piekarz, lekarz, papież, tłumacz, piwosz)
-- 11 paradigm by Grzegorz Jagodziński 
-- 11 by Nowak
-- oper nLekarz for lekarz in GF lexicon

  oper hardened_End_MP : Str -> CommNoun = \lekarz ->
	 let
	   x = lekarz;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => x + "u";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "e";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "e";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -ul
-- (konsul, król)
-- 13 paradigm by Grzegorz Jagodziński 
-- 13_3 by Nowak
-- oper nKrol for król in GF lexicon

  oper ul_End_MP : Str -> CommNoun = \krol->
	 let
	   x = krol;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => x + "u";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "owie";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "e";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -ż (mąż),
-- vowel alternation ą:ę (mąż:męża)
-- 13' paradigm by Grzegorz Jagodziński 
-- 13' by Nowak
-- oper nMaz for mąż in GF lexicon
  
  oper maz_MP : Str -> CommNoun = \maz ->
	 let
	   x = maz;
	   y = vowAlt3 x;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => y + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => y + "u";
	     SF Sg VocP => y + "u";
	     SF Sg _ => y + "a";
	     SF Pl Nom => y + "owie";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl VocP => y + "owie";
	     SF Pl _ => y + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -g (wróg),
-- vowel alternation ó:o (wróg:wroga)
-- only for wróg
-- 14' paradigm by Grzegorz Jagodziński 
-- 14' by Nowak
-- oper nWrog for wróg in GF lexicon
  
  oper wrog_VA1_CL_MP : Str -> CommNoun = \wrog ->
	 let
	   x = vowAlt1 wrog;
	   y = consLength x;
	 in
     	 { s = table { 
	     SF Sg Nom => wrog;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => x + "u";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "owie";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "owie";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal "ksiądz"
-- 20 paradigm by Grzegorz Jagodziński 
-- 20 by Nowak
-- oper nKsiadz for ksiądz in GF lexicon

  oper ksiadz_VA3_CA_MP : Str -> CommNoun = \ksiadz ->
	 let
	   x = vowAlt3 ksiadz; -- księdz
	   y = consAlt x; -- księż
	 in
     	 { s = table { 
	     SF Sg Nom => ksiadz;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => y + "a";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "mi";
	     SF Pl Loc => y + "ach";
	     SF Pl VocP => y + "a";
	     SF Pl _ => y + "y" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -ciec
-- (ojciec, praojciec)
-- 21* paradigm by Grzegorz Jagodziński 
-- 21* by Nowak
-- oper nOjciec for ojciec in GF lexicon
  
  oper ciec_End_CA_FleetingIEminus_MP : Str -> CommNoun = \ojciec ->
	 let
	   w = fleetingIEminus ojciec; -- ojcc
	   x = last1Minus w; -- ojc
	   y = consAlt x; -- ojcz
	 in
     	 { s = table { 
	     SF Sg Nom => ojciec;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "owie";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "owie";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in a hard consonant -t 
-- 18 paradigm by Grzegorz Jagodziński 
-- 18 by Nowak
-- oper nBrat for brat in GF lexicon

  oper hard_End_CAL_MP : Str -> CommNoun = \brat ->
	 let
	   x = brat;
	   y = consAlt x; -- brat:brac
	   z = consLength y; -- brac:braci
	   t = consAlt y; -- brac:brać
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => z + "e";
	     SF Sg VocP => z + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => z + "a";
	     SF Pl Dat => z + "om";
	     SF Pl Instr => t + "mi";
	     SF Pl Loc => z + "ach";
	     SF Pl VocP => z + "a";
	     SF Pl _ => y + "i" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal "bóg"
-- 22' paradigm by Grzegorz Jagodziński 
-- 22' by Nowak
-- oper nBog for bóg in GF lexicon

  oper bog_VA1_CAL_MP : Str -> CommNoun = \bog ->
	 let
	   x = vowAlt1 bog; -- bog
	   y = consLength x; -- bogi
	   z = vowAlt1 (consAlt bog); -- boż
	 in
     	 { s = table { 
	     SF Sg Nom => bog;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => z + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "owie";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "owie";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -iec
-- ( chłopiec)
-- 24** paradigm by Grzegorz Jagodziński 
-- 24** by Nowak
-- oper nChlopiec for chłopiec in GF lexicon
  
  oper iec_End_CA_FleetingIEminus_MP : Str -> CommNoun = \chlopiec ->
	 let
	   x = fleetingIEminus chlopiec; -- chlopc
	   y = consAlt x; -- chlopcz
	 in
     	 { s = table { 
	     SF Sg Nom => chlopiec;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "y";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "y";
	     SF Pl _ => x + "ów" 
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in -zna
-- consinant alternation z:ź, consonant lengthening n:ni
-- 34 paradigm by Grzegorz Jagodziński 
-- 34 by Nowak
-- oper nMezczyzna for mężczyzna in GF lexicon

  oper zna_End_CAL_MP : Str -> CommNoun = \mezczyzna ->
	 let
	   x = last1Minus mezczyzna; -- mężczyzn
	   y = consAlt x; -- mężczyźn
	   z = consLength y;-- mężczyźni
	 in
     	 { s = table { 
	     SF Sg Nom => x + "a";
	     SF Sg Gen => x + "y";
	     SF Sg Dat => z + "e";
	     SF Sg Acc => x + "ę";
	     SF Sg Instr => x + "ą";
	     SF Sg Loc => z + "e";
	     SF Sg VocP => x + "o";
	     SF Pl Nom => y + "i";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => y + "i";
	     SF Pl _ => x  
             };
	   g = Masc Personal
	 };


-- oper for masculine personal ending in a hard consonant
-- + "a" (tata, gazda, drużba, ortodoksa)
-- 36 paradigm by Grzegorz Jagodziński 
-- 36 by Nowak
-- oper nDruzba for tata (synonym for ojciec) in GF lexicon
{- oper hard_plus_a_CAL_MP : Str -> CommNoun = \druzba ->
	 let
	   x = last1Minus druzba;
	   
	in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => x + "u";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "e";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl VocP => x + "e";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Personal
	 }; -}


--1.4.2 Operations for masculine animate


-- oper for masculine animate ending in -ń
-- 59 paradigm by Grzegorz Jagodziński 
-- 59 by Nowak
-- oper nKon for koń in GF lexicon

  oper kon_CAL_MA : Str -> CommNoun = \kon ->
	 let
	   x = consAlt kon; --kon
	   y = consLength x; -- koni
	 in
     	 { s = table { 
	     SF Sg Nom => kon;
	     SF Sg Dat => y + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => y + "u";
	     SF Sg VocP => y + "u";
	     SF Sg _ => y + "a";
	     SF Pl Gen => x + "i";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => kon + "mi";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e" 
             };
	   g = Masc Animate
	 };


-- oper for masculine animate for "wąż"
-- 61' paradigm by Grzegorz Jagodziński 
-- 61' by Nowak
-- oper nWaz for wąż in GF lexicon
  
  oper waz_VA3_MA : Str -> CommNoun = \waz ->
	 let
	   y = vowAlt3 waz; -- węż
	 in
     	 { s = table { 
	     SF Sg Nom => waz;
	     SF Sg Dat => y + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => y + "u";
	     SF Sg VocP => y + "u";
	     SF Sg _ => y + "a";
	     SF Pl Gen => y + "y";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e" 
             };
	   g = Masc Animate
	 };


-- oper for masculine animate ending in -k
-- 62 paradigm by Grzegorz Jagodziński 
-- 62 by Nowak
-- oper nPtak for ptak, robak in GF lexicon
  
  oper k_End_CL_MA : Str -> CommNoun = \ptak ->
	 let
	   y = consLength ptak; -- ptaki
	 in
     	 { s = table { 
	     SF Sg Nom => ptak;
	     SF Sg Dat => ptak + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => ptak + "u";
	     SF Sg VocP => ptak + "u";
	     SF Sg _ => ptak + "a";
	     SF Pl Gen => ptak + "ów";
	     SF Pl Dat => ptak + "om";
	     SF Pl Instr => ptak + "ami";
	     SF Pl Loc => ptak + "ach";
	     SF Pl _ => ptak + "i" 
             };
	   g = Masc Animate
	 };


-- oper for masculine animate for "kot"
-- 64 paradigm by Grzegorz Jagodziński 
-- 64 by Nowak
-- oper nKot for kot in GF lexicon

  oper kot_CAL_MA : Str -> CommNoun = \kot ->
	 let
       	   x = consAlt kot; --koc
	   y = consLength x; -- koci
	 in
     	 { s = table { 
	     SF Sg Nom => kot;
	     SF Sg Dat => kot + "u";
	     SF Sg Instr => kot + "em";
	     SF Sg Loc => y + "e";
	     SF Sg VocP => y + "e";
	     SF Sg _ => kot + "a";
	     SF Pl Gen => kot + "ów";
	     SF Pl Dat => kot + "om";
	     SF Pl Instr => kot + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => kot + "y" 
             };
	   g = Masc Animate
	 };


-- oper for masculine animate for "pies"
-- 64** paradigm by Grzegorz Jagodziński 
-- 64** by Nowak
-- oper nPies for pies in GF lexicon

  oper pies_CL_FleetingIEminus_MA : Str -> CommNoun = \pies ->
	 let
	   x = fleetingIEminus pies; -- ps
	   y = consLength x; -- psi
	 in
     	 { s = table { 
	     SF Sg Nom => pies;
	     SF Sg Dat => x + "u";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Animate
	 };



--1.4.3 Operations for masculine inanimate  


-- oper for masculine inanimate ending in 
-- a vowel + a hard consonant
-- consonant alternation t:c and then lengthening c:ci
-- 70 paradigm by Grzegorz Jagodziński 
-- 70_1_1 by Nowak
-- oper nBat for but in GF lexicon

  oper vowel_hard_CAL_MI : Str -> CommNoun = \bat ->
	 let
	   u = bat;
	   x = consLength (consAlt u);  -- baci
	 in
     	 { s = table { 
	     SF Sg Nom => u;
	     SF Sg Dat => u + "owi";
	     SF Sg Instr => u + "em";
	     SF Sg Loc => x + "e";
	     SF Sg VocP => x + "e";
	     SF Sg _ => u + "a";
	     SF Pl Gen => u + "ów";
	     SF Pl Dat => u + "om";
	     SF Pl Instr => u + "ami";
	     SF Pl Loc => u + "ach";
	     SF Pl _ => u + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in 
-- a vowel + a hard consonant
-- almost like nBat, but with consonant alternation
-- only consonant lengthening
-- (dzban, chleb, Berlin, kręgosłup, kilogram)
-- 70 paradigm by Grzegorz Jagodziński 
-- 70_1_2 by Nowak
-- oper nBat for  chleb, włos, nos, ogon in GF lexicon

  oper vowel_hard_CL_MI : Str -> CommNoun = \chleb ->
	 let
	   u = chleb;
	   x = consLength u;  -- chlebi
	 in
     	 { s = table { 
	     SF Sg Nom => u;
	     SF Sg Dat => u + "owi";
	     SF Sg Acc => u;
	     SF Sg Instr => u + "em";
	     SF Sg Loc => x + "e";
	     SF Sg VocP => x + "e";
	     SF Sg _ => u + "a";
	     SF Pl Gen => u + "ów";
	     SF Pl Dat => u + "om";
	     SF Pl Instr => u + "ami";
	     SF Pl Loc => u + "ach";
	     SF Pl _ => u + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -r
-- consonant alternation r:rz (ser:serze)
-- 70 paradigm by Grzegorz Jagodziński 
-- 70_5 by Nowak
-- oper nSer for ser in GF lexicon

  oper r_End_CA_MI : Str -> CommNoun = \ser ->
	 let
	   x = ser;
	   y = consAlt ser; -- serz
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ąb
-- consonant alternation ą:ę (ząb:zęba)
-- 70' paradigm by Grzegorz Jagodziński 
-- 70'_1 by Nowak
-- oper nZab for ząb in GF lexicon

  oper ab_End_VA3_CL_MI : Str -> CommNoun = \zab ->
	 let
	   y = vowAlt3 zab; -- zęb
	   z = consLength y;
	 in
     	 { s = table { 
	     SF Sg Nom => zab;
	     SF Sg Dat => y + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => z + "e";
	     SF Sg VocP => z + "e";
	     SF Sg _ => y + "a";
	     SF Pl Gen => y + "ów";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending for "kościół"
-- 70^' paradigm by Grzegorz Jagodziński 
-- 70^' by Nowak
-- oper nKosciol for kościół in GF lexicon
  
  oper kosciol_VA1_VA2_CA_MI : Str -> CommNoun = \kosciol ->
	 let
	   x = vowAlt1 kosciol; -- kościoł
	   y = consAlt (vowAlt2 x); -- kościel
	 in
     	 { s = table { 
	     SF Sg Nom => kosciol;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => y + "e";
	     SF Sg VocP => y + "e";
	     SF Sg _ => x + "a";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in a weak
-- consonant (promień, Brześć, Niedźwiedź, Zamość) 
-- consonant alternation and lengthening
-- 71 paradigm by Grzegorz Jagodziński 
-- 71_1 by Nowak
-- oper nCien for korzeń, kamień in GF lexicon
  
  oper week_End_CAL_MI : Str -> CommNoun = \cien ->
	 let
	   x = consAlt cien; -- cień:cien
	   y = consLength x; -- cieni
	 in
     	 { s = table { 
	     SF Sg Nom => cien;
	     SF Sg Gen => y + "a";
	     SF Sg Dat => y + "u";
	     SF Sg Acc => cien;
	     SF Sg Instr => y + "em";
	     SF Sg _ => y + "u";
	     SF Pl Gen => x + "i";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => y + "ami";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in a weak
-- consonant alternation and lengthening
-- fleeting ie minus (łokieć, stopień)
-- 71** paradigm by Grzegorz Jagodziński 
-- 71**_1 by Nowak
-- oper nPien for ogień, paznokieć in GF lexicon
  
  oper week_End_CAL_FleetingIEminus_MI : Str -> CommNoun = \pien ->
	 let
	   x = fleetingIEminus pien; -- pń
	   y = consAlt x; -- pn
	   z = consLength y; -- pni
	 in
     	 { s = table { 
	     SF Sg Nom => pien;
	     SF Sg Dat => z + "u";
	     SF Sg Instr => z + "em";
	     SF Sg Loc => z + "u";
	     SF Sg VocP => z + "u";
	     SF Sg _ => z + "a";
	     SF Pl Gen => y + "i";
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => z + "e" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ść,
-- for liść
-- 72 paradigm by Grzegorz Jagodziński 
-- 72 by Nowak
-- oper nLisc for liść in GF lexicon
  
  oper lisc_CAL_MI : Str -> CommNoun = \lisc ->
	 let
	   x = consAlt lisc; -- liśc
	   y = consLength x; -- liści
	 in
     	 { s = table { 
	     SF Sg Nom => lisc;
	     SF Sg Gen => y + "a";
	     SF Sg Dat => y + "owi";
	     SF Sg Acc => lisc;
	     SF Sg Instr => y + "em";
	     SF Sg _ => y + "u";
	     SF Pl Gen => x + "i";
	     SF Pl Dat => y + "om";
	     SF Pl Instr => lisc + "mi";
	     SF Pl Loc => y + "ach";
	     SF Pl _ => y + "e" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in 
-- a hardened consonant: -ż, -rz, -c, -cz, -dz
-- (gorąc, piec, Kalisz, tłuszcz, bicz, Spisz, Zgierz, Paryż, Łowicz)
-- 73 paradigm by Grzegorz Jagodziński 
-- 73_5 by Nowak
-- oper nKoc for piec, tłuszcz, Paryż in GF lexicon
  
  oper hardened_End_MI_1 : Str -> CommNoun = \koc ->
	 let
	   x = koc; 
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "e";
	     SF Sg VocP => x + "e";
	     SF Sg _ => x + "a";
	     SF Pl Nom => x + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in 
-- a hardened consonant: -ż, -rz, -c, -cz, -dz
-- (kapelusz, księżyc)
-- 74 paradigm by Grzegorz Jagodziński 
-- 74 by Nowak
-- oper nWiersz for księżyc, kapelusz in GF lexicon

  oper hardened_End_MI_2 : Str -> CommNoun = \wiersz ->
	 let
	   x = wiersz; 
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => x + "em";
	     SF Sg Loc => x + "e";
	     SF Sg VocP => x + "e";
	     SF Sg _ => x + "a";
	     SF Pl Gen => x + "y";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate for "dzień"
-- 76** paradigm by Grzegorz Jagodziński 
-- 76** by Nowak
-- oper nDzien for dzień in GF lexicon

  oper dzien_MI : Str -> CommNoun = \dzien ->
	 let
	   x = fleetingLettersMinus dzien; -- dń
	   y = consAlt x; -- dń:dn
	   z = consLength y; -- dn:dni
	 in
     	 { s = table { 
	     SF Sg Nom => dzien;
	     SF Sg Dat => z + "u";
	     SF Sg Instr => z + "em";
	     SF Sg Loc => z + "e";
	     SF Sg VocP => z + "e";
	     SF Sg _ => z + "a";
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => y + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -k, -g
-- consonant lengthening 
-- (ranek, skrawek, Owtock, Hamburg, drąg)
-- 77 paradigm by Grzegorz Jagodziński 
-- 77_1 by Nowak
-- oper nKajak for język, patyk in GF lexicon

  oper g_k_End_CL_MI_1 : Str -> CommNoun = \kajak ->
	 let
	   x = kajak;
	   y = consLength kajak; -- kajaki
	 in
     	 { s = table { 
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "owi";
	     SF Sg Instr => y + "em";
	     SF Sg Loc => x + "u";
	     SF Sg VocP => x + "u";
	     SF Sg _ => x ;
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ek
-- fleeting e minus
-- (fiołek, garnek, podkoszulek, przecinek, Włocławek)
-- 77* paradigm by Grzegorz Jagodziński 
-- 70* by Nowak
-- oper nMlotek for ołówek in GF lexicon

  oper k_End_CL_FleetingEminus_MI : Str -> CommNoun = \mlotek ->
	 let
	   x = fleetingEminus mlotek; -- mlotk
	   y = consLength x; -- mlotki
	 in
     	 { s = table { 
	     SF Sg Nom => mlotek;
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => mlotek;
	     SF Sg Instr => y + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ch
-- (bebech, Wałbrzych, brzuch, łańcuch)
-- 78 paradigm by Grzegorz Jagodziński 
-- 78_1 by Nowak
-- oper nMiech for brzuch in GF lexicon

  oper ch_End_MI : Str -> CommNoun = \miech ->
	 let
	   x = miech;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "a";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in a hard consonant
-- consonant alternation and lengthening
-- 82 paradigm by Grzegorz Jagodziński 
-- 82_1_1 by Nowak
-- oper nSad for samotot, uniwersytet, port, sufit in GF lexicon

  oper hard_End_CAL_MI : Str -> CommNoun = \sad ->
	 let
	   x = sad;
	   y = consLength (consAlt x); -- sadzi
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in a hard consonant
-- consonant lengthening
-- 82 paradigm by Grzegorz Jagodziński 
-- 82_1_2 by Nowak
-- oper nDym for dym, dywan, sklep in GF lexicon

  oper hard_End_CL_MI : Str -> CommNoun = \dym ->
	 let
	   x = dym;
	   y = consLength x; -- dymi
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in 
-- a hard consonant -ł, -r
-- consonant alternation
-- (artykuł, finał, kryształ, materiał)
-- 82 paradigm by Grzegorz Jagodziński 
-- 82_2 + 82_3 by Nowak
-- oper nWal for przemysł, papier, rower in GF lexicon
 
  oper hard_End_CA_MI : Str -> CommNoun = \wal ->
	 let
	   x = wal;
	   y = consAlt x; -- wał:wal
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ó + hard consonant
-- vowel and consonant alternation
-- (rosół, zespół, otwór, wodór )
-- 82' paradigm by Grzegorz Jagodziński 
-- 82' by Nowak
-- oper nDol for stól in GF lexicon

  oper hard_End_VA1_CA_MI : Str -> CommNoun = \dol ->
	 let
	   x = vowAlt1 dol; -- dół:doł
	   y = consAlt x; -- doł:dol
	 in
     	 { s = table { 
	     SF Sg Nom => dol;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => dol;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };
       
       
-- oper for masculine inanimate ending in -ó + hard consonant
-- vowel and consonant alternation
-- (obwód, wschód, przewód, rozwód)
-- 82' paradigm by Grzegorz Jagodziński 
-- 82' by Nowak
-- oper nOgrod for ogród, lód, samochód in GF lexicon

  oper hard_End_VA1_CAL_MI : Str -> CommNoun = \ogrod ->
	let
	  x = vowAlt1 ogrod; -- ogród:ogrod
	  y = consLength (consAlt x); -- ogrod:ogrodz:ogrodzi
	 in
     	{ s = table { 
	    SF Sg Nom => ogrod;
	    SF Sg Gen => x + "u";
	    SF Sg Dat => x + "owi";
	    SF Sg Acc => ogrod;
	    SF Sg Instr => x + "em";
	    SF Sg _ => y + "e";
	    SF Pl Gen => x + "ów";
	    SF Pl Dat => x + "om";
	    SF Pl Instr => x + "ami";
	    SF Pl Loc => x + "ach";
	    SF Pl _ => x + "y" 
            };
	  g = Masc Inanimate
	};
      

-- oper for masculine inanimate ending in a hard consonant
-- vowel alternation,
-- consonant alternation and lengthening
-- (najazd, wszechświat, przyjazd)
-- 82^ paradigm by Grzegorz Jagodziński 
-- 82^_1_1 by Nowak
-- oper nKwiat for kwiat in GF lexicon

  oper hard_End_VA2_CAL_MI : Str -> CommNoun = \kwiat ->
	 let
	   x = kwiat;
	   y = vowAlt2 kwiat; -- kwiet
	   z = consLength (consAlt y); -- kwiet:kwiec:kwieci
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => z + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in a hard consonant
-- vowel alternation,
-- consonant lengthening
-- 82^ paradigm by Grzegorz Jagodziński 
-- 82^_1_2 by Nowak
-- oper nLas for las in GF lexicon

  oper hard_End_VA2_CL_MI : Str -> CommNoun = \las ->
	 let
	   x = las;
	   y = consLength (vowAlt2 x); -- las:les:lesi
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };



-- oper for masculine inanimate for wiatr
-- vowel alternation,
-- consonant alternation
-- 82^ paradigm by Grzegorz Jagodziński 
-- 82^_2 by Nowak
-- oper nWiatr for wiart in GF lexicon
  
  oper wiatr_VA2_CA_MI : Str -> CommNoun = \wiatr ->
	 let
	   x = wiatr;
	   y = consAlt (vowAlt2 x); -- wiatr:wietr:wietrz
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate for "popiół"
-- vowel and consonant alternation
-- 82^' paradigm by Grzegorz Jagodziński 
-- 82^' by Nowak
-- oper nPopiol for popiół in GF lexicon

  oper popiol_VA2_CA_MI : Str -> CommNoun = \popiol ->
	 let
	   x = vowAlt1 popiol; -- popiół:popioł
	   y = consAlt (vowAlt2 x); -- popioł:popieł:popiel
	 in
     	 { s = table { 
	     SF Sg Nom => popiol;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => popiol;
	     SF Sg Instr => x + "em";
	     SF Sg _ => y + "e";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ój
-- vowel alternation
-- last minus
-- (powój, drobnoustrój, strój, zwój)
-- 85' paradigm by Grzegorz Jagodziński (in the big table)
-- 85'_1 by Nowak
-- oper nPokoj for pokój in GF lexicon

  oper onlySgNoun : Str -> CommNoun = \pokoj ->
	 let
	   x = vowAlt1 pokoj; -- pokój:pokoj
	   y = last1Minus x; -- poko
	 in
     	 { s = table { 
	     SF Sg Nom => pokoj;
	     SF Sg Gen => x + "u";
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => pokoj;
	     SF Sg Instr => x + "em";
	     SF Sg _ => x + "u";
	     SF Pl _ => "[" ++ pokoj ++ [": the plural form does not exist]"]
             };
	   g = Masc Inanimate
	 };

-- oper for masculine inanimate ending in a vowel + -j
-- (obyczaj, tramwaj, przywilej, klej) or in a 
-- hardened consonant -ż, -rz, -c, -cz, -dz
-- (Asyż, marsz, pieprz, szkic, wyż, mosiądz)
-- 85 paradigm by Grzegorz Jagodziński 
-- 85_1 + 85_3 by Nowak
-- oper nGaj for kraj, olej, deszcz, owoc in GF lexicon

  oper vowel_j_or_handened_End_MI : Str -> CommNoun = \gaj ->
	 let
	   x = gaj;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "e" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in consonants -g, -k
-- (blok, dotyk, Kołobrzeg, Bug)
-- 87 paradigm by Grzegorz Jagodziński 
-- 87 by Nowak
-- oper nBrzeg for bank, kark in GF lexicon
  
  oper g_k_End_CL_MI_2 : Str -> CommNoun = \brzeg ->
	 let
	   x = brzeg;
	   y = consLength x; 
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => y + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate only for rok
-- 87@ paradigm by Grzegorz Jagodziński 
-- 87@ by Nowak
-- oper nRok for rok in GF lexicon

  oper rok_UnregularyPl_CL_MI : Str -> Str -> CommNoun = \rok, lata ->
	 let
	   x = rok;
	   y = consLength x;
	   z = last1Minus lata;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => y + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => z;
	     SF Pl Dat => z + "om";
	     SF Pl Instr => z + "ami";
	     SF Pl Loc => z + "ach";
	     SF Pl _ => z + "a" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -óg
-- (stóg, głóg, barłóg)
-- 87' paradigm by Grzegorz Jagodziński 
-- 87' by Nowak
-- oper nProg for róg in GF lexicon
  
  oper ug_End_VA1_CL_MI : Str -> CommNoun = \prog ->
	 let
	   x = vowAlt1 prog;
	   y = consLength x;
	 in
     	 { s = table { 
	     SF Sg Nom => prog;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => prog;
	     SF Sg Instr => y + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ek
-- (poniedziałek, obiadek, proszek, początek)
-- 87* paradigm by Grzegorz Jagodziński 
-- 87* by Nowak
-- oper nStatek for piasek in GF lexicon

  oper k_End_CL_FleetingEmins_MI : Str -> CommNoun = \statek ->
	 let
	   x = fleetingEminus statek; -- statk
	   y = consLength x;
	 in
     	 { s = table { 
	     SF Sg Nom => statek;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => statek;
	     SF Sg Instr => y + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "i" 
             };
	   g = Masc Inanimate
	 };


-- oper for masculine inanimate ending in -ch and for dom
-- (oddech, uśmiech, zamach, strych)
-- 88 paradigm by Grzegorz Jagodziński 
-- 88_1 + 88_2 by Nowak
-- oper nDom for dom, dach in GF lexicon

  oper ch_End_dom_MI : Str -> CommNoun = \dom ->
	 let
	   x = dom;
	 in
     	 { s = table { 
	     SF Sg Nom => x;
	     SF Sg Dat => x + "owi";
	     SF Sg Acc => x;
	     SF Sg Instr => x + "em";
	     SF Sg _ => x + "u";
	     SF Pl Gen => x + "ów";
	     SF Pl Dat => x + "om";
	     SF Pl Instr => x + "ami";
	     SF Pl Loc => x + "ach";
	     SF Pl _ => x + "y" 
             };
	   g = Masc Inanimate
	 };
	 
--8 Patterns of auxiliary operations mostly used for nouns 

-- for consonant alternation k:c, g:dz at the end of the subject, 
-- or at the end of the noun
  
  oper consAlt : Str -> Str = \s -> 
	 case s of 
	 { x + "ch" + ("a"|"i"|"e"|"o"|"") => x + "sz" ; -- mucha:musze, klecha:klesze
	   x + "ch" + "y" => x + "s" ; -- głuchy:głusi
	   x + "sn" + ("a"|"i"|"e"|"o"|"y"|"") => x + "śn" ; -- wiosna:wiośnie
	   x + "st" + ("a"|"i"|"e"|"o"|"y"|"") => x + "śc" ; -- artysta:artyście
	   x + "sł" + ("a"|"i"|"e"|"o"|"y"|"") => x + "śl" ; -- krzesło:krześle, masło:maśle
	   x + "dz" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ż" ; -- ksiądz:księża
	   x + "dź" + ("a"|"i"|"e"|"o"|"y"|"") => x + "dz" ; -- łódź:łodzi
	   x + "zn" + ("a"|"i"|"e"|"o"|"y"|"") => x + "źn" ; -- meżczyzna:mężczyźnie
	   x + "zd" + ("a"|"i"|"e"|"o"|"y"|"") => x + "źdz" ; -- gniazdo:gnieździe
	   x + "ni" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ń" ; -- danie:dań
	   x + "ci" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ć" ;
	   x + "sz" + ("a"|"i"|"e"|"o"|"y"|"") => x + "s" ;
	   -----------------------------------------------------------------------
	   -- The alternation of one consonant has to be behind the alternation of
	   -- two other consonants, else they aren't checked.
	   x + "o" + "k" + "o" => "o" + "cz" ;-- oko:oczy
	   x + "ć" + ("a"|"i"|"e"|"o"|"y"|"") => x + "c" ; --sieć:sieci
	   x + "j" + "c" => x + "j" + "cz" ; -- ojciec:ojc:ojcze
	   x + "op" + "c" => x + "op" + "cz" ; -- chłopiec:chłopc:chłopcze
	   x + "ie" + "c" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ie" + "ć" ; -- dziecko:dziećmi
	   x + "óg" + "" => x + "óż" ; -- bóg:boże
	   x + "l" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ł" ; -- przyjaciel:przyjaciół
	   x + "ł" + ("a"|"i"|"e"|"o"|"y"|"") => x + "l" ; -- siła:sile, biegły:biegli
	   x + "yn" + ("a"|"i"|"e"|"o"|"y"|"") => x + "yn" ;
	   x + "n" + ("a"|"i"|"e"|"o"|"y"|"") => x + "n" ;
	   x + "ń" + ("a"|"i"|"e"|"o"|"y"|"") => x + "n" ; -- dzień:dni ,pień:pni, cień:cieni
	   x + "r" + ("a"|"i"|"e"|"o"|"y"|"") => x + "rz" ; -- nora:norze, psychiatra:psychiatrze
	   x + "ś" + ("a"|"i"|"e"|"o"|"y"|"") => x + "s" ; -- pierś:piersi
	   x + "ź" + ("a"|"i"|"e"|"o"|"y"|"") => x + "z" ;
	   x + ("g"|"d") + ("a"|"i"|"e"|"o"|"y"|"") => x + "dz" ; -- noga:nodze; sługa:słudze
	   x + ("k"|"t") + ("a"|"i"|"e"|"o"|"y"|"") => x + "c" ;  -- apteka:aptece; moneta:monecie, tata:tacie
	   x + "c" + ("a"|"i"|"e"|"o"|"y"|"") => x + "ć" ; --brat:bracie:braćmi	   
	   x + "ż" + ("a"|"i"|"e"|"o"|"y"|"") => x + "z" ;
	   _ => last1Minus s  
	 } ;

 

-- Auxiliary operation for consonant lengthening 
-- The consonant in polish is lengthened by a vowel "i"
-- łódź:łodzi, krew:krwi, wieś:wsi

  oper consLength : Str -> Str = \s ->
	 case s of 
	 { x + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + ("a"|"u"|"e"|"o"|"")  
	     => x + y + "i" 
	 } ;
       
-- Auxiliary operation for vowel alternation 
-- o:ó (droga:dróg); 
-- ó:o (nierób:nieroba, łódź:łodzi)

  oper vowAlt1 : Str -> Str = \s ->
	 case s of 
	 { --------------- o:ó -----------------------------------
	   -- 1. nouns ending in a vowel after a consonant
	   -- or in a consonant: woda:wód , doba:dób
	   u + "o" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|   
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + ("a"|"e"|"o"|"y"|"") => u + "ó" + w ;
	   -- 2. nouns ending in a vowel after two consonants
	   -- or in two consonants
	   u + "o" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|  
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + ("a"|"e"|"o"|"y"|"") => u + "ó" + w + x ;
	   -- 3. nouns ending in a vowel after three consonants,
	   -- needed for declension of siostra in nSzkola
	   -- siostra:sióstr 
	   u + "o" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|  
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + x@("a"|"e"|"o"|"y"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + y@("a"|"e"|"o"|"y"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"")
	     + ("a"|"e"|"o"|"y"|"")=> u + "ó" + w + x + y;
	   -------------------------------------------------------
	   --------------- ó:o -----------------------------------
	   -------------------------------------------------------
	   ---- 1. nouns ending in a vowel after a consonant
	   --  łódź:łodzi, sól:soli 
	   u + "ó" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|  
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + ("a"|"e"|"o"|"y"|"") => u + "o" + w ;
	   ---- 2. nouns ending in a vowel after two consonants
	   u + "ó" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + ("a"|"e"|"o"|"y"|"") => u + "o" + w + x ;
	   ---- 3. nouns ending in a vowel after three consonants
	   u + "ó" + w@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|  
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + x@("a"|"e"|"o"|"y"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + y@("a"|"e"|"o"|"y"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"")
	     + ("a"|"e"|"o"|"y"|"")=> u + "o" + w + x + y;
	   _ => s
	     } ;


-- Auxiliary operation for the following vowel alternations:
-- a:e (sąsiad:sąsiedzie, światło:świetle),
-- o:e (anioł:aniele, uczony:uczeni),
-- e:o (nasienie: nasiona, ziele:zioła),
-- ę:o (imię:imiona, znamię:znamiona)

  oper vowAlt2 : Str -> Str = \s ->
	 case s of 
	 { ------------------- a:e, o:e, ó:e -----------------------
	   w + ("a"|"o"|"ó") + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
				"g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
				"p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
				"w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + ("a"|"e"|"o"|"y"|"") => w + "e" + x + y ;
	   ----------------------- e:o, ę:o ------------------------
	   w + ("e"|"ę") + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
				"g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
				"p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
				"w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + y@("a"|"e"|"o"|"y"|"i"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") 
	     + ("a"|"e"|"o"|"y"|"i"|"") => w + "o" + x + y ;
	   _ => s
	 } ;

-- Auxiliary operation for a vowel alternation:
-- ą:ę (gołąb:gołębia, mąż:męża, ksiądz:księdza),
-- ę:ą (ręka:rąk, cielę:cieląt)

  oper vowAlt3 : Str -> Str = \s ->
	 case s of 
	 { ---------------------- ą:ę -----------------------
	   -- noun ending in a consonant
	   x + "ą" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"sł"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"zd"|"") => x + "ę" + y ; 
          --------------------- ą:ę -----------------------
	   -- noun ending in a vowel
	   x + "ą" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"zd") 
	     + ("a"|"o"|"y"|"i") => x + "ę" + y ;
          --------------------- ę:ą -----------------------
	   -- noun ending in a consonant
	   x + "ę" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"zd"|"") => x + "ą" + y ; 
         --------------------- ę:ą -----------------------
	   -- noun ending in a vowel
	   x + "ę" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"| 
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"zd") 
	     + ("a"|"o"|"y"|"i") => x + "ą" + y ;
	   _ => s 
	 } ;


-- The predefined opers like init, drop, take, don't 
-- work correctly with the letters, that are typical only for 
-- polish language. Therefore I must define my own function 
-- (last1Minus, last7Minus, my5Last, my8Last)
-- that work with polish signs (ą, ć, ę, ł, ń, ś, ó, ź, ż, dź, dż).
-- These opers are needed f.e. for the verb conjugation.


-- last1Minus functions work with first (until eight) letters
-- of a word 

  oper last1Minus : Str -> Str = \s ->
	 case s of 
	 { w + ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w;
	   _ => s
	 } ;
     
       
  oper last2Minus : Str -> Str = \s ->
	 case s of 
	 { w + ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w;
	   _ => s
	 } ;
       
              
  oper last3Minus : Str -> Str = \s ->
	 case s of 
	 { w + ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w;
	   _ => s
	 } ;
       

  oper last4Minus : Str -> Str = \s ->
	 case s of 
	 { w + ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w;
	   _ => s
	 } ;

       
  oper last5Minus : Str -> Str = \s ->
	 case s of 
	 { w + ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     ("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w;
            _ => s
	 } ;
       
       
----------------------------------------------------------------------------------------
-- my1Last functions work with last (until eight) letters
-- of words

  oper my1Last : Str -> Str = \s ->
	 case s of 
	 { t + z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => z
	 } ;
       

  oper my2Last: Str -> Str = \s ->
	 case s of 
	 { t + y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => y + z
	 } ;
       
       
  oper my3Last : Str -> Str = \s ->
	 case s of 
	 { t + x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => x + y + z;
	   _ => s
	 } ;


  oper my4Last : Str -> Str = \s ->
	 case s of 
	 { t + w@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż"|"") +
	     x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => w + x + y + z
	 } ;

       
       
  oper my5Last : Str -> Str = \s ->
	 case s of 
	 { t + u@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     w@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +	    
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => u + w + x + y + z
	 } ;


  oper my6Last : Str -> Str = \s ->
	 case s of 
	 { r + t@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     u@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     w@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +	    
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") => t+ u + w + x + y + z
	 } ;


  oper my7Last : Str -> Str = \s ->
	 case s of 
	 { r + q@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"| 
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     t@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     u@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     w@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +	    
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     => q + t + u + w + x + y + z
	 } ;



  oper my8Last : Str -> Str = \s ->
	 case s of 
	 { r + p@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"| 
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     q@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"| 
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     t@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     u@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     w@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") + 
	     x@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +
	     y@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") +	    
	     z@("a"|"ą"|"b"|"c"|"ć"|"ch"|"cz"|"d"|"e"|"ę"|"f"| 
		  "g"|"h"|"i"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|"o"|"ó"|
		  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|"u"|
		  "w"|"y"|"z"|"ź"|"ż"|"dz"|"dź"|"dż") 
	     => p + q + t + u + w + x + y + z
	 } ;


       
-- Auxiliary operation for fleeting e-plus for
-- nouns ending in a vowel like matka
-- subject ending in more than one consonant
-- s. St. Szober, page 184
-- matka:matek, wojna:wojen, skrzydło:skrzydeł 

  oper fleetingEplus : Str -> Str = \s ->
      	 case s of {
	   x + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż") 
	     + z@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż") 
	     + ("a"|"o"|"y"|"")  => x + y + "e" + z 
	 } ;

       
-- Auxiliary operation for fleeting e-minus for
-- nouns ending in a consonant like krew, konew
-- wesz:wszy, krew:krwi, młotek:młotka

  oper fleetingEminus : Str -> Str = \krew ->
	 case krew of 
	 { w + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż") 
	     + "e" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
			  "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
			  "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			  "w"|"z"|"ź"|"ż"|"dź"|"dż") => w + x + y ;
	   x + "ie" => x + "i" ;
	   x + "e" => x
	 } ;


  
-- Auxiliary operation for fleeting ie-plus for
-- nouns like mgła, owca
-- mgła:mgiel, owca:owiec

  oper fleetingIEplus : Str -> Str = \s ->
      	 case s of {
	   x + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż") 
	     + z@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż"|"") 
	     + ("a"|"o"|"y"|"")  => x + y + "ie" + z 
	 } ;
       


-- Auxiliary operation for fleeting ie-minus for
-- nouns ending in a consonant like wieś
-- wieś:wsi, pies:psa, pień:pnia

  oper fleetingIEminus : Str -> Str = \wies ->
	 case wies of 
	 { w + x@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|		  
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż"|"") 
	     + "ie" + y@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
			   "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|
			   "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
			   "w"|"z"|"ź"|"ż"|"dź"|"dż"|"") 
	     + z@("b"|"c"|"ć"|"ch"|"cz"|"d"|"f"|
		    "g"|"h"|"j"|"k"|"l"|"ł"|"m"|"n"|"ń"|
		    "p"|"r"|"rz"|"s"|"ś"|"sz"|"t"|
		    "w"|"z"|"ź"|"ż"|"dź"|"dż"|"") => w + x + y + z ;
	   x + "ie" => x 
	 } ;


-- An operation for fleeting letters-minus for
-- nouns ending in a consonant like chrzest, dzień
-- Not only "ie", but other letters like "zie", "est"
-- must sometimes be put away together.  
-- chrzest:chrztu, dzień:dnia

	    oper fleetingLettersMinus : Str -> Str = \s ->
		   case s of 
		   { d + "zie" + "ń" => d + "n" ; -- dzień:dń
		     d + "est" => d + "t" -- chrzest:chrzt
		   } ;


}
