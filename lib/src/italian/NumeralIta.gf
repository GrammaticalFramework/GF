concrete NumeralIta of Numeral = CatIta ** 
  open CommonRomance, ResRomance, MorphoIta, Prelude in {

lincat 
  Digit = {s : DForm => CardOrd => Str  ; isContr : Bool} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number ; isContr : Bool} ;
  Sub100 = {s : CardOrd => Str ; n : Number} ;
  Sub1000 = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

lin num x = x ;

lin n2 = mkDigit (mkTal "due"     "dodici"      "venti"     "secondo");
lin n3 = mkDigit (mkTal "tre"     "tredici"     "trenta"    "terzo") ;
lin n4 = mkDigit (mkTal "quattro" "quattordici" "quaranta"  "quarto") ;
lin n5 = mkDigit (mkTal "cinque"  "quindici"    "cinquanta" "quinto") ;
lin n6 = mkDigit (mkTal "sei"     "sedici"      "sessanta"  "sesto") ;
lin n7 = mkDigit (mkTal "sette"   "diciassette" "settanta"  "settimo") ; 
lin n8 = {s = (mkTal "otto"    "diciotto"    "ottanta"   "ottavo").s ; isContr = True } ;
lin n9 = mkDigit (mkTal "nove"    "diciannove"  "novanta"   "nono") ;

oper getRoot : Str -> Str = \due -> 
case due of 
  { _ + ("ue" | "o" | "te"| "ve")  => init due;
    _                             => due
   };
oper mkDigit : {s : DForm => CardOrd => Str} -> {s : DForm => CardOrd => Str  ; isContr : Bool} = \ss->
{s = ss.s; isContr = False};

lin pot01 = 
  let uno = (mkTal "uno" "undici" "dieci" "primo" ).s in
  {s =\\f,g => case f of {
      ental t => case t of 
                   {pred  =>  case g of {
                                         NCard Fem => "una" ;
                                         _ => uno ! f ! g
                                         };
                    indip =>  case g of
                                   { NCard _ => [] ;
                                     _       => uno ! f ! g
                                    }
                    };
     _     => uno ! f ! g
     } ; 
   n = Sg; isContr = True
} ;

lin pot0 d = {s = d.s ; n = Pl; isContr = d.isContr} ;
lin pot110 = spl ((mkTall "dieci" [] [] "decimo" []).s ! ental pred) ;
lin pot111 = spl ((mkTall "undici" [] [] "undicesimo" []).s ! ental pred) ;
lin pot1to19 d = spl (d.s ! ton) ;
lin pot0as1 n = {s = n.s ! ental pred ; n = n.n} ;
lin pot1 d = spl (d.s ! tiotal) ;
lin pot1plus d e = 
       let ss = if_then_Str e.isContr  (d.s ! tiouno ! NCard Masc) (d.s ! tiotal ! NCard Masc)
              in
   {s = table {NCard g =>  ss ++ BIND ++(e.s ! ental pred ! NCard Masc) ;
               NOrd g n => ss ++ BIND ++e.s ! ental indip ! NOrd g n};
     n = Pl} ;

lin pot1as2 n = n ;

lin pot2 d = spl (\\co => d.s ! ental indip ! NCard Masc ++ nBIND d.n ++
  (mkTall "cento" [] [] [] "cent").s ! ental indip ! co) ;
lin pot2plus d e = 
  {s = table {NCard g => d.s ! ental indip ! NCard Masc ++ nBIND d.n ++"cento" ++ BIND ++e.s ! NCard Masc ;
              NOrd g n => d.s ! ental indip ! NCard Masc ++ nBIND d.n ++"cento" ++ BIND ++ e.s ! NOrd g n};
   n = Pl} ;
lin pot2as3 n = n ;
lin pot3 n = spl (\\co => n.s ! NCard Masc ++ nBIND n.n ++
  (mkTall (mille ! n.n) [] [] [] "mill").s ! ental indip ! co ) ;

lin pot3plus n m = {s = \\g => n.s ! NCard Masc ++ nBIND n.n ++ mille ! n.n ++ "e" ++ m.s ! g ; n = Pl} ;

oper
  nBIND : Number -> Str = \n -> case n of {Sg => [] ; _ => BIND} ; -- no BIND after silent 1

  mkTall : (x1,_,_,_,x5 : Str) -> {s : DForm => CardOrd => Str} =
    \due,dodici,venti,secondo,du -> 
   {s = \\d,co => case <d,co> of {
       <ental _, NCard _>  => due ;
       <ental indip, NOrd g n> => regOrdpred du g n ;
       <ental pred, NOrd g n> => pronForms (adjSolo secondo) g n ;
       <tiotal,  NCard _>  => venti ;
       <tiotal,  NOrd g n> => regCard venti g n ;
       <ton,     NCard _>  => dodici ;
       <ton,     NOrd g n> => regCard dodici g n ;
       <tiouno, _>  => init venti   
      }
    } ;

mkTal : (x1,_,_,x4 : Str) -> {s : DForm => CardOrd => Str} = \due, dodici, venti, secondo ->
mkTall due dodici venti secondo (getRoot due) ;

  regCard : Str -> Gender -> Number -> Str = \venti ->
    regOrdpred (init venti) ;

  regOrdpred : Str -> Gender -> Number -> Str = \sei ->
    pronForms (adjSolo (sei + "esimo")) ;
     

  spl : (CardOrd => Str) -> {s : CardOrd => Str ; n : Number} = \s -> {
    s = s ;
    n = Pl
    } ;

oper mille : Number => Str = table {Sg => "mille" ; Pl => "mila"} ;
param DForm = ental Pred | ton | tiotal | tiouno ;
param Pred = pred | indip ;


-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = \\o => d.s ! NCard Masc ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk2Dig "1"  Sg ; ---- gender
    D_2 = mkDig "2" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mkDig : Str -> TDigit = \c -> mk2Dig c Pl ;
    
    mk2Dig : Str -> Number -> TDigit = \c,n -> {
      s = table {NCard _ => c ; 
                 NOrd Masc Sg => c + ":o" ; NOrd Fem Sg => c + ":a" ;
                 NOrd Masc Pl => c + ":i" ; NOrd Fem Pl => c + ":e"
                 } ; 
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

}
