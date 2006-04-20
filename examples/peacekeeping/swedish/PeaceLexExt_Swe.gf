--# -path=.:present:prelude

concrete PeaceLexExt_Swe of PeaceLexExt = 
  PeaceCat_Swe ** open LexiconSwe, ParadigmsSwe in {

  lin

    -- Adjectives
    dangerous_A = regA "farlig" ;
    dead_A = regA "död" ;
    hungry_A = regA "hungrig" ;
    large_A = big_A ;
    sick_A = regA "sjuk" ;

    -- Nouns
    air_N = regN "luft" ;
    arm_N = regN "arm" ;
    building_N = mk2N "byggnad" "byggnader" ;
    car_N = regN "bil" ;
    corpse_N = mk2N "lik" "lik" ;
    doctor_N = mkN "doktor" "doktorn" "doktorer" "doktorerna";
    enemy_N = mk2N "fiende" "fiender" ;
    food_N = regN "mat";
    friend_N = mkN "vän" "vännen" "vänner" "vännerna" ;
    landmine_N = regN "landmina" ;
    medicine_N = mk2N "medicin" "mediciner";
    skin_N = mk2N "skinn" "skinn" ;
    soldier_N = mk2N "soldat" "soldater" ;
    weapon_N = mkN "vapen" "vapnet" "vapen" "vapnen" ;

    -- Verbs
    cough_V = regV "hostar" ;
    need_V2 = dirV2 (regV "behöver");
    own_V2 = dirV2 (regV "äger") ;
    show_V3 = dirdirV3 (regV "visar") ;

}
