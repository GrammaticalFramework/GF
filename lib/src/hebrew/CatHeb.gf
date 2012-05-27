--# -path=alltenses

concrete CatHeb of Cat = CommonX - [Utt,Tense,Temp]  ** open ResHeb, Prelude, ParamX in {

  flags optimize=all_subs ;

  lincat

    S  = {s : Mood => Str} ;
    Utt = {s : Str} ;
    Cl =  ResHeb.Cl ;		-- {s : TenseHeb => Polarity => Str} ; 
    VP = ResHeb.VP ;		-- {v : Verb ; obj : Str} ;
    VPSlash = ResHeb.VP ; 	-- TODO VPSlash in Res "titel le-johan" 
    Comp = {s : Agr => Str} ; 
    NP = ResHeb.NP ;            -- {s : Case =>  {obj : Str} ; a : Agr ; isDef : Bool ; sp : Species} ;
    CN =  ResHeb.Noun ;  	-- {s : Number => Species => Str ; g: Gender} ;
    Det = ResHeb.Det ;  	-- {s :  Gender => Str ; n : Number ; sp : Species; isDef : Bool} ; 
    Pron = {s : Case =>  {obj : Str} ; a : Agr ; isDef : Bool ; sp : Species} ;
    Num, Ord =  ResHeb.Num ;  	-- {s : Case => Str; n : Number} ; 
    Card = {s : Str} ; 	   	-- {s : CardForm => Str; n : Number} ;
    Quant = {s :  ResHeb.Number => Gender => Str ; sp : Species; isDef : Bool; isSNum : Bool} ;  
    AP =  ResHeb.AP ;	    	-- {s : Number => Species => Gender =>  Str } ; 

    N = ResHeb.Noun ;         	  -- {s : Number => Species => Str ; g: Gender } ;
    A = ResHeb.Adj ;              -- {s :  Number => Species => Gender => Str} ; 
    V, VV, VS, VQ, VA = ResHeb.Verb ;          	  -- {s : Tense => VPerNumGen  => Str } ;
    V2, V2A = ResHeb.Verb2 ; 	  -- Verb ** {c : Case} ; 
    PN = ResHeb.PN ; 	   	  -- {s : Case => Str; g : Gender} ;
    Prep =  ResHeb.Prep ;  
    ClSlash = ResHeb.ClSlash ; 
    Temp  = {s : Str ; t : TenseHeb ; a : Anteriority} ;
    Tense = {s : Str ; t : TenseHeb} ;
    
A2 = {s : Str} ; 
Conj = {s : Str} ;
Digits = {s : Str} ;
IComp = {s : Str} ;
IDet = {s : Str} ;
IP = {s : Str} ;
IQuant = {s : Str} ;
Imp = {s : Str} ;
N2 = {s : Str} ;
N3 = {s : Str} ;
Numeral = {s : Str} ;
Predet = {s : Str} ;
QCl = {s : Str} ;
QS = {s : Str} ;
RCl = {s : Str} ;
RP = {s : Str} ;
RS = {s : Str} ;
SSlash = {s : Str} ;
Subj = {s : Str} ;
V2Q = {s : Str} ;
V2S = {s : Str} ;
V2V = {s : Str} ;
V3 = {s : Str} ;

}
