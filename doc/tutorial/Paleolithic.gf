abstract Paleolithic = {
cat 
  S ; NP ; VP ; CN ; A ; V ; TV ; 

fun
  PredVP  : NP -> VP -> S ;
  UseV    : V -> VP ;
  ComplTV : TV -> NP -> VP ;
  UseA    : A -> VP ;
  This, That, Def, Indef : CN -> NP ; 
  ModA    : A -> CN -> CN ;
  Bird, Boy, Man, Louse, Snake, Worm : CN ;
  Big, Green, Rotten, Thick, Warm : A ;
  Laugh, Sleep, Swim : V ;
  Eat, Kill, Wash : TV ;
}