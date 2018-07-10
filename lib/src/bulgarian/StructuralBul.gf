--# -coding=cp1251
concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, ParadigmsBul, Prelude, (X = ConstructX) in {
  flags coding=cp1251 ;


  flags optimize=all ;

  lin
  above_Prep = mkPrep "���" ;
  after_Prep = mkPrep "����" ;
  all_Predet = {s = table GenNum ["�������";"��������";"��������";"��������"]} ;
  almost_AdA, almost_AdN = ss "�����" ;
  at_least_AdN, at_most_AdN =  ss "�����" ; ---- AR
  although_Subj = ss ["������� ��"] ;
  always_AdV = mkAdV "������" ;
  and_Conj = {s=[]; conj=0; distr=False; n = Pl} ;
  because_Subj = ss "������" ;
  before_Prep = mkPrep "�����" ;
  behind_Prep = mkPrep "���" ;
  between_Prep = mkPrep "�����" ;
  both7and_DConj = {s=[]; conj=0; distr=True; n = Pl} ;
  but_PConj = ss "��" ;
  by8agent_Prep = mkPrep "����" ;
  by8means_Prep = mkPrep "����" ;
  can8know_VV, can_VV = mkVV (stateV (mkV166 "����")) ;
  during_Prep = mkPrep ["�� ����� ��"] ;
  either7or_DConj = {s=[]; conj=1; distr=True; n = Sg} ;
  everybody_NP = mkNP "�����" (GSg Masc) (NounP3 Pos);
  every_Det = mkDeterminerSg "�����" "�����" "�����";
  everything_NP = mkNP "������" (GSg Neut) (NounP3 Pos);
  everywhere_Adv = ss "���������" ;
  few_Det = {s = \\_,_,_ => "�������"; nn = NCountable; spec = Indef; p = Pos} ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "��" ;
  from_Prep = mkPrep "��" ;
  he_Pron = mkPron "���" "�����" "�������" "��������" "������" "��������" "������" "��������" "������" "��������" (GSg Masc) PronP3 ;
  here_Adv = ss "���" ;
  here7to_Adv = ss ["�� ���"] ;
  here7from_Adv = ss ["�� ���"] ;
  how_IAdv = mkIAdv "���" ;
  how8much_IAdv = mkIAdv "�����" ;
  how8many_IDet = {s = \\_ => table QForm ["�����";"�������"]; n = Pl; nonEmpty = False} ;
  if_Subj = ss "���" ;
  in8front_Prep = mkPrep "����" ;
  i_Pron  = mkPron "��" "���" "���" "����" "���" "�����" "���" "�����" "���" "�����" (GSg Masc) PronP1 ;
  in_Prep = mkPrep (pre { "�" ; 
                          "���" / strs {"�" ; "�" ; "�" ; "�"}
                        }) ;
  it_Pron  = mkPron "��" "�����" "�������" "��������" "������" "��������" "������" "��������" "������" "��������" (GSg Neut) PronP3 ;
  less_CAdv = X.mkCAdv "��-�����" "��" ;
  many_Det = mkDeterminerPl "�����" ;
  more_CAdv = X.mkCAdv "������" "��" ;
  most_Predet = {s = \\_ => "��������"} ;
  much_Det = mkDeterminerSg "�����" "�����" "�����";
  must_VV = 
    mkVV {
         s = \\_=>table {
                    VPres      _ _ => "������" ;
                    VAorist    _ _ => "��������" ;
                    VImperfect _ _ => "��������" ;
                    VPerfect     _ => "��������" ;
                    VPluPerfect  _ => "��������" ;
                    VPassive     _ => "��������" ;
                    VPresPart    _ => "��������" ;
                    VImperative Sg => "�������"  ;
                    VImperative Pl => "���������" ;
                    VNoun _        => "��������" ;
                    VGerund        => "���������"
                  } ;
         vtype=VNormal ;
         lock_V=<>
       } ;
  no_Utt = ss "��" ;
  on_Prep = mkPrep "��" ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "����"} ;
  or_Conj = {s=[]; conj=1; distr=False; n = Sg} ;
  otherwise_PConj = ss "�����" ;
  part_Prep = mkPrep "��" ;
  please_Voc = ss "����" ;
  possess_Prep = mkPrep [] Dat ;
  quite_Adv = ss "�����" ;
  she_Pron = mkPron "��" "����" "������" "�������" "�����" "�������" "�����" "�������" "�����" "�������" (GSg Fem) PronP3 ;
  so_AdA = ss "�������" ;
  somebody_NP = mkNP "�����" (GSg Masc) (NounP3 Pos);
  someSg_Det = mkDeterminerSg "�����" "�����" "�����" ;
  somePl_Det = mkDeterminerPl "�����" ;
  something_NP = mkNP "����" (GSg Neut) (NounP3 Pos);
  somewhere_Adv = ss "������" ;
  that_Quant = mkQuant "����" "�����" "�����" "�����" ;
  that_Subj = ss "��" ;
  there_Adv = ss "���" ;
  there7to_Adv = ss ["�� ���"] ;
  there7from_Adv = ss ["�� ���"] ;
  therefore_PConj = ss ["���� ��"] ;
  they_Pron = mkPron "��" "�����" "������" "�������" "�����" "�������" "�����" "�������" "�����" "�������" GPl PronP3 ; 
  this_Quant = mkQuant "����" "����" "����" "����" ;
  through_Prep = mkPrep "����" ;
  too_AdA = ss "���������" ;
  to_Prep = mkPrep "��" ;
  under_Prep = mkPrep "���" ;
  very_AdA = ss "�����" ;
  want_VV = mkVV (stateV (mkV186 "�����")) ;
  we_Pron = mkPron "���" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl PronP1 ;
  whatPl_IP = mkIP "�����" "�����" GPl ;
  whatSg_IP = mkIP "�����" "�����" (GSg Masc) ;
  when_IAdv = mkIAdv "����" ;
  when_Subj = ss "������" ;
  where_IAdv = mkIAdv "����" ;
  which_IQuant = {s = table GenNum [table QForm ["���";"�����"];
                                    table QForm ["���";"�����"];
                                    table QForm ["���";"�����"];
                                    table QForm ["���";"�����"]]} ;
  whoSg_IP = mkIP "���" "����" (GSg Masc) ;
  whoPl_IP = mkIP "���" "���" GPl ;
  why_IAdv = mkIAdv "����" ;
  without_Prep = mkPrep "���" ;
  with_Prep = mkPrep "" WithPrep ;
  yes_Utt = ss "��" ;
  youSg_Pron = mkPron "��" "����" "����" "�����" "����" "������" "����" "������" "����" "������" (GSg Masc) PronP2 ;
  youPl_Pron = mkPron "���" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl PronP2 ;
  youPol_Pron = mkPron "���" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl PronP2 ;

  as_CAdv = X.mkCAdv [] "�������" ;

  have_V2 = dirV2 (stateV (mkV186 "����")) ;

  lin language_title_Utt = ss "���������" ;

}

