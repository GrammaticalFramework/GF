resource ResSlv = open ParamX, Prelude in {

param
  Case = Nom | Gen | Dat | Acc | Loc | Instr;
  Number = Sg | Dl | Pl ;
  Gender = Masc | Fem | Neut ;
  Person = P1 | P2 | P3 ;
  Species = Indef | Def ;
  Animacy = Animate | Inanimate ;
  AGender = AMasc Animacy | AFem | ANeut ;

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
        
        -- the rest are not really needed because they seem to be syncretic
        | APositDefNom
        | APositIndefAcc
        | APositDefAcc
        | AComparDefAcc
        | ASuperlDefAcc ;

oper
  Agr = {g : Gender; n : Number; p : Person} ;

  Conj = {s : Str; n : Number} ;

  mkConj : Str -> Number -> Conj = \str,nr -> { s = str ; n = nr } ;

  conjNumber : Number -> Number -> Number = \m,n -> 
    case m of {
      Sg => n ;
      _  => Pl 
    } ;

  conjAgr : Agr -> Agr -> Agr = \a,b -> {
    g = b.g ;
    n = conjNumber a.n b.n ;
    p = b.p
  } ;

  VP = {s : Polarity => VForm => Str; s2 : Agr => Str; isCop : Bool ; refl : Str} ;

  ne : Polarity => Str =
    table {Pos => "" ;
           Neg => "ne"
          } ;
          
  ni : Polarity => Str =
    table {Pos => "" ;
           Neg => "ni"
          } ;


  --Added the position of the reflexive particle. Needs testing. 

  predV : Bool -> Bool -> Str -> (Polarity => VForm => Str) -> Tense => Polarity => Agr => Str =
    \ispron,iscop,refl,v -> table {
             Pres => \\p,a => v ! p ! VPres a.n a.p ++ refl ;
             Past => \\p,a => case <ispron,p> of {
                                <True,Pos> => v ! Pos ! VPastPart a.g a.n ++ refl ++ copula ! p ! VPres a.n a.p ;
                                <_   ,_  > => copula ! p ! VPres a.n a.p ++ refl ++ v ! Pos ! VPastPart a.g a.n } ;
             Fut  => \\p,a => case <ispron,p> of {
                                <True,Pos> => case iscop of {
                                                False => v ! Pos ! VPastPart a.g a.n ++ refl ++ bom_V ! a.n ! a.p ;
                                                True  => bom_V ! a.n ! a.p
                                              } ;
                                <_   ,_  > => case iscop of {
                                                False => refl ++ ne ! p ++ bom_V ! a.n ! a.p ++ v ! Pos ! VPastPart a.g a.n ;
                                                True  => ne ! p ++ bom_V ! a.n ! a.p
                                              } } ;
             Cond => \\p,a => ne ! p ++ "bi" ++ refl ++ v ! Pos ! VPastPart a.g a.n
          } ;

  copula : Polarity => VForm => Str = \\p =>
    table {
      VInf              => ne ! p ++ "biti";
      VSup              => ne ! p ++ "bit";
      VPastPart Masc Sg => ni ! p ++ "bil";
      VPastPart Masc Dl => ni ! p ++ "bila";
      VPastPart Masc Pl => ni ! p ++ "bili";
      VPastPart Fem  Sg => ni ! p ++ "bila";
      VPastPart Fem  Dl => ni ! p ++ "bili";
      VPastPart Fem  Pl => ni ! p ++ "bile";
      VPastPart Neut Sg => ni ! p ++ "bilo";
      VPastPart Neut Dl => ni ! p ++ "bili";
      VPastPart Neut Pl => ni ! p ++ "bila";
      VPres Sg P1       => ni ! p + "sem";
      VPres Sg P2       => ni ! p + "si";
      VPres Sg P3       => case p of {Pos=>"je"; Neg=>"ni"};
      VPres Dl P1       => ni ! p + "sva";
      VPres Dl P2       => ni ! p + "sta";
      VPres Dl P3       => ni ! p + "sta";
      VPres Pl P1       => ni ! p + "smo";
      VPres Pl P2       => ni ! p + "ste";
      VPres Pl P3       => ni ! p + "so"; 
      VImper1Sg         => ne ! p ++ "bodita";
      VImper1Dl         => ne ! p ++ "bodite";
      VImper2 Sg        => ne ! p ++ "bodi";
      VImper2 Dl        => ne ! p ++ "bodiva";
      VImper2 Pl        => ne ! p ++ "bodimo"
    };

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

  reflexive : Case => Str = 
    table {
      (Acc | Gen) => "se" ;
      (Loc | Dat) => "si" ;
      Instr       => "sabo" ;
      _           => "wrong" --we should never get here
    } ;


  Clause : Type = {
    s : Tense => Anteriority => Polarity => Str
    } ;


-- Ändra här så att vi kan fixa in det reflexiva pronomenet. Ändra även så att vi har en V2Slash med ett särskilt fält för reflexiv? 

  mkClause : Str -> Agr -> Bool -> VP -> Clause =
    \subj,agr,ispron,vp -> {
      s = \\t,a,p => 
        case ispron of {
          False => subj ++ predV ispron vp.isCop vp.refl vp.s ! t ! p ! agr ++ vp.s2 ! agr ;
          True  => case vp.isCop of {
                     False => predV ispron vp.isCop vp.refl vp.s ! t ! p ! agr ++ vp.s2 ! agr ;
                     True  => vp.s2 ! agr ++ predV ispron vp.isCop vp.refl vp.s ! t ! p ! agr
                   }
        }
    } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> vp ** {
    s2 = \\a => vp.s2 ! a ++ obj ! a ;
    } ;
    
  numAgr2num : NumAgr => Number =
    table {UseNum n => n; UseGen => Pl} ;
    
  agender2gender : AGender -> Gender = \ag ->
    case ag of {
      AMasc _ => Masc ;
      AFem    => Fem ;
      ANeut   => Neut
    } ;

  inanimateGender : Gender -> AGender = \g ->
    case g of {
      Masc => AMasc Inanimate ;
      Fem  => AFem ;
      Neut => ANeut
    } ;

}
