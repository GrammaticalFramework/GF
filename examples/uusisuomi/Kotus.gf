--# -path=.:alltenses

resource Kotus = Declensions ** open MorphoFin,CatFin,Prelude in {

oper

  d01 : Str -> NForms -- 1780 öljy
    = \s -> dUkko s (s + "n") ;
  d01A : Str -> NForms -- 166 yökkö
    = \s -> dUkko s (weakGrade s + "n") ;
  d02 : Str -> NForms -- 1189 ääntely
    = \s -> dSilakka s (s + "n") (s + "j" + getHarmony (last s)) ;
  d03 : Str -> NForms -- 481 ääntiö
    = \s -> dSilakka s (s + "n") (s + "it" + getHarmony (last s)) ;
  d04A : Str -> NForms -- 273 äpärikkö
    = \s -> let ws = weakGrade s in 
      dSilakka s (ws + "n") (ws + "it" + getHarmony (last s)) ;
  d05 : Str -> NForms -- 3212 öljymaali
    = \s -> dPaatti s (s + "n") ;
  d05A : Str -> NForms -- 1959 öylätti
    = \s -> dPaatti s (weakGrade s + "n") ;
  d06 : Str -> NForms -- 1231 öykkäri
    = \s -> dTohtori s ;
  d07 : Str -> NForms -- 81 vuoksi
    = \s -> dArpi s (init s + "en") ;
  d07A : Str -> NForms -- 70 väki
    = \s -> dArpi s (init (weakGrade s) + "en") ;
  d08 : Str -> NForms -- 99 à la carte
    = \s -> dNukke s (s + "n") ;
  d08A : Str -> NForms -- 5 vinaigrette
    = \s -> dNukke s (weakGrade s + "n") ;
  d09 : Str -> NForms -- 696 ääriraja
    = \s -> dUkko s (s + "n") ;
  d09A : Str -> NForms -- 1040 ääniraita
    = \s -> dUkko s (s + weakGrade "n") ;
  d10 : Str -> NForms -- 2119 äänittäjä
    = \s -> dSilakka s (s + "n") (init s + "i" + getHarmony (last s)) ;
  d10A : Str -> NForms -- 284 änkkä
    = \s -> dUkko s (weakGrade s + "n") ;
  d11 : Str -> NForms -- 46 ödeema
    = \s -> dUkko s (s + "n") ;
  d12 : Str -> NForms -- 1125 örinä
    = \s -> let a = getHarmony (last s) in 
      dSilakka s (s + "n") 
        (init s + case a of {"a" => "o" ; _ => "ö"} + "it" + a) ;
  d13 : Str -> NForms -- 157 virtaska
    = \s -> let a = getHarmony (last s) in 
      dSilakka s (s + "n") 
        (init s + case a of {"a" => "o" ; _ => "ö"} + "j" + a) ;
  d14A : Str -> NForms -- 244 ötökkä
    = \s -> let a = getHarmony (last s) ; ws = weakGrade s in 
      dSilakka s (ws + "n") 
        (init ws + case a of {"a" => "o" ; _ => "ö"} + "it" + a) ;
  d15 : Str -> NForms -- 170 äreä
    = dKorkea ;
----  d16 : Str -> NForms -- 2 kumpikin
----    = \s ->  ;
  d16A : Str -> NForms -- 20 ylempi
    = dSuurempi ;
  d17 : Str -> NForms -- 38 virkkuu
    = dPaluu ;
  d18 : Str -> NForms -- 84 yksi-ilmeinen --- ?? voi, tee, sää
    = dPuu ;
  d19 : Str -> NForms -- 6 yö
    = dSuo  ;
  d20 : Str -> NForms -- 46 voodoo
    = dPaluu ;
  d21 : Str -> NForms -- 22 tax-free
    = dPuu ;
----  d22 : Str -> NForms -- 13 tournedos
----    = \s ->  ;
  d23 : Str -> NForms -- 9 vuohi
    = \s -> dArpi s (init s + "en") ;
  d24 : Str -> NForms -- 20 uni
    = \s -> dArpi s (init s + "en") ;
  d25 : Str -> NForms -- 9 tuomi
    = \s -> dArpi s (init s + "en") ;
  d26 : Str -> NForms -- 113 ääri
    = \s -> dArpi s (init s + "en") ;
  d27 : Str -> NForms -- 23 vuosi
    = \s -> dArpi s (Predef.tk 2 s + "den") ;
  d28 : Str -> NForms -- 13 virsi
    = \s -> dArpi s (Predef.tk 2 s + "ren") ;
  d28A : Str -> NForms -- 1 jälsi
    = \s -> dArpi s (Predef.tk 2 s + "len") ;
----  d29 : Str -> NForms -- 1 lapsi
----    = \s ->  ;
----  d30 : Str -> NForms -- 2 veitsi
----    = \s ->  ;
----  d31 : Str -> NForms -- 3 yksi
----    = \s ->  ;
  d32 : Str -> NForms -- 20 uumen
    = \s -> dPiennar s (s + "en") ;
  d32A : Str -> NForms -- 54 ystävätär
    = \s -> dPiennar s (strongGrade (init s) + last s + "en") ;
  d33 : Str -> NForms -- 168 väistin
    = \s -> dLiitin s (init s + "men") ;
  d33A : Str -> NForms -- 181 yllytin
    = \s -> dLiitin s (strongGrade (init s) + "men") ;
----  d34 : Str -> NForms -- 1 alaston
----    = dOnneton ;
  d34A : Str -> NForms -- 569 ääretön
    = dOnneton ;
----  d35A : Str -> NForms -- 1 lämmin
----    = \s ->  ;
  d36 : Str -> NForms -- 11 ylin
    = dSuurin ;
----  d37 : Str -> NForms -- 1 vasen
----    = \s ->  ;
  d38 : Str -> NForms -- 4195 öykkärimäinen
    = dNainen ;
  d39 : Str -> NForms -- 2730 örähdys
    = dJalas ;
  d40 : Str -> NForms -- 2482 öykkärimäisyys
    = dLujuus  ;
  d41 : Str -> NForms -- 127 äyräs
    = \s -> let is = init s in dRae s (is + last is ++ "n") ;
  d41A : Str -> NForms -- 401 öljykangas
    = \s -> let is = init s in dRae s (strongGrade is + last is ++ "n") ;
----  d42 : Str -> NForms -- 1 mies
----    = \s ->  ;
  d43 : Str -> NForms -- 11 tiehyt
    = \s -> dRae s (init s + "en") ;
  d43A : Str -> NForms -- 1 immyt
    = \s -> dRae s (strongGrade (init s) + "en") ;
----  d44 : Str -> NForms -- 1 kevät
----    = \s ->  ;
----  d45 : Str -> NForms -- 23 yhdes
----    = \s ->  ;
----  d46 : Str -> NForms -- 1 tuhat
----    = \s ->  ;
  d47 : Str -> NForms -- 46 ylirasittunut
    = dOttanut ;
  d48 : Str -> NForms -- 346 äpäre
    = \s -> dRae s (s + "en") ;
  d48A : Str -> NForms -- 481 äänne
    = \s -> dRae s (strongGrade s + "en") ;
  d49 : Str -> NForms -- 31 vempele
    = \s -> dRae s (s + "en") ;
----  d49A : Str -> NForms -- 11 vemmel
----    = \s ->  ;
{-
  d50 : Str -> NForms -- 520 vääräsääri
    = \s ->  ;
  d51 : Str -> NForms -- 62 vierasmies
    = \s ->  ;
  c52 : Str -> VForms -- 667 ärjyä
    = \s ->  ;
  c52A : Str -> VForms -- 1568 öljyyntyä
    = \s ->  ;
  c53 : Str -> VForms -- 605 äänestää
    = \s ->  ;
  c53A : Str -> VForms -- 2121 örähtää
    = \s ->  ;
  c54 : Str -> VForms -- 2 pieksää
    = \s ->  ;
  c54A : Str -> VForms -- 316 ääntää
    = \s ->  ;
  c55A : Str -> VForms -- 7 yltää
    = \s ->  ;
  c56 : Str -> VForms -- 22 valaa
    = \s ->  ;
  c56A : Str -> VForms -- 28 virkkaa
    = \s ->  ;
  c57A : Str -> VForms -- 3 saartaa
    = \s ->  ;
  c58 : Str -> VForms -- 13 suitsea
    = \s ->  ;
  c58A : Str -> VForms -- 19 tunkea
    = \s ->  ;
  c59A : Str -> VForms -- 1 tuntea
    = \s ->  ;
  c60A : Str -> VForms -- 1 lähteä
    = \s ->  ;
  c61 : Str -> VForms -- 249 äyskiä
    = \s ->  ;
  c61A : Str -> VForms -- 153 vääntelehtiä
    = \s ->  ;
  c62 : Str -> VForms -- 684 öykkäröidä
    = \s ->  ;
  c63 : Str -> VForms -- 3 saada
    = \s ->  ;
  c64 : Str -> VForms -- 8 viedä
    = \s ->  ;
  c65 : Str -> VForms -- 1 käydä
    = \s ->  ;
  c66 : Str -> VForms -- 268 öristä
    = \s ->  ;
  c66A : Str -> VForms -- 3 vavista
    = \s ->  ;
  c67 : Str -> VForms -- 704 ällistellä
    = \s ->  ;
  c67A : Str -> VForms -- 634 äännellä
    = \s ->  ;
  c68 : Str -> VForms -- 49 viheriöidä
    = \s ->  ;
  c69 : Str -> VForms -- 48 villitä
    = \s ->  ;
  c70 : Str -> VForms -- 3 syöstä
    = \s ->  ;
  c71 : Str -> VForms -- 2 tehdä
    = \s ->  ;
  c72 : Str -> VForms -- 93 yletä
    = \s ->  ;
  c72A : Str -> VForms -- 52 yhdetä
    = \s ->  ;
  c73 : Str -> VForms -- 600 äkseerata
    = \s ->  ;
  c73A : Str -> VForms -- 313 änkätä
    = \s ->  ;
  c74 : Str -> VForms -- 99 öljytä
    = \s ->  ;
  c74A : Str -> VForms -- 72 ängetä
    = \s ->  ;
  c75 : Str -> VForms -- 39 viritä
    = \s ->  ;
  c75A : Str -> VForms -- 9 siitä
    = \s ->  ;
  c76A : Str -> VForms -- 2 tietää
    = \s ->  ;
  c77 : Str -> VForms -- 3 vipajaa
    = \s ->  ;
  c78 : Str -> VForms -- 31 ähkää
    = \s ->  ;
  c78A : Str -> VForms -- 1 tuikkaa
    = \s ->  ;
  c99 : Str -> VForms -- 5453 öykkärimäisesti
    = \s ->  ;
-}

}

