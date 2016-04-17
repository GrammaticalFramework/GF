resource ResKal =
  ParamX [Number, Sg, Pl] **
open Prelude in {

param
  GPerson = GP1 | GP2 | GP3 | GP4 ;

  Case = Abs | Rel | Instr | All | Loc | Abl | Vial | Aequal ;


oper

-- p. Bjørnum, p. 71
  caseEnding : Number -> Case -> Str = \n,c ->
     let mn = case n of {Sg => "m" ; Pl => "n"}
   in case <n,c> of {
    <Sg,Abs>     => [] ;
    <Sg,Rel>     => "p" ;
    <_,Instr>    => mn + "ik" ;
    <_,All>      => mn + "ut" ;
    <_,Loc>      => mn + "i" ;
    <_,Abl>      => mn + "it" ; --- miit, minngaanniit
    <Sg,Vial>    => "kkut" ;
    <_, Aequal>  => "tut" ;  --- sut
    <Pl,Abs|Rel> => "t" ;
    <Pl,Vial>    => "tigut"  --- sigut
    } ;

  Noun : Type = {
    s : Number => Case => Str
    } ;


{-
  -- p. 76
  mkNoun : (sgAbs, sgRel, plAbs, sgInstr : Str) -> Noun =
    \sgAbs, sgRel, plAbs, sgInstr -> {
      s = \\
-}

-- p. 190
  vowelNoun : Str -> Noun = \illu -> {
    s = \\n,c => illu + caseEnding n c ;
    } ;

-- examples
  illu_Noun = vowelNoun "illu" ; -- house
  aja_Noun  = vowelNoun "aja" ;  -- aunt (moster)
  ini_Noun  = vowelNoun "ini" ;  -- hut

-- p. 197
  qWeakNoun : Str -> Noun = \qimmeq ->
    let
      qimmi : Str = case qimmeq of {
        qimm + "eq"  => qimm + "i" ;  -- p. 197
	mee  + "raq" => mee + "qqa" ; -- p. 199 --- for inflection with gemination
	igal + "aaq" => igal + "aa" ; -- p. 203 --- for double vowels
	_ => init qimmeq ----
        }
    in {
    s = \\n,c => case <n,c> of {
      <Sg,Abs> => qimmeq ;
      _ => qimmi + caseEnding n c
      }
    } ;

  qimmeq_Noun  = qWeakNoun "qimmeq" ;   -- dog
  meeraq_Noun  = qWeakNoun "meeraq" ;   -- child 
  igalaaq_Noun = qWeakNoun "igalaaq" ;  -- window



}