--# -path=.:../abstract:../common:../prelude

concrete CatMon of Cat = CommonX - [CAdv,Temp,Tense] ** open ResMon, Prelude in {

 flags optimize=all_subs ; coding=utf8 ;

lincat

-- Tensed/Untensed

   S  = {s : SType => Str} ;
   QS = {s : QForm => Str} ;  
   RS = {s : ComplType => Str ; existSubject : Bool} ;
   SSlash = {s : Str ; c2 : Complement} ;
   
-- Clause (variable tense) e.g. "John walks"/"John walked"

   Cl = {s : ClTense => Anteriority => Polarity => SType => Str} ; 
   ClSlash = {s : ClTense => Anteriority => Polarity => SType => Str ; c2 : Complement} ;
   Imp = {s : Polarity => ImpForm => Str} ;

-- Question

   QCl = {s : ClTense => Anteriority => Polarity => QForm => Str} ;  
   IP = {s : RCase => Str} ;  
   IComp = {s : Str} ;   
   IDet = {s : RCase => Str ; n : Number} ;   
   IQuant = {s : RCase => Str} ;
   
-- Relative

-- Mongolian lacks relative pronouns: a relative clause consists of a truncated sentence
-- (desentential phrase) in apposition to. The verbs of relative clauses in Mongolian take
-- verbal nominal endings (NDS). The subject goes into the genitive case, which transforms the RP.
-- (Binnick, 1979:89; Kullmann 2005:392)

   RCl = {s :  ClTense => Anteriority => Polarity => SType => Str ; existSubject : Bool} ;
   RP = {s : Str} ;

-- Verb

   VP = VerbPhrase ;  
   Comp = {s : RCase => Str} ;   
   VPSlash = VerbPhrase ** {c2 : Complement} ;            

-- Adjective
    
   AP = { s : Str } ; 
   CAdv = {s : Str} ** {c2 : Complement} ;

-- Noun (Mongolian common nouns have neither gender nor animacy):

   CN = {s : Number => NCase => Str} ; 
   NP = NounPhrase ;
   Pron = { s : PronForm => Str ; n : Number ; p : Person} ;

-- Determiners 

-- The determined noun has the case parameter specific for the determiner

   Det = {
      s : Str ; 
	  sp : RCase => Str ; -- substantival form
	  isNum : Bool ; -- true, if a numeral is present
	  isPoss : Bool ; -- true, if a possessive is present
	  isDef : Bool ; -- when definite, is true
	  isPre : Bool
	  } ;
   Ord = { s : Str } ;                              
   Predet = {
      s : Str ; 
	  isPre : Bool ; 
	  isDef : Bool 
	  }  ; 
   Quant = {
      s : Number => Str ; 
	  sp : Number => NCase => Str ; 
	  isPoss : Bool ; 
	  isDef : Bool
	  } ;

-- Numeral

   Num  = {s : Str ; sp : RCase => Str ; n : Number ; isNum : Bool} ; 
   Card = {s : Str ; sp : RCase => Str ; n : Number} ;
   Numeral = {s : CardOrd => Str; n : Number} ;
   Digits = {s : CardOrd => Str ; n : Number} ; 

-- Structural

   Conj = {s1,s2 : Str} ;
   Subj = {s : Str ; isPre : Bool} ;   
   Prep = {s : Str ; rc : RCase} ;

-- Open lexical classes, e.g. Lexicon

   V,VA,VS,VQ = Verb ;
   VV = Aux ;
   V2,V2S,V2A,V2Q,V2V = Verb ** {c2 : Complement} ; 
   V3 = Verb ** {c2,c3 : Complement} ;

   A = Adjective ; 
   A2 = Adjective ** {c2 : Complement} ;

   N = Noun ;  
   N2 = Noun ** {c2 : Complement} ;
   N3 = Noun ** {c2,c3 : Complement} ;
   PN = {s : RCase => Str} ;
   
   Temp = {s : Str ; t : ClTense ; a : Anteriority} ;
   Tense = {s : Str ; t : ClTense} ;
}

