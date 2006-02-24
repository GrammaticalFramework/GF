incomplete concrete StoneageI of Stoneage = open Lang, Swadesh in { 

flags
  startcat=S ;

lincat
  S = Phr ;
  NP = NP ;
  N = N;
  CN = CN ;

lin

  Think = PresV think_V ;
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


  Drink = PresV2 drink_V ;
  Eat = PresV2 eat_V ;
  Bite = PresV2 bite_V ;
  Suck = PresV2 suck_V ;
  See = PresV2 see_V ;
  Hear = PresV2 hear_V ;
  Know = PresV2 know_V ;
  Smell = PresV2 smell_V ;
  Fear = PresV2 fear_V ;
  Kill = PresV2 kill_V ;
  Fight = PresV2 fight_V ;
  Hunt = PresV2 hunt_V ;
  Hit = PresV2 hit_V ;
  Cut = PresV2 cut_V ;
  Split = PresV2 split_V ;
  Stab = PresV2 stab_V ;
  Scratch = PresV2 scratch_V ;
  Hold = PresV2 hold_V ;
  Squeeze = PresV2 squeeze_V ;
  Rub = PresV2 rub_V ;
  Wash = PresV2 wash_V ;
  Wipe = PresV2 wipe_V ;
  Pull = PresV2 pull_V ;
  Push = PresV2 push_V ;
  Throw = PresV2 throw_V ;
  Tie = PresV2 tie_V ;
  Count = PresV2 count_V ;

  Give = PresV3 give_V ;


--  Say = ;

  The_One = DetCN (DetSg (SgQuant DefArt) NoOrd) ;
  The_Many = DetCN (DetPl (PlQuant DefArt) NoNum NoOrd) ;
  A = DetCN (DetSg (SgQuant IndefArt) NoOrd) ;
  This = DetCN this_Det ;
  That = DetCN that_Det ;
  All = DetCN all_Det ;
  Many = DetCN many_Det ;
  Some_One = DetCN someSg_Det ;
  Some_Many = DetCN somePl_Det ;
  Few = DetCN few_Det ;
  Other = DetCN other_Det ;

  One = DetCN one_Det ;
  Two = DetCN (DetPl (PlQuant IndefArt) two_Num NoOrd) ;
  Three = DetCN (DetPl (PlQuant IndefArt) three_Num NoOrd) ;
  Four = DetCN (DetPl (PlQuant IndefArt) four_Num NoOrd) ;
  Five = DetCN (DetPl (PlQuant IndefArt) five_Num NoOrd) ;

  -- Pronouns

  I = UsePron i_NP ;
  You_One = UsePron youSg_NP ;
  He = UsePron he_NP ;
  We = UsePron we_NP ;
  You_Many = UsePron youPl_NP ;
  They = UsePron they_NP ;

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
----  MotherOf = AppN2 (mkN2 mother_N "of") ;
----  FatherOf = AppN2 (mkN2 father_N "of") ;

  Big = ModA big_A ;
  Long = ModA long_A ;
  Wide = ModA wide_A ;
  Thick = ModA thick_A ;
  Heavy = ModA heavy_A ;
  Small = ModA small_A ;
  Short = ModA short_A ;
  Narrow = ModA narrow_A ;
  Thin = ModA thin_A ;
  Red = ModA red_A ;
  Green = ModA green_A ;
  Yellow = ModA yellow_A ;
  White = ModA white_A ;
  Black = ModA black_A ;
  Warm = ModA warm_A ;
  Cold = ModA cold_A ;
  Full = ModA full_A ;
  New = ModA new_A ;
  Old = ModA old_A ;
  Good = ModA good_A ;
  Bad = ModA bad_A ;
  Rotten = ModA rotten_A ;
  Dirty = ModA dirty_A ;
  Straight = ModA straight_A ;
  Round = ModA round_A ;
  Sharp = ModA sharp_A ;
  Dull = ModA dull_A ;
  Smooth = ModA smooth_A ;
  Wet = ModA wet_A ;
  Dry = ModA dry_A ;
  Correct = ModA correct_A ;
  Near = ModA near_A ;

  Right = ModA right_A ;
  Left = ModA left_A ;

oper

  PresV : V -> NP -> Phr = \v,s -> 
    PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos 
      (PredVP s (UseV v)))) NoVoc ;
  PresV2 : V2 -> NP -> NP -> Phr = \v,s,o -> 
    PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos 
      (PredVP s (ComplV2 v o)))) NoVoc ;
  PresV3 : V3 -> NP -> NP -> NP -> Phr = \v,s,o,r -> 
    PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos 
      (PredVP s (ComplV3 v o r)))) NoVoc ;

  ModA : A -> CN -> CN = \a ->
    AdjCN (PositA a) ;


}
