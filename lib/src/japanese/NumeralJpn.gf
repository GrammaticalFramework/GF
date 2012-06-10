concrete NumeralJpn of Numeral = CatJpn ** open ResJpn, ParadigmsJpn, Prelude in {

flags coding = utf8 ;

  lincat
    Digit = {s : Str ; n : Number} ;
    Sub10 = {s : Str ; n : Number ; is1 : Bool ; null : Str} ;
    Sub100 = {s : Str ; n : Number ; numType : NumeralType ; digit1 : Str ; digit2 : Str ; 
              tenPlus : Bool ; is1 : Bool} ;
    Sub1000 = {s_init : Str ; s_mid : Str ; n : Number ; numType : NumeralType ; 
               man : Str ; sen : Str ; tenPlus : Bool ; is1 : Bool ; null : Str} ;
    Sub1000000 = {s : Str ; n : Number ; tenPlus : Bool} ;

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

    pot01 = {s = "一" ; n = Sg ; is1 = True ; null = ""} ;
    
    pot0 d = d ** {is1 = False ; null = ""} ;
    
    pot110 = {
      s = "十" ;  -- "juu"
      n = Pl ; 
      numType = EndZero ;
      digit1 = "一" ;
      digit2 = "0" ;
      tenPlus = True ;
      is1 = False
      } ;
    
    pot111 = {
      s = "十一" ; 
      n = Pl ; 
      numType = EndNotZero ;
      digit1 = "一" ;
      digit2 = "一"  ;
      tenPlus = True ;
      is1 = False
      } ;
    
    pot1to19 d = {
      s = "十" ++ d.s ;
      n = Pl ;
      numType = EndNotZero ;
      digit1 = "一" ;
      digit2 = d.s ;
      tenPlus = True ;
      is1 = False
      } ;
    
    pot0as1 d = {
      s = d.s ; 
      n = Pl ; 
      numType = SingleDigit ;
      digit1 = [] ;
      digit2 = d.s ;
      tenPlus = False ;
      is1 = d.is1
      } ;
    
    pot1 d = {
      s = d.s ++ "十" ;
      n = Pl ;
      numType = EndZero ;
      digit1 = d.s ;
      digit2 = "0" ;
      tenPlus = True ;
      is1 = False
      } ;
    
    pot1plus d n = {
      s = d.s ++ "十" ++ n.s ;
      n = Pl ;
      numType = EndNotZero ;
      digit1 = d.s ;
      digit2 = n.s ;
      tenPlus = True ;
      is1 = False
      } ;
      
    pot1as2 d = {
      s_init = d.s ; 
      s_mid = d.s ;
      n = d.n ; 
      numType = d.numType ; 
      man = d.digit1 ; 
      sen = d.digit2 ; 
      tenPlus = d.tenPlus ; 
      is1 = d.is1 ;
      null = ""
      } ;
    
    pot2 d = {
      s_init = case d.is1 of {
        True => d.null ++ "百" ;  -- "hyaku"
        False => d.s ++ "百" 
        } ;
      s_mid = d.s ++ "百" ;
      n = Pl ;
      numType = EndZero ;
      man = case d.is1 of {
        True => d.null ++ "十" ;
        False => d.s ++ "十" 
        } ;
      sen = [] ;
      tenPlus = True ;
      is1 = False ;
      null = ""
      } ;
      
    pot2plus d n = {
      s_init = case d.is1 of {
        True => d.null ++ "百" ++ n.s ;
        False => d.s ++ "百" ++ n.s
        } ;
      s_mid = d.s ++ "百" ++ n.s ;
      n = Pl ;
      numType = case n.numType of {
        EndZero => EndZero ;
        _ => EndNotZero
        } ;
      man = case d.is1 of {
        True => d.null ++ "十" ++ n.digit1 ;
        False => d.s ++ "十" ++ n.digit1
        } ;
      sen = n.digit2 ;
      tenPlus = True ;
      is1 = False ;
      null = ""
      } ;
    
    pot2as3 d = {
      s = d.s_init ;
      n = d.n ;
      tenPlus = d.tenPlus
      } ;
    
    pot3 d = {
      s = case d.numType of {
        EndZero => d.man ++ "万" ;  -- "man"
        EndNotZero => d.man ++ "万" ++ d.sen ++ "千" ;  -- "sen"
        SingleDigit => case d.is1 of {
          True => d.null ++ "千" ;
          False => d.s_init ++ "千"
          }
        } ;
      n = Pl;
      tenPlus = True
      } ;
      
    pot3plus d n = {
      s = case d.numType of {
        EndZero => d.man ++ "万" ++ n.s_mid ;
        EndNotZero => d.man ++ "万" ++ d.sen ++ "千" ++ n.s_mid ;
        SingleDigit => case d.is1 of {
          True => d.null ++ "千" ++ n.s_mid ;
          False => d.s_init ++ "千" ++ n.s_mid
          }
        } ;
      n = Pl;
      tenPlus = True
      } ;
      
  lincat
    Dig = {s : Str ; n : Number ; is0 : Bool} ;
    
  lin
    IDig d = {
      s = d.s ;
      n = d.n ;
      tenPlus = False ;
      tail = T1
      } ;
    
    IIDig d n = {
      s = d.s ++ commaIf n.tail ++ n.s ;
      n = Pl ;
      tenPlus = case <d.is0, n.tenPlus> of {
        <_, True> => True ;
        <True, False> => False ;
        _ => True
        } ;
      tail = inc n.tail
      } ;
  
    D_0 = {s = "0" ; n = Sg ; is0 = True} ;
    D_1 = {s = "1" ; n = Sg ; is0 = False} ;
    D_2 = {s = "2" ; n = Pl ; is0 = False} ;
    D_3 = {s = "3" ; n = Pl ; is0 = False} ;
    D_4 = {s = "4" ; n = Pl ; is0 = False} ;
    D_5 = {s = "5" ; n = Pl ; is0 = False} ;
    D_6 = {s = "6" ; n = Pl ; is0 = False} ;
    D_7 = {s = "7" ; n = Pl ; is0 = False} ;
    D_8 = {s = "8" ; n = Pl ; is0 = False} ;
    D_9 = {s = "9" ; n = Pl ; is0 = False} ;
    
  oper
    commaIf : DTail -> Str = \t -> case t of {
      T3 => "," ;
      _ => []
      } ;

    inc : DTail -> DTail = \t -> case t of {
      T1 => T2 ;
      T2 => T3 ;
      T3 => T1
      } ;
}
