resource Morpho = open Prelude in {

param
  VForm = VInf | VPres | VPast | VPastPart | VPresPart ;

oper
  Verb : Type = {s : VForm => Str} ;

-- worst-case function for data abstraction

  mkVerb : (_,_,_,_,_ : Str) -> Verb = \vi,vpr,vpa,vpap,vprp -> {
    s = table {
      VInf => vi ;
      VPres => vpr ;
      VPast => vpa ;
      VPastPart => vpap ;
      VPresPart => vprp
      }
    } ;

  regVerb : Str -> Verb = \walk -> 
    mkVerb walk (walk + "s") (walk + "ed") (walk + "ed") (walk + "ing") ;

  s_regVerb : Str -> Verb = \kiss -> 
    mkVerb kiss (kiss + "es") (kiss + "ed") (kiss + "ed") (kiss + "ing") ;

  e_regVerb : Str -> Verb = \use -> 
    let us = init use 
    in
    mkVerb use (use + "s") (us + "ed") (us + "ed") (us + "ing") ;

  y_regVerb : Str -> Verb = \cry -> 
    let cr = init cry 
    in
    mkVerb cry (cr + "ies") (cr + "ied") (cr + "ied") (cry + "ing") ;

  ie_regVerb : Str -> Verb = \die -> 
    let dy = Predef.tk 2 die + "y" 
    in
    mkVerb die (die + "s") (die + "d") (die + "d") (dy + "ing") ;

  dupRegVerb : Str -> Verb = \stop -> 
    let stopp = stop + last stop 
    in
    mkVerb stop (stop + "s") (stopp + "ed") (stopp + "ed") (stopp + "ing") ;

  smartVerb : Str -> Verb = \v -> case v of {
    _ + ("s"|"z"|"x"|"ch")      => s_regVerb v ;
    _                    + "ie" => ie_regVerb v ;
    _                    + "ee" => mkVerb v (v + "s") (v + "d") (v + "d") (v + "ing") ;
    _                     + "e" => e_regVerb v ;
    _ + ("a"|"e"|"o"|"u") + "y" =>   regVerb v ;
    _                     + "y" => y_regVerb v ;
    _ + ("ea"|"ee"|"ie"|"oa"|"oo"|"ou") + ? => regVerb v ;
    _ + ("a"|"e"|"i"|"o"|"u") + 
            ("b"|"d"|"g"|"m"|"n"|"p"|"s"|"t") => dupRegVerb v ;
    _ => regVerb v
    } ;

  irregVerb : (_,_,_ : Str) -> Verb = \sing,sang,sung -> 
    let v = smartVerb sing 
    in
    mkVerb sing (v.s ! VPres) sang sung (v.s ! VPresPart) ;

-- first example of matching

  add_s : Str -> Str = \v -> case v of {
    _ +     ("s"|"z"|"x"|"ch")  => v  + "es" ;
    _ + ("a"|"e"|"o"|"u") + "y" => v  + "s" ;
    cr                    + "y" => cr + "ies" ;
    _                           => v  + "s"
    } ;

-- user paradigm

  mkV = overload {
    mkV : (cry : Str) -> Verb = smartVerb ;
    mkV : (sing,sang,sung : Str) -> Verb = irregVerb ;
    mkV : (go,goes,went,gone,going : Str) -> Verb = mkVerb ;
  } ;

}
