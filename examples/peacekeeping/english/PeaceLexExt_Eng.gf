--# -path=.:present:prelude

concrete PeaceLexExt_Eng of PeaceLexExt = 
  PeaceCat_Eng ** open ParadigmsEng, IrregEng in {

  lin

    -- Adjectives
    dangerous_A = regA "dangerous" ;
    dead_A = regA "dead" ;
    hungry_A = regA "hungry" ;
    large_A = regA "large" ;
    sick_A = regA "sick" ;

    -- Nouns
    air_N = regN "air" ;
    arm_N = regN "arm" ;
    building_N = regN "building" ;
    car_N = regN "car" ;
    corpse_N = regN "corpse" ;
    doctor_N = regN "doctor";
    enemy_N = regN "enemy";
    face_N = regN "face" ;
    food_N = regN "food";
    friend_N = regN "friend";
    ground_N = regN "ground" ;
    knife_N = mk2N "knife" "knives" ;
    landmine_N = regN "landmine" ;
    map_N = regN "map" ;
    medicine_N = regN "medicine" ;
    police8officer_N = mk2N "policeman" "policemen" ;
    skin_N = regN "skin" ;
    soldier_N = regN "soldier" ;
    weapon_N = regN "weapon";

    -- Verbs
    cough_V = regV "cough" ;
    drop_V2 = dirV2 (regDuplV "drop") ;
    hurt_V = dirV2 hurt_V ;
    need_V2 = dirV2 (regV "need");
    own_V2 = dirV2 (regV "own") ;
    show_V3 = dirdirV3 (regV "show") ;

}
