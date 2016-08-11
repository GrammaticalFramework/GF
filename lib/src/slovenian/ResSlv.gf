resource ResSlv = open ParamX in {

param
  Case = Nom | Gen | Dat | Acc | Loc | Instr;
  Number = Sg | Dl | Pl ;
  Gender = Masc | Fem | Neut ;
  Person = P1 | P2 | P3 ;
  Species = Indef | Def ;

  NumAgr = UseNum Number | UseGen;
  DForm = Unit Gender | Teen | Ten | Hundred;

  VForm = VInf
        | VSup
        | VPastPart Gender Number
        | VPres Number Person
        | VImper1Sg
        | VImper1Dl
        | VImper2 Number ;

  AForm = APosit  Gender Number Case
        | ACompar Gender Number Case
        | ASuperl Gender Number Case
        | APositDefNom
        | APositIndefAcc
        | APositDefAcc
        | AComparDefAcc
        | ASuperlDefAcc ;

oper
  Agr = {g : Gender; n : Number; p : Person} ;

  VP = {s : VForm => Str; s2 : Agr => Str} ;

  neg : Polarity => Tense => Str =
    table {Pos => \\_ => "" ;
           Neg => table {Past => "ni"; _ => "ne"}
          } ;

  predV : (VForm => Str) -> Tense => Polarity => Agr => Str =
    \v -> table {
             Pres => \\p,a => neg ! p ! Pres ++ v ! VPres a.n a.p ;
             Past => \\p,a => neg ! p ! Past +  sem_V ! a.n ! a.p ++ v ! VPastPart a.g a.n ;
             Fut  => \\p,a => neg ! p ! Fut  ++ bom_V ! a.n ! a.p ++ v ! VPastPart a.g a.n ;
             Cond => \\p,a => neg ! p ! Cond ++ "bi" ++ v ! VPastPart a.g a.n
          } ;

  sem_V : Number => Person => Str =
    table {
      Sg => table {
              P1 => "sem" ;
              P2 => "si" ;
              P3 => "je"
            } ;
      Dl => table {
              P1 => "sva" ;
              P2 => "sta" ;
              P3 => "sta"
            } ;
      Pl => table {
              P1 => "smo" ;
              P2 => "ste" ;
              P3 => "so"
            }
    } ;

  bom_V : Number => Person => Str =
    table {
      Sg => table {
              P1 => "bom" ;
              P2 => "boš" ;
              P3 => "bo"
            } ;
      Dl => table {
              P1 => "bova" ;
              P2 => "bosta" ;
              P3 => "bosta"
            } ;
      Pl => table {
              P1 => "bomo" ;
              P2 => "boste" ;
              P3 => "bodo"
            }
    } ;

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,p => 
        subj ++ predV vp.s ! t ! p ! agr ++ vp.s2 ! agr
    } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> vp ** {
    s2 = \\a => vp.s2 ! a ++ obj ! a ;
    } ;

}
