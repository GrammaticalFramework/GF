--# -path=.:present:prelude

concrete PeaceLexExt_Fin of PeaceLexExt = 
  PeaceCat_Fin ** open ParadigmsFin in {

  lin

    -- Adjectives
    dangerous_A = mkA "vaarallinen" ;
    dead_A = mkA (mkN "kuollut" "kuolleita") ;
    hungry_A = mkA "n‰lk‰inen" ;
    large_A = mkA "iso" ;
    sick_A = mkA "sairas" ;

    -- Nouns
    air_N = mkN "ilma" ;
    arm_N = mk3N "k‰si" "k‰den" "k‰si‰" ;
    building_N = mkN "rakennus" ;
    car_N = mkN "auto" ;
    corpse_N = mkN "ruumis" ;
    doctor_N = mkN "l‰‰k‰ri";
    enemy_N = mkN "vihollinen";
    face_N = mkN "naama" ; ---- kasvot
    food_N = mkN "ruoka";
    friend_N = mkN "yst‰v‰";
    ground_N = mkN "maa" ;
    knife_N = mk2N "veitsi" "veitsi‰" ; ---- veist‰
    landmine_N = mkN "maamiina" ;
    map_N = mkN "kartta" ;
    medicine_N = mkN "l‰‰ke" ;
    police8officer_N = mkN "poliisi" ;
    skin_N = mkN "iho" ;
    soldier_N = mkN "sotilas" ;
    weapon_N = mkN "ase";

    -- Verbs
    cough_V = mkV "yski‰" ;
    drop_V2 = dirV2 (mkV "pudottaa") ;
    hurt_V = mkV "sattua" ;
    need_V2 = dirV2 (mkV "tarvita");
    own_V2 = dirV2 (mkV "omistaa") ;
    show_V3 = dirdirV3 (mkV "n‰ytt‰‰") ;

}
