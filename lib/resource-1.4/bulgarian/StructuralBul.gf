concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, ParadigmsBul, Prelude in {
  flags coding=cp1251 ;


  flags optimize=all ;

  lin
  above_Prep = mkPrep "над" Acc ;
  after_Prep = mkPrep "след" Acc ;
  all_Predet = {s = table GenNum ["всичкия";"всичката";"всичкото";"всичките"]} ;
  almost_AdA, almost_AdN = ss "почти" ;
  although_Subj = ss ["въпреки че"] ;
  always_AdV = ss "винаги" ;
  and_Conj = {s=[]; conj=True; distr=False; n = Pl} ;
  because_Subj = ss "защото" ;
  before_Prep = mkPrep "преди" Acc ;
  behind_Prep = mkPrep "зад" Acc ;
  between_Prep = mkPrep "между" Acc ;
  both7and_DConj = {s=[]; conj=True; distr=True; n = Pl} ;
  but_PConj = ss "но" ;
  by8agent_Prep = mkPrep "чрез" Acc ;
  by8means_Prep = mkPrep "чрез" Acc ;
  can8know_VV, can_VV = mkVV (stateV (mkV166 "мога")) ;
  during_Prep = mkPrep ["по време на"] Acc ;
  either7or_DConj = {s=[]; conj=False; distr=True; n = Sg} ;
  everybody_NP = mkNP "всеки" (GSg Masc) P3 ;
  every_Det = mkDeterminerSg "всеки" "всяка" "всяко";
  everything_NP = mkNP "всичко" (GSg Neut) P3 ;
  everywhere_Adv = ss "навсякъде" ;
  few_Det = {s = \\_,_ => "няколко"; n = Pl; countable = True; spec = Indef} ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "за" Acc ;
  from_Prep = mkPrep "от" Acc ;
  he_Pron = mkPron "той" "него" "му" "негов" "неговия" "неговият" "негова" "неговата" "негово" "неговото" "негови" "неговите" (GSg Masc) P3 ;
  here_Adv = ss "тук" ;
  here7to_Adv = ss ["до тук"] ;
  here7from_Adv = ss ["от тук"] ;
  how_IAdv = mkIAdv "как" ;
  how8many_IDet = {s = \\_ => table QForm ["колко";"колкото"]; n = Pl; nonEmpty = False} ;
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
  must_VV = 
    mkVV {
         s = \\_=>table {
                    VPres      _ _ => "трябва" ;
                    VAorist    _ _ => "трябваше" ;
                    VImperfect _ _ => "трябвало" ;
                    VPerfect     _ => "трябвало" ;
                    VPluPerfect  _ => "трябвало" ;
                    VPassive     _ => "трябвало" ;
                    VPresPart    _ => "трябвало" ;
                    VImperative Sg => "трябвай"  ;
                    VImperative Pl => "трябвайте" ;
                    VGerund        => "трябвайки"
                  } ;
         vtype=VNormal ;
         lock_V=<>
       } ;
  no_Utt = ss "не" ;
  on_Prep = mkPrep "на" Acc ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "само"} ;
  or_Conj = {s=[]; conj=False; distr=False; n = Sg} ;
  otherwise_PConj = ss "иначе" ;
  part_Prep = mkPrep "от" Acc ;
  please_Voc = ss "моля" ;
  possess_Prep = mkPrep [] Dat ;
  quite_Adv = ss "доста" ;
  she_Pron = mkPron "тя" "нея" "и" "неин" "нейния" "нейният" "нейна" "нейната" "нейно" "нейното" "нейни" "нейните" (GSg Fem) P3 ;
  so_AdA = ss "толкова" ;
  somebody_NP = mkNP "някой" (GSg Masc) P3 ;
  someSg_Det = mkDeterminerSg "някой" "някоя" "някое" ;
  somePl_Det = mkDeterminerPl "някои" ;
  something_NP = mkNP "нещо" (GSg Neut) P3 ;
  somewhere_Adv = ss "някъде" ;
  that_Quant = mkQuant "онзи" "онази" "онова" "онези" ;
  there_Adv = ss "там" ;
  there7to_Adv = ss ["до там"] ;
  there7from_Adv = ss ["от там"] ;
  therefore_PConj = ss ["така че"] ;
  they_Pron = mkPron "те" "тях" "им" "техен" "техния" "техният" "тяхна" "тяхната" "тяхно" "тяхното" "техни" "техните" GPl P3 ; 
  this_Quant = mkQuant "този" "тази" "това" "тези" ;
  through_Prep = mkPrep "през" Acc ;
  too_AdA = ss "прекалено" ;
  to_Prep = mkPrep "до" Acc ;
  under_Prep = mkPrep "под" Acc ;
  very_AdA = ss "много" ;
  want_VV = mkVV (stateV (mkV186 "искам")) ;
  we_Pron = mkPron "ние" "нас" "ни" "наш" "нашия" "нашият" "наша" "нашата" "наше" "нашето" "наши" "нашите" GPl P1 ;
  whatPl_IP = mkIP "какви" "какви" GPl ;
  whatSg_IP = mkIP "какъв" "какъв" (GSg Masc) ;
  when_IAdv = mkIAdv "кога" ;
  when_Subj = ss "когато" ;
  where_IAdv = mkIAdv "къде" ;
  which_IQuant = {s = table GenNum [table QForm ["кой";"който"];
                                    table QForm ["коя";"която"];
                                    table QForm ["кое";"което"];
                                    table QForm ["кои";"които"]]} ;
  whoSg_IP = mkIP "кой" "кого" (GSg Masc) ;
  whoPl_IP = mkIP "кои" "кои" GPl ;
  why_IAdv = mkIAdv "защо" ;
  without_Prep = mkPrep "без" Acc ;
  with_Prep = mkPrep (pre { "с" ; 
                            "със" / strs {"с" ; "з" ; "С" ; "З"}
                          }) Acc ;
  yes_Utt = ss "да" ;
  youSg_Pron = mkPron "ти" "теб" "ти" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Masc) P2 ;
  youPl_Pron = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl P2 ;
  youPol_Pron = mkPron "вие" "вас" "ви" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl P2 ;
}

