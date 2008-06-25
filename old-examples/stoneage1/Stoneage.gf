abstract Stoneage = {

cat
  S ;
  NP ;
  CN ;

fun

  -- Sentence conjunction

--  AndS : S -> S -> S ;

  -- NP conjunction

--  AndNP : NP -> NP -> NP ;

  -- Actions with an object

  Drink : NP -> NP -> S ;
  Eat : NP -> NP -> S ;
  Bite : NP -> NP -> S ;
  Suck : NP -> NP -> S ;
  See : NP -> NP -> S ;
  Hear : NP -> NP -> S ;
  Know : NP -> NP -> S ;
  Smell : NP -> NP -> S ;
  Fear : NP -> NP -> S ;
  Kill : NP -> NP -> S ;
  Fight : NP -> NP -> S ;
  Hunt : NP -> NP -> S ;
  Hit : NP -> NP -> S ;
  Cut : NP -> NP -> S ;
  Split : NP -> NP -> S ;
  Stab : NP -> NP -> S ;
  Scratch : NP -> NP -> S ;
  Hold : NP -> NP -> S ;
  Squeeze : NP -> NP -> S ;
  Rub : NP -> NP -> S ;
  Wash : NP -> NP -> S ;
  Wipe : NP -> NP -> S ;
  Pull : NP -> NP -> S ;
  Push : NP -> NP -> S ;
  Throw : NP -> NP -> S ;
  Tie : NP -> NP -> S ;
  Count : NP -> NP -> S ;

  -- Actions without an object

  Think : NP -> S ;
  Spit : NP -> S ;
  Vomit : NP -> S ;
  Blow : NP -> S ;
  Breathe : NP -> S ;
  Laugh : NP -> S ;
  Sleep : NP -> S ;
  Live : NP -> S ;
  Die : NP -> S ;
  Dig : NP -> S ;
  Swim : NP -> S ;
  Fly : NP -> S ;
  Walk : NP -> S ;
  Come : NP -> S ;
  Lie : NP -> S ;
  Sit : NP -> S ;
  Stand : NP -> S ;
  Turn : NP -> S ;
  Fall : NP -> S ;
  Sing : NP -> S ;
  Sew : NP -> S ;
  Play : NP -> S ;
  Float : NP -> S ;
  Flow : NP -> S ;
  Freeze : NP -> S ;
  Swell : NP -> S ;
  Burn : NP -> S ;

  -- Actions with an object and a recipient

  Give : NP -> NP -> NP -> S ; -- subject object recipient

--  Say
--  FearThat

  -- Determiners

  The_One : CN -> NP ;
  The_Many : CN -> NP ;
  A : CN -> NP ;
  This : CN -> NP ;
  That : CN -> NP ;
  All : CN -> NP ;
  Many : CN -> NP ;
  Some_One : CN -> NP ;
  Some_Many : CN -> NP ;
  Few : CN -> NP ;
  Other : CN -> NP ;

  One : CN -> NP ;
  Two : CN -> NP ;
  Three : CN -> NP ;
  Four : CN -> NP ;
  Five : CN -> NP ;

  -- Pronouns
 
  I : NP ;
  You_One : NP ;
  He : NP ;
  We : NP ;
  You_Many : NP ;
  They : NP ;

  -- People
  Woman : CN ;
  Man : CN ;
  Person : CN ;
  Child : CN ;
  Wife : CN ;
  Husband : CN ;
  Mother : CN ;
  Father : CN ;

  -- Animals
  Animal : CN ;
  Fish : CN ;
  Bird : CN ;
  Dog : CN ;
  Louse : CN ;
  Snake : CN ;
  Worm : CN ;

  -- Plants
  Tree : CN ;
  Forest : CN ;
  Stick : CN ;
  Fruit : CN ;
  Seed : CN ;
  Leaf : CN ;
  Root : CN ;
  Bark : CN ;
  Flower : CN ;
  Grass : CN ;

  -- Materials
  Rope : CN ;
  Skin : CN ;
  Meat : CN ;
  Blood : CN ;
  Bone : CN ;
  Fat : CN ;
  Egg : CN ;
  Horn : CN ;
  Tail : CN ;
  Feather : CN ;

  -- Body parts
  Hair : CN ;
  Head : CN ;
  Ear : CN ;
  Eye : CN ;
  Nose : CN ;
  Mouth : CN ;
  Tooth : CN ;
  Tongue : CN ;
  Fingernail : CN ;
  Foot : CN ;
  Leg : CN ;
  Knee : CN ;
  Hand : CN ;
  Wing : CN ;
  Belly : CN ;
  Guts : CN ;
  Neck : CN ;
  Back : CN ;
  Breast : CN ;
  Heart : CN ;
  Liver : CN ;

  -- Heavenly bodies
  Sun : CN ;
  Moon : CN ;
  Star : CN ;

  -- Water
  Water : CN ;
  Rain : CN ;
  River : CN ;
  Lake : CN ;
  Sea : CN ;

  -- Minerals 
  Salt : CN ;
  Stone : CN ;
  Sand : CN ;
  Dust : CN ;
  Earth : CN ;

  -- Weather
  Cloud : CN ;
  Fog : CN ;
  Sky : CN ;
  Wind : CN ;
  Snow : CN ;
  Ice : CN ;

  -- Fire
  Smoke : CN ;
  Fire : CN ;
  Ashes : CN ;

  -- Terrain
  Road : CN ;
  Mountain : CN ;

  -- Time
  Night : CN ;
  Day : CN ;
  Year : CN ;

  Name : CN ;

--  NameOf : NP -> CN ;
----  MotherOf : NP -> CN ;
----  FatherOf : NP -> CN ;

  -- Shape
  Big : CN -> CN ;
  Long : CN -> CN ;
  Wide : CN -> CN ;
  Thick : CN -> CN ;
  Heavy : CN -> CN ;
  Small : CN -> CN ;
  Short : CN -> CN ;
  Narrow : CN -> CN ;
  Thin : CN -> CN ;
  Straight : CN -> CN ;
  Round : CN -> CN ;

  -- Color
  Red : CN -> CN ;
  Green : CN -> CN ;
  Yellow : CN -> CN ;
  White : CN -> CN ;
  Black : CN -> CN ;

  -- Temperature
  Warm : CN -> CN ;
  Cold : CN -> CN ;

  Full : CN -> CN ;

  -- Age
  New : CN -> CN ;
  Old : CN -> CN ;

  -- Quality
  Good : CN -> CN ;
  Bad : CN -> CN ;
  Rotten : CN -> CN ;

  -- Texture
  Dirty : CN -> CN ;
  Sharp : CN -> CN ;
  Dull : CN -> CN ;
  Smooth : CN -> CN ;
  Wet : CN -> CN ;
  Dry : CN -> CN ;

  -- Truthfulness
  Correct : CN -> CN ;

  -- Position
  Near : CN -> CN ;
 -- Far : CN -> CN ;
  Right : CN -> CN ;
  Left : CN -> CN ;

}