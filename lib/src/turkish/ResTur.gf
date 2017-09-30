--# -path=.:../abstract:../common:../../prelude

resource ResTur = ParamX ** open Prelude, Predef, HarmonyTur in {

--2 For $Noun$

  flags
    coding=utf8 ;

  param
    Case = Nom | Acc | Dat | Gen | Loc | Ablat | Abess Polarity ;
    Species = Indef | Def ;
    Contiguity = Con | Sep ; --Concatenate or Separate

  oper
    Agr = {n : Number ; p : Person} ;
    Noun = {
      s   : Number => Case => Str ;
      gen : Number => Agr => Str  ;
      harmony : Harmony
    } ;
    Pron = {s : Case => Str; a : Agr} ;

    agrP3 : Number -> Agr ;
    agrP3 n = {n = n; p = P3} ;
-- For $Adjective$
  oper
    Adjective = Noun ** { adv : Str } ;
-- For $Verb$.

  param
    VForm = 
       VProg      Agr
     | VPast      Agr
     | VFuture    Agr
     | VAorist    Agr
     | VImperative
     | VInfinitive
     | Gerund Number Case
     ;

    UseGen = NoGen | YesGen Agr | UseIndef ;

  oper
    Verb : Type = {
      s : VForm => Str
      } ;

--2 For $Numeral$
  param
    DForm = unit | ten ;
    CardOrd = NCard | NOrd ;

  oper
    mkPron : (ben,beni,bana,banin,bende,benden,benli,bensiz:Str) -> Number -> Person -> Pron =
     \ben,beni,bana,benim,bende,benden,benli,bensiz,n,p -> {
     s = table {
       Nom => ben ;
       Acc => beni ;
       Dat => bana ;
       Gen => benim ;
       Loc => bende ;
       Ablat => benden ;
       Abess Pos => benli ;
       Abess Neg => bensiz
       } ;
     a = {n=n; p=p} ;
     } ;

    -- Prep
    no_Prep = mkPrep [] Acc;

    mkPrep : Str -> Case -> {s : Str; c : Case; lock_Prep : {}} =
      \s, c -> lin Prep {s=s; c=c};

    mkClause : Str -> Agr -> Verb -> {s : Str} =
      \np, a, v -> ss (np ++ v.s ! VProg a) ;

    attachMe : Verb -> {s : Str} =
      \v ->
        let
          s : Str = v.s ! VImperative
        in
          case s of {
            (_ + #vowel + _ )* + (_ + #frontVowel + _) => ss (s ++ "me") ;
            (_ + #vowel + _)*  + (_ + #backVowel  + _) => ss (s ++ "ma")
          } ;
}
