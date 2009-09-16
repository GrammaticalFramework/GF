concrete SymbolRon of Symbol = 
  CatRon ** open Prelude, ResRon in {

lin
  SymbPN i = mkSymb i.s ;
  IntPN i  = mkSymb i.s ;
  FloatPN i = mkSymb i.s ;
  NumPN i  = mkSymb (i.sp ! Masc) ;

  CNIntNP cn i = let gg = agrGender cn.g Sg in
  heavyNP {
    s = \\c => cn.s ! Sg ! Def ! (convCase c) ++ i.s ;
    a = agrP3 gg Sg ;
    hasClit = False ;
    ss = cn.s ! Sg ! Def ! ANomAcc ++ i.s 
    } ;
   
  CNSymbNP det cn xs = let gg = agrGender cn.g det.n;
                           st = if_then_else Species det.isDef Def Indef;
                           rs = if_then_else Species det.hasRef Def Indef;
                           ag = agrP3 gg det.n ;
                           hr = andB (getClit cn.a) det.hasRef
                        in                               
    {s = \\c => case c of 
                 {Vo =>
                   {comp = det.s ! gg ! No ++ det.size ++ cn.s ! det.n ! st ! ANomAcc ++ det.post ! gg ! No  ;
                    clit = \\cs => if_then_Str hr ((genCliticsCase ag c).s ! cs) [] };
                  _ => {comp = det.s ! gg ! c ++ det.size ++ cn.s ! det.n ! st ! (convCase c) ++ det.post ! gg ! c  ;
                    clit = \\cs => if_then_Str hr ((genCliticsCase ag c).s ! cs) [] }  
                    };
     a = ag ;
     hasClit = hr ;
     hasRef = hr ;
     isPronoun = False ;
     indForm = det.s ! gg ! No ++ det.size ++cn.s ! det.n ! rs ! ANomAcc 
   } ;   
    
  CNNumNP cn i = let gg = agrGender cn.g Sg in 
    heavyNP {
    s = \\c => cn.s ! Sg ! Def ! (convCase c) ++ i.sp ! gg;
    a = agrP3 gg Sg ;
    hasClit = False ;
    ss = cn.s ! Sg ! Def ! ANomAcc ++ i.sp ! gg
    } ;
  SymbS sy = {s = \\_ => sy.s} ;

  SymbNum nn = {s,sp = \\_ => nn.s ; n = Pl; size = less20} ; -- need to know the size of the symbol to properly set it to less20 or plural
  SymbOrd nn = {s = \\n,g,nc => case nc of
                      {Da | Ge => artDem g n AGenDat ++ "de-" ++ artPos g n ANomAcc ++ nn.s ++ "-lea";
                       _       => artPos g n ANomAcc ++ nn.s ++ "-lea"  
                      };
               isPre = True       
                      } ;

lincat 

  Symb, [Symb] = SS ;

lin

  MkSymb s = s ;

  BaseSymb = infixSS "ºi" ; 
  ConsSymb = infixSS "," ;

oper mkSymb : Str -> PN = \ss ->
{ s = \\c => case c of 
      {Da | Ge => "lui" ++ ss;
       _       => ss 
       };
 g = Masc; n = Sg; a = Animate ;
 lock_PN = <>
};
  
}
