--# -path=.:../../lib/resource/abstract:../../lib/prelude:../../lib/resource/norwegian:../../lib/resource/scandinavian
concrete StoneageNor of Stoneage 
  = open SyntaxNor, ResourceNor, ParadigmsNor, VerbsNor, SwadeshLexNor, StoneageResNor in {

--- rough-translated from Swedish by AR 11/3/2005. To be fixed soon.

flags
  startcat=S; optimize=share;

lincat
  S = Phr ;
  NP = NP ;
  N = N;
  CN = CN ;

lin

  -- Sentence conjunction

--  AndS s1 s2 = { s = s1.s ++ and_Conj.s ++ s2.s } ** { lock_Phr = <> } ;

  -- NP conjunction

--  AndNP n1 n2 = ConjNP and_Conj (TwoNP n1 n2);

  Drink = PresVasV2 drink_V ;
  Eat = PresVasV2 eat_V ;
  Bite = PresVasV2 bite_V ;
  Suck = PresVasV2 suck_V ;
  See = PresVasV2 see_V ;
  Hear = PresVasV2 hear_V ;
  Know = PresVasV2 know_V ;
  Think = PresVasV2 think_V ;
  Smell = PresV2 (mkV2 (regV "lukte") "på") ;
  Fear = PresVasV2 fear_V ;
  Kill = PresVasV2 kill_V ;
  Fight s o = PresCl (AdvCl (SPredV s slåss_V) (AdvPP (PrepNP with_Prep o))) ;
  Hunt = PresVasV2 hunt_V ;
  Hit = PresVasV2 hit_V ;
  Cut = PresVasV2 cut_V ;
  Split = PresVasV2 split_V ;
  Stab = PresVasV2 stab_V ;
  Scratch = PresVasV2 scratch_V ;
  Hold = PresVasV2 hold_V ;
  Squeeze = PresVasV2 squeeze_V ;
  Rub = PresVasV2 rub_V ;
  Wash = PresVasV2 wash_V ;
  Wipe = PresVasV2 wipe_V ;
  Pull = PresVasV2 pull_V ;
  Push = PresVasV2 push_V ;
  Throw = PresVasV2 throw_V ;
  Tie = PresVasV2 tie_V ;
  Count = PresVasV2 count_V ;

  Spit = PresV spit_V ;
  Vomit = PresV vomit_V ;
  Blow = PresV blow_V ;
  Breathe = PresV breathe_V ;
  Laugh = PresV laugh_V ;
  Sleep = PresV sleep_V ;
  Live = PresV live_V ;
  Die = PresV die_V ;
  Dig = PresV dig_V ;
  Swim = PresV swim_V ;
  Fly = PresV fly_V ;
  Walk = PresV walk_V ;
  Come = PresV come_V ;
  Lie = PresV lie_V ;
  Sit = PresV sit_V ;
  Stand = PresV stand_V ;
  Turn = PresV turn_V ;
  Fall = PresV fall_V ;
  Sing = PresV sing_V ;
  Sew = PresV sew_V ;
  Play = PresV play_V ;
  Float = PresV float_V ;
  Flow = PresV flow_V ;
  Freeze = PresV freeze_V ;
  Swell = PresV swell_V ;
  Burn = PresV burn_V ;

  Give = PresV3 (dirV3 give_V "til") ;

--  Say = ;

  The_One = DefOneNP;
  The_Many = DefNumNP NoNum ;
  A = IndefOneNP ;
  This = DetNP this_Det ;
  That = DetNP that_Det ;
  All = NDetNP all_NDet NoNum ;
  Many = DetNP many_Det ;
  Some_One = DetNP some_Det ;
  Some_Many = NDetNP some_NDet NoNum ;
  Few = DetNP few_Det ;
  Other = DetNP other_Det ;

  One = IndefNumNP one_Num ;
  Two = IndefNumNP two_Num ;
  Three = IndefNumNP three_Num ;
  Four = IndefNumNP four_Num ;
  Five = IndefNumNP five_Num ;

  -- Pronouns

  I = i_NP ;
  You_One = thou_NP ;
  He = he_NP ;
  We = we_NP ;
  You_Many = you_NP ;
  They = they_NP ;

  -- Nouns

  Woman = UseN woman_N ;
  Man = UseN man_N ;
  Person = UseN person_N ;
  Child = UseN child_N ;
  Wife = UseN wife_N ;
  Husband = UseN husband_N ;
  Mother = UseN mother_N ;
  Father = UseN father_N ;
  Animal = UseN animal_N ;
  Fish = UseN fish_N ;
  Bird = UseN bird_N ;
  Dog = UseN dog_N ;
  Louse = UseN louse_N ;
  Snake = UseN snake_N ;
  Worm = UseN worm_N ;
  Tree = UseN tree_N ;
  Forest = UseN forest_N ;
  Stick = UseN stick_N ;
  Fruit = UseN fruit_N ;
  Seed = UseN seed_N ;
  Leaf = UseN leaf_N ;
  Root = UseN root_N ;
  Bark = UseN bark_N ;
  Flower = UseN flower_N ;
  Grass = UseN grass_N ;
  Rope = UseN rope_N ;
  Skin = UseN skin_N ;
  Meat = UseN meat_N ;
  Blood = UseN blood_N ;
  Bone = UseN bone_N ;
  Fat = UseN fat_N ;
  Egg = UseN egg_N ;
  Horn = UseN horn_N ;
  Tail = UseN tail_N ;
  Feather = UseN feather_N ;
  Hair = UseN hair_N ;
  Head = UseN head_N ;
  Ear = UseN ear_N ;
  Eye = UseN eye_N ;
  Nose = UseN nose_N ;
  Mouth = UseN mouth_N ;
  Tooth = UseN tooth_N ;
  Tongue = UseN tongue_N ;
  Fingernail = UseN fingernail_N ;
  Foot = UseN foot_N ;
  Leg = UseN leg_N ;
  Knee = UseN knee_N ;
  Hand = UseN hand_N ;
  Wing = UseN wing_N ;
  Belly = UseN belly_N ;
  Guts = UseN guts_N ;
  Neck = UseN neck_N ;
  Back = UseN back_N ;
  Breast = UseN breast_N ;
  Heart = UseN heart_N ;
  Liver = UseN liver_N ;
  Sun = UseN sun_N ;
  Moon = UseN moon_N ;
  Star = UseN star_N ;
  Water = UseN water_N ;
  Rain = UseN rain_N ;
  River = UseN river_N ;
  Lake = UseN lake_N ;
  Sea = UseN sea_N ;
  Salt = UseN salt_N ;
  Stone = UseN stone_N ;
  Sand = UseN sand_N ;
  Dust = UseN dust_N ;
  Earth = UseN earth_N ;
  Cloud = UseN cloud_N ;
  Fog = UseN fog_N ;
  Sky = UseN sky_N ;
  Wind = UseN wind_N ;
  Snow = UseN snow_N ;
  Ice = UseN ice_N ;
  Smoke = UseN smoke_N ;
  Fire = UseN fire_N ;
  Ashes = UseN ashes_N ;
  Road = UseN road_N ;
  Mountain = UseN mountain_N ;
  Night = UseN night_N ;
  Day = UseN day_N ;
  Year = UseN year_N ;
  Name = UseN name_N ;

--  NameOf = AppN2 name_N2 ;
  MotherOf = AppN2 (mkN2 mother_N "til") ;
  FatherOf = AppN2 (mkN2 father_N "til") ;

  Big = ModPosA big_ADeg ;
  Long = ModPosA long_ADeg ;
  Wide = ModPosA wide_ADeg ;
  Thick = ModPosA thick_ADeg ;
  Heavy = ModPosA heavy_ADeg ;
  Small = ModPosA small_ADeg ;
  Short = ModPosA short_ADeg ;
  Narrow = ModPosA narrow_ADeg ;
  Thin = ModPosA thin_ADeg ;
  Red = ModPosA red_ADeg ;
  Green = ModPosA green_ADeg ;
  Yellow = ModPosA yellow_ADeg ;
  White = ModPosA white_ADeg ;
  Black = ModPosA black_ADeg ;
  Warm = ModPosA warm_ADeg ;
  Cold = ModPosA cold_ADeg ;
  Full = ModPosA full_ADeg ;
  New = ModPosA new_ADeg ;
  Old = ModPosA old_ADeg ;
  Good = ModPosA good_ADeg ;
  Bad = ModPosA bad_ADeg ;
  Rotten = ModPosA rotten_ADeg ;
  Dirty = ModPosA dirty_ADeg ;
  Straight = ModPosA straight_ADeg ;
  Round = ModPosA round_ADeg ;
  Sharp = ModPosA sharp_ADeg ;
  Dull = ModPosA dull_ADeg ;
  Smooth = ModPosA smooth_ADeg ;
  Wet = ModPosA wet_ADeg ;
  Dry = ModPosA dry_ADeg ;
  Correct = ModPosA correct_ADeg ;
  Near = ModPosA near_ADeg ;
--  Far = ModPosA far_ADeg ;

  Right = ModAP (UseA right_A) ;
  Left = ModAP (UseA left_A) ;

}