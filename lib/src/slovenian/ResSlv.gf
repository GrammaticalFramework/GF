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

  predV : (VForm => Str) -> Tense => Agr => Str =
    \v -> table {
             Pres => \\a => v ! VPres a.n a.p ;
             Past => \\a => sem_V ! a.n ! a.p ++ v ! VPastPart a.g a.n ;
             Fut  => \\a => bom_V ! a.n ! a.p ++ v ! VPastPart a.g a.n ;
             Cond => \\a => "bi" ++ v ! VPastPart a.g a.n
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
        subj ++ predV vp.s ! t ! agr ++ vp.s2 ! agr
    } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> vp ** {
    s2 = \\a => vp.s2 ! a ++ obj ! a ;
    } ;

}
