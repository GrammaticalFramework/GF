concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, ParadigmsBul, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = mkPrep "над" Acc ;
  after_Prep = mkPrep "след" Acc ;
  all_Predet = {s = table GenNum ["всичкия";"всичката";"всичкото";"всичките"]} ;
  almost_AdA, almost_AdN = ss "почти" ;
{-  although_Subj = ss "although" ;
  always_AdV = ss "always" ;
  and_Conj = ss "and" ** {n = Pl} ;
-}
  because_Subj = ss "защото" ;
  before_Prep = mkPrep "преди" Acc ;
  behind_Prep = mkPrep "зад" Acc ;
  between_Prep = mkPrep "между" Acc ;
{-
  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "but" ;
-}
  by8agent_Prep = mkPrep "чрез" Acc ;
  by8means_Prep = mkPrep "чрез" Acc ;
{-
  can8know_VV, can_VV = {
    s = table { 
      VVF VInf => ["be able to"] ;
      VVF VPres => "can" ;
      VVF VPPart => ["been able to"] ;
      VVF VPresPart => ["being able to"] ;
      VVF VPast => "could" ;      --# notpresent
      VVPastNeg => "couldn't" ;   --# notpresent
      VVPresNeg => "can't"
      } ;
    isAux = True
    } ;
-}
  during_Prep = mkPrep ["по време на"] Acc ;
{-
  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
  everybody_NP = regNP "everybody" Sg ;
-}
  every_Det = mkDeterminerSg "всеки" "всяка" "всяко";
{-
  everything_NP = regNP "everything" Sg ;
-}
  everywhere_Adv = ss "навсякъде" ;
  few_Det = {s = \\_,_ => "няколко"; n = Pl; countable = True; spec = Indef} ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "за" Acc ;
  from_Prep = mkPrep "от" Acc ;
  he_Pron = mkPron "той" "него" "му" "свой" "своя" "своят" "своя" "своята" "свое" "своето" "свои" "своите" (GSg Masc) P3 ;
  here_Adv = ss "тук" ;
  here7to_Adv = ss ["до тук"] ;
  here7from_Adv = ss ["от тук"] ;
  how_IAdv = ss "как" ;
  how8many_IDet = {s = \\_ => "колко"; n = Pl} ;
  if_Subj = ss "ако" ;
  in8front_Prep = mkPrep "пред" Acc ;
  i_Pron  = mkPron "аз" "мен" "ми" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Masc) P1 ;
  in_Prep = mkPrep (pre { "в" ; 
                          "във" / strs {"в" ; "ф" ; "В" ; "Ф"}
                        }) Acc ;
  it_Pron  = mkPron "то" "него" "му" "негов" "неговия" "неговият" "негова" "неговата" "негово" "неговото" "негови" "неговите" (GSg Neut) P3 ;
  less_CAdv = {s="не"; sn="по-малко"} ;
  many_Det = mkDeterminerPl "много" ;
  more_CAdv = {s=[]; sn="повече"} ;
  most_Predet = {s = \\_ => "повечето"} ;
  much_Det = mkDeterminerSg "много" "много" "много";
{-
  must_VV = {
    s = table {
      VVF VInf => ["have to"] ;
      VVF VPres => "must" ;
      VVF VPPart => ["had to"] ;
      VVF VPresPart => ["having to"] ;
      VVF VPast => ["had to"] ;      --# notpresent
      VVPastNeg => ["hadn't to"] ;      --# notpresent
      VVPresNeg => "mustn't"
      } ;
    isAux = True
    } ;
-}
  no_Phr = ss "не" ;
  on_Prep = mkPrep "на" Acc ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "само"} ;
{-
  or_Conj = ss "or" ** {n = Sg} ;
  otherwise_PConj = ss "otherwise" ;
-}
  part_Prep = mkPrep "от" Acc ;
{-
  please_Voc = ss "please" ;
-}
  possess_Prep = mkPrep [] Dat ;
  quite_Adv = ss "доста" ;
  she_Pron = mkPron "тя" "нея" "и" "неин" "нейния" "нейният" "нейна" "нейната" "нейно" "нейното" "нейни" "нейните" (GSg Fem) P3 ;
  so_AdA = ss "толкова" ;
{-
  somebody_NP = regNP "somebody" Sg ;
  someSg_Det = mkDeterminerSg "някой" "някое" "някоя" ;
  somePl_Det = mkDeterminerPl "някои" ;
  something_NP = regNP "something" Sg ;
-}
  somewhere_Adv = ss "някъде" ;
  that_Quant = mkQuant "онзи" "онази" "онова" "онези" ;
{-
  that_NP = regNP "that" Sg ;
-}
  there_Adv = ss "там" ;
  there7to_Adv = ss ["до там"] ;
  there7from_Adv = ss ["от там"] ;
{-
  therefore_PConj = ss "therefore" ;
  these_NP = regNP "these" Pl ;
-}
  they_Pron = mkPron "те" "тях" "им" "техен" "техния" "техният" "тяхна" "тяхната" "тяхно" "тяхното" "техни" "техните" GPl P3 ; 
  this_Quant = mkQuant "този" "тaзи" "това" "тези" ;
{-
  this_NP = regNP "this" Sg ;
  those_NP = regNP "those" Pl ;
-}
  through_Prep = mkPrep "през" Acc ;
  too_AdA = ss "прекалено" ;
  to_Prep = mkPrep "до" Acc ;
  under_Prep = mkPrep "под" Acc ;
  very_AdA = ss "много" ;
{-
  want_VV = P.mkVV (P.regV "want") ;
-}
  we_Pron = mkPron "ние" "нас" "ни" "наш" "нашия" "нашият" "наша" "нашата" "наше" "нашето" "наши" "нашите" GPl P1 ;
  whatPl_IP = mkIP "какви" "какви" GPl ;
  whatSg_IP = mkIP "какъв" "какъв" (GSg Masc) ;
  when_IAdv = ss "кога" ;
{-
  when_Subj = ss "when" ;
-}
  where_IAdv = ss "къде" ;
  whichPl_IDet = {s = table GenNum ["кой";"коя";"кое";"кои"]; n = Pl} ;
  whichSg_IDet = {s = table GenNum ["кой";"коя";"кое";"кои"]; n = Sg} ;
  whoSg_IP = mkIP "кой" "кого" (GSg Masc) ;
  whoPl_IP = mkIP "кои" "кого" GPl ;
  why_IAdv = ss "защо" ;
  without_Prep = mkPrep "без" Acc ;
  with_Prep = mkPrep (pre { "с" ; 
                            "със" / strs {"с" ; "з" ; "С" ; "З"}
                          }) Acc ;
  yes_Phr = ss "да" ;
  youSg_Pron = mkPron "ти" "теб" "ти" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Masc) P2 ;
  youPl_Pron = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl P2 ;
  youPol_Pron = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" (GSg Masc) P2 ;
}

