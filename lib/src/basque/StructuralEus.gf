concrete StructuralEus of Structural = CatEus ** 
              open Prelude, (R=ResEus), (N=NounEus), ParadigmsEus in {



-------
-- Ad*

lin almost_AdA = mkAdA "ia" ;
lin almost_AdN = ss "ia" ;
lin at_least_AdN = ss "gutxienez" ;
lin at_most_AdN = ss "gehienez" ;
lin so_AdA = ss "hain" ;
lin too_AdA = ss "gehiegi" ;
lin very_AdA = mkAdA "oso" ;

lin as_CAdv = { s = "bezain" ; p = [] } ;
lin less_CAdv = { s = "gutxiago" ; p = [] } ;
lin more_CAdv = { s = "gehiago" ; p = [] } ;

lin how_IAdv = ss "nola" ;
lin how8much_IAdv = ss "zerbait" ;
lin when_IAdv = ss "noiz" ;
lin where_IAdv = ss "non" ;
lin why_IAdv = ss "zergatik" ;

lin always_AdV = ss "beti" ;

lin everywhere_Adv = ss "nonahi" ;
lin here7from_Adv = ss "hemendik" ;
lin here7to_Adv = ss "hona" ;
lin here_Adv = ss "hemen" ;
lin quite_Adv = ss "nahiko" ;
lin somewhere_Adv = ss "nonbait" ;
lin there7from_Adv = ss "hortik" ;
lin there7to_Adv = ss "horra" ;
lin there_Adv = ss "hor" ;


-------
-- Conj

lin and_Conj = mkConj [] "eta" pl ; 
lin or_Conj  = mkConj [] "edo" sg ;
lin if_then_Conj = mkConj [] "orduan" sg ; --TODO: is there even a way to say this? "if boys then girls"
lin both7and_DConj = mkConj "bai" "eta" pl ;
lin either7or_DConj = mkConj "bai" "edo" pl ;

lin but_PConj = ss "baina" ;
lin otherwise_PConj = ss "bestela" ;
--lin therefore_PConj


-----------------
-- *Det and Quant

lin how8many_IDet = R.indefDet "zenbat" pl ; 

--TODO: fix predets in NounEus, figure out whether Predet should inflect
lin all_Predet = { s = "guzti" } ; 
lin not_Predet = { s = "ez" } ;
lin only_Predet = { s = "bakarrik" } ;
lin most_Predet = { s = "gehien" } ;

lin every_Det = R.defDet [] sg ** -- egun+ero "every day" --TODO: urtero *urte+ero
                 { s = \\c,_ => SOFT_BIND ++ "ero" 
                              ++ R.artDef ! R.Sg ! c ! R.FinalVow } ; 
lin few_Det = R.indefDet "gutxi" pl ;
lin many_Det = R.indefDet "asko" pl ;
lin much_Det = R.indefDet "asko" sg ;
lin somePl_Det = R.indefDet "zenbait" pl ;
lin someSg_Det = R.indefDet "zenbait" sg ;

lin no_Quant = R.indefDet "ez" sg ** { s = R.artDef } ; --TODO: this is just the word for "no"; not even sure if it's possible to have no_Quant

lin that_Quant = R.defDet [] sg ** { s = R.quantHori } ;
lin this_Quant = R.defDet [] sg ** { s = R.quantHau } ;
lin which_IQuant = R.defDet "zein" sg ** { s = R.artDef } ;


-----
-- NP

lin everybody_NP = defNP "dena" N.NumPl ;
lin everything_NP = defNP "dena" N.NumSg ;
lin nobody_NP = defNP "ez inor" N.NumSg ; --TODO: negation should be in the verb; "ez da inor"
lin nothing_NP = defNP "ezer" N.NumSg ;
--lin somebody_NP =
--lin something_NP =

oper 
 defNP : Str -> Num -> NP = \dena,num ->
   N.DetCN (N.DetQuant N.DefArt num) 
           (N.UseN (R.mkNoun dena)) ;
-------
-- Prep

lin above_Prep = mkPrep "gainean" ;
lin after_Prep = mkPrep "ondoan" ;
lin before_Prep = mkPrep "gabe" absolutive ;
lin behind_Prep = mkPrep "atzean"  ;
lin between_Prep = mkPrep "artean"  ; --`bitartean' for time
lin by8agent_Prep = mkPrep [] ergative ; -- choose just case, no separate postposition
lin by8means_Prep = mkPrep [] instrumental ;
lin during_Prep = mkPrep [] inessive ; --- ???
lin except_Prep = mkPrep "gain" sociative ;
lin for_Prep = affixPrep "tzat" genitive ;
lin from_Prep = locPrep "tik" ; --- ?
lin in8front_Prep = mkPrep "aurrean"  ;
lin in_Prep = mkPrep [] inessive ;
lin on_Prep = mkPrep "gainean"   ; 
lin part_Prep = mkPrep [] partitive ; 
lin possess_Prep = mkPrep [] ; --Genitive. TODO add locative genitive in extra
lin through_Prep = mkPrep "barrena" inessive  ; -- ?
lin to_Prep = mkPrep [] dative ; --"I gave it to Fran", not "I went to school"
lin under_Prep = mkPrep "azpian"   ;
lin with_Prep = mkPrep [] sociative ;
lin without_Prep = mkPrep "gabe" partitive ; --absolutive ; 


-------
-- Pron

-- Pronouns are closed class, no constructor in ParadigmsEus.

lin i_Pron = R.persPron "ni" "niri" "nik" "nire" "nitaz" R.Ni ;
lin we_Pron = R.persPron "gu" "guri" "guk" "gure" "gutaz" R.Gu ;
lin youSg_Pron = R.persPron "zu" "zuri" "zuk" "zure" "zutaz" R.Zu ; -- in Extra: hi/hire
lin youPl_Pron = R.persPron "zuek" "zuei" "zuen" "zuen" "zuetaz" R.Zuek ;
lin youPol_Pron =  R.persPron "zu" "zuri" "zuk" "zure" "zutaz" R.Zu ;
lin he_Pron = R.persPron "hura" "hari" "hark" "haren" "hartaz" R.Hau ;
lin she_Pron = R.persPron "hura" "hari" "hark" "haren" "hartaz" R.Hau ;
lin it_Pron = R.persPron "hau" "honi" "honek" "bere" "honetaz" R.Hau ;
lin they_Pron = R.persPron "hauek" "hauei" "hauek" "beren" "hauetaz" R.Hauek ; -- in Extra: other forms
 
lin whatPl_IP = R.inanPron "zertzuk" "zertzuei" "zertzuek" "zertzuen" "zertzuetaz" R.Hauek ;
lin whatSg_IP = R.inanPron "zer" "zeri" "zerk" "zeren" "zertaz" R.Hau ;
lin whoPl_IP = R.persPron "nortzuk" "nortzuei" "nortzuek" "nortzuen" "nortzuetaz" R.Hauek ;
lin whoSg_IP = R.persPron "nor" "nori" "nork" "noren" "zertaz" R.Hau ;




-------
-- Subj

lin although_Subj = mkSubj "en arren" False ; -- askotan ez dirudien arren
lin because_Subj  = mkSubj "lako" False ;
lin if_Subj = mkSubj "ba" True ;
lin that_Subj = mkSubj "n" False ;
lin when_Subj = mkSubj "nean" False ;



------
-- Utt

lin language_title_Utt = ss "euskara" ;
lin no_Utt = ss "ez" ; --?
lin yes_Utt = ss "bai" ;


-------
-- Verb

lin have_V2 = R.syntVerbDu "eduki" R.Eduki ;

lin can8know_VV = ukanV "ahal" ; -- can (capacity)
lin can_VV = ukanV "ahal" ;      -- can (possibility)
lin must_VV = ukanV "behar" ;
lin want_VV = ukanV "nahi" ;


------
-- Voc

lin please_Voc = ss "mesedez" ;

}
