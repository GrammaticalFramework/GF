concrete StructuralChi of Structural = CatChi **
  open ParadigmsChi, ResChi, Prelude in {

  flags coding = utf8 ;

lin
    every_Det = mkDet "meǐ" Sg ;
        
    this_Quant = mkQuant "zhè" ;
    that_Quant = mkQuant "nǎ" ;

    i_Pron = pronNP "wǒ" ;
    youSg_Pron = pronNP "nǐ" ;
    he_Pron = pronNP "tā" ;
    she_Pron = pronNP "tā" ;
    we_Pron = pronNP "wǒmen" ;
    youPl_Pron = pronNP "nǐmen" ;
    they_Pron = pronNP "tāmen" ;

    very_AdA = ssword "feīcháng" ;

    by8means_Prep = mkPrep [] "pángbiān" mannerAdvType ;
--    in_Prep = mkPrep "lǐ" [];  --- in Paris
    in_Prep = mkPrep "zaì" "zhōng"  ;  --- in the house, the car, etc
    possess_Prep = mkPrep [] "de" ATPoss ;
    with_Prep = mkPrep "hé" "yīqǐ" (ATPlace True) ; -- "with you"
----    with_Prep = mkPrep "hé" [] ; -- "with bread"
 
and_Conj = {s = table {
                    CPhr CNPhrase => mkConjForm "hé" ;
                    CPhr CAPhrase => mkConjForm "ér" ;
                    CPhr CVPhrase => mkConjForm "yoù" ;
                    CSent => mkConjForm "bìngqiě"             --modified by chenpneg 11.19
                          }
                } ;
 or_Conj = {s = table {
                    CPhr _ => mkConjForm "huò" ;
                    CSent => mkConjForm "haíshì"
                          }
                } ;

    although_Subj = mkSubj "suīrán" "dàn";
    because_Subj = mkSubj "yīnweí" "suǒyǐ" ;
    when_Subj = mkSubj [] "deshíhoù" ;

here_Adv = mkAdv "zhèlǐ" ;
there_Adv = mkAdv "nǎlǐ" ;
whoSg_IP, whoPl_IP = mkIPL "sheí" ;
whatSg_IP, whatPl_IP = mkIPL " shénma" ;
where_IAdv = mkIAdvL "nǎlǐ" ;
when_IAdv = mkIAdvL "shénmashíhoù" ;
how_IAdv = mkIAdvL "rúhé" ;
all_Predet = ssword "suǒyoǔ" ;
many_Det = mkDet (word "hěnduō") DTPoss ;
someSg_Det = mkDet (word "yīxiē") Sg ;
somePl_Det = mkDet (word "yīxiē") Sg ;
few_Det = mkDet "shaǒ" Pl ;
other_A = mkA "qítā" ;

oper
  mkIPL, mkIAdvL, mkAdA, mkIDetL, mkPConjL, mkIQuant = ssword ;

-- hsk

lin


above_Prep = mkPrep [] "shàngbiān" ;
after_Prep = mkPrep [] "yǐhoù" timeAdvType ;
under_Prep = mkPrep [] "xià" ;
why_IAdv = mkIAdvL "weíshénma" ;
too_AdA = mkAdA "taì" ;

before_Prep = mkPrep [] "zhīqián" timeAdvType ;
between_Prep = mkPrep [] "zhījiān" ;
but_PConj = mkPConjL "dànshì" ;


    can_VV = mkVerb "néng" [] [] [] [] "bù" ;
    must_VV = mkVerb "bìxū" [] [] [] [] "bù" ; ---- False "bùnéng"
    want_VV = mkVerb "xiǎng" [] [] [] [] "bù" ;

can8know_VV = mkV "huì" [] [] [] [] "bù" ; ----


except_Prep = mkPrep "yǐwaì" "chúle" mannerAdvType ;
for_Prep = mkPrep "weíle" ;
from_Prep = mkPrep "cōng" "" (ATPlace True) ;
in8front_Prep = mkPrep zai_s "qiánbiān"  ;
it_Pron = pronNP "tā" ;
much_Det = mkDet "duō" Sg ;
no_Quant = mkQuant "bù" ;
not_Predet = ssword "bù" ;
otherwise_PConj = mkPConjL "haíshì" ;
to_Prep = mkPrep "wǎng" ;

have_V2 = mkV2 (mkV "yoǔ" "le" "zhaō" "zaì" "guò" "meí") ;

yes_Utt = ss "duì" ;
no_Utt = ss neg_s ;


lin
  always_AdV = ssword "yīzhí" ;
  part_Prep = mkPrep [] "de" ATPoss ;
  language_title_Utt = ssword "zhōngwén" ;
  please_Voc = ss "qǐng" ;
  quite_Adv = mkAdA "déhěn" ;

-- just missing

lin
almost_AdA = ssword "jīhū" ;
almost_AdN = ssword "jīhū" ;
as_CAdv = {s = word "hé" ; p = word "yīyàng" } ; -- modified by chenpeng 11.24
at_least_AdN = ssword "zuìshaǒ" ; -- at least five
at_most_AdN = ssword "zuìduō" ;
behind_Prep = mkPrep "zaì" "hoùmiàn" ;
  
both7and_DConj = {s = table { -- modified by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm2 "baōkuò" "hé" ;
                    CPhr CAPhrase => mkConjForm2 "jí" "yoù" ;
                    CPhr CVPhrase => mkConjForm2 "bùdàn" "érqiě" ;
                    CSent => mkConjForm2 "bùdàn" "érqiě"
                    }
                } ;

by8agent_Prep = mkPrep "beì" [] mannerAdvType; -- by for agent in passive
                                  -- [mark] 被
during_Prep = mkPrep "zaì" "qījiān" timeAdvType ; -- [mark] often equivalent to nothing
                                   -- translation for "he swam during this summer. " and "he swam this summer." are often the same

either7or_DConj = {s = table { -- modified by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm2 "huòzhě" "huòzhě" ;
                    CPhr CAPhrase => mkConjForm2 "yaōma" "yaōma" ;
                    CPhr CVPhrase => mkConjForm2 "yaōma" "yaōma" ;
                    CSent => mkConjForm2 "yaōma" "yaōma"
                    }
                } ;

everybody_NP = ssword "meǐgèrén" ; -- [mark] "meǐgèrén": 每(every)+个(classifier)+人(person)
everything_NP = ssword "meǐjiànshì" ; -- [mark] "meǐjiànshì": 每(every)+件(classifier)+事(thing)
everywhere_Adv = mkAdv "daòchǔ" ;
here7from_Adv = mkAdv "cōngzhèlǐ" ; -- from here
here7to_Adv = mkAdv "daòzhèlǐ" ; -- to here
-- [mark] "cōngzhèlǐ" 从(from) 这里(here)
-- "daòzhèlǐ" 到( to ) 这里(here)
how8many_IDet = mkIDet "duōshaǒ" ;
how8much_IAdv = ssword "duōshaǒ" ;
if_Subj = mkSubj "rúguǒ" [] ; --"jiù" ; -- [mark] "jiù" often comes between NP and VP
less_CAdv = {s = than_s ; p = word "meígēng"} ; -- modified by chenpeng 11.24
more_CAdv = {s = than_s ; p = word "gēng"} ; -- modified by chenpeng 11.24
most_Predet = ssword "dàduōshǔ" ;
if_then_Conj = {s = table { -- added by chenpeng 11.19
                    CPhr CNPhrase => mkConjForm [] ;
                    CPhr CAPhrase => mkConjForm [] ;
                    CPhr CVPhrase => mkConjForm [] ;
                    CSent => mkConjForm2 "rúguǒ" "nǎma"
                    }
                } ;
nobody_NP = ssword "meírén" ;
nothing_NP = ssword "meíyoǔshénma" ;
on_Prep = mkPrep "zaì" "shàng"  ;
only_Predet = ssword "qíyoǔ" ; -- only John
so_AdA = ssword "rúcǐ" ;
somebody_NP = ssword "moǔrén" ;
something_NP = ssword "moǔshì" ; -- [mark] in sent, it depends on the context
somewhere_Adv = mkAdv "moǔchǔ" ;
that_Subj = mkSubj [] chcomma ; -- that + S [mark] comma
there7from_Adv = mkAdv "cōngnǎlǐ" ; -- from there
there7to_Adv = mkAdv "daònǎlǐ" ;
therefore_PConj = ssword "yīncǐ" ;
through_Prep = mkPrep "tōngguò" ;
which_IQuant = mkIQuant "nǎ" ; -- 
--which_IQuant = ssword [] ; -- [mark] in sent, it depends on the context
without_Prep = mkPrep "meíyoǔ" [] mannerAdvType ;
youPol_Pron = ssword "nín" ; -- polite you

}
