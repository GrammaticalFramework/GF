concrete LetterFre of Letter = {

--1 An French Concrete Syntax for Business and Love Letters
--
-- This file defines the French syntax of the grammar set 
-- whose abstract syntax is $letter.Abs.gf$. 


flags lexer=textlit ; unlexer=textlit ;

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
  cher : Num => Gen => Tok = 
    table {n => table {masc => regNom "cher" ! n ; fem => regNom "chère" ! n}};
  regAdj : Str -> Gen => Num => Str = \s -> 
    table {masc => regNom s ; fem => regNom (s + "e")} ;
  regNom : Str -> Num => Str = \s -> table {sg => s ; pl => s + "s"} ;
  egosum : Num => Str = 
    table {sg => "je" ++ "suis" ; pl => "nous" ++ "sommes"} ;
  egohabeo : Num => Str = 
    table {sg => "j'ai" ; pl => "nous" ++ "avons"} ;
  fuisti : Num => Str = 
    table {sg => "tu" ++ "as" ++ "été"; pl => "vous" ++ "avez" ++ "été"} ;
  quePrep = "que" ; ----
  tuinformare : Num => Str = 
    table {sg => "t'informer"; pl => "vous" ++ "informer"} ;

  avoir : Num => Str = 
    table {sg => "a"; pl => "ont"} ;
 
  mes : Num => Str = table {sg => "mes" ; pl => "nos"} ;

  teamo : Num => Num => Str = table {
    sg => table {sg => "je" ++ "t'aime" ; 
                 pl => "je" ++ "vous" ++ "aime"} ;
    pl => table {sg => "nous" ++ "t'aimons" ; 
                 pl => "nous" ++ "vous" ++ "aimons"}
   } ;

  constNG : Str -> Num -> Gen -> SSSrc2 = \str,num,gen -> 
    {s =  table {_ => table {_ => str}} ; n = cnum num ; g = cgen gen} ;

  dep2num : DepNum -> Num -> Num = \dn,n -> case dn of {
    depnum  => n ; 
    cnum sg => sg ;
    cnum pl => pl
    } ;
  dep2gen : DepGen -> Gen -> Gen = \dg,g -> case dg of {
    depgen  => case g of {
      masc => fem ;
      fem  => masc
      };             -- negative dependence: the author is of opposite sex
    cgen cg => cg
    } ;


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
  ss (head.s ++ "," ++ "&-" ++ 
      mess.s ! end.n ! end.g ! head.n ! head.g ++ "." ++ "&-" ++ 
      end.s ! head.n ! head.g) ;

DearRec rec   = {s = cher ! rec.n ! rec.g ++ rec.s ; n = rec.n ; g = rec.g} ;
PlainRec rec  = rec ;
HelloRec rec  = {s = "Bonjour" ++ rec.s ; n = rec.n ; g = rec.g} ;
JustHello rec = {s = "Bonjour"          ; n = rec.n ; g = rec.g} ;

ModeSent mode sent = 
  {s = 
    table {na => table {xa => table {nr => table {xr => 
      mode.s ! na ! xa ! nr ! xr ++ sent.s ! na ! xa ! nr ! xr}}}}
  } ;
PlainSent sent = sent ;

FormalEnding auth = 
  {s = 
     table {n => table {g => 
        "avec" ++ mes ! dep2num auth.n n ++ 
        ["salutations distinguées &-"] ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;
InformalEnding auth = 
  {s = table {n => table {g => ["Amicalement &-"] ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;

ColleaguesHe  = {s = regNom "collègue" ! pl  ; n = pl ; g = masc} ;
ColleaguesShe = {s = regNom "collègue" ! pl  ; n = pl ; g = fem} ;
ColleagueHe  = {s = regNom "collègue" ! sg ; n = sg ; g = masc} ;
ColleagueShe = {s = regNom "collègue" ! sg ; n = sg ; g = fem} ;
DarlingHe    = {s = "chéri"   ; n = sg ; g = masc} ;
DarlingShe   = {s = "chérie"  ; n = sg ; g = fem} ;
NameHe s   = {s = s.s  ; n = sg ; g = masc} ;
NameShe s  = {s = s.s  ; n = sg ; g = fem} ;

Honour = {s = 
    table {na => table {xa => table {nr => table {xr => 
      egohabeo ! dep2num na nr ++ 
      ["l'honneur de"] ++ tuinformare ! nr ++ quePrep}}}}
  } ;

Regret = {s = 
    table {na => table {ga => table {nr => table {gr =>
      let {dga = dep2gen ga gr ; dna = dep2num na nr} in 
      egosum ! dna ++ regAdj "désolé" ! dga ! dna ++ 
      ["d'informer"] ++ quePrep}}}}
  } ;


President = constNG ["le président"] sg masc ;
Mother    = constNG ["maman"] sg fem ;
Spouse    = {s = table {
                   sg => table {fem => ["ton mari"] ; masc => ["ta femme"]} ; 
                   pl => table {fem => ["vos maris"] ; masc => ["vos femmes"]}
                 } ; n = depnum ; g = depgen} ;
Dean      = constNG ["le doyen"] sg masc ;
Name s    = constNG s.s sg masc ; ---

BePromoted pos = {s = 
    table {na => table {xa => table {nr => table {xr => 
      fuisti ! nr ++ regAdj "promu" ! xr ! nr ++ 
      pos.s ! nr ! xr}}}}
  } ;
GoBankrupt np = {s = 
    table {na => table {xa => table {nr => table {xr => 
      np.s ++ avoir ! np.n ++ ["fait banqueroute"]}}}}
  } ;
ILoveYou = {s = 
    table {na => table {xa => table {nr => table {xr => 
      teamo ! dep2num na nr ! nr}}}}
  } ;
    
Company      = {s = ["notre entreprise"]          ; n = sg ; g = fem} ;
Competitor   = {s = ["notre pire compétiteur"]    ; n = sg ; g = masc} ;
OurCustomers = {s = ["nos clients"] ; n = pl ; g = masc} ;

Senior = {s = table {sg => table {g => ["responsable scientifique"]} ;
                     pl => table {g => ["responsables scientifiques"]}
                    } 
         } ;

ProjectManager = {s = 
  table {
    sg => table {_ => ["chef de projet"]} ;
    pl => table {_ => ["chefs de projets"]}
        }} ;
}
