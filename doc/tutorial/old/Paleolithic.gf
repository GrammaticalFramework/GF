abstract Paleolithic = {
cat 
  S ; NP ; VP ; CN ; A ; V ; TV ; 

fun
  PredVP  : NP -> VP -> S ;
  UseV    : V -> VP ;
  ComplTV : TV -> NP -> VP ;
  UseA    : A -> VP ;
  ModA    : A -> CN -> CN ;
  This, That, Def, Indef : CN -> NP ; 
  Boy, Louse, Snake, Worm : CN ;
  Green, Rotten, Thick, Warm : A ;
  Laugh, Sleep, Swim : V ;
  Eat, Kill, Wash : TV ;
}