--# -coding=cp1251
concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, ParadigmsBul, Prelude, (X = ConstructX) in {
  flags coding=cp1251 ;


  flags optimize=all ;

  lin
  above_Prep = mkPrep "над" ;
  after_Prep = mkPrep "след" ;
  all_Predet = {s = table GenNum ["всичкия";"всичката";"всичкото";"всичките"]} ;
  almost_AdA, almost_AdN = ss "почти" ;
  at_least_AdN, at_most_AdN =  ss "почти" ; ---- AR
  although_Subj = ss ["въпреки че"] ;
  always_AdV = mkAdV "винаги" ;
  and_Conj = {s=[]; conj=0; distr=False; n = Pl} ;
  because_Subj = ss "защото" ;
  before_Prep = mkPrep "преди" ;
  behind_Prep = mkPrep "зад" ;
  between_Prep = mkPrep "между" ;
  both7and_DConj = {s=[]; conj=0; distr=True; n = Pl} ;
  but_PConj = ss "но" ;
  by8agent_Prep = mkPrep "чрез" ;
  by8means_Prep = mkPrep "чрез" ;
  can8know_VV, can_VV = mkVV (stateV (mkV166 "мога")) ;
  during_Prep = mkPrep ["по време на"] ;
  either7or_DConj = {s=[]; conj=1; distr=True; n = Sg} ;
  everybody_NP = mkNP "всеки" (GSg Masc) (NounP3 Pos);
  every_Det = mkDeterminerSg "всеки" "всяка" "всяко";
  everything_NP = mkNP "всичко" (GSg Neut) (NounP3 Pos);
  everywhere_Adv = ss "навсякъде" ;
  few_Det = {s = \\_,_,_ => "няколко"; nn = NCountable; spec = Indef; p = Pos} ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "за" ;
  from_Prep = mkPrep "от" ;
  he_Pron = mkPron "той" "негов" "неговия" "неговият" "негова" "неговата" "негово" "неговото" "негови" "неговите" (GSg Masc) PronP3 ;
  here_Adv = ss "тук" ;
  here7to_Adv = ss ["до тук"] ;
  here7from_Adv = ss ["от тук"] ;
  how_IAdv = mkIAdv "как" ;
  how8much_IAdv = mkIAdv "колко" ;
  how8many_IDet = {s = \\_ => table QForm ["колко";"колкото"]; n = Pl; nonEmpty = False} ;
  if_Subj = ss "ако" ;
  in8front_Prep = mkPrep "пред" ;
  i_Pron  = mkPron "аз" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Masc) PronP1 ;
  in_Prep = mkPrep (pre { "в" ; 
                          "във" / strs {"в" ; "ф" ; "В" ; "Ф"}
                        }) ;
  it_Pron  = mkPron "то" "негов" "неговия" "неговият" "негова" "неговата" "негово" "неговото" "негови" "неговите" (GSg Neut) PronP3 ;
  less_CAdv = X.mkCAdv "по-малко" "от" ;
  many_Det = mkDeterminerPl "много" ;
  more_CAdv = X.mkCAdv "повече" "от" ;
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
                    VNoun _        => "трябване" ;
                    VGerund        => "трябвайки"
                  } ;
         vtype=VNormal ;
         lock_V=<>
       } ;
  no_Utt = ss "не" ;
  on_Prep = mkPrep "на" ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "само"} ;
  or_Conj = {s=[]; conj=1; distr=False; n = Sg} ;
  otherwise_PConj = ss "иначе" ;
  part_Prep = mkPrep "от" ;
  please_Voc = ss "моля" ;
  possess_Prep = mkPrep [] Dat ;
  quite_Adv = ss "доста" ;
  she_Pron = mkPron "тя" "неин" "нейния" "нейният" "нейна" "нейната" "нейно" "нейното" "нейни" "нейните" (GSg Fem) PronP3 ;
  so_AdA = ss "толкова" ;
  somebody_NP = mkNP "някой" (GSg Masc) (NounP3 Pos);
  someSg_Det = mkDeterminerSg "някой" "някоя" "някое" ;
  somePl_Det = mkDeterminerPl "някои" ;
  something_NP = mkNP "нещо" (GSg Neut) (NounP3 Pos);
  somewhere_Adv = ss "някъде" ;
  that_Quant = mkQuant "онзи" "онази" "онова" "онези" ;
  that_Subj = ss "че" ;
  there_Adv = ss "там" ;
  there7to_Adv = ss ["до там"] ;
  there7from_Adv = ss ["от там"] ;
  therefore_PConj = ss ["така че"] ;
  they_Pron = mkPron "те" "техен" "техния" "техният" "тяхна" "тяхната" "тяхно" "тяхното" "техни" "техните" GPl PronP3 ; 
  this_Quant = mkQuant "този" "тази" "това" "тези" ;
  through_Prep = mkPrep "през" ;
  too_AdA = ss "прекалено" ;
  to_Prep = mkPrep "до" ;
  under_Prep = mkPrep "под" ;
  very_AdA = ss "много" ;
  want_VV = mkVV (stateV (mkV186 "искам")) ;
  we_Pron = mkPron "ние" "наш" "нашия" "нашият" "наша" "нашата" "наше" "нашето" "наши" "нашите" GPl PronP1 ;
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
  without_Prep = mkPrep "без" ;
  with_Prep = mkPrep "" WithPrep ;
  yes_Utt = ss "да" ;
  youSg_Pron = mkPron "ти" "твой" "твоя" "твоят" "твоя" "твоята" "твое" "твоето" "твои" "твоите" (GSg Masc) PronP2 ;
  youPl_Pron = mkPron "вие" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl PronP2 ;
  youPol_Pron = mkPron "вие" "ваш" "вашия" "вашият" "ваша" "вашата" "ваше" "вашето" "ваши" "вашите" GPl PronP2 ;

  as_CAdv = X.mkCAdv [] "колкото" ;

  have_V2 = dirV2 (stateV (mkV186 "имам")) ;

  lin language_title_Utt = ss "Български" ;

}

