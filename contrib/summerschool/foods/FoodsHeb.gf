--# -path=alltenses

-- (c) 2009 Dana Dannells under LGPL

concrete FoodsHeb of Foods = open Prelude in {
  
	flags coding=utf8 ;

    lincat
      Comment = SS ;
      Quality = {s: Gender => Number => Str} ;  
      Kind = {s : Number => Str ; g : Gender} ; 
      Item = {s : Str ; g : Gender ; n : Number} ; 
  
    lin
      Pred item quality = ss (item.s ++ quality.s ! item.g ! item.n) ; 
      This  = det Sg "זה" "זאת"; 
      That  = det Sg "הוא" "היא" ; 
      These = det Pl  "אלה" "אלה" ; 
      Those = det Pl "הם" "הן" ; 
      Mod quality kind = {
	s = \\n => kind.s ! n ++ quality.s ! kind.g ! n ;
	g = kind.g 
	} ;     
      Wine = regNoun "יין" "יינות"Fem ; 
      Cheese = regNoun "גבינה" "גבינות" Fem ;  
      Fish = regNoun "דג" "דגים" Masc ; 
      Pizza = regNoun "פיצה" "פיצוי" Fem ; 
      Very qual = {s = \\g,n => "מאוד" ++  qual.s ! g ! n} ;
      Fresh = regAdj "טרי" ; 
      Warm = regAdj "חם" ;
      Italian = irregAdj "איטלקי" ;
      Expensive = regAdj "יקר" ; 
      Delicious = irregAdj "נהדר" ; 
      Boring = regAdj "משעמם"; 

    param 
      Number = Sg | Pl ;
      Gender = Masc | Fem ;
 
    oper
      det : Number -> Str -> Str -> {s : Number => Str ; g :Gender} -> 
	{s : Str ; g :Gender ; n : Number} = 
        \n,m,f,cn -> {
          s =  cn.s ! n ++ case cn.g of {Masc => m ; Fem => f} ;
	  g = cn.g ; 
          n = n
        } ;
      
     regNoun : Str -> Str -> Gender -> {s : Number => Str ; g : Gender} = 
        \gvina,gvinot,g -> {s = table {
          Sg => gvina ;
          Pl => gvinot 
          };
       	g=g
        } ;

      replaceLastLetter : Str -> Str = \s -> 
	init s + case last s of  {
          "מ" => "ם" ; "ן" => "נ" ; "פ" => "ף" ; "ץ" => "צ" ; "כ" => "ך" ; c => c
          } ;
	      
      adjective : (_,_,_,_ : Str) -> {s : Gender => Number => Str} = 
       \tov,tova,tovim,tovot -> {
        s = table {
          Masc => table {
            Sg => tov ;
            Pl => tovim
            } ; 
          Fem => table {
            Sg => tova ;
            Pl => tovot
            }
          }
      } ;
    
    regAdj : Str -> {s : Gender => Number => Str} = \tov ->
	case tov of { to + c@? =>
 	adjective tov (replaceLastLetter (to + c + "ה" )) (replaceLastLetter (to + c +"ים" )) (replaceLastLetter (to + c + "ות" ))};	 
     
    irregAdj : Str -> {s : Gender => Number => Str} = \italki ->
 	case italki of { italk+ c@? => 
 	adjective italki (replaceLastLetter (italk + c +"ת" ))  (replaceLastLetter (italk + c+ "ים" )) (replaceLastLetter (italk + c+ "ות" ))};
    
}  -- FoodsHeb  
