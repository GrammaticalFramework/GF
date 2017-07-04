--# -path=.:../abstract:../prelude

concrete SymbolJpn of Symbol = CatJpn ** open Prelude, ResJpn, NounJpn in {

  flags coding = utf8;

 lin
 --PN = {s : Style => Str ; anim : Animateness} ;
  SymbPN i = {s = \\style => i.s ; anim = Inanim } ;
  
  IntPN i = {s = \\style => i.s ; anim = Inanim } ;
  
  FloatPN i = {s = \\style => i.s ; anim = Inanim } ;
  
  NumPN i = {s = \\style => i.s ; anim = Inanim } ;


  --  : Det -> CN -> [Symb] -> NP ; -- (the) (2) numbers x and y  
  CNSymbNP det cn xs = 
    let np = DetCN det cn ;
     in np ** { s = \\st => xs.s ++ "の" ++ np.s ! st } ; 

  -- : CN -> Card -> NP ;          -- level five ; level 5
  -- This is pure guessing /IL 2017-07
  CNNumNP cn i = 
    let np = MassNP cn ;
     in np ** { s = \\st => i.s ++ "の" ++ np.s ! st } ; 

  -- S = {s, te, ba, subj : Particle => Style => Str ; pred, pred_te, pred_ba : Style => Str} ;
  SymbS sy = { s = \\p,st => sy.s ;
               te = \\_,_ => [] ; ba = \\_,_ => [] ; subj = \\_,_ => [] ;
               pred = \\st => [] ; pred_te = \\st => [] ; pred_ba = \\st => [] } ;

  SymbNum sy = mkNum sy.s Pl ;

  SymbOrd = mkOrd ;


lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "と" ;
  ConsSymb = infixSS "," ;

  -- level 53 (covered by CNNumNP)
  --CNIntNP cn i = {} ;


}
