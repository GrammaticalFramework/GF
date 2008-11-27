incomplete concrete CatSlavic of Cat = open Prelude, CommonSlavic, ResSlavic in {

lincat
  CN = {s : NForm => Str; g : Gender; anim : Animacy} ;

  Subj = {s : Str} ;
  Prep = {s : Str; c: Case} ;

  N  = {s : NForm => Str; g : Gender; anim : Animacy} ;
  N2 = {s : NForm => Str; g : Gender; anim : Animacy} ** {c2 : Preposition} ;
  N3 = {s : NForm => Str; g : Gender; anim : Animacy} ** {c2,c3 : Preposition} ;
}