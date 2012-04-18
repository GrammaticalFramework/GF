concrete NumeralJap of Numeral = CatJap ** open ResJap, ParadigmsJap, Prelude in {

flags coding = utf8 ;

  lincat
    Digit, Sub1000000 = {s : Str ; n : Number} ;
    Sub10 = {s : Str ; n : Number ; is1 : Bool} ;
    Sub100, Sub1000 = {s : Str ; n : Number ; numType : NumeralType ; 
                       digit1 : Str ; digit2 : Str} ;

  lin
    num dig = dig ;
  
    n2 = {s = "二" ; n = Pl} ;  -- "ni"
    n3 = {s = "三" ; n = Pl} ;  -- "san"
    n4 = {s = "四" ; n = Pl} ;  -- "yon"
    n5 = {s = "五" ; n = Pl} ;  -- "go"
    n6 = {s = "六" ; n = Pl} ;  -- "roku"
    n7 = {s = "七" ; n = Pl} ;  -- "shichi"
    n8 = {s = "八" ; n = Pl} ;  -- "hachi"
    n9 = {s = "九" ; n = Pl} ;  -- "kyuu"

    pot01 = {s = "一" ; n = Sg ; is1 = True} ;  -- "ichi"
    
    pot0 d = d ** {is1 = False} ;
    
    pot110 = {
      s = "十" ;  -- "juu"
      n = Pl ; 
      numType = Tens ;
      digit1 = "1" ;
      digit2 = "0"
      } ;
    
    pot111 = {
      s = "十一" ; 
      n = Pl ; 
      numType = TensPlus ;
      digit1 = "1" ;
      digit2 = "1" 
      } ;
    
    pot1to19 d = {
      s = "十" ++ d.s ;
      n = Pl ;
      numType = TensPlus ;
      digit1 = "1" ;
      digit2 = d.s 
      } ;
    
    pot0as1 d = {
      s = d.s ; 
      n = Pl ; 
      numType = Other ;
      digit1 = [] ;
      digit2 = [] 
      } ;
    
    pot1 d = {
      s = d.s ++ "十" ;
      n = Pl ;
      numType = Tens ;
      digit1 = d.s ;
      digit2 = "0" 
      } ;
    
    pot1plus d n = {
      s = d.s ++ "十" ++ n.s ;
      n = Pl ;
      numType = TensPlus ;
      digit1 = d.s ;
      digit2 = n.s 
      } ;
      
    pot1as2 d = d ;
    
    pot2 d = {
      s = case d.is1 of {
        True => "百" ;  -- "hyaku"
        False => d.s ++ "百" 
        } ;
      n = Pl ;
      numType = Other ;
      digit1 = [] ;
      digit2 = [] 
      } ;
      
    pot2plus d n = {
      s = case d.is1 of {
        True => "百" ++ n.s ;
        False => d.s ++ "百" ++ n.s
        } ;
      n = Pl ;
      numType = Other ;
      digit1 = [] ;
      digit2 = [] 
      } ;
    
    pot2as3 d = d ;
    
    pot3 d = {
      s = case d.numType of {
        Tens => d.digit1 ++ "万" ;  -- "man" 
        TensPlus => d.digit1 ++ "万" ++ d.digit2 ++ "千" ;  -- "sen"
        Other => d.s ++ "千"  
        } ;
      n = Pl
      } ;
      
    pot3plus d n = {
      s = case d.numType of {
        Tens => d.digit1 ++ "万" ++ n.s ;
        TensPlus => d.digit1 ++ "万" ++ d.digit2 ++ "千" ++ n.s ;
        Other => d.s ++ "千" ++ n.s 
        } ;
      n = Pl
      } ;
      
  lincat
    Dig = {s : Str ; n : Number} ;
    
  lin
    IDig d = d ;
    
    IIDig d n = {
      s = d.s ++ n.s ;
      n = Pl
      } ;
  
    D_0 = {s = "0" ; n = Sg} ;
    D_1 = {s = "1" ; n = Sg} ;
    D_2 = {s = "2" ; n = Pl} ;
    D_3 = {s = "3" ; n = Pl} ;
    D_4 = {s = "4" ; n = Pl} ;
    D_5 = {s = "5" ; n = Pl} ;
    D_6 = {s = "6" ; n = Pl} ;
    D_7 = {s = "7" ; n = Pl} ;
    D_8 = {s = "8" ; n = Pl} ;
    D_9 = {s = "9" ; n = Pl} ;
}
