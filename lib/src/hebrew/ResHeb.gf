--# -path=alltenses

-- (c) 2011 Dana Dannells
-- Licensed under LGPL
-- Compiled with GF version 3.3

resource ResHeb =  PatternsHeb ** open Prelude, ParamX in {

  flags coding=utf8 ;

param

 Number = Sg | Pl | Dl ;
 Gender = Masc | Fem ;
 Species = Def | Indef ;
 Case = Nom | Acc | Dat ;
 Agr = Ag Gender Number Person;
 Person = Per1 | Per2 | Per3 ;
 Voice = Active | Passive | Reflexive ; 
 VPerNumGen = Vp1Sg | Vp1Pl | Vp2Sg Gender | Vp2Pl Gender | Vp3Sg Gender | Vp3Pl Gender ;
 TenseHeb = Perf | Part | Imperf ;
 NPForm = Verbal | Nominal ;  
 Size = One | Two | ThreeTen | Teen | NonTeen | Hundreds | None ;
 Mood = Ind | Con ;


oper

 Cl = {s : TenseHeb => Anteriority => Polarity => Str};  
 NP = {s :  Case => {obj : Str} ; a : Agr ; isDef : Bool ; sp : Species } ; 
 AP = {s : Number => Species => Gender =>  Str } ; 
 PN = {s : Case => Str; g : Gender} ;

 ClSlash : Type = {
 	 s : TenseHeb => Polarity => Str ;
	 c2 : Prep
   	 } ;

 VP : Type = { 
      s : TenseHeb => Polarity =>VPerNumGen => Str; 
      obj : Str;
      pred : Comp;
      isPred : Bool; --indicates if there is a predicate (xabar)
      s2 : Str
      } ; 

 VPSlash = VP ** {c2 : Case} ;

 Prep = {s : Str ; isPre : Bool} ;

 mkClause : Str -> VPerNumGen -> VP -> Cl =
    \subj,png,vp -> {
      s = \\t,a,p => 
        let 
          verb  = vp.s ! t ! p ! png ;
          obj = vp.obj;
          gn = png2gn png ;
	  pred = vp.pred.s ! gn ! Nom               
        in
	  subj ++ obj ++ pred ++ verb ;
  	  } ;

 agr2png : Agr -> VPerNumGen = \a -> 
 	case a of {
    	     Ag g n p => chooseForm g n p  
  	 } ;

 png2gn : VPerNumGen -> {g : Gender; n : Number} = \png ->
      case png of {
      	   Vp1Sg => {n = Sg ; g =Masc} ; 
      	   Vp1Pl => {n = Pl ; g =Masc} ; 
      	   Vp2Sg g   => {n = Sg ; g = g} ;
      	   Vp2Pl g   => {n = Pl ; g = g} ;
      	   Vp3Sg g   => {n = Sg ; g = g} ;
      	   Vp3Pl g   => {n = Pl ; g = g} 
      } ;
      
 pronNP : (s,a,d : Str) -> Gender -> Number -> Person ->  NP =
      \s,a,d,g,n,p ->  { 
      	s = 
	  table {
	  	Nom => {obj = s}  ;
	  	Acc => {obj = a}  ;
	  	Dat => {obj = []}
          	} ;
    	  isDef = False ;
    	  sp = Indef ; 
    	  a = Ag g n p 
  } ;

  agrV : Verb -> TenseHeb ->  Agr -> Str = \v,t,a -> case a of {
    Ag g n p => v.s ! t ! (chooseForm g n p)  
  } ;
  
  chooseForm : Gender -> Number -> Person -> VPerNumGen = \g,n,p->
  	case <g,n,p> of {
       	     <_,Sg,Per1> => Vp1Sg;
       	     <_,Pl,Per1> =>  Vp1Pl; 
       	     <_,Sg,Per2> => Vp2Sg g ; 
       	     <_,Pl,Per2> => Vp2Pl g ; 
       	     <_,Sg,Per3> => Vp3Sg g ; 
       	     <_,Pl,Per3> => Vp3Pl g ;
       	     _           => Vp3Sg g --Masc
       } ;
  
 
  Noun : Type = {s : Number => Species => Str ; g : Gender} ; 
  Adj  : Type = {s : Number => Species => Gender => Str} ; 
  Verb : Type = {s : TenseHeb => VPerNumGen  => Str } ;
  Verb2 : Type = Verb ** {c : Case} ; 
  
  Pattern : Type = {C1, C1C2, C2C3, C3 : Str}; 
  Root    : Type = {C1,C2,C3 : Str};	   -- most verb roots consist of three consonants
  Root4   : Type = Root ** {C4 : Str};   -- for verb roots with four consonants

  AAgr = { g : Gender ; n : Number} ;

  Comp : Type = {
      s : AAgr => Case => Str
      } ; 

  replaceLastLet :  Str -> Str = \c -> 
	 case c of {"P" => "p" ; "M" => "m" ; "N" => "n" ; "Z." => "Z" ; "K" => "k"; _ => c} ;

  Num, Ord :  Type = {s : Case => Str; n : Number} ;
  Det :   Type = {s :  Gender => Str ; n : Number ; sp : Species; isDef : Bool} ; 

--  defH : Str -> Str = \cn ->
--	case cn of {_ => "h" + cn} ;	

  insertObj : NP -> VP -> VP = \np,vp ->
      let
        nps = np.s ! Acc
      in
      { s = vp.s;
        obj = nps.obj;
        s2 = vp.s2;
        pred = vp.pred;
        isPred = vp.isPred
      } ;

  insertObj2 : Comp -> NP -> VP -> VP = \c,np,vp ->
      let
        nps = np.s ! Acc
      in
      { s = vp.s;
        obj = nps.obj;
        s2 = vp.s2;
        pred = vp.pred;
        isPred = vp.isPred
      } ;

  predV : Verb -> VP = \v ->
       { s = \\t,p,png => v.s ! t ! png ; obj =  []  ; s2 = [];
        pred = { s = \\_,_ => []};
        isPred = False
	} ;

  appPattern : Root -> Pattern -> Str = \r,p ->
    p.C1 + r.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;

  -- remove the first letter
  appPattern2 : Root -> Pattern -> Str = \r,p ->
    p.C1 + p.C1C2 + r.C2 + p.C2C3 + r.C3 + p.C3 ;

  getRoot : Str -> Root = \s -> case s of {
    C1@? + C2@? + C3 => {C1 = C1 ; C2 = C2 ; C3 = C3} ;
    _ => Predef.error ("cannot get root from" ++ s)
    } ;


} 
