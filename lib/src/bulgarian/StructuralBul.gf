--# -coding=cp1251
concrete StructuralBul of Structural = CatBul ** 
  open MorphoBul, ParadigmsBul, Prelude in {
  flags coding=cp1251 ;


  flags optimize=all ;

  lin
  above_Prep = mkPrep "���" Acc ;
  after_Prep = mkPrep "����" Acc ;
  all_Predet = {s = table GenNum ["�������";"��������";"��������";"��������"]} ;
  almost_AdA, almost_AdN = ss "�����" ;
  at_least_AdN, at_most_AdN =  ss "�����" ; ---- AR
  although_Subj = ss ["������� ��"] ;
  always_AdV = mkAdV "������" ;
  and_Conj = {s=[]; conj=0; distr=False; n = Pl} ;
  because_Subj = ss "������" ;
  before_Prep = mkPrep "�����" Acc ;
  behind_Prep = mkPrep "���" Acc ;
  between_Prep = mkPrep "�����" Acc ;
  both7and_DConj = {s=[]; conj=0; distr=True; n = Pl} ;
  but_PConj = ss "��" ;
  by8agent_Prep = mkPrep "����" Acc ;
  by8means_Prep = mkPrep "����" Acc ;
  can8know_VV, can_VV = mkVV (stateV (mkV166 "����")) ;
  during_Prep = mkPrep ["�� ����� ��"] Acc ;
  either7or_DConj = {s=[]; conj=1; distr=True; n = Sg} ;
  everybody_NP = mkNP "�����" (GSg Masc) P3 Pos;
  every_Det = mkDeterminerSg "�����" "�����" "�����";
  everything_NP = mkNP "������" (GSg Neut) P3 Pos;
  everywhere_Adv = ss "���������" ;
  few_Det = {s = \\_,_,_ => "�������"; nn = NCountable; spec = Indef; p = Pos} ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "��" Acc ;
  from_Prep = mkPrep "��" Acc ;
  he_Pron = mkPron "���" "����" "��" "��" "�����" "�������" "��������" "������" "��������" "������" "��������" "������" "��������" (GSg Masc) P3 ;
  here_Adv = ss "���" ;
  here7to_Adv = ss ["�� ���"] ;
  here7from_Adv = ss ["�� ���"] ;
  how_IAdv = mkIAdv "���" ;
  how8much_IAdv = mkIAdv "�����" ;
  how8many_IDet = {s = \\_ => table QForm ["�����";"�������"]; n = Pl; nonEmpty = False} ;
  if_Subj = ss "���" ;
  in8front_Prep = mkPrep "����" Acc ;
  i_Pron  = mkPron "��" "���" "��" "��" "���" "���" "����" "���" "�����" "���" "�����" "���" "�����" (GSg Masc) P1 ;
  in_Prep = mkPrep (pre { "�" ; 
                          "���" / strs {"�" ; "�" ; "�" ; "�"}
                        }) Acc ;
  it_Pron  = mkPron "��" "����" "��" "��" "�����" "�������" "��������" "������" "��������" "������" "��������" "������" "��������" (GSg Neut) P3 ;
  less_CAdv = {s="��"; sn="��-�����"} ;
  many_Det = mkDeterminerPl "�����" ;
  more_CAdv = {s=[]; sn="������"} ;
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
  on_Prep = mkPrep "��" Acc ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = {s = \\_ => "����"} ;
  or_Conj = {s=[]; conj=1; distr=False; n = Sg} ;
  otherwise_PConj = ss "�����" ;
  part_Prep = mkPrep "��" Acc ;
  please_Voc = ss "����" ;
  possess_Prep = mkPrep [] Dat ;
  quite_Adv = ss "�����" ;
  she_Pron = mkPron "��" "���" "�" "�" "����" "������" "�������" "�����" "�������" "�����" "�������" "�����" "�������" (GSg Fem) P3 ;
  so_AdA = ss "�������" ;
  somebody_NP = mkNP "�����" (GSg Masc) P3 Pos;
  someSg_Det = mkDeterminerSg "�����" "�����" "�����" ;
  somePl_Det = mkDeterminerPl "�����" ;
  something_NP = mkNP "����" (GSg Neut) P3 Pos;
  somewhere_Adv = ss "������" ;
  that_Quant = mkQuant "����" "�����" "�����" "�����" ;
  that_Subj = ss "��" ;
  there_Adv = ss "���" ;
  there7to_Adv = ss ["�� ���"] ;
  there7from_Adv = ss ["�� ���"] ;
  therefore_PConj = ss ["���� ��"] ;
  they_Pron = mkPron "��" "���" "��" "��" "�����" "������" "�������" "�����" "�������" "�����" "�������" "�����" "�������" GPl P3 ; 
  this_Quant = mkQuant "����" "����" "����" "����" ;
  through_Prep = mkPrep "����" Acc ;
  too_AdA = ss "���������" ;
  to_Prep = mkPrep "��" Acc ;
  under_Prep = mkPrep "���" Acc ;
  very_AdA = ss "�����" ;
  want_VV = mkVV (stateV (mkV186 "�����")) ;
  we_Pron = mkPron "���" "���" "��" "��" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl P1 ;
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
  without_Prep = mkPrep "���" Acc ;
  with_Prep = mkPrep (pre { "�" ; 
                            "���" / strs {"�" ; "�" ; "�" ; "�"}
                          }) Acc ;
  yes_Utt = ss "��" ;
  youSg_Pron = mkPron "��" "���" "��" "��" "����" "����" "�����" "����" "������" "����" "������" "����" "������" (GSg Masc) P2 ;
  youPl_Pron = mkPron "���" "���" "��" "��" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl P2 ;
  youPol_Pron = mkPron "���" "���" "��" "��" "���" "�����" "������" "����" "������" "����" "������" "����" "������" GPl P2 ;

  have_V2 = dirV2 (stateV (mkV186 "����")) ;

  lin language_title_Utt = ss "���������" ;

}

