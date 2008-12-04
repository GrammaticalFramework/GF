concrete LetterRus of Letter = {

flags lexer=textlit ; unlexer=textlit ; coding=utf8 ;

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
  regAdj : Str -> Num => Gen => Tok =\s -> table {
     sg => table {masc => s+"ой"; fem => s+"ая"};
     pl => table {masc => s+"ие"; fem => s+"ие"}
  };
  regVer : Str -> Num => Gen => Str = \s -> table {
     sg => table {masc => s; fem => s+"а"};
     pl => table {masc => s+"ы"; fem => s+"ы"}
  };
  
  hello : Str -> Num => Str = \s -> 
    table {sg => s ; pl => s+"те" } ;

  regVerPerf : Str -> Num => Gen => Str = \s -> table {
     sg => table {masc => s+"ся"; fem => s+"ось"};
     pl => table {masc => s+"ись"; fem => s+"ись"}
  };

  ego : Num => Str = 
    table {sg => "я" ; pl => "вы" } ;
  egoHave : Num => Str = 
    table {sg => ["я имею"] ; pl => ["мы имеем"]} ;

  haveBeen : Num => Gen => Str = table {
     sg => table {masc => ["ты был"] ; fem => ["ты была"] };
     pl => table {masc => ["вы были"]; fem => ["вы были"]}
  };

  thatPrep = [", что"] ; 
  informYou : Num => Str = 
    table {sg => ["сообщить тебе"]; pl => ["сообщить вам"]} ;
    
  loveYou : Num => Num => Str = table {
    sg => table {sg => ["я тебя люблю"] ; 
                 pl => ["я вас люблю"]} ;
    pl => table {sg => ["мы тебя любим"] ; 
                 pl => ["мы вас любим"]}
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

DearRec rec   = {s = regAdj "Дорог"
 ! rec.n ! rec.g ++ rec.s ; n = rec.n ; g = rec.g} ;
PlainRec rec  = rec ;
HelloRec rec  = {s = hello "Здравствуй" ! rec.n ++ rec.s ; n = rec.n ; g = rec.g} ;
JustHello rec = {s = hello "Здравствуй" ! rec.n ; n = rec.n ; g = rec.g} ;

ModeSent mode sent = 
  {s = 
    table {na => table {xa => table {nr => table {xr => 
      mode.s ! na ! xa ! nr ! xr ++ sent.s ! na ! xa ! nr ! xr}}}}
  } ;
PlainSent sent = sent ;

FormalEnding auth = 
  {s = 
     table {n => table {g => 
        "С" ++  
        ["наилучшими пожеланиями ,"] ++ RET ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;
InformalEnding auth = 
  {s = table {n => table {g => ["С дружеским приветом , "] ++ RET ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;

ColleaguesHe  = {s = "коллеги"   ; n = pl ; g = masc} ;
ColleaguesShe = {s = "коллеги"   ; n = pl ; g = fem} ;
ColleagueHe  = {s =  "коллега"  ; n = sg ; g = masc} ;
ColleagueShe = {s =  "коллега"  ; n = sg ; g = fem} ;
DarlingHe    = {s = "любимый"   ; n = sg ; g = masc} ;
DarlingShe   = {s = "любимая"  ; n = sg ; g = fem} ;
NameHe s   = {s = s.s  ; n = sg ; g = masc} ;
NameShe s  = {s = s.s  ; n = sg ; g = fem} ;


Honour = {s = 
    table {na => table {xa => table {nr => table {xr => 
      egoHave ! dep2num na nr ++ 
      ["честь"] ++ informYou ! nr ++ thatPrep}}}}
  } ;

Regret = {s = 
    table {na => table {ga => table {nr => table {gr =>
      let {dga = dep2gen ga gr ; dna = dep2num na nr} in 
      ego ! dna ++ regVer "вынужден" ! dna ! dga ++ 
      ["сообщить"] ++ thatPrep}}}}
  } ;


President = constNG ["президент"] sg masc ;
Mother    = constNG ["мама"] sg fem ;
Spouse    = {s = table {
                   sg => table {fem => ["твой муж"] ; masc => ["твоя жена"]} ; 
                   pl => table {fem => ["ваши мужья"] ; masc => ["ваши жены"]}
                 } ; n = depnum ; g = depgen} ;
Dean      = constNG ["декан"] sg masc ;
Name s    = constNG s.s sg masc ; ---

BePromoted pos = {s = 
    table {na => table {xa => table {nr => table {xr => 
      haveBeen ! nr ! xr ++ regVer  "назначен" ! nr ! xr ++ 
      pos.s ! nr ! xr}}}}
  } ;
GoBankrupt np = {s = 
    table {na => table {xa => table {nr => table {xr => 
      np.s ++ regVerPerf "обанкротил" ! np.n ! np.g }}}}
  } ;
ILoveYou = {s = 
    table {na => table {xa => table {nr => table {xr => 
      loveYou ! dep2num na nr ! nr}}}}
  } ;
    
Company      = {s = ["наше предприятие"] ; n = sg ; g = fem} ;
Competitor   = {s = ["наш конкурент"]    ; n = sg ; g = masc} ;
OurCustomers = {s = ["наши клиенты"] ; n = pl ; g = masc} ;

Senior = {s = table {sg => table {g => ["старшим научным сотрудником"]} ;
                     pl => table {g =>[ "старшими научными сотрудниками"]}
                    } 
         } ;

ProjectManager = {s = 
  table {
    sg => table {_ => ["менеджером проекта"]} ;
    pl => table {_ => ["менеджерами проектов"]}
        }} ;

}
