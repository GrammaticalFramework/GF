include letter.Abs.gf ;

-- (c) Alex Kutsela 2005

flags lexer=textlit ; unlexer=textlit ; coding=utf8 ;

param Gen = masc | fem ;
param Num = sg | pl ;
param Kas = nom | dat | acc ;
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
     sg => table {masc => s; fem => s+"ה"};
     pl => table {masc => s+"ים"; fem => s+"ות"}
  };

hello : Str -> Num => Str = \s -> table {sg => s ; pl => s} ;

regVerPerf : Str -> Num => Gen => Str = \s -> 
           table {sg => table {masc => s; fem => s+"ה"};
                  pl => table {masc => s+"ו"; fem => s+"ו"}
           };
	
ego : Num => Str =  table {sg => "אןי" ; pl => "אןחןו" } ;

tu : Num => Gen => Kas => Str =  
	table {sg => table {fem  => table {nom => "את";  dat => "לך"; acc => "אותך"} ;
                            masc => table {nom => "אתה"; dat => "לך"; acc => "אותך"}    
                     } ;  
	       pl => table {fem  => table {nom => "אתן"; dat => "לכן"; acc => "אתכן"} ;
                            masc => table {nom => "אתם"; dat => "לכם"; acc => "אתכם"}        
                     }
        };

hereIam : Num => Str = 
    table {sg => "הןןי" ; pl => "הןןו" } ;

haveBeen : Str -> Num => Gen => Str = \s -> 
           table {sg => table {masc => s+"ת"; fem => s+"ת"};
                  pl => table {masc => s+"תם"; fem => s+"תן"}
                 };

thatConj = ["ש"] ;
 
regVer : Str -> Num => Gen => Str = \s -> 
	table {sg => table {masc => s; fem => s+"ת"};
               pl => table {masc => s+"ים"; fem => s+"ות"}
        };

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
  ss ("," ++ head.s ++ "&-" ++ 
       mess.s ! end.n ! end.g ! head.n ! head.g  ++ "&-" ++
       end.s ! head.n ! head.g) ;

DearRec rec   = {s = rec.s ++ regAdj "יקר" ! rec.n ! rec.g; 
                 n = rec.n; 
                 g = rec.g};
PlainRec rec  = rec ;
HelloRec rec  = {s = hello "שלום" ! rec.n ++ rec.s ; n = rec.n ; g = rec.g} ;
JustHello rec = {s = hello "שלום" ! rec.n ; n = rec.n ; g = rec.g} ;

ModeSent mode sent = 
  {s = 
    table {na => table {xa => table {nr => table {xr => 
      mode.s ! na ! xa ! nr ! xr ++ sent.s ! na ! xa ! nr ! xr}}}}
  } ;
PlainSent sent = sent ;

FormalEnding auth = 
  {s = 
     table {n => table {g => 
	[",בכבוד רב &-"] ++
        auth.s ! n ! g 	 
         }} ; 
   n = auth.n ; g = auth.g} ;

InformalEnding auth = 
  {s = table {n => table {g => [",בברכה &-"] ++ auth.s ! n ! g}} ; 
   n = auth.n ; g = auth.g} ;

ColleagueHe  = {s =  "עמית"  ; n = sg ; g = masc} ;
ColleagueShe = {s =  "עמיתה"  ; n = sg ; g = fem} ;
ColleaguesHe  = {s = "עמיתים"   ; n = pl ; g = masc} ;
ColleaguesShe = {s = "עמיתות"   ; n = pl ; g = fem} ;
DarlingHe    = {s = "אהובי"   ; n = sg ; g = masc} ; 
DarlingShe   = {s = "אהובתי"  ; n = sg ; g = fem} ; 

NameHe s   = {s = s.s  ; n = sg ; g = masc} ;
NameShe s  = {s = s.s  ; n = sg ; g = fem} ;

Honour = {s = table {
                 na => table {
                         xa => table {
                                 nr => table {
                                         xr => hereIam ! dep2num na nr ++
                                               regVer "מתכבד" ! dep2num na nr ! dep2gen xa xr ++  
                                               ["להודיע"] ++ tu ! nr ! xr ! dat ++ thatConj
                                             }
                                      }
                              }
                       }
          } ;

Regret = {s = table {
                na => table {
                        ga => table {
                                nr => table {
                                        gr => let {dga = dep2gen ga gr ; dna = dep2num na nr} in 
                                        ego ! dna ++ regVer "מצטער" ! dna ! dga ++ 
                                        ["להודיע"] ++ tu ! nr ! gr ! dat ++ thatConj
                                            }
                                    }
                             }
                     }
           } ;

Dean      = constNG ["דיקן"] sg masc ;
President = constNG ["ןשיא"] sg masc ;
Mother    = constNG ["אמא"] sg fem ;
Name s    = constNG s.s sg masc ; ---
Spouse    = {s = table {
                   sg => table {fem => ["בעלך"] ; masc => ["אישתך"]} ; 
                   pl => table {fem => ["בעליכן"] ; masc => ["ןשותיכם"]}
                 } ; n = depnum ; g = depgen} ;

BePromoted pos = {s = table {
                         na => table {
                                  xa => table {
                                           nr => table {
                 xr => haveBeen  "קודמ" ! nr !xr ++ "לתפקיד" ++ "של" ++ pos.s ! nr ! xr 
                                                        }
                                              }
                                     }
                           }
                 } ;

GoBankrupt np = 
	{s = table 
		{na => table 
			{xa => table 
				{nr => table 
					{xr => np.s ++ regVerPerf "פשט" ! np.n ! np.g ++ "רגל"}
				}
			}
		}
  	} ;

ILoveYou = {s = table 
                {na => table 
                       {ga => table 
                              {nr => table 
                                    {gr => let {dga = dep2gen ga gr ; dna = dep2num na nr} in
					   ego ! dna ++ regVer "אוהב" ! dna ! dga ++ 
                                              tu ! nr ! gr ! acc}
                              }
                       }
               }
           } ;

Company      = {s = ["חברתןו"] ; n = sg ; g = fem} ;
Competitor   = {s = ["המתחרה הגרוע ביותר שלןו"]    ; n = sg ; g = masc} ;
OurCustomers = {s = ["לקוחותיןו"] ; n = pl ; g = masc} ;

Senior = {s = table 
		{sg => table {g => ["חבר בכיר"]} ;
                 pl => table {g => ["חברים  בכירים"]}
                } 
         } ;

ProjectManager = {s = table {
			sg => table {fem => ["מןהלת פרוייקט"]; masc => ["מןהל פרוייקט"]} ;
    			pl => table {fem => ["מןהלות פרוייקט"]; mask =>["מןהלי פרוייקט"]}
       			}
		} ;
