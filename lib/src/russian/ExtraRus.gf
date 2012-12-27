concrete ExtraRus of ExtraRusAbs = CatRus ** 
  open ResRus, MorphoRus, (P = ParadigmsRus), Prelude, NounRus in {
  flags optimize=all ; coding=utf8 ;

lin
  have_V3 = P.mkV3 (P.mkV P.imperfective "" "" "" "" "" "" "был" "будь" "есть") "" "у" Nom Gen;

  have2_V3 = P.mkV3 (P.mkV P.imperfective "есть" "есть" "есть" "есть" "есть" "есть" "был" "будь" "есть") "" "у" Nom Gen;

  have_not_V3 = P.mkV3 (P.mkV P.imperfective "нет" "нет" "нет" "нет" "нет" "нет" "не было" "не будь" "нет") "" "у" Gen Gen;

  be_V3 = P.mkV3 (P.mkV P.imperfective "" "" "" "" "" "" "был" "будь" "") "" "" Nom Dat;

  to2_Prep = { s = "в" ; c = Acc };

} 
