concrete LetterEng of Letter = {

--1 An English Concrete Syntax for Business and Love Letters
--
-- This file defines the English syntax of the grammar set 
-- whose abstract syntax is $letter.Abs.gf$. 

flags lexer=textlit ; unlexer=textlit ;

param Sex = masc | fem ;
param Num = sg | pl ;
param Kas = nom | acc ;
param DepNum = depnum | cnum Num ;

oper SS     = {s : Str} ;
oper SSDep  = {s : Num => Sex => Str} ;      -- needs Num and Sex
oper SSSrc  = {s : Str ; n : Num ; x : Sex} ; -- gives Num and Sex
oper SSSrc2 = {s : Num => Sex => Str ; n : DepNum ; x : Sex} ; -- gives and needs
oper SSDep2 = {s : DepNum => Sex => Num => Sex => Str} ; -- needs Auth's & Recp's
oper SSSrcNum  = {s : Str ; n : Num} ; -- gives Num only


oper 
  ss : Str -> SS = \s -> {s = s} ;
  constNX : Str -> Num -> Sex -> SSSrc2 = \str,num,sex -> 
    {s =  table {_ => table {_ => str}} ; n = cnum num ; x = sex} ;

  dep2num : DepNum -> Num -> Num = \dn,n -> case dn of {
    depnum  => n ; 
    cnum cn => cn
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
NounPhrase = SSSrcNum ;
Position   = SSDep ;

lin
MkLetter head mess end = 
  ss (head.s ++ "," ++ RET ++ 
      mess.s ! end.n ! end.x ! head.n ! head.x ++ "." ++ RET ++ 
      end.s ! head.n ! head.x) ;

DearRec rec   = {s = "Dear" ++ rec.s ; n = rec.n ; x = rec.x} ;
PlainRec rec  = rec ;
HelloRec rec  = {s = "Hello" ++ rec.s ; n = rec.n ; x = rec.x} ;
JustHello rec = {s = "Hello"          ; n = rec.n ; x = rec.x} ;

ModeSent mode sent = 
  {s = 
    table {dna => table {xa => table {nr => table {xr =>
      mode.s ! dna ! xa ! nr ! xr ++ sent.s ! dna ! xa ! nr ! xr}}}}
  } ;
PlainSent sent = sent ;

FormalEnding auth = 
  {s = table {n => table {x => 
     ["Sincerely yours"] ++ RET ++ auth.s ! n ! x}} ; n = auth.n ; x = auth.x} ;
InformalEnding auth = 
  {s = table {n => table {x => 
     ["With best regards"] ++ RET ++ auth.s ! n ! x}} ; n = auth.n ; x = auth.x} ;

ColleaguesHe  = {s = kollega ! pl ; n = pl ; x = masc} ;
ColleaguesShe = {s = kollega ! pl ; n = pl ; x = fem} ;
ColleagueHe  = {s = kollega ! sg ; n = sg ; x = masc} ;
ColleagueShe = {s = kollega ! sg ; n = sg ; x = fem} ;
DarlingHe    = {s = "darling"  ; n = sg ; x = masc} ;
DarlingShe   = {s = "darling"  ; n = sg ; x = fem} ;
NameHe s   = {s = s.s  ; n = sg ; x = masc} ;
NameShe s  = {s = s.s  ; n = sg ; x = fem} ;


Honour = {s = 
    table {dna => table {xa => table {nr => table {xr => 
      let {na = dep2num dna nr} in 
      ego ! na ! nom ++ ["have the honour to inform you that"]}}}}
  } ;

Regret = {s = 
    table {dna => table {xa => table {nr => table {xr =>
      let {na = dep2num dna nr} in  
      ego ! na ! nom ++ am ! na ++ ["sorry to inform you that"]}}}}
  } ;


President = constNX ["the President"] sg masc ;
Mother    = constNX "Mom" sg fem ;
Spouse    = {s = table {
                   sg => table {fem => ["your husband"] ; masc => ["your wife"]} ; 
                   pl => table {fem => ["your husbands"] ; masc => ["your wives"]}
                 } ; n = depnum ; x = masc} ; -- sex does not matter here
Dean      = constNX ["the Dean"] sg masc ;
Name s    = constNX s.s sg masc ; ---

BePromoted pos = {s = 
    table {na => table {xa => table {nr => table {xr => 
      ["you have been promoted to"] ++ 
      pos.s ! nr ! xr}}}}
  } ;
GoBankrupt np = {s = 
    table {na => table {xa => table {nr => table {xr => 
      np.s ++ have ! np.n ++ ["gone bankrupt"]}}}}
  } ;
ILoveYou = {s = 
    table {na => table {xa => table {nr => table {xr => 
      ego ! dep2num na nr ! nom ++ ["love you"]}}}}
  } ;
    
Company      = {s = ["our company"]          ; n = sg} ;
Competitor   = {s = ["our worst competitor"] ; n = sg} ;
OurCustomers = {s = ["our customers"]        ; n = pl} ;

Senior = {s = 
  table {
    sg => table {x => ["a senior fellow"]} ;
    pl => table {x => ["senior fellows"]}
        }} ;
ProjectManager = {s = 
  table {
    sg => table {_ => ["a project manager"]} ;
    pl => table {_ => ["project managers"]}
        }} ;

oper 

kollega : 
  Num => Str =
  table {sg => "colleague" ; pl => "colleagues"} ;

am : 
  Num => Str =
  table {sg => "am" ; pl => "are"} ;

have : 
  Num => Str =
  table {sg => "has" ; pl => "have"} ;

ego : 
  Num => Kas => Str =
  table {
    sg => table {nom => "I"  ; acc => "me"} ;
    pl => table {nom => "we" ; acc => "us"}
        } ;

}
