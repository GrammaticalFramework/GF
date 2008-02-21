concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, (P = ParadigmsBul), Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "над" ;
  after_Prep = ss "след" ;
  all_Predet = {s = table GenNum ["всичкия";"всичката";"всичкото";"всичките"]} ;
  almost_AdA, almost_AdN = ss "почти" ;
{-  although_Subj = ss "although" ;
  always_AdV = ss "always" ;
  and_Conj = ss "and" ** {n = Pl} ;
-}
  because_Subj = ss "защото" ;
  before_Prep = ss "преди" ;
  behind_Prep = ss "зад" ;
  between_Prep = ss "между" ;
{-
  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "but" ;
-}
  by8agent_Prep = ss "чрез" ;
  by8means_Prep = ss "чрез" ;
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
  during_Prep = ss ["по време на"] ;
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
  for_Prep = ss "за" ;
  from_Prep = ss "от" ;
  he_Pron = mkNP "той" "него" "свой" "своя" "своят" "своя" "своята" "свое" "своето" "свои" "своите" (GSg Masc) P3 ;
  here_Adv = ss "тук" ;
  here7to_Adv = ss ["до тук"] ;
  here7from_Adv = ss ["от тук"] ;
  how_IAdv = ss "как" ;
  how8many_IDet = mkDeterminerPl ["колко много"] ;
  if_Subj = ss "ако" ;
  in8front_Prep = ss "пред" ;
  i_Pron  = mkNP "аз" "мен" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Masc) P1 ;
  in_Prep = ss (pre { "в" ; 
                      "във" / strs {"в" ; "ф" ; "В" ; "Ф"}
                    }) ;
  it_Pron  = mkNP "то" "него" "негов" "неговия" "неговият" "негова" "неговата" "негово" "неговото" "негови" "неговите" (GSg Neut) P3 ;
  less_CAdv = ss "помалко" ;
  many_Det = mkDeterminerPl "много" ;
  more_CAdv = ss "още" ;
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
  on_Prep = ss "на" ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "само"} ;
{-
  or_Conj = ss "or" ** {n = Sg} ;
  otherwise_PConj = ss "otherwise" ;
-}
  part_Prep = ss "от" ;
{-
  please_Voc = ss "please" ;
-}
  possess_Prep = ss "на" ;
  quite_Adv = ss "доста" ;
  she_Pron = mkNP "тя" "нея" "неин" "нейния" "нейният" "нейна" "нейната" "нейно" "нейното" "нейни" "нейните" (GSg Fem) P3 ;
{-
  so_AdA = ss "so" ;
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
  they_Pron = mkNP "те" "тях" "техен" "техния" "техният" "тяхна" "тяхната" "тяхно" "тяхното" "техни" "техните" GPl P3 ; 
  this_Quant = mkQuant "този" "тaзи" "това" "тези" ;
{-
  this_NP = regNP "this" Sg ;
  those_NP = regNP "those" Pl ;
-}
  through_Prep = ss "през" ;
{-
  too_AdA = ss "too" ;
-}
  to_Prep = ss "до" ;
  under_Prep = ss "под" ;
{-
  very_AdA = ss "very" ;
  want_VV = P.mkVV (P.regV "want") ;
-}
  we_Pron = mkNP "ние" "нас" "наш" "нашия" "нашият" "наша" "нашата" "наше" "нашето" "наши" "нашите" GPl P1 ;
  whatPl_IP = mkIP "какви" GPl ;
  whatSg_IP = mkIP "какъв" (GSg Masc) ;
  when_IAdv = ss "кога" ;
{-
  when_Subj = ss "when" ;
-}
  where_IAdv = ss "къде" ;
{-
  whichPl_IDet = mkDeterminer Pl ["which"] ;
  whichSg_IDet = mkDeterminer Sg ["which"] ;
-}
  whoSg_IP = mkIP "кой" (GSg Masc) ;
  whoPl_IP = mkIP "кои" GPl ;
  why_IAdv = ss "защо" ;
  without_Prep = ss "без" ;
  with_Prep = ss (pre { "с" ; 
                        "със" / strs {"с" ; "з" ; "С" ; "З"}
                      }) ;
  yes_Phr = ss "да" ;
  youSg_Pron = mkNP "ти" "теб" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Masc) P2 ;
  youPl_Pron = mkNP "вие" "вас" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl P2 ;
  youPol_Pron = mkNP "вие" "вас" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" (GSg Masc) P2 ;
}

