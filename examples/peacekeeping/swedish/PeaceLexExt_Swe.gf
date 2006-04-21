--# -path=.:present:prelude

concrete PeaceLexExt_Swe of PeaceLexExt = 
  PeaceCat_Swe ** open ParadigmsSwe, IrregSwe, 
                       LexiconSwe, StructuralSwe in {

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
    face_N = regN "ansikte" ;
    food_N = regN "mat";
    friend_N = mkN "vän" "vännen" "vänner" "vännerna" ;
    ground_N = mk2N "mark" "marker";
    knife_N = regN "kniv" ;
    landmine_N = regN "landmina" ;
    map_N = regN "karta" ;
    medicine_N = mk2N "medicin" "mediciner";
    police8officer_N = mk2N "polis" "poliser" ;
    skin_N = mk2N "skinn" "skinn" ;
    soldier_N = mk2N "soldat" "soldater" ;
    toy_N = regN "leksak" ;
    translation8machine_N = mk2N "översättningsmaskin" "översättningsmaskiner";
    weapon_N = mkN "vapen" "vapnet" "vapen" "vapnen" ;

    -- Verbs
    cooperate_V2 = mkV2 (regV "samarbetar") (mkPreposition "med") ;
    cough_V = regV "hostar" ;
    drop_V2 = dirV2 (regV "släpper") ;
    hurt_V = partV göra_V "ont" ; -- FIXME: "Gör ont ditt ben?"
    need_V2 = dirV2 (regV "behöver");
    own_V2 = dirV2 (regV "äger") ;
    show_V3 = dirdirV3 (regV "visar") ;

}
