concrete LetterFin of Letter = {

--1 A Finnish Concrete Syntax for Business and Love Letters
--
-- This file defines the Finnish syntax of the grammar set 
-- whose abstract syntax is $letter.Abs.gf$. 

flags lexer=textlit ; unlexer=textlit ;

-- modified from French in 20 min, 15/6/2002

param Gen = masc | fem ;
param Num = sg | pl ;
param Kas = nom | acc ;
param DepNum = depnum | cnum Num ;
param DepGen = depgen | cgen Gen ;

lintype SS     = {s : Str} ;
lintype SSDep  = {s : Num => Gen => Str} ;      -- needs Num and Gen
lintype SSSrc  = {s : Str ; n : Num ; g : Gen} ; -- gives Num and Gen
lintype SSSrc2 = {s : Num => Gen => Str ; n : DepNum ; g : DepGen} ; -- gives&needs
lintype SSDep2 = {s : DepNum => DepGen => Num => Gen => Str} ; -- needs Auth's&Rec's
lintype SSSrcGen = {s : Str ; n : Num ; g : Gen} ; -- gives Num and Gen

oper 
  ss : Str -> SS = \s -> {s = s} ;

  noDep : (P : Type) -> Str -> P => Str = \_,s -> table {_ => s} ;

  cher : Num => Gen => Tok = 
    table {sg => noDep Gen "rakas" ; pl => noDep Gen "rakkaat"} ;

  egosum : Num => Str = 
    table {sg => "olen" ; pl => "olemme"} ;
  egohabeo : Num => Str = 
    table {sg => "minulla" ++ "on" ; pl => "meillä" ++ "on"} ;
  fuisti : Num => Str = 
    table {sg => "sinut" ++ "on"; pl => "teidät" ++ "on"} ;
  quePrep = "että" ; ----
  tuinformare : Num => Str = 
    table {sg => "ilmoittaa" ++ "sinulle" ; pl => "ilmoittaa" ++ "teille"} ;
  
  regNom : Str -> Num => Str = \pora -> table {sg => pora ; pl => pora + "t"} ;

  avoir : Num => Str = 
    table {sg => "on"; pl => "ovat"} ;
 
  mes : Num => Str = table {sg => "minun" ; pl => "meidän"} ;

  teamo : Num => Num => Str = table {
    sg => table {sg => "rakastan" ++ "sinua" ; 
                 pl => "rakastan" ++ "teitä"} ;
    pl => table {sg => "rakastamme" ++ "sinua" ; 
                 pl => "rakastamme" ++ "teitä"}
   } ;

  constNG : Str -> Num -> Gen -> SSSrc2 = \str,num,gen -> 
    {s =  table {_ => table {_ => str}} ; n = cnum num ; g = cgen gen} ;

  dep2num : DepNum -> Num -> Num = \dn,n -> case dn of {
    depnum  => n ; 
    cnum cn => cn
    } ;
  dep2gen : DepGen -> Gen -> Gen = \dg,g -> case dg of {
    depgen  => case g of {
      masc => fem ;
      fem  => masc
      };             -- negative dependence: the author is of opposite sex
    cgen cg => cg
    } ;

  RET = "" ; -- &-

lincat
Letter     = SS ;
Recipient  = SSSrc ;
Author     = SSSrc2 ;
Message    = SSDep2 ;
Heading    = SSSrc ;
Ending     = SSSrc2 ;
Mode       = SSDep2 ;
Sentence   = SSDep2 ;
NounPhrase = SSSrcGen ;
Position   = SSDep ;

lin
MkLetter head mess end = 
  ss (head.s ++ "," ++ RET ++ 
      mess.s ! end.n ! end.g ! head.n ! head.g ++ "." ++ RET ++ 
      end.s ! head.n ! head.g) ;

DearRec rec   = {s = cher ! rec.n ! rec.g ++ rec.s ; n = rec.n ; g = rec.g} ;
PlainRec rec  = rec ;
HelloRec rec  = {s = "Terve" ++ rec.s ; n = rec.n ; g = rec.g} ;
JustHello rec = {s = "Terve"          ; n = rec.n ; g = rec.g} ;

ModeSent mode sent = 
  {s = 
    table {na => table {xa => table {nr => table {xr => 
      mode.s ! na ! xa ! nr ! xr ++ sent.s ! na ! xa ! nr ! xr}}}}
  } ;
PlainSent sent = sent ;

FormalEnding auth = 
  {s = table {n => table {g => ["parhain terveisin"] ++ RET ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;
InformalEnding auth = 
  {s = table {n => table {g => ["terveisin"] ++ RET ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;

ColleaguesHe  = {s = regNom "kollega" ! pl  ; n = pl ; g = masc} ;
ColleaguesShe = {s = regNom "kollega" ! pl  ; n = pl ; g = fem} ;
ColleagueHe  = {s = regNom "kollega" ! sg ; n = sg ; g = masc} ;
ColleagueShe = {s = regNom "kollega" ! sg ; n = sg ; g = fem} ;
DarlingHe    = {s = "kulta"   ; n = sg ; g = masc} ;
DarlingShe   = {s = "kulta"  ; n = sg ; g = fem} ;
NameHe s   = {s = s.s  ; n = sg ; g = masc} ;
NameShe s  = {s = s.s  ; n = sg ; g = fem} ;


Honour = {s = 
    table {na => table {xa => table {nr => table {xr => 
      egohabeo ! dep2num na nr ++ 
      ["kunnia"] ++ tuinformare ! nr ++ quePrep}}}}
  } ;

Regret = {s = 
    table {na => table {ga => table {nr => table {gr =>
      mes ! dep2num na nr ++ 
      ["on valitettavasti ilmoitettava"] ++ quePrep}}}}
  } ;


President = constNG ["presidentti"] sg masc ;
Mother    = constNG ["äiti"] sg fem ;
Spouse    = {s = table {
                   sg => table {fem => ["miehesi"] ; masc => ["vaimosi"]} ; 
                   pl => table {fem => ["miehenne"] ; masc => ["vaimonne"]}
                 } ; n = depnum ; g = depgen} ;
Dean      = constNG ["dekaani"] sg masc ;
Name s    = constNG s.s sg masc ; ---

BePromoted pos = {s = 
    table {na => table {xa => table {nr => table {xr => 
      fuisti ! nr ++ "ylennetty" ++
      pos.s ! nr ! xr}}}}
  } ;
GoBankrupt np = {s = 
    table {na => 
      table {xa => 
        table {nr => 
          table {xr => 
            np.s ++ avoir ! np.n ++ 
            (case np.n of {sg => "mennyt" ; pl => "menneet"}) ++ 
            "konkurssiin"
          }
        }
      }
    }
  } ;

ILoveYou = {s = 
    table {na => table {xa => table {nr => table {xr => 
      teamo ! dep2num na nr ! nr}}}}} ;
    
Company      = {s = ["yrityksemme"]          ; n = sg ; g = fem} ;
Competitor   = {s = ["pahin kilpailijamme"]    ; n = sg ; g = masc} ;
OurCustomers = {s = ["asiakkaamme"] ; n = pl ; g = masc} ;

Senior = {s = table {sg => table {g => ["vanhemmaksi tutkijaksi"]} ;
                     pl => table {g => ["vanhemmiksi tutkijoiksi"]}
                    } 
         } ;

ProjectManager = {s = 
  table {
    sg => table {_ => ["projektipäälliköksi"]} ;
    pl => table {_ => ["projektipäälliköiksi"]}
        }} ;

}
